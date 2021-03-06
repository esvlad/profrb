<h2 class="modal_title">Добавление новой секции</h2>
<form class="admin_form clearfix" method="post" data-table="section" data-params="save">
    <div class="admin_form_row">
      <label for="page">Выберите page*</label>
      <select id="page" name="page_id" data-table="page">
        <? foreach($page as $p) : ?>
          <option value="<?=$p['id']?>"><?=$p['title']?></option>
        <? endforeach; ?>
      </select>
    </div>
    <div class="admin_form_row">
      <label for="name">Машинное имя*</label>
      <input id="name" type="text" name="name" data-table="section" value="" required/>
    </div>
    <div class="admin_form_row">
      <label for="action">Обработчик*</label>
      <input id="action" type="text" name="action" data-table="section" value="" required/>
    </div>
    <div class="admin_form_row">
      <label for="title">Название*</label>
      <input id="title" type="text" name="title" data-table="section" value="" required/>
    </div>
    <div class="admin_form_row">
      <label for="order">Позиция отображения на странице</label>
      <select id="order" name="order" data-table="section">
        <? for($o = 0; $o <= 20; $o++) : ?>
          <option value="<?=$o;?>"><?=$o;?></option>
        <? endfor; ?>
      </select>
    </div>
    <div class="admin_form_row">
      <input id="active" type="checkbox" name="active" data-table="section" value="1" checked/>
      <label for="active">Секция видна</label>
    </div>
    <div class="admin_form_row setting closed">
      <p class="setting_btn">Настройки</p>
      <label for="type">Тип</label>
      <input id="type" type="text" name="type" data-table="setting" value="section"/>
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
    post_data_page = {},
    post_data_settig = {};

  var btn = $(this).attr('data-btn-event');

  $('.admin_form input, .admin_form select, .admin_form textarea').each(function(){
    if($(this).attr('data-table') == 'setting'){
      post_data_settig[$(this).attr('name')] = $(this).val();
    } else if ($(this).attr('data-table') == 'page'){
      data['page_id'] = $(this).val();
    } else {
      post_data[$(this).attr('name')] = $(this).val();
    }
  });

  data['event'] = $('.admin_form').attr('data-params');
  data['type'] = $('.admin_form').attr('data-table');
  data['setting'] = post_data_settig;
  data[$('.admin_form').attr('data-table')] = post_data;
  console.log(data);

  saveData(data, btn);
});
</script>