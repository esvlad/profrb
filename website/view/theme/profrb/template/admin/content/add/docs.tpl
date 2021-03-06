<h2 class="modal_title">Создание материала <?=$content['content_type_title'];?></h2>

<form class="admin_form clearfix" method="post" action="index.php?r=admin/content/save&type=static" data-table="content" data-params="save">
    <input type="hidden" name="content_type_id" value="14">
    <div class="admin_form_row">
      <label for="title">Название документа</label>
      <input id="title" type="text" name="title" data-table="content" value="" required/>
    </div>
    <div class="admin_form_row">
      <label for="category_id">Категория документа</label>
      <select id="category_id" name="category_id" data-table="content">
        <? foreach($content['category'] as $category) : ?>
          <option value="<?=$category['id']?>"><?=$category['title']?></option>
        <? endforeach; ?>
      </select>
    </div>
    <div class="admin_form_row">
      <label for="filter_id">Фильтр</label>
      <select id="filter_id" name="filter_id" data-table="content">
        <? foreach($content['filters'] as $filter) : ?>
          <option value="<?=$filter['id']?>"><?=$filter['title']?></option>
        <? endforeach; ?>
      </select>
    </div>
    <div class="admin_form_row content_fields content_fields_doc">
      <? if(!empty($content['field_type'])) : ?>
        <? foreach($content['field_type'] as $key => $fields) : ?>
          <?=HtmlHelper::formField($fields, 1);?>
        <? endforeach; ?>
      <? endif; ?>
    </div>
    <div class="admin_form_row">
      <label for="date_creat">Дата публикации</label>
      <input id="date_creat" type="datetime-local" name="date_creat" data-table="content" value=""/>
    </div>
    <div class="admin_form_row">
      <label for="date_end">Дата конца публикации</label>
      <input id="date_end" type="datetime-local" name="date_end" data-table="content" value=""/>
    </div>
    <div class="admin_form_row">
      <input id="popular" type="checkbox" name="popular" data-table="content" value="1"/>
      <label for="popular">Закрепить в популярных документах</label>
    </div>
    <div class="admin_form_row">
      <input id="active" type="checkbox" name="active" data-table="content" value="1" checked/>
      <label for="active">Материал опубликован</label>
    </div>
    <div class="admin_form_row">
      <input id="is_letter" type="checkbox" name="is_letter" data-table="content" value="1" checked/>
      <label for="is_letter">Включено в рассылку</label>
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

$('label[for="docs_title"], #docs_title, #remove_field').detach();

$('.file_upload_input').each(function(){
  group = $(this).attr('name');
  $(this).attr('id','docs');
  ngroup = group.replace('[25]','');
  $(this).attr('name',ngroup);
});

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