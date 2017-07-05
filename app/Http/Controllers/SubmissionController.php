<?php

namespace App\Http\Controllers;

use App\Category;
use App\Events\SubmissionWasCreated;
use App\Events\SubmissionWasDeleted;
use App\Filters;
use App\Photo;
use App\PhotoTools;
use App\Submission;
use App\Traits\CachableCategory;
use App\Traits\CachableSubmission;
use App\Traits\CachableUser;
use App\Traits\Submit;
use Auth;
use DB;
use Embed\Embed;
use Illuminate\Http\Request;

class SubmissionController extends Controller
{
    use Filters, PhotoTools, CachableUser, CachableSubmission, CachableCategory, Submit;

    public function __construct()
    {
        $this->middleware('auth', ['except' => ['getBySlug', 'getById', 'getPhotos', 'show']]);
    }

    /**
     * shows the submission page to guests.
     *
     * @param string $category
     * @param string $slug
     *
     * @return view
     */
    public function show($category, $slug)
    {

        // var_dump('SubmissionController@show');


       // var_dump(Auth::check());

       // $user = Auth::user();

       // var_dump($user);

       // exit();

        // if (Auth::check()) {
        //     return view('welcome');
        // }


        $submission = $this->getSubmissionBySlug($slug);

        // $category = $submission->category;
        // $category = $this->getCategoryByName($submission->category_name);
        $submission->category->stats = $this->categoryStats($submission->category->id);
        // $submission->category = $category;

        // var_dump($submission->wantsFor);
        // exit();


        return view('submission.show', compact('submission'));
    }

    /**
     * Stores the submitted submission into database. There are 3 types of submissions:
     * 1.text, 2.link and 3.img. 4.gif Different actions are required for different
     * types. After storing the submission, redirects to the submission page.
     *
     * @param Illuminate\Support\Request $request
     *
     * @return Illuminate\Support\Collection
     */
    public function store(Request $request)
    {
        $user = Auth::user();

        if ($user->isShadowBanned()) {
            return response('I hate to break it to you but your account has been banned.', 500);
        }

        // first make sure user is allowed to submit to this category. (not banned from it)
        if ($this->isUserBanned($user->id, $request->name)) {
            return response('You have been banned from submitting to #'.$request->name.'. If you think there has been some kind of mistake, please contact the moderators of #'.$request->name.'.', 500);
        }

        if ($request->type == 'link') {
            $this->validate($request, [
                'url'   => 'required|url',
                'title' => 'required|between:7,150',
                'name'  => 'required|exists:categories',
            ]);

            // check if it's in the blocked domains list
            if ($this->isDomainBlocked($request->url, $request->name)) {
                return response("The submitted website is in the channel's blacklist. Please find another source.", 500);
            }

            try {
                $data = $this->linkSubmission($request);
            } catch (\Exception $e) {
                $data = [
                    'url'           => $request->url,
                    'title'         => $request->title,
                    'description'   => null,
                    'type'          => 'link',
                    'embed'         => null,
                    'img'           => null,
                    'thumbnail'     => null,
                    'providerName'  => null,
                    'publishedTime' => null,
                    'domain'        => domain($request->url),
                ];
            }
        }

        // if ($request->type == 'img') {
        //     $this->validate($request, [
        //         'title'  => 'required|between:7,150',
        //         'photos' => 'required',
        //         'name'   => 'required|exists:categories',
        //     ]);

        //     $data = $this->imgSubmission($request);
        // // }

        // $photo = Photo::where('id', $request->input('photos')[0])->firstOrFail();


        // if ($request->type == 'gif') {
        //     $this->validate($request, [
        //         'title' => 'required|between:7,150',
        //         'gif'   => 'required|mimes:gif|max:40960',
        //         'name'  => 'required|exists:categories',
        //     ]);

        //     try {
        //         $data = $this->gifSubmission($request);
        //     } catch (\Exception $exception) {
        //         app('sentry')->captureException($exception);

        //         return response("We couldn't process this GIF, please try another one. ", 500);
        //     }
        // }

        // if ($request->type == 'text') {
            $this->validate($request, [
                'title' => 'required|between:7,150',
                // 'type'  => 'required|in:link,img,text',
                'name'  => 'required|exists:categories',
            ]);

            // $data = $this->textSubmission($request);
        // }

        $category = Category::where('name', $request->name)->select('id', 'nsfw')->firstOrFail();

        try {
            $submission = Submission::create([
                'title'         => $request->title,
                'slug'          => $this->slug($request->title),
                'type'          => $request->type,
                'category_name' => $request->name,
                'category_id'   => $category->id,
                'nsfw'          => $category->nsfw,
                'rate'          => firstRate(),
                'user_id'       => $user->id,
                // 'data'          => $data,
                'body'          => $request->text,
                // 'thumbnail'     => '11111',

            ]);

            event(new SubmissionWasCreated($submission));
        } catch (\Exception $exception) {
            app('sentry')->captureException($exception);

            return response('Ooops, something went wrong', 500);
        }

        // Update the submission_id field in photos (We just found access to the submission_id)
        // if ($request->type == 'img') {
            DB::table('photos')->whereIn('id', $request->input('photos'))->update(['submission_id' => $submission->id]);
        // }

        try {
            $this->firstVote($user, $submission->id);
        } catch (\Exception $exception) {
            app('sentry')->captureException($exception);
        }

        return $submission;
    }

    /**
     * Fetches the title from an external URL.
     *
     * @param Illuminate\Http\Request $request
     *
     * @return string title
     */
    public function getTitleAPI(Request $request)
    {
        $this->validate($request, [
            'url' => 'required|url',
        ]);

        return $this->getTitle($request->url);
    }

    /**
     * hides the submission so the user won't see it (=== block).
     *
     * @param Illuminate\Http\Request $request
     *
     * @return response
     */
    public function hide(Request $request)
    {
        $this->validate($request, [
            'submission_id' => 'required|integer',
        ]);

        $user = Auth::user();

        $user->hides()->attach($request->submission_id);

        // update the cach record for hiddenSubmissions:
        $this->updateHiddenSubmissions($user->id, $request->submission_id);

        return response('submission added to the hidden list', 200);
    }

    /**
     * Returns the submission.
     *
     * @param Illuminate\Http\Request $request
     *
     * @return Illuminate\Support\Collection
     */
    public function getBySlug(Request $request)
    {
        $this->validate($request, [
            'slug' => 'required',
        ]);


        $submission = $this->getSubmissionBySlug($request->slug);

        $submission->category->stats = $this->categoryStats($submission->category->id);


        // $submission = $this->getSubmissionBySlug($request->slug);

        // $category = $this->getCategoryByName($submission->category_name);

        // $category->stats = $this->categoryStats($category->id);

        // $submission->category = $category;

        return $submission;
    }

    /**
     * Returns the submission (even if it's been soft-deleted).
     *
     * @return Illuminate\Http\Request       $request
     * @return Illuminate\Support\Collection
     */
    public function getById(Request $request)
    {
        $this->validate($request, [
            'id' => 'required|integer',
        ]);

        return $this->getSubmissionById($request->id);
    }

    /**
     * Returns all the uploaded photos for a specific submission.
     *
     * @param Illuminate\Http\Request $request
     *
     * @return Illuminate\Support\Collection
     */
    public function getPhotos(Request $request)
    {
        $this->validate($request, [
            'id' => 'required|integer',
        ]);

        return Photo::where('submission_id', $request->id)->get();
    }

    /**
     * Destroys the submisison record from the database.
     *
     * @param Illuminate\Http\Request $request
     *
     * @return response
     */
    public function destroy(Request $request)
    {
        $this->validate($request, [
            'id' => 'required|integer',
        ]);

        $submission = Submission::findOrFail($request->id);

        abort_unless($this->mustBeOwner($submission), 403);

        event(new SubmissionWasDeleted($submission));

        $submission->forceDelete();

        return response('Submission was successfully deleted', 200);
    }

    /**
     * Removes the thumbnail.
     *
     * @return response
     */
    public function removeThumbnail(Request $request)
    {
        $this->validate($request, [
            'id' => 'required|integer',
        ]);

        $submission = $this->getSubmissionById($request->id);

        abort_unless($this->mustBeOwner($submission), 403);

        $submission->update([
            'data' => [
                'url'           => $submission->data['url'],
                'title'         => $submission->data['title'],
                'description'   => $submission->data['description'],
                'type'          => $submission->data['type'],
                'embed'         => $submission->data['embed'],
                'img'           => null,
                'thumbnail'     => null,
                'providerName'  => $submission->data['providerName'],
                'publishedTime' => $submission->data['publishedTime'],
                'domain'        => $submission->data['domain'] || domain($submission->data['url']),
            ],
        ]);

        $this->putSubmissionInTheCache($submission);

        return response('thumbnail removed', 200);
    }

    /**
     * Patches the Text Submission.
     *
     * @return reponse
     */
    public function patchTextSubmission(Request $request)
    {
        $this->validate($request, [
            'id' => 'required|integer',
        ]);

        $submission = Submission::findOrFail($request->id);

        abort_unless($this->mustBeOwner($submission), 403);
        // make sure submission's type is "text" (at the moment submission editing is only available for text submissions)
        abort_unless($submission->type == 'text', 403);

        $submission->update([
            'title' => $request->title,
            'data' => array_only($request->all(), ['text']),
        ]);


        // var_dump( $request->input('photos') );

        foreach ($request->input('photos') as $photo) {

            if(is_string($photo)){                 // si es string asumo que es una foto subida recien, caso contrario mostraria el array que llego al front con toda la data de la foto

                DB::table('photos')->whereId($photo)->update(['submission_id' => $submission->id]);
            }

        }



        // so next time it'll fetch the updated copy
        $this->removeSubmissionFromCache($submission);

        // return response('Text Submission has been updated. ', 200);

        return Photo::where('submission_id', $submission->id)->get();
    }
}
