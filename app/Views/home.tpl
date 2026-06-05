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
                <a class="btn" href="{route name='blog.create'}">Добавить статью</a>
                <a class="btn" href="{route name='category.create'}">Добавить категорию</a>
                {if $isAdmin}
                <a class="btn text-right" href="{route name='user.logoff'}">Выход</a>
                {else}
                <a class="btn text-right" href="{route name='user.auth'}">Авторизация</a>
                {/if}
            </div>
            <div id="data">




{foreach $categories as $category}
<h3><a href="{route name='category.view' id=$category.id}">{$category.name}</a></h3>

<div class="table-responsive">
<table class="table">
  <thead class="table-light">
    <tr>
      <th scope="col">ID</th>
      <th scope="col">Название блога</th>
      <th scope="col">Текст статьи</th>
      <th scope="col">Описание</th>
      <th scope="col">Статус</th>
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>    
{foreach $category.blogs as $blog_list}
    {include file="blog_list_item.tpl"}
{/foreach}
  </tbody>
</table>
</div>

<a class="btn text-right mb-2" href="{route name='category.view' id=$category.id}">Все статьи</a>

{/foreach}


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
            
<h3>Список блогов</h3>
{include file="blog_list.tpl"}

            </div>
        </div>
        
<script src="{url path='/js/bootstrap/bootstrap.bundle.min.js'}"></script>
<script src="{url path='/js/app.js'}" charset="utf-8"></script>
    </body>
</html>