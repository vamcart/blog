<?php

$router = resolve('router');

$router->get('/', 'BlogController@index')->name('home');

$router->get('/sort/{sort}/order/{order}', 'BlogController@index')->name('home');

$router->get('/user/auth', 'UserController@auth')->name('user.auth');
$router->post('/user/login', 'UserController@login')->name('user.login');
$router->get('/user/logoff', 'UserController@logoff')->name('user.logoff');

// create
$router->get('/blog/create', function (\App\Core\Http\Request $request, \App\Core\Session $session) {
    $blog = new App\Models\Blog();
    return view('edit', compact('todo'));
})->name('blog.create');
$router->post('/blog/create', 'BlogController@store');
// edit
$router->get('/blog/{id}/edit', 'BlogController@edit')->name('blog.edit');
// save edit
$router->put('/blog/{id}', 'BlogController@save')->name('blog.save');
