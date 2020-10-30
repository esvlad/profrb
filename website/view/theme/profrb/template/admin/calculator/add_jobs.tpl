<h2 class="modal_title">Добавление нового места работы</h2>

<form class="admin_form clearfix" method="post" data-table="calc" data-params="update">
    <div class="admin_form_row">
      <label for="name">Название места работы</label>
      <p class="admin_form_caption"><b>Обязательно для заполнения</b></p>
      <input id="name" type="text" name="name" data-table="calc_jobs" value="" required/>
    </div>
    <div class="admin_form_row">
      <label for="position">Сортировка</label>
      <p class="admin_form_caption">Введите число в котором порядке будет выведен элемент в калькуляторе, <b>не обязательно</b></p>
      <input id="position" type="text" name="position" data-table="calc_jobs" value=""/>
    </div>
    <div class="admin_form_row">
      <input id="active" type="checkbox" name="active" value="1" checked/>
      <label for="active">Включено</label>
      <p class="admin_form_caption">Уберите галочку если место работы не должено выводиться в калькуляторе</p>
    </div>
    <div class="admin_form_row btns">
      <button class="btn brd btn_admin" id="add" data-btn-event="add">Добавить</button>
    </div>
</form>

<script>

$('#active').change(function(){
  if(!$(this).is(':checked')){
    $(this).val(0);
    $(this).next().text('Выключено');
  } else {
    $(this).val(1);
    $(this).next().text('Включено');
  }
});

var form_error;
$('.admin_modal #add').click(function(e){
  e = e || event;
  e.preventDefault();

  form_error = false;

  var my_form = $(this).parents('.admin_form');

  if(my_form.find('input[required]')){
    my_form.find('input[required]').removeClass('error_form');
    mi = 0;
    my_form.find('input[required]').each(function(){
      my_text = $(this).val();
      if(my_text == '' || my_text == undefined){
        $(this).addClass('error_form');
        form_error = true;
      }
    });
  }

  if(!form_error){
    var post_data = {};

    my_form.find('input').each(function(){
      post_data[$(this).attr('name')] = $(this).val();
    });

    $.ajax({
      url: 'index.php?r=admin/calculator/saveJob',
      type: 'post',
      data: post_data,
      dataType: 'json',
      success: function(json){
        console.log(json);
        if(json.success == true){
          $('.admin_section a[href="admin/calculator/viewJobs"]').trigger('click');
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