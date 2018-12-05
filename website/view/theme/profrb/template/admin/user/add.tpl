<h2 class="modal_title">Добавление нового пользователя</h2>
<form id="user_add" class="admin_form clearfix" method="post" data-table="content" data-params="save">
    <input type="hidden" name="event" value="add">
    <input type="hidden" name="level_id" value="1">
    <input type="hidden" name="name" value="Редактор">
    <input type="hidden" name="impurity" value="0Grs56a">
    <input type="hidden" name="active" value="1">
    <div class="admin_form_row">
      <label for="login">Придумайте логин *</label>
      <input id="login" type="text" name="login" value="" required/>
    </div>
    <div class="admin_form_row">
      <label for="email">Введите email</label>
      <input id="email" type="mail" name="email" value=""/>
    </div>
    <div class="admin_form_row">
      <label for="org_id">Выберите организацию *</label>
      <input id="org_id" type="text" name="org_id" value="" list="list_geo_page" required/>
      <datalist id="list_geo_page">
        <? foreach($geo_objects as $geo) : ?>
          <option value="<?=$geo['id'];?>"><?=$geo['title'];?></option>
        <? endforeach; ?>
      </datalist>
    </div>
    <div class="admin_form_row clearfix">
      <label for="password">Придумайте или сгенерируйте пароль *</label>
      <input id="password" type="text" name="password" value="" required/>
      <span id="generation_password" class="btn brd btn_admin gpass">Сгенерировать пароль</span>
    </div>
    <div class="admin_form_row btns">
      <button class="btn brd btn_admin" id="save" data-btn-event="save">Сохранить</button>
    </div>
</form>
<script>
$('#generation_password').click(function(){
  $('#password').val(password_generator());
});

$('#user_add').submit(function(event) {
  event.preventDefault();

  var data_form = $(this).serialize();
  action_user('save', data_form);
});
</script>