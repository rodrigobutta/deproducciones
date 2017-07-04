<?php

namespace App\Http\Controllers;

use App\Submission;
use App\Traits\CachableCategory;
use App\Traits\CachableSubmission;
use App\Traits\CachableUser;
use Auth;
use Carbon\Carbon;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    use CachableUser, CachableSubmission, CachableCategory;

    /**
     * Displays the home page.
     *
     * @param Illuminate\Http\Request $request
     *
     * @return view
     */
    public function homePage(Request $request)
    {

        if (!Auth::check()) {
            $submissions = $this->guestHome($request);


            // var_dump($submissions->toJson());
            // exit();

            return view('home', compact('submissions'));
        }

        return view('welcome');
    }

    /**
     * Returns the submissions for the homepage of Auth user.
     *
     * @param Illuminate\Http\Request $request
     *
     * @return Illuminate\Support\Collection
     */
    public function feed(Request $request)
    {
        // var_dump('feed');
        // exit();


        $this->validate($request, [
            'sort' => 'required|in:hot,new,relevant',
            'page' => 'required|integer',
        ]);

        if (!Auth::check()) {
            return $this->guestHome($request);
        }

        $submissions = (new Submission())->newQuery();


        // $submissions = $submissions->join('categories', 'submissions.category_id', '=', 'categories.id');

        // spicify the filter:
        if ($request->filter == 'all-channels') {
            // guest what? we don't have to do anything :|
        } elseif ($request->filter == 'moderating-channels') {
            $submissions->whereIn('category_id', Auth::user()->moderatingIds());
        } elseif ($request->filter == 'bookmarked-channels') {
            $submissions->whereIn('category_id', $this->bookmarkedCategories());
        } elseif ($request->filter == 'by-bookmarked-users') {
            $submissions->whereIn('user_id', $this->bookmarkedUsers());
        } else { // $request->filter == "subscribed channels"
            $submissions->whereIn('category_id', $this->subscriptions());
        }



        // exclude user's hidden submissions
        $submissions->whereNotIn('id', $this->hiddenSubmissions());

        // exclude NSFW if user doens't want to see them
        if (!settings('nsfw')) {
            $submissions->where('nsfw', false);
        }

        if (settings('exclude_upvoted_submissions')) {
            $submissions->whereNotIn('id', $this->submissionUpvotesIds());
        }

        if (settings('exclude_downvoted_submissions')) {
            $submissions->whereNotIn('id', $this->submissionDownvotesIds());
        }

        if ($request->sort == 'new') {
            $submissions->orderBy('created_at', 'desc');
        }

        if ($request->sort == 'relevant') {
            // $submissions->where('created_at', '>=', Carbon::now()->subHour())
            //             ->orderBy('rate', 'desc');

            $submissions->orderBy('comments_number', 'desc');
        }

        if ($request->sort == 'hot') {
            $submissions->orderBy('rate', 'desc');
        }

        // var_dump($submissions->simplePaginate(10));

        return $submissions->simplePaginate(10);
    }

    /**
     * returns submisisons from default categories. by time we're gonna improve this.
     *
     * @param Illuminate\Http\Request $request
     *
     * @return Illuminate\Support\Collection
     */
    protected function guestHome(Request $request)
    {
        $submissions = (new Submission())->newQuery();

        $submissions->whereIn(
            'category_id', $this->getDefaultCategories()
        );

        $submissions->where('nsfw', false);

        if ($request->sort == 'new') {
            $submissions->orderBy('created_at', 'desc');
        } elseif ($request->sort == 'relevant') {
            // $submissions->where('created_at', '>=', Carbon::now()->subHour())
            //             ->orderBy('rate', 'desc');
            $submissions->orderBy('comments_number', 'desc');
        } else {
            $submissions->orderBy('rate', 'desc');
        }

        return $submissions->simplePaginate(10);
    }
}
