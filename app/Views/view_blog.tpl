<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>{config key='name'} - Блог</title>
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
            </div>

        </div>
    </body>
</html>