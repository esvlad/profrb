<section class="sect <?=$sect_class;?>">
  <div class="wrapper">
    <div class="content">
    <? if(!empty($admin)) : ?>
      <div class="user_auth_hello">
        <p>Привет <?=$admin['name'];?>!</p>
        <p>На <a href="../" target="_self">главную</a>.</p>
      </div>
    <? else : ?>
  		<form id="authForm" action="index.php?r=auth/login/verification" method="post">
        <div class="auth_set_group">
          <div class="auth_form_row">
            <label>Имя пользователя:</label>
            <input class="auth_form_input" type="text" name="login" value="" required>
          </div>
          <div class="auth_form_row">
            <label>Пароль:</label>
            <input class="auth_form_input" type="password" name="password" value="" required>
          </div>
          <div class="auth_form_row">
            <input class="btn brd btn_auth" type="submit" value="Войти">
          </div>
        </div>
  		</form>
    <? endif; ?>
	</div>
  </div>
</section>