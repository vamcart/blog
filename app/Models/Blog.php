<?php

namespace App\Models;

use App\Core\Model;

class Blog extends Model
{
    /**
     * @var string table associated with this model
     */
    protected $table = 'blogs';

    /**
     * @var array list of safe properties
     */
    protected $fillable = ['name', 'text', 'description', 'status', 'edited'];

    /**
     * Get all records from db
     * @return array An array of Blog
     */
    public static function all($sort, $order, $page, $limit)
    { 

        $sort = white_list($sort, 'sort');
        $order = white_list($order, 'order');

        $db = resolve('db');
        $db->prepare('select * from blogs order by ' . $sort . ' ' . $order . $limit);

        $db->execute();
        $result = $db->fetchAllAssociative();
        $modelList = [];
        // transform to array of models
        foreach ($result as $data) {
            $model = new Blog();
            // Apply htmlspecialchars to every value in the array
            $sanitizedResult = array_map(function($value) {
                return htmlspecialchars($value ?? '', ENT_QUOTES, 'UTF-8');
            }, $data);  
            $model->_fill($sanitizedResult);
            $modelList[] = $model;
        }

        return $modelList;
    }
    
    public static function count_all()
    {
    	$db = resolve('db');
    	$db->prepare("select * from blogs");
    	$db->execute();
    	$count = $db->countRows();

        return $count;
    }    
}
