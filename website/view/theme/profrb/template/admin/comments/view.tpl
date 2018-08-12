<?
function ordered($data, $order){
  if($data == $order){
    return 1;
  } else {
    return 0;
  }
}
?>
<h2 class="modal_title">Показаны комментарии</h2>
<div class="admin_content_view admin_comments">
  <div class="admin_filter">
    Фильтр: 
    <select name="active" onchange="filter_comments(this.value);">
      <option value="all">Все комментарии</option>
      <option value="not_moder">Не проверенные</option>
      <option value="is_moder">Проверенные</option>
      <option value="admin_comment">Свои</option>
    </select>
  </div>
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
        <p id="date_creat" data-sorted="<?=$sort;?>" data-sort-active="<?=ordered('date_creat', $order);?>" class="sorted"><span onclick="sorted('date_creat');">Дата создания</span></p>
      </td>
      <td>
        <p>Автор</p>
      </td>
      <td>
        <p>Комментарий</p>
      </td>
      <td>
        <p class="sorted" data-sorted="<?=$sort;?>" data-sort-active="<?=ordered('faq_id', $order);?>"><span onclick="sorted('faq_id');">ID вопроса</span></p>
      </td>
      <td>
        <p>Состояние</p>
      </td>
      <td></td>
    </tr>
  </thead>
  <tbody>
    <? foreach($contents as $content) : ?>
      <tr class="admin_content_row" data-content-type-id="0" data-content-id="<?=$content['id']?>">
        <td>
          <div class="content_views_check">
            <input id="content_id<?=$content['id']?>" type="checkbox" name="id[<?=$content['id']?>]" value="<?=$content['id']?>">
            <label for="content_id<?=$content['id']?>"></label>
          </div>
        </td>
        <td>
          <p class="content_views_title"><?=$content['date_creat']?></p>
        </td>
        <td>
          <p class="content_views_title"><a target="_self"><?=$content['author']?></a></p>
        </td>
        <td>
          <p class="content_views_title" title="<?=$content['text']?>"><?=mb_substr($content['text'], 0, 45).'...';?></p>
          <div class="modal_qc" data-viewed="0">
            <div class="modal_qc_text"><?=$content['text']?></div>
          </div>
        </td>
        <td>
          <p class="faq_id"><span id="view_faq"><?=$content['faq_id']?></span></p>
          <div class="modal_qc" data-viewed="0">
            <p class="modal_qc_title">Вопрос:</p>
            <div class="modal_qc_text"><?=$content['question'];?></div>
            <p class="modal_qc_title">Ответ:</p>
            <div class="modal_qc_text"><?=$content['answer'];?></div>
          </div>
        </td>
        <td>
          <? if($content['active'] == 1) : ?>
            <span data-content-id="<?=$content['id']?>" onclick="active_faq(<?=$content['id']?>, 'comment')" class="content_event admin_faq_active admin_icon icon_active">Опубликован</span>
            <input id="faq_active<?=$content['id']?>" type="hidden" name="active" value="1">
          <? else : ?>
            <span data-content-id="<?=$content['id']?>" onclick="active_faq(<?=$content['id']?>, 'comment')" class="content_event admin_faq_active admin_icon icon_active">Не опубликован</span>
            <input id="faq_active<?=$content['id']?>" type="hidden" name="active" value="0">
          <? endif; ?>
        </td>
        <td>
          <span id="deleted" onclick="delete_comments(<?=$content['id']?>)" data-content-id="<?=$content['id']?>" class="content_event admin_icon icon_delete">Удалить</span>
        </td>
      </tr>
    <? endforeach; ?>
  </tbody>
  </table>
  <div id="delete_ids" class="btn brd btn_admin btn_delete_ids">Удалить отмеченное</div>
  <div class="clearfix"></div>
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
  $('input[name^="id"]').trigger('click');
});

$('#delete_ids').click(function(){
  var data_ids = [];

  $('input[name^="id"]:checked').each(function(){
    data_ids.push($(this).val());
  });

  if(data_ids.length > 0){
    var data_confirm = confirm('Вы уверенны, что хотите удалить выбранные элементы?');

    //console.log(data_ids);

    if(data_confirm){
      $.ajax({
        url: 'index.php?r=admin/comments/delete',
        type: 'post',
        data: {cid: data_ids},
        dataType: 'json',
        success: function(json){
          alert('Выбранные элементы удалены!');
          reload_content('comments', <?=$page;?>);
        }
      });
    }
  } else {
    alert('Ничего не выбрано');
  }
});

$('span#delete_content').click(function(){
  var data_tag = $(this);
  var content_id = data_tag.attr('data-id');
  var element = $('.admin_content_row[data-content-id="'+content_id+'"]');
  var content_title = element.find('#ctitle_name').text();
  var content_type_title = element.find('#ctype_title_name').text();

  data_tag.parent().addClass('mini_load');  

  var data_confirm = confirm('Вы уверены что хотите удалить комментарий: '+content_title);

  if(data_confirm){
    var data_url = 'index.php?r=admin/comments/delete';

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
</script>