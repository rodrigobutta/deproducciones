<?php

namespace App\Http\Controllers;

use App\Activity;
use App\Profession;
use App\ProfessionForbiddenName;
use App\Events\ProfessionWasUpdated;
use App\Filters;
use App\Submission;
use App\Traits\CachableProfession;
use App\Traits\CachableUser;
use Auth;
use Carbon\Carbon;
use Illuminate\Http\Request;

class ProfessionController extends Controller
{
    use Filters, CachableUser, CachableProfession;

    /**
     * makes sure the user is logged in.
     *
     * @return void
     */
    public function __construct()
    {
        // $this->middleware('auth', ['except' => ['show', 'getProfession', 'fillStore', 'redirect']]);
        $this->middleware('auth', ['except' => ['show', 'submissions', 'getProfession', 'fillStore', 'redirect']]);
    }





    /**
     * shows the submission page to guests.
     *
     * @param string $profession
     * @param string $slug
     *
     * @return view
     */
    public function show($slug, Request $request)
    {

        if (Auth::check()) {
            return view('welcome');
        }

        $profession = $this->getProfessionBySlug($slug);

        $profession->stats = $this->professionStats($profession->id);

        $submissions = $profession->wantedBy;



        return view('profession.show', compact('profession','submissions'));
    }

    /**
     * Returns all the nesseccary information to fill the professionStore on front-end.
     *
     * @return Collection
     */
    public function fillStore(Request $request)
    {
        $this->validate($request, [
            'slug' => 'required',
        ]);

        $profession = $this->getProfessionBySlug($request->slug);

        $profession->stats = $this->professionStats($profession->id);

        return $profession;
    }

    /**
     * Creates a new profession.
     *
     * @param Illuminate\Http\Request $request
     *
     * @return string $name
     */
    public function store(Request $request)
    {
        $this->validate($request, [
            'name'        => 'required|alpha_num|min:3|max:50|unique:categories',
            'description' => 'required|min:10|max:250',
        ]);

        $user = Auth::user();

        if ($user->isShadowBanned()) {
            return response('I hate to break it to you but your account has been banned.', 500);
        }

        $tooEarly = $this->tooEarlyToCreate();

        if ($tooEarly != false) {
            return response("Looks like you're over doing it. You can create another channel in ".$tooEarly.' seconds. Thank you for being patient.', 500);
        }

        if ($this->isForbiddenName(str_slug($request->name, ''))) {
            return response('This name is forbidden. Please pick another one.', 500);
        }

        $profession = Profession::create([
            'name'        => str_slug($request->name, ''),
            'description' => $request->description,
            'avatar'      => '/public/imgs/channel-avatar.png',
        ]);

        // subscribes user to profession that was just created
        $user->subscriptions()->toggle($profession->id);
        $this->updateSubscriptions($user->id, $profession->id, true);

        // Set the creator of profession as the administrator of it
        $user->professionRoles()->attach($profession, [
            'role' => 'administrator',
        ]);

        return $profession;
    }

    /**
     * is the name in the blacklist names.
     *
     * @return bool
     */
    protected function isForbiddenName($name)
    {
        return ProfessionForbiddenName::where('name', $name)->exists();
    }

    /**
     * Whether or the user is breaking the time limit for creating another profession.
     *
     * @return mixed
     */
    protected function tooEarlyToCreate()
    {
        // exclude white-listed users form this checking
        if ($this->mustBeWhitelisted()) {
            return false;
        }

        $lastCreated = Activity::where([
            ['subject_type', 'App\Profession'],
            ['user_id', Auth::user()->id],
            ['name', 'created_profession'],
        ])->orderBy('created_at', 'desc')->first();

        if ($lastCreated) {
            $timeDiff = time() - strtotime($lastCreated->created_at);
            // 43200 = 12 hours
            if ($timeDiff < 43200) {
                return 43200 - $timeDiff;
            }
        }

        return false;
    }

    /**
     * Patches the profession model with recently send info.
     *
     * @param Illuminate\Support\Request $request
     *
     * @return response
     */
    public function patch(Request $request)
    {
        $this->validate($request, [
            'name'        => 'required|alpha_num|max:25',
            'description' => 'required|max:230',
            'color'       => 'required|in:Dark Blue,Blue,Red,Dark,Pink,Dark Green,Bright Green,Purple,Gray,Orange',
        ]);

        $profession = $this->getProfessionByName($request->name);

        abort_unless($this->mustBeAdministrator($profession->id), 403);

        $profession->update([
            'description' => $request->description,
            'color'       => $request->color,
            'nsfw'        => ($request->nsfw ? true : false),
        ]);

        event(new ProfessionWasUpdated($profession));

        return response('The channel has been successfully updated', 200);
    }

    /**
     * Searches categories. Mostly used for submiting new submissions.
     *
     * @param Illuminate\Http\Request $request
     *
     * @return Illuminate\Support\Collection
     */
    public function getProfessions(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|alpha_num|max:25',
        ]);

        return Profession::where('title', 'like', '%'.$request->name.'%')
                    ->orWhere('slug', 'like', '%'.$request->name.'%')
                    ->select('id','title')->take(100)->get();
    }

    /**
     * looks for the profession by its name.
     *
     * @param Request $request [name]
     *
     * @return [Collection] profession
     */
    public function getProfession(Request $request)
    {
        $this->validate($request, [
            'name' => 'required',
        ]);

        return $this->getProfessionByName($request->name);
    }

    /**
     * @param App\Profession $profession
     *
     * @return bool
     */
    protected function isNSWF($profession)
    {
        return $profession->nsfw == 1 && Auth::user()->settings['nsfw'] == 0;
    }


    /**
     * redirects old channel URLs (/c/channel/hot) to the new one (/c/channel). This is just to
     * to prevent dead URLS and also to respect our old users who shared their channels on
     * social media to support us. To them!
     *
     * @return redirect
     */
    public function redirect($profession)
    {
        return redirect('/c/'.$profession);
    }
}
