<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>{$category->name} - Блоги</title>
        <link href="{url path='/css/bootstrap/bootstrap.min.css'}" rel="stylesheet">
        <link rel="stylesheet" href="{url path='/css/fontawesome/css/all.min.css'}">
        <link rel="stylesheet" href="{url path='/css/app.css'}">
    </head>
    <body>
        <div class="container">
            <h1>{$category->name}</h1>
            <p>{$category->description}</p>

            <div class="panel">
                <a class="btn" href="{url path='/'}">Вернуться на главную страницу</a>
            </div>

            <h3>Список статей категории</h3>
            {include file="blog_list.tpl"}
        </div>
    </body>
</html>