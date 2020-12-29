<h2 class="modal_title">Редактирование компенсации</h2>

<form class="admin_form admin_form_calc_cp clearfix" method="post" data-table="calc" data-params="update">
    <input type="hidden" name="id" value="<?=$content['id'];?>">
    <div class="admin_form_row">
      <label for="positions">Должность</label>
      <p class="admin_form_caption">Выберите должность, <b>для выбора нескольких должностей выбирайте зажав клавишу CTRL</b></p>
      <select id="positions" name="positions[]" multiple style="min-height: 200px; height: 250px; resize: vertical;">
        <? foreach($positions as $position) : ?>
          <? if(in_array($position['id'], $content['position_id'])) : ?>
            <option value="<?=$position['id'];?>" selected><?=$position['name'];?></option>
          <? else : ?>
            <option value="<?=$position['id'];?>"><?=$position['name'];?></option>
          <? endif; ?>
        <? endforeach; ?>
      </select>
      <div id="all_positions" class="btn brd btn_admin" style="margin-bottom: 20px; width: 250px; float: none; clear: both;">Выбрать все должности</div>
    </div>
    <div class="admin_form_row">
      <label for="name">Название компенсации</label>
      <p class="admin_form_caption"><b>Обязательно для заполнения</b></p>
      <textarea name="name" id="name" cols="30" rows="5" required><?=$content['name']?></textarea>
    </div>
    <div class="admin_form_row">
      <label for="oklad">Размер компенсации %</label>
      <p class="admin_form_caption"><b>Обязательно для заполнения, если нет вариантов для данной компенсации</b></p>
      <input id="value" type="text" name="value" data-table="calc_position" value="<?=$content['value']?>"/>
    </div>
    <div class="admin_form_row admin_form_row_calc_variants">
      <label for="">Дополнительные варианты</label>
      <p class="admin_form_caption"><b>Используется когда есть варинты для данной компенсации</b></p>
      <div id="variants">
        <? $v = 1; ?>
        <? if(!empty($content['variants'])) : ?>
          <? $variants = json_decode($content['variants']); ?>
          <? foreach($variants as $variant) : ?>
            <div id="variant<?=$v;?>" class="admin_form_row">
              <label><span class="delete_variant" onclick="delete_variant(<?=$v;?>)">Удалить вариант</span></label>
              <input class="calc_var_name" type="text" name="variants[<?=$v;?>][name]" data-table="calc_jobs" value="<?=$variant->name;?>" placeholder="Название варианта" />
              <input class="calc_var_value" type="text" name="variants[<?=$v;?>][value]" data-table="calc_jobs" value="<?=$variant->value;?>" placeholder="Размер компенсации %" />
            </div>
            <? $v++; ?>
          <? endforeach; ?>
        <? endif; ?>
      </div>
      <div id="add_variant" class="btn brd btn_admin">Добавить вариант</div>
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

$('#all_positions').click(function(){
  if($(this).hasClass('_selected')){
    $(this).removeClass('_selected');
    $('#positions > option').removeAttr('selected');
  } else {
    $(this).addClass('_selected');
    $('#positions > option').attr('selected', 'selected');
  }
});

var v = <?=(int)$v;?>;
$('#add_variant').click(function(){
  html = '<div id="variant'+v+'" class="admin_form_row"> ' +
         '   <label><span class="delete_variant" onclick="delete_variant('+v+')">Удалить вариант</span></label> ' +
         '   <input class="calc_var_name" type="text" name="variants['+v+'][name]" data-table="calc_jobs" value="" placeholder="Название варианта" /> ' +
         '   <input class="calc_var_value" type="text" name="variants['+v+'][value]" data-table="calc_jobs" value="" placeholder="Размер компенсации %" /> ' +
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

    my_form.find('input, select, textarea').each(function(){
      if($(this).val() != '') post_data[$(this).attr('name')] = $(this).val();
    });

    $.ajax({
      url: 'index.php?r=admin/calculator/updateCompensation',
      type: 'post',
      data: post_data,
      dataType: 'json',
      success: function(json){
        console.log(json);
        if(json.success == true){
          $('.admin_section a[href="admin/calculator/viewCompensation"]').trigger('click');
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