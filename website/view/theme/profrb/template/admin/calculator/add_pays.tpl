<h2 class="modal_title">Добавление новой выплаты</h2>

<form class="admin_form admin_form_calc_cp clearfix" method="post" data-table="calc" data-params="add">
    <div class="admin_form_row">
      <label for="type">Тип выплаты</label>
      <p class="admin_form_caption">Выберите тип выплаты, <b>обязательно для заполнения</b></p>
      <select id="type" name="type">
        <option value="1" selected>Начисляется к оплате за фактический объем работы</option>
        <option value="2">Начисляется на оклад (ставку) работника</option>
      </select>
    </div>
    <div class="admin_form_row">
      <label for="positions">Должность</label>
      <p class="admin_form_caption">Выберите должность, <b>для выбора нескольких должностей выбирайте зажав клавишу CTRL</b></p>
      <select id="positions" name="positions[]" multiple style="min-height: 200px; height: 250px; resize: vertical;">
        <? foreach($positions as $position) : ?>
            <option value="<?=$position['id'];?>"><?=$position['name'];?></option>
        <? endforeach; ?>
      </select>
      <div id="all_positions" class="btn brd btn_admin" style="margin-bottom: 20px; width: 250px; float: none; clear: both;">Выбрать все должности</div>
    </div>
    <div class="admin_form_row">
      <label for="name">Название выплаты</label>
      <p class="admin_form_caption"><b>Обязательно для заполнения</b></p>
      <textarea name="name" id="name" cols="30" rows="5" required></textarea>
    </div>
    <div class="admin_form_row">
      <label for="value">Размер выплаты</label>
      <p class="admin_form_caption"><b>Обязательно для заполнения, если нет вариантов для данной выплаты</b></p>
      <input id="value" type="text" name="value" data-table="calc_position" value=""/>
    </div>
    <div class="admin_form_row">
      <label for="type_value">Тип значения выплаты</label>
      <p class="admin_form_caption"><b>Обязательно для заполнения</b></p>
      <select id="type_value" name="type_value">
        <option value="1" selected>Коэфицент</option>
        <option value="2">Фактическая</option>
      </select>
    </div>
    <div class="admin_form_row admin_form_row_calc_variants">
      <label for="">Дополнительные варианты</label>
      <p class="admin_form_caption"><b>Используется когда есть варинты для данной выплаты</b></p>
      <div id="variants"></div>
      <div id="add_variant" class="btn brd btn_admin">Добавить вариант</div>
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

$('#all_positions').click(function(){
  if($(this).hasClass('_selected')){
    $(this).removeClass('_selected');
    $('#positions > option').removeAttr('selected');
  } else {
    $(this).addClass('_selected');
    $('#positions > option').attr('selected', 'selected');
  }
});

var v = 1;
$('#add_variant').click(function(){
  html = '<div id="variant'+v+'" class="admin_form_row"> ' +
         '   <label><span class="delete_variant" onclick="delete_variant('+v+')">Удалить вариант</span></label> ' +
         '   <input class="calc_var_name" type="text" name="variants['+v+'][name]" data-table="calc_jobs" value="" placeholder="Название варианта" /> ' +
         '   <input class="calc_var_value" type="text" name="variants['+v+'][value]" data-table="calc_jobs" value="" placeholder="Размер выплаты" /> ' +
         ' </div>';

  $('#variants').append(html);
  v++;
});

function delete_variant(v){
  $('#variant'+v).detach();
}

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

    my_form.find('input, select, textarea').each(function(){
      post_data[$(this).attr('name')] = $(this).val();
    });

    $.ajax({
      url: 'index.php?r=admin/calculator/savePays',
      type: 'post',
      data: post_data,
      dataType: 'json',
      success: function(json){
        console.log(json);
        if(json.success == true){
          $('.admin_section a[href="admin/calculator/viewPays"]').trigger('click');
        } else {
          console.log('Что-то пошло не так!');
        }
      },
      error: function(xhr, ajaxOptions, thrownError){
        console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  }
});
</script>