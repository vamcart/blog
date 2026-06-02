<?php

namespace App\Controllers;

use App\Core\Http\Controller;
use App\Core\Http\Request;
use App\Core\Http\Response;
use App\Core\Session;
use App\Core\Utilities\FunctionInjector;
use App\Core\View;
use App\Models\Category;
use voku\helper\Paginator;


class CategoryController extends Controller
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
        $pages->set_total(Category::count_all());

        $categoryList = Category::all($sort, $order, $page, $pages->get_limit());

        foreach ($categoryList as $category) {
            $categories[] = $category->toArray();
        }
        
        $view_data = compact('categories');
        $view_merge = array_merge(array('pagination' => $pages->page_links()), $view_data);
        
        return view('home', $view_merge);
    }

    /**
     * Delete a category
     * @param null|int $id
     * @return string
     */
    public function delete(Session $session, $id = null)
    {
        $category = Category::delete($id);

        $errors[] = 'Запись удалена!';
        session()->setFlash('errors', $errors);

        return view('home', compact('category'));
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
        $category = Category::find($id);
        if (!$category) {
            return response_404();
        }

        return view('edit_category', compact('category'));
    }

    /**
     * Update a category
     * @param Request $request
     * @param null|int $id
     * @return \App\Core\Http\Response
     */
    public function save(Request $request, $id = null)
    {
        // get origin
        $category = Category::find($id);
        if (!$category) {
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
        $category->fill($request->input());
        $category->save();
        
        // back
        return to_route('category.edit', ['id' => $category->id, '+query' => ['saved' => 1]]);
    }

    /**
     * Create a Category
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
        $category = new Category($request->input());
        $category->save();
        return to_route('category.edit', ['id' => $category->id, '+query' => ['saved' => 1]]);
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
        $text = trim($request->input('description'));
        $errors = [];
        if (empty($text)) {
            $errors[] = 'Описание не должно быть пустым';
        }
        // if has errors
        if (!empty($errors)) {
            session()->setFlash('errors', $errors);
            // save old input
            session()->setFlash('old', $request->input());
            if ($id) {
                return to_route('category.edit', ['id' => $id]);
            } else {
                return to_route('category.create');
            }
        }
        // else
        return true;
    }
}
