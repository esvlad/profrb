<?
function ordered($data, $order){
  if($data == $order){
    return 1;
  } else {
    return 0;
  }
}
?>

<h2 class="modal_title">Показаны материалы: <?=$content_type;?></h2>
<? if($c_type == 'docs') : ?>
  <div class="admin_filter faq_category">
    Фильтр по категориям: <select name="category_id" onchange="docs_filter(this.value);">
      <? if(!$category_id) : ?>
        <option value="0" selected>Все категории</option>
      <? else : ?>
        <option value="0">Все категории</option>
      <? endif; ?>
      <? foreach($cats as $category) : ?>
        <? if($category_id == $category['id']) : ?>
          <option value="<?=$category['id'];?>" selected><?=$category['title'];?></option>
        <? else : ?>
          <option value="<?=$category['id'];?>"><?=$category['title'];?></option>
        <? endif; ?>
      <? endforeach; ?>
    </select>
  </div>
  <div class="admin_filter faq_category">
    Фильтр по популярным: <select name="populars" onchange="get_populars_docs(this.value);">
      <? if(!empty($populars)) : ?>
        <option value="0">Все документы</option>
        <option value="1" selected>В популярных</option>
      <? else : ?>
        <option value="0" selected>Все документы</option>
        <option value="1">В популярных</option>
      <? endif; ?>
    </select>
  </div>
<? endif; ?>
<div class="admin_content_view" data-user-level="<?=$user['level']?>">
  <table class="admin_content_table">
  <thead data-types="<?=$c_type;?>">
    <tr>
      <td>
        <div class="content_views_check">
            <input id="content_id" type="checkbox" name="id[]" value="">
            <label for="content_id"></label>
          </div>
      </td>
      <td>
        <p id="date_creat" data-sorted="<?=$sort;?>" data-sort-active="<?=ordered('date_creat', $order);?>" class="sorted"><span onclick="sorted('date_creat');">Дата создания</span></p>
      </td>
      <td>
        <p id="title" data-sorted="<?=$sort;?>" data-sort-active="<?=ordered('title', $order);?>" class="sorted"><span onclick="sorted('title');">Заголовок</span></p>
      </td>
      <td>
        <p id="type" class="content_views_title">Тип</p>
      </td>
      <? if($c_type == 'geo_news') : ?>
        <td class="geo_news">
          <p id="type" class="content_views_title">Организация</p>
        </td>
      <? endif; ?>
      <? if($c_type == 'docs') : ?>
        <td>
          <p id="views" data-sorted="<?=$sort;?>" data-sort-active="<?=ordered('views', $order);?>" class="sorted"><span onclick="sorted('views');">Количество скачиваний</span></p>
        </td>
        <td>
          <p id="type" class="content_views_title">Закреплен в&nbsp;популярных</p>
        </td>
      <? endif; ?>
      <td></td>
      <td></td>
      <td></td>
    </tr>
  </thead>
  <tbody>
    <? foreach($contents as $content) : ?>
      <tr class="admin_content_row" data-content-type-id="<?=$content['type_id']?>" data-content-id="<?=$content['id']?>">
        <td>
          <div class="content_views_check">
            <input id="content_id<?=$content['id']?>" type="checkbox" name="id[]" value="<?=$content['id']?>">
            <label for="content_id<?=$content['id']?>"></label>
          </div>
        </td>
        <td>
          <p id="ctype_title_name" class="content_views_title"><?=$content['date_creat'];?></p>
        </td>
        <td>
          <p id="ctitle_name" class="content_views_title"><a href="admin/content/update"><?=$content['title'];?></a></p>
        </td>
        <td>
          <p id="ctype_title_name" class="content_views_title"><?=$content['type_title'];?></p>
        </td>
        <? if($c_type == 'geo_news') : ?>
          <td>
            <p id="geo_title" class="content_views_title"><?=$content['geo_title'];?></p>
          </td>
        <? endif; ?>
        <? if($c_type == 'docs') : ?>
        <td>
          <p id="views" class="content_views_title" style="text-align:center;"><b><?=$content['views'];?></b></p>
        </td>
        <td>
          <? $popular_checked = (!empty($content['popular'])) ? ' checked' : null; ?>
          <div class="content_views_check">
            <input id="popular<?=$content['id'];?>" type="checkbox"<?=$popular_checked;?> onchange="change_popular(<?=$content['id'];?>)">
            <label for="popular<?=$content['id'];?>"></label>
          </div>
          <p id="popular" class="content_views_title"></p>
        </td>
      <? endif; ?>
        <td>
          <span onclick="content_event(<?=$content['id'];?>, 'edit');" class="content_event admin_icon icon_update">Редактировать</span>
        </td>
        <td>
          <? if($content['active'] == 1) : ?>
            <span id="content_event" data-event="active" data-params="0" class="content_event admin_icon icon_active">Отключить</span>
          <? else : ?>
            <span id="content_event" data-event="active" data-params="1" class="content_event admin_icon icon_active">Включить</span>
          <? endif; ?>
        </td>
        <td>
          <span id="delete_content" data-id="<?=$content['id']?>" class="content_event admin_icon icon_delete">Удалить</span>
        </td>
      </tr>
    <? endforeach; ?>
    </tbody>
  </table>
  <? if(!empty($paginator)){
      echo $paginator;
    } 
  ?>
</div>
<script>
$('.admin_content_view a').click(function(e){
  e.preventDefault();
});

$('#content_id').change(function(){
  console.log('change');
  $('tbody input[type="checkbox"]').each(function(){
    $(this).trigger('click');
  });
});

$('span#delete_content').click(function(){
  var data_tag = $(this);
  var content_id = data_tag.attr('data-id');
  var element = $('.admin_content_row[data-content-id="'+content_id+'"]');
  var content_title = element.find('#ctitle_name').text();
  var content_type_title = element.find('#ctype_title_name').text();

  data_tag.parent().addClass('mini_load');  

  var data_confirm = confirm('Вы уверены что хотитеудалить материал: '+content_type_title+' - '+content_title);

  if(data_confirm){
    var data_url = 'index.php?r=admin/content/delete';

    $.ajax({
      url: data_url,
      type: 'post',
      data: {cid: content_id},
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

var moment_active = ['Включить', 'Отключить'];
var params_active = [1, 0];
$('span#content_event').click(function(){
  var data_tag = $(this);
  var data_event = data_tag.attr('data-event');
  var data_url = 'index.php?r=admin/content/edit';

  var data = {};

  data.params = data_tag.attr('data-params')
  data.data_event = data_event;
  data.content_id = data_tag.parents('.admin_content_row').attr('data-content-id');
  data.content_type_id = data_tag.parents('.admin_content_row').attr('data-content-type-id');

  data_tag.parent().addClass('mini_load');
  console.log(data);
  $.ajax({
    url: data_url,
    type: 'post',
    data: {data},
    dataType: 'json',
    success: function(json){
      console.log(json);
      if(json.success && data_event == 'active'){
        data_tag.parent().removeClass('mini_load');
        data_tag.attr('data-params', params_active[data.params]);
        data_tag.text(moment_active[data.params]);
      }
    },
    error: function(xhr, ajaxOptions, thrownError){
      console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
});
</script>