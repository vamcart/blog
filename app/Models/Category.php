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
     * Blogs of category
     * @throws \Exception
     */
    public static function blogs($id = null,$sort = 'id', $order = 'desc', $page = 1, $limit = 999)
    { 

        $sort = white_list($sort, 'sort');
        $order = white_list($order, 'order');

        $db = resolve('db');
        //Выводим все категории
        //$db->prepare('select * from categories order by ' . $sort . ' ' . $order . ' limit ' . $limit);
        //Выводим только категории со статьями
        $db->prepare('select categories.* from categories left join blogs on blogs.category_id = categories.id where blogs.category_id > 0 group by categories.id order by ' . $sort . ' ' . $order . ' limit ' . $limit);

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

            $blogList = Blog::byCategory($data['id'], $sort, $order, $page, 'limit 3');
                    
            $sanitizedResult['blogs'] = array_map(fn($blog) => $blog->toArray(), $blogList);
            $model->_fill($sanitizedResult);
            $modelList[] = $model;
        }

        return $modelList;
    }

}
