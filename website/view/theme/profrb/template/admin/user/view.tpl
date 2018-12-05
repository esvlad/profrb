<?
function ordered($data, $order){
  if($data == $order){
    return 1;
  } else {
    return 0;
  }
}
?>
<h2 class="modal_title">Пользователи</h2>
<div class="admin_content_view admin_user">
  <table class="admin_content_table">
  <thead data-types="comments">
    <tr>
      <td>
        <div class="content_views_check">
            <input id="content_id" type="checkbox" name="id_all" value="">
            <label for="content_id"></label>
          </div>
      </td>
      <td>
        <p id="id" data-sorted="<?=$sort;?>" data-sort-active="<?=ordered('id', $order);?>" class="sorted"><span onclick="sorted('id');">ID</span></p>
      </td>
      <td>
        <p id="login" data-sorted="<?=$sort;?>" data-sort-active="<?=ordered('login', $order);?>" class="sorted"><span onclick="sorted('login');">Логин</span></p>
      </td>
      <td>
        <p id="org" data-sorted="<?=$sort;?>" data-sort-active="<?=ordered('org', $order);?>" class="sorted"><span onclick="sorted('org');">Организация</span></p>
      </td>
      <td></td>
      <td></td>
      <td></td>
    </tr>
  </thead>
  <tbody>
    <? foreach($users as $user) : ?>
      <tr class="admin_content_row" data-content-type-id="0" data-content-id="<?=$user['id']?>">
        <td>
          <div class="content_views_check">
            <input id="content_id<?=$user['id']?>" type="checkbox" name="id[<?=$user['id']?>]" value="<?=$user['id']?>">
            <label for="content_id<?=$user['id']?>"></label>
          </div>
        </td>
        <td>
          <p class="content_views_title"><?=$user['id']?></p>
        </td>
        <td>
          <p class="content_views_title"><?=$user['login']?></p>
        </td>
        <td>
          <p class="content_views_title"><?=$user['org_name']?></p>
        </td>
        <td>
          <span onclick="user_update(<?=$user['id'];?>, 'edit');" class="content_event admin_icon icon_update">Редактировать</span>
        </td>
        <td>
          <? if($user['active'] == 1) : ?>
            <span id="content_event" data-event="active" data-params="0" class="content_event admin_icon icon_active">Заблокировать</span>
          <? else : ?>
            <span id="content_event" data-event="active" data-params="1" class="content_event admin_icon icon_active">Разблокировать</span>
          <? endif; ?>
        </td>
        <td>
          <span id="delete_content" data-id="<?=$user['id']?>" class="content_event admin_icon icon_delete">Удалить</span>
        </td>
      </tr>
    <? endforeach; ?>
  </tbody>
  </table>
  <div id="delete_ids" class="btn brd btn_admin btn_delete_ids">Удалить отмеченных</div>
  <div class="clearfix"></div>
  <? if(!empty($paginator)){
      echo $paginator;
    } 
  ?>
</div>
<script>
$('#content_id').change(function(){
  $('input[name^="id"]').trigger('click');
});

$('.admin_content_view a').click(function(e){
  e.preventDefault();
});

$('#delete_ids').click(function(){
  var data_ids = [];

  $('input[name^="id"]:checked').each(function(){
    data_ids.push($(this).val());
  });

  if(data_ids.length > 0){
    var data_confirm = confirm('Вы уверенны, что хотите удалить выбранных пользователей?');

    console.log(data_ids);

    if(data_confirm){
      $.ajax({
        url: 'index.php?r=admin/user/delete',
        type: 'post',
        data: {ids: data_ids},
        dataType: 'json',
        success: function(json){
          alert('Выбранные элементы удалены!');
          $('.admin_section a[href="admin/user/view"]').trigger('click');
        }
      });
    }
  } else {
    alert('Ничего не выбрано');
  }
});

$('span#delete_content').click(function(){
  var data_tag = $(this);
  var uid = data_tag.attr('data-id');
  var element = $('.admin_content_row[data-content-id="'+content_id+'"]');
  var content_title = element.find('.content_views_title').text();

  data_tag.parent().addClass('mini_load');  

  var data_confirm = confirm('Вы уверены что хотите удалить пользователя: '+content_title+'?');

  if(data_confirm){
    var data_url = 'index.php?r=admin/user/delete';

    $.ajax({
      url: data_url,
      type: 'post',
      data: {ids: uid},
      dataType: 'json',
      success: function(json){
        console.log(json);
        if(json.success){
          data_tag.parent().removeClass('mini_load');
          element.slideUp(300);
          setTimeout(function(){
            element.detach();
          },300);
        }
      },
      error: function(xhr, ajaxOptions, thrownError){
        console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  } else {
    data_tag.parent().removeClass('mini_load');
  }
});

var moment_active = ['Разблокировать', 'Заблокировать'];
var params_active = [1, 0];
$('span#content_event').click(function(){
  var data_tag = $(this);
  var data_url = 'index.php?r=admin/user/active';

  var data_form = {};

  data_form.params = data_tag.attr('data-params')
  data_form.user_id = data_tag.parents('.admin_content_row').attr('data-content-id');

  data_tag.parent().addClass('mini_load');
  console.log(data_form);
  $.ajax({
    url: data_url,
    type: 'post',
    data: data_form,
    dataType: 'json',
    success: function(json){
      console.log(json);
      if(json.success){
        data_tag.parent().removeClass('mini_load');
        data_tag.attr('data-params', params_active[data_form.params]);
        data_tag.text(moment_active[data_form.params]);
      }
    },
    error: function(xhr, ajaxOptions, thrownError){
      console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
});
</script>