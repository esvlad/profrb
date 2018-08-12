<h2 class="modal_title">Создание материала <?=$content_type;?></h2>
<form class="admin_form clearfix" method="post" data-table="content" data-params="save">
    <div class="admin_form_row">
      <label for="title">Название материала*</label>
      <input id="title" type="text" name="title" data-table="content" value="" required/>
    </div>
    <div class="admin_form_row">
      <label for="event_caption">Описание *</label>
      <textarea id="event_caption" name="event_caption" data-table="fields" required></textarea>
    </div>
    <div class="admin_form_row">
      <label for="event_link">Призыв к действию (Ссылка)</label>
      <input id="event_link" type="text" name="event_link" data-table="fields" value=""/>
    </div>
    <div class="admin_form_row">
      <label for="date_creat">Дата публикации</label>
      <input id="date_creat" type="datetime" name="date_creat" data-table="content" value=""/>
    </div>
    <div class="admin_form_row">
      <label for="date_end">Дата конца публикации</label>
      <input id="date_end" type="datetime" name="date_end" data-table="content" value=""/>
    </div>
    <div class="admin_form_row">
      <input id="active" type="checkbox" name="active" data-table="content" value="" checked/>
      <label for="active">Отобразить материал</label>
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