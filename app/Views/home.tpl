<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>{config key='name'}</title>
        <link href="{url path='/css/bootstrap/bootstrap.min.css'}" rel="stylesheet">
        <link rel="stylesheet" href="{url path='/css/fontawesome/css/all.min.css'}">
        <link rel="stylesheet" href="{url path='/css/app.css'}">
    </head>
    <body>
        <div class="container">
            <h1><a href="./">{config key='name'}</a></h1>
            <div class="panel">
                <a class="btn" href="{route name='blog.create'}">Добавить блог</a>
                <a class="btn" href="{route name='category.create'}">Добавить категорию</a>
                {if $isAdmin}
                <a class="btn text-right" href="{route name='user.logoff'}">Выход</a>
                {else}
                <a class="btn text-right" href="{route name='user.auth'}">Авторизация</a>
                {/if}
            </div>
            <div id="data">
<h3>Список блогов</h3>
<div class="table-responsive">
<table class="table">
  <thead class="table-light">
    <tr>
      <th scope="col">ID <a data-bs-toggle="tooltip" data-bs-title="Сортировка по id по возрастанию" href="/sort/id/order/asc"><i class="fas fa-chevron-up"></i></a> <a data-bs-toggle="tooltip" data-bs-title="Сортировка по id по убыванию" href="/sort/id/order/desc"><i class="fas fa-chevron-down"></i></a></th>
      <th scope="col">Название <a data-bs-toggle="tooltip" data-bs-title="Сортировка по названию по возрастанию" href="/sort/name/order/asc"><i class="fas fa-chevron-up"></i></a> <a data-bs-toggle="tooltip" data-bs-title="Сортировка по названию по убыванию" href="/sort/name/order/desc"><i class="fas fa-chevron-down"></i></a></th>
      <th scope="col">Текст <a data-bs-toggle="tooltip" data-bs-title="Сортировка по тексту по возрастанию" href="/sort/text/order/asc"><i class="fas fa-chevron-up"></i></a> <a data-bs-toggle="tooltip" data-bs-title="Сортировка по тексту по убыванию" href="/sort/text/order/desc"><i class="fas fa-chevron-down"></i></a></th>
      <th scope="col">Описание <a data-bs-toggle="tooltip" data-bs-title="Сортировка по описанию по возрастанию" href="/sort/description/order/asc"><i class="fas fa-chevron-up"></i></a> <a data-bs-toggle="tooltip" data-bs-title="Сортировка по описанию по убыванию" href="/sort/description/order/desc"><i class="fas fa-chevron-down"></i></a></th>
      <th scope="col">Статус <a data-bs-toggle="tooltip" data-bs-title="Сортировка по статусу по возрастанию" href="/sort/status/order/asc"><i class="fas fa-chevron-up"></i></a> <a data-bs-toggle="tooltip" data-bs-title="Сортировка по статусу по убыванию" href="/sort/status/order/desc"><i class="fas fa-chevron-down"></i></a></th>
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

<h3>Список категорий</h3>
<div class="table-responsive">
<table class="table">
  <thead class="table-light">
    <tr>
      <th scope="col">ID</th>
      <th scope="col">Название категории</th>
      <th scope="col">Описание</th>
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>
{foreach $categories as $category}
    <tr>
      <th scope="row">{$category.id}</th>
      <td>{$category.name}</td>
      <td>{$category.description}</td>
      <td>{if $category.edited == 1}
      <div class="text-success">Отредактировано администратором</div>
      {/if}{if isAdmin}
      <a href="{route name='category.edit' id=$category.id}">Редактировать</a>
      {/if}</td>
    </tr>
{/foreach}
  </tbody>
</table>
</div>

            </div>
        </div>
        
<script src="{url path='/js/bootstrap/bootstrap.bundle.min.js'}"></script>
<script src="{url path='/js/app.js'}" charset="utf-8"></script>
    </body>
</html>