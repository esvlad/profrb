<h2 class="modal_title">Редактирование материала <?=$content['content_type_title'];?></h2>

<form class="admin_form clearfix" method="post" action="index.php?r=admin/content/save_update&type=static" data-table="content" data-params="save">
    <input type="hidden" name="content_type_id" value="17">
    <input type="hidden" name="content_id" value="<?=$content_id;?>">
    <div class="admin_form_row">
      <label for="title">Название материала* - <?=$user_level;?></label>
      <input id="title" type="text" name="title" data-table="content" value="<?=$content['title'];?>" disabled required/>
    </div>
    <? $none_class = ($user_level < 80) ? ' display_none' : ''; ?>
    <div class="admin_form_row<?=$none_class;?>">
        <label for="geo_page">Организация</label>
        <p class="admin_form_caption">Введите или выберите существующий</p>
        <? if($user_level > 80) : ?>
          <input id="geo_page" name="geo_id" required="required" list="list_geo_page" value="<?=$geo_id;?>">
          <datalist id="list_geo_page">
            <? foreach($geo_objects as $geo) : ?>
              <option value="<?=$geo['id'];?>"><?=$geo['title'];?></option>
            <? endforeach; ?>
          </datalist>
        <? else : ?>
          <input id="geo_page" name="geo_id" required="required" list="list_geo_page" value="<?=$geo_id;?>">
        <? endif; ?>
    </div>
    <div class="admin_form_row content_fields">
      <? if(!empty($fields)) : ?>
        <? foreach($fields as $key => $field) : ?>
          <?=HtmlHelper::formField($field);?>
        <? endforeach; ?>
      <? endif; ?>
    </div>
    <div class="admin_form_row">
      <label for="date_creat">Дата публикации</label>
      <input id="date_creat" type="datetime-local" name="date_creat" data-table="content" value="<?=$content['date_creat'];?>"/>
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

var tid = [];
$('textarea').each(function(){
  tid.push($(this).attr('id'));
});

for(var i = 0; i<$('textarea').length; i++){
  CKEDITOR.replace(tid[i]);
}

</script>