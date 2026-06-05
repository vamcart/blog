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