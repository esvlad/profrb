<h2 class="modal_title">Действия пользователей</h2>
<div class="admin_content_view admin_user">
  <table class="admin_content_table notifications">
  <thead data-types="comments">
    <tr>
      <td>
        <div class="content_views_check">
            <input id="content_id" type="checkbox" name="id_all" value="">
            <label for="content_id"></label>
          </div>
      </td>
      <td>
        <p>Дата</p>
      </td>
      <td>
        <p>Уведомление</p>
      </td>
      <!--<td></td>-->
    </tr>
  </thead>
  <tbody>
    <? foreach($notifications as $notification) : ?>
      <? $tr_class = ($notification['view'] == 1) ? ' is_view' : ' no_view'; ?>
      <tr class="admin_content_row<?=$tr_class;?>" data-content-type-id="0" data-content-id="<?=$notification['id']?>">
        <td>
          <div class="content_views_check">
            <input id="content_id<?=$notification['id']?>" type="checkbox" name="id[<?=$notification['id']?>]" value="<?=$notification['id']?>">
            <label for="content_id<?=$notification['id']?>"></label>
          </div>
        </td>
        <td>
          <p class="content_views_title"><?=$notification['date'];?></p>
        </td>
        <td>
          <p class="content_views_title"><?=$notification['message'];?></p>
        </td>
        <!--<td>
          <? if($notification['active'] == 1) : ?>
            <span id="content_event" data-event="active" data-params="0" class="content_event admin_icon icon_active"><a href="<?=$notification['href'];?>">Посмотреть</a></span>
          <? else : ?>
            <span id="content_event" data-event="active" data-params="1" class="content_event admin_icon icon_active">Просмотрено</span>
          <? endif; ?>
        </td>-->
      </tr>
    <? endforeach; ?>
  </tbody>
  </table>
  <div id="viewed_ids" class="btn brd btn_admin btn_delete_ids vieweds">Отметить просмотренными</div>
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

$('#viewed_ids').click(function(){
  var data_ids = [];

  $('input[name^="id"]:checked').each(function(){
    data_ids.push($(this).val());
    $(this).parents('.admin_content_row').removeClass('no_view');
    $(this).parents('.admin_content_row').addClass('is_view');
  });

  if(data_ids.length > 0){
      $.ajax({
        url: 'index.php?r=admin/notification/active',
        type: 'post',
        data: {ids: data_ids},
        dataType: 'json',
        success: function(json){
          //$('.admin_section a[href="admin/notification/view"]').trigger('click');
        }
      });
  } else {
    alert('Ничего не выбрано');
  }
});

var moment_active = ['Разблокировать', 'Заблокировать'];
var params_active = [1, 0];
$('span#content_event').click(function(){
  var data_tag = $(this);
  var data_url = 'index.php?r=admin/notification/active';

  var data_form = {};

  data_form.params = data_tag.attr('data-params');
  data_form.user_id = data_tag.parents('.admin_content_row').attr('data-content-id');

  data_tag.parent().addClass('mini_load');
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