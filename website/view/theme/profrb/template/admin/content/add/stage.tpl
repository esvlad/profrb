<h2 class="modal_title">Создание материала <?=$content['content_type_title'];?></h2>

<form class="admin_form clearfix" method="post" action="index.php?r=admin/content/save&type=static" data-table="content" data-params="save">
    <input type="hidden" name="content_type_id" value="15">
    <div class="admin_form_row">
      <label for="title">Название материала*</label>
      <input id="title" type="text" name="title" data-table="content" value="" required/>
    </div>
    <div class="admin_form_row content_fields">
      <? if(!empty($content['field_type'])) : ?>
        <? foreach($content['field_type'] as $key => $fields) : ?>
          <?=HtmlHelper::formField($fields, 1);?>
        <? endforeach; ?>
      <? endif; ?>
    </div>
    <p id="more_field" class="admin_more_docs" onclick="addField(45)" data-type-id="45" data-type="stage" data-key="2">Добавить этап</p>
    <p id="more_field" class="admin_more_docs" onclick="addField(25)" data-type-id="25" data-type="docs" data-key="2">Добавить документ</p>
    <div class="admin_form_row">
      <label for="date_creat">Дата публикации</label>
      <input id="date_creat" type="datetime-local" name="date_creat" data-table="content" value=""/>
    </div>
    <div class="admin_form_row">
      <label for="date_end">Дата конца публикации</label>
      <input id="date_end" type="datetime-local" name="date_end" data-table="content" value=""/>
    </div>
    <div class="admin_form_row">
      <input id="active" type="checkbox" name="active" data-table="content" value="" checked/>
      <label for="active">Материал опубликован</label>
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