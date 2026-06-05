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
            <p>{$blog->text}</p>
            <p>{$blog->description}</p>

            <div class="panel">
                <a class="btn" href="{url path='/'}">Вернуться к списку блогов</a>
                <a class="btn" href="{route name='blog.edit' id=$blog->id}">Редактировать статью</a>
            </div>

            <h3>Похожие статьи</h3>
            <div class="table-responsive">
            <table class="table">
            <thead class="table-light">
                <tr>
                <th scope="col">ID</th>
                <th scope="col">Название</th>
                <th scope="col">Текст</th>
                <th scope="col">Описание</th>
                <th scope="col">Статус</th>
                <th scope="col"></th>
                </tr>
            </thead>
            <tbody>
            {foreach $blogs as $blog_list}
                <tr>
                <th scope="row">{$blog_list.id}</th>
                <td><a href="{route name='blog.view' id=$blog_list.id}">{$blog_list.name}</a></td>
                <td>{$blog_list.text}</td>
                <td>{$blog_list.description}</td>
                <td>{$blog_list.status}</td>
                <td>{if $blog_list.edited == 1}
                <div class="text-success">Отредактировано администратором</div>
                {/if}{if isAdmin}
                <a href="{route name='blog.edit' id=$blog_list.id}">Редактировать</a>
                {/if}</td>
                </tr>
            {/foreach}
            </tbody>
            <tfoot>
                <tr>
                <td colspan="6">{$pagination nofilter}</td>
                </tr>
            </tfoot>
            </table>
            </div>     

        </div>
    </body>
</html>