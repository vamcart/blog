<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>{config key='name'} - Редактировать блог</title>
        <link href="{url path='/css/bootstrap/bootstrap.min.css'}" rel="stylesheet">
        <link rel="stylesheet" href="{url path='/css/fontawesome/css/all.min.css'}">
        <link rel="stylesheet" href="{url path='/css/app.css'}">
    </head>
    <body>
        <div class="container">
            {if $blog->id}
                <h1>Редактировать блог: {$blog->name}</h1>
            {else}
                <h1>Создать новый блог</h1>
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

           {if $blog->id}
            <form action="{route name='blog.save' id=$blog->id}" method="post">
                <input type="hidden" name="_method" value="PUT">
                <input type="hidden" name="edited" value="1">
            {else}
            <form action="{route name='blog.create'}" method="post">
            {/if}            
                <div class="form-group">
                    <label>Название</label>
                    <input type="text" name="name" value="{$blog->name}" required>
                </div>
                <div class="form-group">
                    <label>Текст</label>
                    <input type="text" name="text" value="{$blog->text}" required>
                </div>
                <div class="form-group">
                    <label>Описание</label>
                    <textarea columns="50" rows="5" name="description">{$blog->description}</textarea>
                </div>
                <div class="form-group">
                    <label>URL картинки</label>
                    <input type="text" name="image" value="{$blog->image}" required>
                </div>
                <div class="form-group">
                    <label>Количество просмотров</label>
                    <input type="text" name="viewed" value="{$blog->viewed}" required>
                </div>
                <div class="form-group">
                    <label>Текст</label>
                    <input type="text" name="text" value="{$blog->text}" required>
                </div>
                <div class="form-group">
                    <label>Статус</label>
                    <select name="status">
                        {foreach ['Активный', 'Неактивный'] as $status}
                            <option value="{$status}"{if $status == $blog->status} selected{/if}>{$status}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="form-group">
                    <label>Категория</label>
                    <select name="category_id">
                        {foreach $categories as $category}
                            <option value="{$category->id}"{if $category->id == $blog->category_id} selected{/if}>{$category->name}</option>
                        {/foreach}                            
                    </select>
                </div>
                <button class="btn primary" type="submit">Сохранить</button>
            </form>
        </div>
    </body>
</html>