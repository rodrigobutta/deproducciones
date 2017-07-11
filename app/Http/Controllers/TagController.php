<?php

namespace App\Http\Controllers;

use App\Activity;
use App\Tag;
use Auth;
use Carbon\Carbon;
use Illuminate\Http\Request;

class TagController extends Controller
{
    // use Filters, CachableUser, CachableCategory;

    /**
     * makes sure the user is logged in.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth', ['except' => ['getCategories']]);
    }


    /**
     * Searches categories. Mostly used for submiting new submissions.
     *
     * @param Illuminate\Http\Request $request
     *
     * @return Illuminate\Support\Collection
     */
    public function getTags(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|alpha_num|max:25',
        ]);

        return Tag::where('title', 'like', '%'.$request->name.'%')
                    ->orderBy('used_count', 'desc')
                    ->select('id','name')->take(100)->get();
    }



    public function getTopTags(Request $request)
    {

        return Tag::orderBy('used_count', 'desc')
                    ->select('id','name')->take(5)->get();
    }



}
