<?
function ordered($data, $order){
  if($data == $order){
    return 1;
  } else {
    return 0;
  }
}
?>
<h2 class="modal_title">Показаны подписчики</h2>
<div class="admin_content_view admin_letters">
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
        <p id="mail" data-sorted="<?=$sort;?>" data-sort-active="<?=ordered('mail', $order);?>" class="sorted"><span onclick="sorted('mail');">E-mail</span></p>
      </td>
      <td>
        <p id="news" class="sorted" data-sorted="<?=$sort;?>" data-sort-active="<?=ordered('news', $order);?>"><span onclick="sorted('news');">новости</span></p>
      </td>
      <td>
        <p id="docs" class="sorted" data-sorted="<?=$sort;?>" data-sort-active="<?=ordered('docs', $order);?>"><span onclick="sorted('docs');">документы</span></p>
      </td>
      <td>
        <p id="events" class="sorted" data-sorted="<?=$sort;?>" data-sort-active="<?=ordered('events', $order);?>"><span onclick="sorted('events');">события</span></p>
      </td>
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
          <p class="content_views_title"><?=$content['id']?></p>
        </td>
        <td>
          <p class="content_views_title"><?=$content['mail']?></p>
        </td>
        <td>
          <p class="content_views_title isset_keys" data-key="<?=$content['news']?>"></p>
        </td>
        <td>
          <p class="content_views_title isset_keys" data-key="<?=$content['docs']?>"></p>
        </td>
        <td>
          <p class="content_views_title isset_keys" data-key="<?=$content['events']?>"></p>
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
    var data_confirm = confirm('Вы уверенны, что хотите удалить выбранные элементы?');

    console.log(data_ids);

    if(data_confirm){
      $.ajax({
        url: 'index.php?r=admin/letters/delete',
        type: 'post',
        data: {ids: data_ids},
        dataType: 'json',
        success: function(json){
          alert('Выбранные элементы удалены!');
          console.log(data_ids);
          reload_content('letters', <?=$page;?>);
        }
      });
    }
  } else {
    alert('Ничего не выбрано');
  }
});
</script>