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
    protected $fillable = ['name', 'text', 'description', 'image', 'viewed', 'status', 'edited', 'category_id'];

    /**
     * Get all records from db
     * @return array An array of Blog
     */
    public static function byCategory(int $category_id, string $sort, string $order, string $page, string $limit)
    { 

        $sort = white_list($sort, 'sort');
        $order = white_list($order, 'order');

        $db = resolve('db');
        $db->prepare('select * from blogs where category_id = :id order by ' . $sort . ' ' . $order . ' ' . $limit);
        $db->bindValues(['id' => $category_id]);
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

    /**
     * Get similar records from db
     * @return array An array of Blog
     */
    public static function findSimilar(int $blog_id, string $text, string $sort = 'id', string $order = 'desc', string $page = '1', string $limit = 'limit 3')
    { 

        $sort = white_list($sort, 'sort');
        $order = white_list($order, 'order');
        
        $db = resolve('db');
        $db->prepare('SELECT *, 
                        MATCH(name, description) AGAINST(:text IN NATURAL LANGUAGE MODE) AS relevance
                        FROM blogs
                        WHERE id != :id AND MATCH(name, description) AGAINST(:text IN NATURAL LANGUAGE MODE)
                        ORDER BY relevance DESC
                    ');
        $db->bindValues(['id' => $blog_id, 'text' => $text]);
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

    /**
     * Get all records from db
     */
    public static function increaseViewed(int $blog_id) : void
    {
        $db = resolve('db');
        $db->prepare('UPDATE blogs SET viewed = viewed + 1 WHERE id = :id');
        $db->bindValues(['id' => $blog_id]);
        $db->execute();
    }    

}
