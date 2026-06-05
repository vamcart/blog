<?php

namespace App\Models;

use App\Core\Model;
use voku\helper\Paginator;
use App\Models\Blog;

class Category extends Model
{
    /**
     * @var string table associated with this model
     */
    protected $table = 'categories';

    /**
     * @var array list of safe properties
     */
    protected $fillable = ['name', 'description'];

    /**
     * Get all records from db
     * @return array An array of Category
     */
    public static function all($sort, $order, $page, $limit)
    { 

        $sort = white_list($sort, 'sort');
        $order = white_list($order, 'order');

        $db = resolve('db');
        $db->prepare('select * from categories order by ' . $sort . ' ' . $order . $limit);

        $db->execute();
        $result = $db->fetchAllAssociative();
        $modelList = [];
        // transform to array of models
        foreach ($result as $data) {
            $model = new Category();
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
     * Blogs of category
     * @throws \Exception
     */
    public static function blogs($id = null,$sort = 'id', $order = 'desc', $page = 1, $limit = 999)
    { 

        $sort = white_list($sort, 'sort');
        $order = white_list($order, 'order');

        $db = resolve('db');
        $db->prepare('select * from categories order by ' . $sort . ' ' . $order . ' limit ' . $limit);

        $db->execute();
        $result = $db->fetchAllAssociative();
        $modelList = [];
        // transform to array of models
        foreach ($result as $data) {
            $model = new Category();
            // Apply htmlspecialchars to every value in the array
            $sanitizedResult = array_map(function($value) {
                return htmlspecialchars($value ?? '', ENT_QUOTES, 'UTF-8');
            }, $data);  
            $sanitizedResult['blogs'] = Blog::allByCategory($data['id'], $sort, $order, $page, 3);
            $model->_fill($sanitizedResult);
            $modelList[] = $model;
        }

        return $modelList;
    }

}
