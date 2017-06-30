<?php

namespace App\Http\Controllers;

use App\Traits\CachableProfession;
use App\Traits\CachableUser;
use Auth;
use Illuminate\Http\Request;

class ProfessionSubscribeController extends Controller
{
    use CachableUser, CachableProfession;

    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * subscribing/unsubscrbing to professions.
     *
     * @param Illuminate\Http\Request $request
     *
     * @return status
     */
    public function subscribeToggle(Request $request)
    {
        $this->validate($request, [
            'profession_id' => 'required|integer',
        ]);

        $user = Auth::user();

        try {
            $result = $user->professions()->toggle($request->profession_id);
        } catch (\Exception $e) {
            return response('duplicate action', 200);
        }

        // subscibed
        if ($result['attached']) {
            $this->updateProfessionSubscriptions($user->id, $request->profession_id, true);

            $this->updateProfessionSubscribersCount($request->profession_id);

            return response('Subscribed', 200);
        }

        // unsubscribed
        $this->updateProfessionSubscriptions($user->id, $request->profession_id, false);

        $this->updateProfessionSubscribersCount($request->profession_id, -1);

        return response('Unsubscribed', 200);
    }

    /**
     * whether or not the user is subscribed to the profession.
     *
     * @param Illuminate\Http\Request $request
     *
     * @return string
     */
    public function isSubscribed(Request $request)
    {
        $this->validate($request, [
            'profession_id' => 'required|integer',
        ]);

        $user = Auth::user();

        return $user->professions->contains($request->profession_id) ? 'true' : 'false';
    }
}
