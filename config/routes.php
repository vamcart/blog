<?php

$router = resolve('router');

$router->get('/', 'BlogController@index')->name('home');

$router->get('/sort/{sort}/order/{order}', 'BlogController@index')->name('home');

$router->get('/user/auth', 'UserController@auth')->name('user.auth');
$router->post('/user/login', 'UserController@login')->name('user.login');
$router->get('/user/logoff', 'UserController@logoff')->name('user.logoff');

// blog create
$router->get('/blog/create', function (\App\Core\Http\Request $request, \App\Core\Session $session) {
    $blog = new App\Models\Blog();
    $categories = App\Models\Blog::find_categories();
    return view('edit_blog', compact('blog', 'categories'));
})->name('blog.create');
$router->post('/blog/create', 'BlogController@store');
// blog edit
$router->get('/blog/{id}/edit', 'BlogController@edit')->name('blog.edit');
// blog view
$router->get('/blog/view/{id}', 'BlogController@view')->name('blog.view');
// blog save edit
$router->put('/blog/{id}', 'BlogController@save')->name('blog.save');

// category create
$router->get('/category/create', function (\App\Core\Http\Request $request, \App\Core\Session $session) {
    $category = new App\Models\Category();
    return view('edit_category', compact('category'));
})->name('category.create');
$router->post('/category/create', 'CategoryController@store');
// category edit
$router->get('/category/{id}/edit', 'CategoryController@edit')->name('category.edit');
// category save edit
$router->put('/category/{id}', 'CategoryController@save')->name('category.save');
