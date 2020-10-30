<h2 class="modal_title">Редактирование должности</h2>

<form class="admin_form clearfix" method="post" data-table="calc" data-params="update">
    <input type="hidden" name="id" value="<?=$content['id'];?>">
    <div class="admin_form_row">
      <label for="job_id">Место работы</label>
      <p class="admin_form_caption">Выберите место работы</p>
      <select id="job_id" name="job_id">
        <? foreach($jobs as $job) : ?>
          <? if($job['id'] == $content['job_id']) : ?>
            <option value="<?=$job['id'];?>" selected><?=$job['name'];?></option>
          <? else : ?>
            <option value="<?=$job['id'];?>"><?=$job['name'];?></option>
          <? endif; ?>
        <? endforeach; ?>
      </select>
    </div>
    <div class="admin_form_row">
      <label for="name">Название должности</label>
      <p class="admin_form_caption"><b>Обязательно для заполнения</b></p>
      <input id="name" type="text" name="name" data-table="calc_position" value="<?=$content['name']?>" required/>
    </div>
    <div class="admin_form_row">
      <label for="oklad">Оклад</label>
      <p class="admin_form_caption"><b>Обязательно для заполнения</b></p>
      <input id="oklad" type="text" name="oklad" data-table="calc_position" value="<?=$content['oklad']?>" required/>
    </div>
    <div class="admin_form_row">
      <label for="norm_hour">Норма часов</label>
      <p class="admin_form_caption"><b>Обязательно для заполнения</b></p>
      <input id="norm_hour" type="text" name="norm_hour" data-table="calc_position" value="<?=$content['norm_hour']?>" required/>
    </div>
    <div class="admin_form_row">
      <label for="position">Сортировка</label>
      <p class="admin_form_caption">Введите число в котором порядке будет элемент в калькуляторе, <b>не обязательно</b></p>
      <input id="position" type="text" name="position" data-table="calc_jobs" value="<?=$content['position'];?>"/>
    </div>
    <div class="admin_form_row">
      <? if($content['active'] == 1) : ?>
        <input id="active" type="checkbox" name="active" data-table="faq" value="1" checked/>
      <? else : ?>
        <input id="active" type="checkbox" name="active" data-table="faq" value="0"/>
      <? endif; ?>
      <label for="active">Включено</label>
      <p class="admin_form_caption">Уберите галочку если место работы не должено выводиться в калькуляторе</p>
    </div>
    <div class="admin_form_row btns">
      <button class="btn brd btn_admin" id="edit" data-btn-event="edit">Сохранить</button>
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
$('.admin_modal #edit').click(function(e){
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

    my_form.find('input, select').each(function(){
      if($(this).val() != '') post_data[$(this).attr('name')] = $(this).val();
    });

    $.ajax({
      url: 'index.php?r=admin/calculator/updatePosition',
      type: 'post',
      data: post_data,
      dataType: 'json',
      success: function(json){
        console.log(json);
        if(json.success == true){
          $('.admin_section a[href="admin/calculator/viewPositions"]').trigger('click');
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