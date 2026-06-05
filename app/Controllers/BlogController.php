<?php

namespace App\Controllers;

use App\Core\Http\Controller;
use App\Core\Http\Request;
use App\Core\Http\Response;
use App\Core\Session;
use App\Core\Utilities\FunctionInjector;
use App\Core\View;
use App\Models\Blog;
use App\Models\Category;
use voku\helper\Paginator;


class BlogController extends Controller
{
    /**
     * Display homepage
     * @throws \Exception
     */
    public function index($sort = 'id', $order = 'desc', $page = 1)
    {
        // create a new object

        $pages = new Paginator(3, 'page');

        // set the total records, calling a method to get the number of records from a model
        $pages->set_total(Blog::count_all());

        $blogList = Blog::all($sort, $order, $page, $pages->get_limit());

        foreach ($blogList as $blog) {
            $blogs[] = $blog->toArray();
        }

        $categoryList = Category::blogs($sort, $order, $page, $pages->get_limit());

        foreach ($categoryList as $category) {
            $categories[] = $category->toArray();
        }
        
        $view_data = compact('blogs', 'categories');
        $view_merge = array_merge(array('pagination' => $pages->page_links()), $view_data);
        
        return view('home', $view_merge);
    }

    /**
     * Delete a blog
     * @param null|int $id
     * @return string
     */
    public function delete(Session $session, $id = null)
    {
        Blog::delete($id);

        $errors[] = 'Запись удалена!';
        session()->setFlash('errors', $errors);

        return view('home', compact('blog'));
    }

    /**
     * Display edit form
     * @param Session $session
     * @param null|int $id
     * @return \App\Core\Http\Response
     * @throws \Exception
     */
    public function edit(Session $session, $id = null)
    {
        $blog = Blog::findWithCategories($id);
        if (!$blog) {
            return response_404();
        }

        if (!isAdmin()) {
            return to_route('user.auth');
        }
                
        $categories = Blog::find_categories();

        return view('edit_blog', compact('blog', 'categories'));
    }

    /**
     * Display blog page
     * @param null|int $id
     * @return \App\Core\Http\Response
     * @throws \Exception
     */
    public function view($id = null)
    {
        $blog = Blog::find($id);
        if (!$blog) {
            return response_404();
        }

        $similar_blogs_list = Blog::findSimilar($blog->id, $blog->name);
        $blogs = [];

        foreach ($similar_blogs_list as $similar) {
            $blogs[] = $similar->toArray();
        }        

        Blog::increaseViewed($blog->id);

        return view('view_blog', compact('blog', 'blogs'));
    }

    /**
     * Update a blog
     * @param Request $request
     * @param null|int $id
     * @return \App\Core\Http\Response
     */
    public function save(Request $request, $id = null)
    {
        // get origin
        $blog = Blog::find($id);
        if (!$blog) {
            return response_404();
        }

        if (!isAdmin()) {
            return to_route('user.auth');
        }
        
        // pure validating
        $validation = $this->validate($request, $id);
        if ($validation !== true) {
            return $validation;
        }

        // fill new data to model
        $blog->fill($request->input());
        $blog->save();
        
        // back
        return to_route('blog.edit', ['id' => $blog->id, '+query' => ['saved' => 1]]);
    }

    /**
     * Create a Blog
     * @param Request $request
     * @return Response
     */
    public function store(Request $request)
    {
        // @TODO validate
        // pure validating
        $validation = $this->validate($request);
        if ($validation !== true) {
            return $validation;
        }
        // save
        $blog = new Blog($request->input());
        $blog->save();
        return to_route('blog.edit', ['id' => $blog->id, '+query' => ['saved' => 1]]);
    }

    /**
     * Validate request
     * @param Request $request
     * @param null|int $id Pass the id to redirect to edit page when errors occur, else go to create page
     * @return true|Response
     */
    protected function validate(Request $request, $id = null)
    {
        $name = trim($request->input('name'));
        $errors = [];
        if (empty($name)) {
            $errors[] = 'Название не должно быть пустым';
        }
        $text = trim($request->input('text'));
        $errors = [];
        if (empty($text)) {
            $errors[] = 'Текст не должен быть пустым';
        }
        // if has errors
        if (!empty($errors)) {
            session()->setFlash('errors', $errors);
            // save old input
            session()->setFlash('old', $request->input());
            if ($id) {
                return to_route('blog.edit', ['id' => $id]);
            } else {
                return to_route('blog.create');
            }
        }
        // else
        return true;
    }
}
