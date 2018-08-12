<h2 class="modal_title">Редактирование материала: Внештатная инспекция труда</h2>

<form class="admin_form clearfix" method="post" action="index.php?r=admin/content/save_update&type=static" data-table="content" data-params="save">
    <input type="hidden" name="content_type_id" value="10">
    <input type="hidden" name="content_id" value="<?=$content_id;?>">
    <div class="admin_form_row">
      <label for="title">Название материала*</label>
      <input id="title" type="text" name="title" data-table="content" value="<?=$content['title'];?>" required/>
    </div>
    <div class="admin_form_row content_fields">
      <pre><?#print_r($fields);?></pre>
      <? if(!empty($fields)) : ?>
        <? foreach($fields as $key => $field) : ?>
          <? if($field['name'] == 'labor_image') : ?>
            <div class="admin_form_row">
              <label for="labor_image">Фото сотрудника</label>
              <div id="fileUpload<?=$key;?>" class="file_upload clearfix">
                <input id="labor_image" type="file" name="labor_image[]" data-table="fields" data-file-type="images" class="file_upload_input" onchange="getUploadFiles('labor_image');" value="">
                <?=HtmlHelper::crutchLaborImage($field);?>
                <div id="fileUploaded" class="btn btn_admin" onclick="fileUploadBtn('labor_image');">Добавить файл</div>
                <input class="file_upload_filed" type="hidden" name="labor_image[<?=$field['id'];?>]" value="">
              </div>
              <p class="admin_form_caption">Можно прикрепить лишь 1 фотографию. Разрешены форматы: JPG, PNG, GIF</p>
            </div>
          <? else : ?>
            <?=HtmlHelper::formField($field);?>
          <? endif; ?>
          <? $i = $fields['id']; ?>
        <? endforeach; ?>
      <? endif; ?>
    </div>
    <p id="more_field" class="admin_more_docs" onclick="addField(25)" data-type-id="25" data-type="docs" data-key="<?=++$i;?>">Добавить ещё документ</p>
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
    <div class="admin_form_row setting closed display_none">
      <p class="setting_btn">Настройки</p>
      <label for="type">Тип</label>
      <input id="type" type="text" name="type" data-table="setting" value="content"/>
      <label for="action">Action</label>
      <input id="action" type="text" name="action" data-table="setting" value=""/>
      <label for="tag_id">#Идентификатор</label>
      <input id="tag_id" type="text" name="tag_id" data-table="setting" value=""/>
      <label for="tag_html">Тег HTML</label>
      <input id="tag_html" type="text" name="tag_html" data-table="setting" value=""/>
      <label for="class">.Class</label>
      <input id="class" type="text" name="class" data-table="setting" value=""/>
      <label for="attr">Атрибуты</label>
      <input id="attr" type="text" name="attr" data-table="setting" value=""/>
      <label for="params">Параметры</label>
      <textarea id="params" name="params" data-table="setting"></textarea>
      <label for="order">Порядок</label>
      <input id="order" type="text" name="order" data-table="setting" value=""/>
      <label for="role">Минимальный уровень роли</label>
      <input id="role" type="text" name="role" data-table="setting" value=""/>
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