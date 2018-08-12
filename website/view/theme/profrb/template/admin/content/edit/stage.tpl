<h2 class="modal_title">Редактирование материала <?=$content['content_type_title'];?></h2>

<form class="admin_form clearfix" method="post" action="index.php?r=admin/content/save_update&type=static" data-table="content" data-params="save">
    <input type="hidden" name="content_type_id" value="15">
    <input type="hidden" name="content_id" value="<?=$content_id;?>">
    <div class="admin_form_row">
      <label for="title">Название материала*</label>
      <input id="title" type="text" name="title" data-table="content" value="<?=$content['title'];?>" required/>
    </div>
    <div class="admin_form_row content_fields">
      <? if(!empty($fields)) : ?>
        <? $i = 0; ?>
        <? foreach($fields as $key => $field) : ?>
          <?=HtmlHelper::formField($field);?>
          <? if($field['id'] > $i) $i = $field['id']; ?>
        <? endforeach; ?>
        <? $i+=100000; ?>
      <? endif; ?>
    </div>
    <p id="more_field" class="admin_more_docs" onclick="addField(45)" data-type-id="45" data-type="stage" data-key="<?=$i;?>">Добавить этап</p>
    <p id="more_field" class="admin_more_docs" onclick="addField(25)" data-type-id="25" data-type="docs" data-key="<?=$i;?>">Добавить документ</p>
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
$('.admin_form_row #fileUpload').each(function(){
	var dfid = $(this).find('.file_upload_filed').val();
	var difid = $(this).find('input#docs').attr('id');
	var newfid = difid + dfid;
	$(this).find('input#docs').attr('id', newfid);
});

$('.file_upload_filed').each(function(){
  group = $(this).attr('name');
  ngroup = group.replace('[group]','');
  $(this).attr('name',ngroup);
});

var tid = [];
$('textarea').each(function(){
	var tarea = $(this).attr('data-tarea');
	var tt = $(this).attr('id');
	var newtid = tt + tarea;
	$(this).attr('id',newtid);
	tid.push(newtid);
});

for(var i = 0; i<$('textarea').length; i++){
  CKEDITOR.replace(tid[i]);
}

$('.setting > .setting_btn').bind('click', function(){
  $(this).parent().toggleClass('closed opened');
});
</script>