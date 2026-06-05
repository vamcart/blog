            <div class="table-responsive">
            <table class="table">
            <thead class="table-light">
                <tr>
                <th scope="col">ID <a data-bs-toggle="tooltip" data-bs-title="Сортировка по id по возрастанию" href="/category/view/{$category->id}/sort/id/order/asc"><i class="fas fa-chevron-up"></i></a> <a data-bs-toggle="tooltip" data-bs-title="Сортировка по id по убыванию" href="/category/view/{$category->id}/sort/id/order/desc"><i class="fas fa-chevron-down"></i></a></th>
                <th scope="col">Название <a data-bs-toggle="tooltip" data-bs-title="Сортировка по названию по возрастанию" href="/category/view/{$category->id}/sort/name/order/asc"><i class="fas fa-chevron-up"></i></a> <a data-bs-toggle="tooltip" data-bs-title="Сортировка по названию по убыванию" href="/category/view/{$category->id}/sort/name/order/desc"><i class="fas fa-chevron-down"></i></a></th>
                <th scope="col">Текст <a data-bs-toggle="tooltip" data-bs-title="Сортировка по тексту по возрастанию" href="/category/view/{$category->id}/sort/text/order/asc"><i class="fas fa-chevron-up"></i></a> <a data-bs-toggle="tooltip" data-bs-title="Сортировка по тексту по убыванию" href="/category/view/{$category->id}/sort/text/order/desc"><i class="fas fa-chevron-down"></i></a></th>
                <th scope="col">Описание <a data-bs-toggle="tooltip" data-bs-title="Сортировка по описанию по возрастанию" href="/category/view/{$category->id}/sort/description/order/asc"><i class="fas fa-chevron-up"></i></a> <a data-bs-toggle="tooltip" data-bs-title="Сортировка по описанию по убыванию" href="/category/view/{$category->id}/sort/description/order/desc"><i class="fas fa-chevron-down"></i></a></th>
                <th scope="col">Статус <a data-bs-toggle="tooltip" data-bs-title="Сортировка по статусу по возрастанию" href="/category/view/{$category->id}/sort/status/order/asc"><i class="fas fa-chevron-up"></i></a> <a data-bs-toggle="tooltip" data-bs-title="Сортировка по статусу по убыванию" href="/category/view/{$category->id}/sort/status/order/desc"><i class="fas fa-chevron-down"></i></a></th>
                <th scope="col"></th>
                </tr>
            </thead>
            <tbody>
            {foreach $blogs as $blog_list}
                {include file="blog_list_item.tpl"}
            {/foreach}
            </tbody>
            <tfoot>
                <tr>
                <td colspan="6">{$pagination nofilter}</td>
                </tr>
            </tfoot>
            </table>
            </div>   