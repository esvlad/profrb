<h2 class="modal_title">Редактирование описания модуля Калькулятор ЗП</h2>

<form class="admin_form clearfix" method="post" data-table="calc" data-params="update">
    <input type="hidden" name="id" value="1">
    <div class="admin_form_row">
      <label for="title">Заголовок страницы</label>
      <p class="admin_form_caption">Введите заголовок который будет отображаться на странице модуля, <b>обязательно для заполнения</b></p>
      <input id="title" type="text" name="title" data-table="faq" value="<?=$title;?>" required/>
    </div>
    <div class="admin_form_row">
      <label for="caption">Описание</label>
      <p class="admin_form_caption">Введите текст который будет отображаться перед калькулятором, <b>обязательно для заполнения</b></p>
      <textarea id="caption" name="caption" data-table="faq" required><?=$caption;?></textarea>
    </div>
    <div class="admin_form_row">
      <label for="prompt1">Справка к полю Билет</label>
      <p class="admin_form_caption">Введите текст который будет отображаться в спарвке к полю Билет</p>
      <input id="prompt1" type="text" name="prompt[bilet]" data-table="faq" value="<?=$prompt['bilet'];?>"/>
    </div>
    <div class="admin_form_row">
      <label for="prompt1">Справка к полю Место работы</label>
      <p class="admin_form_caption">Введите текст который будет отображаться в спарвке к полю Место работы</p>
      <input id="prompt1" type="text" name="prompt[jobs]" data-table="faq" value="<?=$prompt['jobs'];?>"/>
    </div>
    <div class="admin_form_row">
      <label for="prompt1">Справка к полю Должность</label>
      <p class="admin_form_caption">Введите текст который будет отображаться в спарвке к полю Должность</p>
      <input id="prompt1" type="text" name="prompt[position]" data-table="faq" value="<?=$prompt['position'];?>"/>
    </div>
    <div class="admin_form_row">
      <label for="prompt1">Справка к полю Сколько часов вы работаете?</label>
      <p class="admin_form_caption">Введите текст который будет отображаться в спарвке к полю Сколько часов вы работаете?</p>
      <input id="prompt1" type="text" name="prompt[how_norm_hour]" data-table="faq" value="<?=$prompt['how_norm_hour'];?>"/>
    </div>
    <div class="admin_form_row">
      <label for="prompt1">Справка к полю Компенсационные выплаты</label>
      <p class="admin_form_caption">Введите текст который будет отображаться в спарвке к полю Компенсационные выплаты</p>
      <input id="prompt1" type="text" name="prompt[compensation]" data-table="faq" value="<?=$prompt['compensation'];?>"/>
    </div>
    <div class="admin_form_row">
      <label for="prompt1">Справка к полю Стимулирующие выплаты</label>
      <p class="admin_form_caption">Введите текст который будет отображаться в спарвке к полю Стимулирующие выплаты</p>
      <input id="prompt1" type="text" name="prompt[pays]" data-table="faq" value="<?=$prompt['pays'];?>"/>
    </div>
    <div class="admin_form_row">
      <label for="prompt1">Справка к полю Количество учащихся</label>
      <p class="admin_form_caption">Введите текст который будет отображаться в спарвке к полю Количество учащихся</p>
      <input id="prompt1" type="text" name="prompt[dop_cpays]" data-table="faq" value="<?=$prompt['dop_cpays'];?>"/>
    </div>
    <div class="admin_form_row btns">
      <button class="btn brd btn_admin" id="save" data-btn-event="save">Сохранить</button>
    </div>
</form>

<script>

CKEDITOR.replace('caption');

var form_error;
$('.admin_modal #save').click(function(e){
  e = e || event;
  e.preventDefault();

  form_error = false;

  var my_form = $(this).parents('.admin_form');

  if(my_form.find('input[required], textarea[required]')){
    my_form.find('input[required], textarea[required]').removeClass('error_form');
    mi = 0;
    my_form.find('input[required], textarea[required]').each(function(){
      my_text = $(this).val();
      if(my_text == '' || my_text == undefined){
        $(this).addClass('error_form');
        form_error = true;
      }
    });
  }

  if(!form_error){
    var post_data = {};

    my_form.find('input, select, textarea').each(function(){
      if($(this).attr('id') == 'caption'){
        post_data[$(this).attr('name')] = CKEDITOR.instances['caption'].getData();
      } else {
        post_data[$(this).attr('name')] = $(this).val();
      }
    });

    $.ajax({
      url: 'index.php?r=admin/calculator/update_setting',
      type: 'post',
      data: post_data,
      dataType: 'json',
      success: function(json){
        console.log(json);
        if(json.success == true){
          location.reload();
        } else {
          console.log('Что-то пошло не так!');
        }
      },
      error: function(xhr, ajaxOptions, thrownError){
        console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  }

  //console.log(post_data);
});
</script>