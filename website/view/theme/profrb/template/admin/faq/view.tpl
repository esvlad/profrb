<?
function ordered($data, $order){
  if($data == $order){
    return 1;
  } else {
    return 0;
  }
}
?>

<h2 class="modal_title">Показаны вопросы</h2>
<div class="admin_content_view admin_faq">
  <div class="admin_filter faq_category">
    Фильтр по категориям: <select name="category_id" onchange="faq_filter(this.value, 'category');">
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
  <div class="admin_filter faq_authors">
    по авторам ответов: <select name="author_id" onchange="faq_filter(this.value, 'author');">
      <? if(!$author_id) : ?>
        <option value="0" selected>Все авторы</option>
      <? else : ?>
        <option value="0">Все авторы</option>
      <? endif; ?>
      <? foreach($authors_answer as $author) : ?>
        <? if($author_id == $author['id']) : ?>
          <option value="<?=$author['id'];?>" selected><?=$author['name'];?></option>
        <? else : ?>
          <option value="<?=$author['id'];?>"><?=$author['name'];?></option>
        <? endif; ?>
      <? endforeach; ?>
    </select>
  </div>
  <table class="admin_content_table">
  <thead data-types="">
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
        <p id="category_id" data-sorted="<?=$sort;?>" data-sort-active="<?=ordered('category_id', $order);?>" class="sorted"><span onclick="sorted('category_id');">Категория</span></p>
      </td>
      <td>
        <p id="question" data-sorted="<?=$sort;?>" data-sort-active="<?=ordered('question', $order);?>" class="sorted"><span onclick="sorted('question');">Название вопроса</span></p>
      </td>
      <td>
        <p id="answered" data-sorted="<?=$sort;?>" data-sort-active="<?=ordered('answered', $order);?>" class="sorted"><span onclick="sorted('answered');">Состояние</span></p>
      </td>
      <td></td>
      <td></td>
      <td></td>
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
          <p class="content_views_title"><a target="_self"><?=$content['title']?></a></p>
        </td>
        <td>
          <p class="content_views_title faq_answer"><?=mb_substr(trim(strip_tags($content['question'])), 0, 45).'...';?></p>
          <div class="modal_qc" data-viewed="0">
            <p class="modal_qc_title">Вопрос:</p><br/>
            <div class="modal_qc_text"><?=$content['question']?></div>
          </div>
        </td>
        <td>
          <div class="content_views_check">
            <? if($content['answered'] == 0) : ?>
              <input id="answered<?=$content['id']?>" type="checkbox" name="answered[<?=$content['id']?>]" onchange="answered_faq(<?=$content['id']?>)" value="1">
            <? else : ?>
              <input id="answered<?=$content['id']?>" type="checkbox" name="answered[<?=$content['id']?>]" onchange="answered_faq(<?=$content['id']?>)" value="0" checked>
            <? endif; ?>
            <label for="answered<?=$content['id']?>"></label>
          </div>
        </td>
        <td>
          <? if($content['answered'] == 0) : ?>
              <span onclick="faq_event(<?=$content['id']?>, 'edit');" class="content_event admin_icon icon_update">Ответить</span>
          <? else : ?>
              <span onclick="faq_event(<?=$content['id']?>, 'edit');" class="content_event admin_icon icon_update">Редактировать</span>
          <? endif; ?>
        </td>
        <td>
          <? if($content['active'] == 1) : ?>
            <span data-content-id="<?=$content['id']?>" onclick="active_faq(<?=$content['id']?>)" class="content_event admin_faq_active admin_icon icon_active">Отключить</span>
            <input id="faq_active<?=$content['id']?>" type="hidden" name="active" value="0">
          <? else : ?>
            <span data-content-id="<?=$content['id']?>" onclick="active_faq(<?=$content['id']?>)" class="content_event admin_faq_active admin_icon icon_active">Включить</span>
            <input id="faq_active<?=$content['id']?>" type="hidden" name="active" value="1">
          <? endif; ?>
        </td>
        <td>
          <span id="deleted" onclick="delete_faq(<?=$content['id']?>)" data-content-id="<?=$content['id']?>" class="content_event admin_icon icon_delete">Удалить</span>
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
        url: 'index.php?r=admin/faq/delete',
        type: 'post',
        data: {cid: data_ids},
        dataType: 'json',
        success: function(json){
          alert('Выбранные элементы удалены!');
          reload_content('faq', <?=$page;?>);
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

  var data_confirm = confirm('Вы уверены что хотитеудалить материал: '+content_type_title+' - '+content_title);

  if(data_confirm){
    var data_url = 'index.php?r=admin/faq/delete';

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

$('.admin_content_table .content_views_title').each(function(){});
</script>