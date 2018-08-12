<h2 class="modal_title">Добавление нового типа материала</h2>
<form class="admin_form clearfix" method="post" data-table="content" data-params="save">
    <div class="admin_form_row">
      <label for="section">Выберите секцию</label>
      <select id="section" name="section_id" data-table="content">
        <option value="1">Слайдер на главной</option>
        <option value="2">О профсоюзе</option>
        <option value="3">Ближайшие события</option>
        <option value="4">Документы</option>
        <option value="5">Новости</option>
      </select>
    </div>
    <div class="admin_form_row">
      <label for="ctype">Выберите тип контента</label>
      <input id="ctype" type="text" name="type_id" list="content_type" autocomplete="off" data-table="content" value=""/>
      <datalist id="content_type">
        <option>Статический контент</option>
        <option>Календарь событий</option>
        <option>Документы</option>
        <option>Новости</option>
      </datalist>
    </div>
    <div class="admin_form_row setting closed">
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
      <button class="btn brd btn_admin" id="save" data-btn-event="save_close">Сохранить и выйти</button>
    </div>
</form>

<script>
$('.setting > .setting_btn').bind('click', function(){
  $(this).parent().toggleClass('closed opened');
});

$('.admin_modal #save').click(function(e){
  e.preventDefault();
  var data = {},
    post_data = {},
    post_data_settig = {};
  $('.admin_form input, .admin_form select, .admin_form textarea').each(function(){
    if($(this).attr('data-table') == 'setting'){
      post_data_settig[$(this).attr('name')] = $(this).val();
    } else {
      post_data[$(this).attr('name')] = $(this).val();
    }
  });

  data['event'] = $('.admin_form').attr('data-params');
  data['setting'] = post_data_settig;
  data[$('.admin_form').attr('data-table')] = post_data;
  console.log(data);
});
</script>