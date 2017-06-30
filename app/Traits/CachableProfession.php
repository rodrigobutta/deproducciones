<?php

namespace App\Traits;

use App\Profession;
use Auth;
use DB;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Redis;

trait CachableProfession
{
    /**
     * Fetches all the cachable data for the profession and put it in the cache.
     *
     * @param int $id
     *
     * @return void
     */
    protected function cacheProfessionData($id)
    {
        $profession = Profession::where('id', $id)->firstOrFail();

        $professionData = [
            'submissionsCount' => $profession->submissions()->count(),
            'usersCount' => $profession->users()->count()
        ];

        Redis::hmset('profession.'.$id.'.data', $professionData);

        return $professionData;
    }

    /**
     * Returns all the stats of the auth profession.
     *
     * @param int $id
     *
     * @return Illuminate\Support\Collection
     */
    protected function professionStats($id)
    {
        $stats = Redis::hmget('profession.'.$id.'.data',
                        'submissionsCount', 'usersCount');

        // if profession's data is not cached, then fetch it from database and then cache it
        if (json_decode($stats[0]) === null || json_decode($stats[1]) === null) {
            return $this->cacheProfessionData($id);
        }

        return collect([
            'submissionsCount' => json_decode($stats[0]),
            'usersCount'    => json_decode($stats[1])
        ]);
    }

    /**
     * updates the submissionsCount of the profession.
     *
     * @param int $id
     * @param int $number
     *
     * @return void
     */
    protected function updateProfessionSubmissionsCount($id, $number = 1)
    {
        // we need to make sure the cached data exists
        if (!Redis::hget('profession.'.$id.'.data', 'submissionsCount')) {
            $this->cacheProfessionData($id);
        }

        Redis::hincrby('profession.'.$id.'.data', 'submissionsCount', $number);
    }



    /**
     * Returns the Profession model using the $id. First it tries to fetch it from Cache. In case it doesn't
     * exist in the cache, fetches it from the database, and then put it in the cache and then return it.
     *
     * @param string $id
     *
     * @return Illuminate\Support\Collection
     */
    protected function getProfessionById($id)
    {
        return Cache::remember('profession.id.'.$id, 60 * 60 * 24, function () use ($id) {
            return Profession::withTrashed()->findOrFail($id);
        });
    }

    /**
     * Returns the Profession model using the name. First it tries to fetch it from Cache. In case it doesn't
     * exist in the cache, fetches it from the database, and then put it in the cache and then return it.
     *
     * @param string $name
     *
     * @return Illuminate\Support\Collection
     */
    protected function getProfessionByName($name)
    {
        return Cache::remember('profession.name.'.$name, 60 * 60 * 24, function () use ($name) {
            return Profession::withTrashed()->where('name', $name)->firstOrFail();
        });
    }

    /**
     * Returns the Profession model using the slug. First it tries to fetch it from Cache. In case it doesn't
     * exist in the cache, fetches it from the database, and then put it in the cache and then return it.
     *
     * @param string $slug
     *
     * @return Illuminate\Support\Collection
     */
    protected function getProfessionBySlug($slug)
    {
        return Cache::remember('profession.slug.'.$slug, 60 * 60 * 24, function () use ($slug) {
            return Profession::withTrashed()->where('slug', $slug)->firstOrFail();
        });
    }


    /**
     * Put the profession infto the cache. In case it already exists, updates it. Otherwise adds it.
     *
     * @param Illuminate\Support\Collection $profession
     */
    protected function putProfessionInTheCache($profession)
    {
        Cache::put('profession.id.'.$profession->id, $profession, 60 * 60 * 24);

        Cache::put('profession.name.'.$profession->name, $profession, 60 * 60 * 24);
    }



    // protected function getProfessions()
    // {
    //     return Cache::remember('professions', 60 * 60 * 24, function () {

    //         return Profession::get();
    //     });
    // }



    protected function updateProfessionSubscribersCount($id, $number = 1)
    {
        // we need to make sure the cached data exists
        if (!Redis::hget('profession.'.$id.'.data', 'subscribersCount')) {
            $this->cacheProfessionData($id);
        }

        $subscribersCount = Redis::hincrby('profession.'.$id.'.data', 'subscribersCount', $number);

        // for newbie categories we update on each new subscription
        if ($subscribersCount < 1000) {
            DB::table('professions')->where('id', $id)->update(['subscribers' => $subscribersCount]);

            return;
        }
        // but for major ones, we do this once a 100 times
        if (($subscribersCount % 100) === 0) {
            DB::table('professions')->where('id', $id)->update(['subscribers' => $subscribersCount]);
        }
    }


}
