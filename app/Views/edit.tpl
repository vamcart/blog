<?php
// Converted from edit.html to Smarty template
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>{config key='name'} - Редактировать задачу</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="{url path='/css/app.css'}">
    </head>
    <body>
        <div class="container">
            {if $todo->id}
                <h1>Редактировать задачу: {$todo->name}</h1>
            {else}
                <h1>Создать новую задачу</h1>
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
            {/if}

            <form action="{route name='todo.save' id=$todo->id}" method="post">
                <input type="hidden" name="_method" value="PUT">
                <div class="form-group">
                    <label>Имя</label>
                    <input type="text" name="name" value="{$todo->name}" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" value="{$todo->email}" required>
                </div>
                <div class="form-group">
                    <label>Описание</label>
                    <textarea name="description">{$todo->description}</textarea>
                </div>
                {if $todo->id}
                    <div class="form-group">
                        <label>Статус</label>
                        <select name="status">
                            {foreach ['Ожидает проверки', 'Выполняется', 'Выполнено'] as $status}
                                <option value="{$status}"{if $status == $todo->status} selected{/if}>{$status}</option>
                            {/foreach}
                        </select>
                    </div>
                {/if}
                <button class="btn primary" type="submit">Сохранить</button>
            </form>
        </div>
    </body>
</html>