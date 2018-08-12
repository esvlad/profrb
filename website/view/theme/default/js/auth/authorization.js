$(function() {
	//Открыть форму авторизации
    $("#loginForm").click(function(event) {
        $("#formAutorization").fadeIn(400);
    });
	
	//Открыть форму регистрации
	$("#userRegistration").click(function(){
		$("#formAutorization").fadeOut(300);
		$("#formRegistration").fadeIn(300);
	});
	
	//Открыть форму восстановления пароля
	$("#userForgotPassword").click(function(){
		$("#formAutorization").fadeOut(300);
		$("#formForgotPassword").fadeIn(300);
	});
	
	//Открыть форму выхода
	$("#logOutForm").click(function(){
		$("#formLogOut").fadeIn(300);
	});
	
	$("#loginRegistration").click(function(){
		userForm = $(this).parent(".auth-form-form");
		nameUser = userForm.children("input[name='userName']").val();
		passUser = userForm.children("input[name='userPassword']").val();
		mailUser = userForm.children("input[name='userEmail']").val();
		//alert("Логин -> "+nameUser+" Пароль -> "+passUser+" EMAIL -> "+mailUser);
		
		$.post("/modul/Auth/auth.php",
			{typeAuth : "registration",
			 userName : nameUser,
			 userPassword : passUser,
			 userEmail : mailUser
			},
			function(data){
				if(data.type == 'error'){
					textError = $(".message-error").text();
					if (textError != '') $(".message-error").detach();
					switch(data.report){
						case "message" :
						 userForm.append("<p class=\"message-error\">" + data.answer + "</p>");
						 break;
						case "alert" :
						 alert(data.answer);
						 break;
						default:
						 userForm.children("input[name='" + data.report + "']").after("<p class=\"message-error\">" + data.answer + "</p>");
						 break;
					}
				} else {
					userForm.html("<p class=\"message-success\">" + data.answer + "</p><button class=\"btn btn-success auth-btn-login\" onClick=\"closeAuthForm()\">Закрыть окно</button>");
				}
				console.log(data);
			}
		);
		/* setTimeout(function () {
          document.location.reload();
        }, 0); */
	});
	
	//Авторизация пользователей
	$("#loginAuth").click(function(){
		userForm = $(this).parent(".auth-form-form");
		nameUser = userForm.children("input[name='userName']").val();
		passUser = userForm.children("input[name='userPassword']").val();
		rememberUser = $("input[name='userRemember']:checked").val();
		if(rememberUser != 1) rememberUser = 0;
		//alert(rememberUser);
		$.post("/modul/Auth/auth.php",
			{typeAuth : "authentication",
			 userName : nameUser,
			 userPassword : passUser,
			 userRemember : rememberUser
			},
			function(data){
				if(data.type == 'error'){
					textError = $(".message-error").text();
					if (textError != '') $(".message-error").detach();
					switch(data.report){
						case "message" :
						 userForm.append("<p class=\"message-error error-noname\">" + data.answer + "</p>");
						 break;
						case "alert" :
						 alert(data.answer);
						 break;
						default:
						 userForm.children("input[name='" + data.report + "']").after("<p class=\"message-error\">" + data.answer + "</p>");
						 break;
					}
				} else {
					$(".auth-form-social, .auth-user-registration").detach();
					userForm.html("<p class=\"message-success\">" + data.answer + "</p>");
					setTimeout(function () {
						document.location.reload();
					}, 2000);
				}
				console.log(data);
			}
		);
	});
	
	//Замена пароля
	$("#loginForgot").click(function(){
		userForm = $(this).parent(".auth-form-form");
		loginUser = userForm.children("input[name='userLogin']").val();
		
		$.post("/modul/Auth/auth.php",
			{typeAuth : "forgotPassword",
			 userLogin : loginUser
			},
			function(data){
				if(data.type == 'error'){
					textError = $(".message-error").text();
					if (textError != '') $(".message-error").detach();
					switch(data.report){
						case "message" :
						 userForm.append("<p class=\"message-error error-noname\">" + data.answer + "</p>");
						 break;
						default:
						 userForm.children("input[name='" + data.report + "']").after("<p class=\"message-error\">" + data.answer + "</p>");
						 break;
					}
				} else {
					userForm.html("<p class=\"message-success\">" + data.answer + "</p><button class=\"btn btn-success auth-btn-login\" onClick=\"closeAuthForm()\">Закрыть окно</button>");
					setTimeout(function () {
						document.location.reload();
					}, 5000);
				}
				console.log(data);
			}
		);
	});
	
	$("#loginOut").click(function(){
		$.post("/modul/Auth/auth.php",
			{typeAuth : "logOut"}, 
			function(data){
				if(data.type == 'success'){
					setTimeout(function(){
						document.location.reload();
					},100);
				} 
				console.log(data);
			}
		);
	});
});

//Закрыть все всплывающие формы
$(document).mouseup(function (e) {
    var container = $(".auth-form-overlay");
    if (container.has(e.target).length === 0){
        container.fadeOut(400);
    }
});

function closeAuthForm(){
	$(".auth-form-overlay").fadeOut(400);
}