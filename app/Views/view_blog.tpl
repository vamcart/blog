<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>{$blog->name} - Блог</title>
        <link href="{url path='/css/bootstrap/bootstrap.min.css'}" rel="stylesheet">
        <link rel="stylesheet" href="{url path='/css/fontawesome/css/all.min.css'}">
        <link rel="stylesheet" href="{url path='/css/app.css'}">
    </head>
    <body>
        <div class="container">
            <h1>{$blog->name}</h1>

            {if $blog->image}
            <img src="{$blog->image}" alt="{$blog->name}" class="img-fluid">
            {/if}
            <p>{$blog->text}</p>
            <p>{$blog->description}</p>

            <br />

            <p>Просмотры: {$blog->viewed}</p>
            <p>Дата: {$blog->created_at}</p>
            
            <div class="panel">
                <a class="btn" href="{url path='/'}">Вернуться к списку блогов</a>
                <a class="btn" href="{route name='blog.edit' id=$blog->id}">Редактировать статью</a>
            </div>

            <h3>Похожие статьи</h3>

            <div class="table-responsive">
            <table class="table">
            <thead class="table-light">
                <tr>
                <th scope="col"></th>
                <th scope="col">ID</th>
                <th scope="col">Название блога</th>
                <th scope="col">Текст статьи</th>
                <th scope="col">Описание</th>
                <th scope="col">Просмотры</th>
                <th scope="col">Дата</th>
                <th scope="col">Статус</th>
                <th scope="col"></th>
                </tr>
            </thead>
            <tbody>    
            {foreach $blogs as $blog_list}
                {include file="blog_list_item.tpl"}
            {/foreach}
            </tbody>
            </table>
            </div>

        </div>
    </body>
</html>