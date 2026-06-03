<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>{config key='name'}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" integrity="sha384-gfdkjb5BdAXd+lj+gudLWI+BXq4IuLW5IT+brZEZsLFm++aCMlF1V92rMkPaX4PP" crossorigin="anonymous">
        <link rel="stylesheet" href="{url path='/css/app.css'}">
    </head>
    <body>
    <div class="container">
            <h1>Вход</h1>

        <div class="panel">
                <a class="btn" href="{url path='/'}">Вернуться к списку блогов</a>
        </div>

            <ul class="msg msg-success">
                    <li>Редактировать данные может только администратор. Авторизуйтесь.</li>
            </ul>

        {if $session->hasFlash('errors')}
            <ul class="msg msg-error">
                {foreach from=$session->flash('errors') item=error}
                    <li>{$error}</li>
                {/foreach}
            </ul>
        {/if}

        <form action="{route name='user.login'}" method="post">
            <div class="form-group">
                <label>Логин (admin)</label>
                <input type="text" name="login" value="admin" required>
            </div>
            <div class="form-group">
                <label>Пароль (123)</label>
                <input type="password" name="password" value="123" required>
            </div>
            <button class="btn primary" type="submit">Войти</button>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
    <script src="{url path='/js/app.js'}" charset="utf-8"></script>        
    </body>
</html>
