<ul class="menunav authorization">
<?php if($userLogged != true): ?>
 <li id="loginForm" class="link-duration">Авторизация</li>
<?php else: ?>
 <li id="logOutForm" class="link-duration">Выйти</li>
<?php endif; ?>
</ul>

<!-- Форма авторизации -->
<div id="formAutorization" class="auth-form-overlay" style="display: none;">
 <div class="auth-form-modal">
  <div class="auth-form-title">Вход</div>
  <div class="btn btn-success auth-form-close" onClick="closeAuthForm()">X</div>
  <div class="auth-form-form">
   <input class="auth-form-input" type="text" name="userName" maxlength="50" placeholder="Введите логин" value="" required>
   <input class="auth-form-input" type="password" name="userPassword" maxlength="20"  placeholder="Введите пароль" value="" required>
   <div class="auth-form-label">
    <input id="chekRemember" type="checkbox" name="userRemember" value="1">
    <label class="auth-form-chek-remember" for="chekRemember">Запомнить</label>
    <label id="userForgotPassword" class="auth-forgot-password">Забыли пароль?</label>
   </div>
   <input type="hidden" name="typeAuth" value="authentication">
   <button id="loginAuth" class="btn btn-success auth-btn-login">Войти</button>
  </div>
  <div class="auth-form-social">
	<p>Или через соц. сети</p>
	<div class="auth-social-button">
	 <span class="socauth sa1" title="Кликните, чтобы авторизоваться!" onclick="doLogin('vk')"></span>
	 <span class="socauth sa2" title="Кликните, чтобы авторизоваться!" onclick="doLogin('fb')"></span>
	 <span class="socauth sa3" title="Кликните, чтобы авторизоваться!" onclick="doLogin('ya')"></span>
	</div>
  </div>
  <div id="userRegistration" class="auth-user-registration">Зарегистрироваться</div>
 </div>
</div>

<!-- Форма регистрации -->
<div id="formRegistration" class="auth-form-overlay" style="display: none;">
 <div class="auth-form-modal">
  <div class="auth-form-title">Форма регистрации</div>
  <div id="authCloseForm" class="btn btn-success auth-form-close" onClick="closeAuthForm()">X</div>
  <div class="auth-form-form">
   <input class="auth-form-input" type="text" name="userName" maxlength="50" placeholder="Введите логин" value="" required>
   <input class="auth-form-input" type="email" name="userEmail" maxlength="50" placeholder="Введите E-mail" value="" required>
   <input class="auth-form-input" type="password" name="userPassword" maxlength="20"  placeholder="Введите пароль" value="" required>
   <input type="hidden" name="typeAuth" value="registration">
   <button id="loginRegistration" class="btn btn-success auth-btn-login">Зарегистрироваться</button>
  </div>
 </div>
</div>

<!-- Форма восстановления пароля -->
<div id="formForgotPassword" class="auth-form-overlay" style="display: none;">
 <div class="auth-form-modal">
  <div class="auth-form-title">Форма восстановления пароля</div>
  <div id="authCloseForm" class="btn btn-success auth-form-close" onClick="closeAuthForm()">X</div>
  <div class="auth-form-form">
   <input class="auth-form-input" type="text" name="userLogin" maxlength="100" placeholder="Введите логин или E-mail" value="" required>
   <input type="hidden" name="typeAuth" value="forgotPassword">
   <button id="loginForgot" class="btn btn-success auth-btn-login">Восстановить пароль</button>
  </div>
 </div>
</div>

<!-- Форма выхода -->
<div id="formLogOut" class="auth-form-overlay" style="display: none;">
 <div class="auth-form-modal">
  <div class="auth-form-title">Точно?</div>
  <div id="authCloseForm" class="btn btn-success auth-form-close" onClick="closeAuthForm()">X</div>
  <div class="auth-form-form">
   <button id="loginOut" class="btn btn-success auth-btn-logout logout-yes">Да</button>
   <button class="btn btn-success auth-btn-logout logout-no" onClick="closeAuthForm()">Нет</button>
  </div>
 </div>
</div>

<script src="<?=TPL_PATH;?>default/js/auth/authorization.js"></script>