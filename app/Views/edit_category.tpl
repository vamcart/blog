<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>{config key='name'} - Редактировать категорию</title>
        <link href="{url path='/css/bootstrap/bootstrap.min.css'}" rel="stylesheet">
        <link rel="stylesheet" href="{url path='/css/fontawesome/css/all.min.css'}">
        <link rel="stylesheet" href="{url path='/css/app.css'}">
    </head>
    <body>
        <div class="container">
            {if $category->id}
                <h1>Редактировать категорию: {$category->name}</h1>
            {else}
                <h1>Создать новую категорию</h1>
            {/if}

            {if $session->hasFlash('errors')}
                <ul class="msg msg-error">
                    {foreach $errors as $error}
                        <li>{$error}</li>
                    {/foreach}
                </ul>
            {/if}

           {if $request->query('saved')}
                <p class="msg msg-success">Успешно сохранено!</p>
                <div class="panel">
                    <a class="btn" href="{url path='/'}">Вернуться к списку блогов</a>
                </div>
            {/if}

           {if $category->id}
            <form action="{route name='category.save' id=$category->id}" method="post">
                <input type="hidden" name="_method" value="PUT">
                <input type="hidden" name="edited" value="1">
            {else}
            <form action="{route name='category.create'}" method="post">
            {/if}            
                <div class="form-group">
                    <label>Название</label>
                    <input type="text" name="name" value="{$category->name}" required>
                </div>
                    <div class="form-group">
                    <label>Описание</label>
                    <textarea name="description">{$category->description}</textarea>
                </div>
                <button class="btn primary" type="submit">Сохранить</button>
            </form>
        </div>
    </body>
</html>