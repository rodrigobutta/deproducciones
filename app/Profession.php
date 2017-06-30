<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Laravel\Scout\Searchable;

class Profession extends Model
{
    use Bookmarkable, SoftDeletes, Searchable, RecordsActivity;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'data', 'title', 'slug', 'type', 'data', 'nsfw', 'approved_at', 'deleted_at'
    ];

    protected $casts = [
        'data' => 'json',
    ];


    protected static $recordEvents = ['created'];


    public function users()
    {
        return $this->belongsToMany(User::class, 'user_professions', 'profession_id', 'user_id');
    }

    public function submissions()
    {
        return $this->belongsToMany(Submission::class, 'profession_submissions', 'profession_id', 'submission_id');
    }

    /**
     * Get the indexable data array for the model.
     *
     * @return array
     */
    public function toSearchableArray()
    {
        return [
            'id'    => $this->id,
            'title' => $this->title
        ];
    }
}
