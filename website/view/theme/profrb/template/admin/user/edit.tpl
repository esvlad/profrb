<h2 class="modal_title">Добавление нового пользователя</h2>
<form id="user_add" class="admin_form clearfix" method="post" data-table="content" data-params="save">
    <input type="hidden" name="event" value="update">
    <input type="hidden" name="user_id" value="<?=$user['id'];?>">
    <div class="admin_form_row">
      <label for="login">Логин *</label>
      <input id="login" type="text" name="login" value="<?=$user['login'];?>" required/>
    </div>
    <div class="admin_form_row">
      <label for="email">Email</label>
      <input id="email" type="text" name="email" value="<?=$user['email'];?>"/>
    </div>
    <div class="admin_form_row">
      <label for="org_id">Организация *</label>
      <input id="org_id" type="text" name="org_id" value="<?=$user['org_id'];?>" list="list_geo_page" required/>
      <datalist id="list_geo_page">
        <? foreach($content['geo_objects'] as $geo) : ?>
          <option value="<?=$geo['id'];?>"><?=$geo['title'];?></option>
        <? endforeach; ?>
      </datalist>
    </div>
    <div class="admin_form_row">
      <label for="password">Пароль *</label>
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