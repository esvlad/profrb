<h2 class="modal_title">Создание материала <?=$content['content_type_title'];?></h2>

<form class="admin_form clearfix admin_content_history" method="post" action="index.php?r=admin/content/save&type=static" data-table="content" data-params="save">
    <input type="hidden" name="content_type_id" value="11">
    <div class="admin_form_row">
      <label for="title">Название материала</label>
      <input id="title" type="text" name="title" data-table="content" value="" required/>
    </div>
    <div class="admin_form_row">
      <label for="filter_id">Категория новости</label>
      <select id="filter_id" name="filter_id" data-table="content">
        <option value="6" selected>Обычная новость</option>
        <option value="4">Фотоотчет</option>
        <option value="5">Видеоотчет</option>
      </select>
    </div>
    <div class="admin_form_row">
      <input id="important_news" name="important_news" data-table="fields" type="checkbox" value="1">
      <label for="important_news">Важная новость</label>
      <p class="admin_form_caption">Отметьте, если это важное событие, отображается слева с большой превью!</p>
    </div>
    <div class="admin_form_row content_fields">
      <? if(!empty($content['field_type'])) : ?>
        <? foreach($content['field_type'] as $key => $fields) : ?>
          <?=HtmlHelper::formField($fields, 1);?>
        <? endforeach; ?>
      <? endif; ?>
    </div>
    <p id="more_field" class="admin_more_docs" onclick="addField(37)" data-type-id="37" data-type="news_image" data-key="2">Добавить картинку</p>
    <p id="more_field" class="admin_more_docs" onclick="addField(26)" data-type-id="26" data-type="text" data-key="2">Добавить текстовое поле</p>
    <p id="more_field" class="admin_more_docs" onclick="addField(38)" data-type-id="38" data-type="gallery_image" data-key="2">Добавить галерею</p>
    <div class="admin_form_row">
      <label for="date_creat">Дата публикации</label>
      <input id="date_creat" type="datetime-local" name="date_creat" data-table="content" value=""/>
    </div>
    <div class="admin_form_row">
      <label for="date_end">Дата конца публикации</label>
      <input id="date_end" type="datetime-local" name="date_end" data-table="content" value=""/>
    </div>
    <div class="admin_form_row">
      <input id="active" type="checkbox" name="active" data-table="content" value="1" checked/>
      <label for="active">Материал опубликован</label>
    </div>
    <div class="admin_form_row">
      <input id="is_letter" type="checkbox" name="is_letter" data-table="content" value="1" checked/>
      <label for="is_letter">Включено в рассылку</label>
    </div>
    <div class="admin_form_row btns">
      <button class="btn brd btn_admin" id="save" data-btn-event="save">Сохранить</button>
    </div>
</form>

<script>

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