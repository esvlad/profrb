<h2 class="modal_title">Редактирование материала <?=$content['content_type_title'];?></h2>

<form class="admin_form clearfix admin_content_history" method="post" action="index.php?r=admin/content/save_update&type=static" data-table="content" data-params="save">
    <input type="hidden" name="content_type_id" value="11">
    <input type="hidden" name="content_id" value="<?=$content_id;?>">
    <div class="admin_form_row">
      <label for="title">Название материала</label>
      <input id="title" type="text" name="title" data-table="content" value="<?=$content['title'];?>" required/>
    </div>
    <div class="admin_form_row categ">
      <label for="filter_id">Категория новости</label>
      <select id="filter_id" name="filter_id" data-table="content">
        <? foreach($filters as $filter) : ?>
          <? if($content['filter_id'] == $filter['id']) : ?>
            <option value="<?=$filter['id']?>" selected><?=$filter['title']?></option>
          <? else : ?>
            <option value="<?=$filter['id']?>"><?=$filter['title']?></option>
          <? endif; ?>
        <? endforeach; ?>
      </select>
    </div>
    <div class="admin_form_row content_fields">
      <? if(!empty($fields)) : ?>
        <? $i = 0; ?>
        <? foreach($fields as $key => $field) : ?>
          <? if($field['name'] == 'preview_news') : ?>
            <div class="admin_form_row preview_news">
              <label for="preview_news">Превью</label>
              <div id="fileUpload<?=$key;?>" class="file_upload preview clearfix">
                <input id="preview_news" type="file" name="preview_news" data-table="fields" data-file-type="images" class="file_upload_input" onchange="getUploadFiles('preview_news');" value="">
                <? 
                  if($field['body'] != '') {
                    echo HtmlHelper::crutchLaborImage($field);
                  }
                ?>
                <div id="fileUploaded" class="btn btn_admin" onclick="fileUploadBtn('preview_news');">Добавить файл</div>
                <input class="file_upload_filed" type="hidden" name="preview_news[<?=$field['id'];?>]" value="<?=$field['body'];?>">
                <input type="hidden" name="order[<?=$field['id'];?>]" value="-50">
              </div>
              <p class="admin_form_caption">Обязательно для важных новостей и фото/видео отчетов. Можно прикрепить лишь 1 картинку. Размер картинки должены быть 770x667 пикселей (Ш х В). Разрешены форматы: JPG, PNG, GIF</p>
            </div>
          <? elseif($field['name'] == 'important_news') : ?>
            <div class="admin_form_row">
              <? if($field['body'] == 1) : ?>
                <input id="important_news" name="important_news" data-table="fields" type="checkbox" value="1" checked>
              <? else : ?>
                <input id="important_news" name="important_news" data-table="fields" type="checkbox" value="1">
              <? endif; ?>
              <label for="important_news">Важная новость</label>
              <p class="admin_form_caption">Отметьте, если это важное событие, отображается слева с большой превью!</p>
            </div>
          <? else : ?>
            <?=HtmlHelper::formField($field);?>
          <? endif; ?>
          <? if($field['id'] > $i) $i = $field['id']; ?>
        <? endforeach; ?>
        <? $i+=100000; ?>
      <? endif; ?>
    </div>
    <p id="more_field" class="admin_more_docs" onclick="addField(37)" data-type-id="37" data-type="news_image" data-key="<?=$i;?>">Добавить картинку</p>
    <p id="more_field" class="admin_more_docs" onclick="addField(26)" data-type-id="26" data-type="text" data-key="<?=$i;?>">Добавить текстовое поле</p>
    <p id="more_field" class="admin_more_docs" onclick="addField(38)" data-type-id="38" data-type="gallery_image" data-key="<?=$i;?>">Добавить галерею</p>
    <div class="admin_form_row">
      <label for="date_creat">Дата публикации</label>
      <input id="date_creat" type="datetime-local" name="date_creat" data-table="content" value="<?=$content['date_creat'];?>"/>
    </div>
    <div class="admin_form_row">
      <label for="date_end">Дата конца публикации</label>
      <input id="date_end" type="datetime-local" name="date_end" data-table="content" value="<?=$content['date_end'];?>"/>
    </div>
    <div class="admin_form_row">
      <? $checked = ($content['active'] == 1) ? 'checked' : null; ?>
      <input id="active" type="checkbox" name="active" data-table="content" value="1" <?=$checked;?> />
      <label for="active">Материал опубликован</label>
    </div>
    <div class="admin_form_row btns">
      <button class="btn brd btn_admin" id="save" data-btn-event="save">Сохранить</button>
    </div>
</form>

<script>


$('.preview_news').insertAfter($('.admin_form_row.categ'));

$('.file_upload_filed').each(function(){
  group = $(this).attr('name');
  ngroup = group.replace('[group]','');
  $(this).attr('name',ngroup);
});

var tid = [];
$('textarea').each(function(){
  tid.push($(this).attr('id'));
});

for(var i = 0; i<$('textarea').length; i++){
  CKEDITOR.replace(tid[i]);
}

$('.setting > .setting_btn').bind('click', function(){
  $(this).parent().toggleClass('closed opened');
});

</script>