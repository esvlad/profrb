<h2 class="modal_title">Создание материала <?=$content['content_type_title'];?></h2>
<form id="adminForm" class="admin_form clearfix" method="post" action="index.php?r=admin/content/save&type=geo" data-table="content" data-params="save">
    <div class="admin_form_row">
      <label for="title">Название материала</label>
      <p class="admin_form_caption">Название объекта (УГАТУ) или района (Октябрьский РК)</p>
      <input id="title" type="text" name="title" data-table="content" value="" required/>
    </div>
    <div class="admin_form_row">
      <?=HtmlHelper::formField($content['field_type'][1], 0);?>
    </div>
    <div class="admin_form_row">
      <?=HtmlHelper::formField($content['field_type'][0], 0);?>
    </div>
    <div class="admin_form_row">
      <label for="citytype">Тип местности</label>
      <p class="admin_form_caption">Город или район, только для новых, если есть, выбирать не нужно</p>
      <select id="citytype" name="citytype">
        <option value="">-</option>
        <option value="city">Город</option>
        <option value="area">Район</option>
      </select>
    </div>
    <div class="admin_form_row">
      <?=HtmlHelper::formField($content['field_type'][2], 0);?>
    </div>
    <div class="admin_form_row is_field_group">
      <div id="<?=$content['field_group']['group']['group_name'];?>" data-group="1" class="admin_field_group">
        <p class="admin_field_group_title"><?=$content['field_group']['group']['group_title'];?></p>
        <? foreach($content['field_group']['field_type'] as $key => $fields) : ?>
          <?=HtmlHelper::formField($fields, 1, 1);?>
        <? endforeach; ?>
      </div>
      <div class="admin_form_row clearfix">
        <div id="add_group" class="btn brd btn_admin">Добавить группу</div>
      </div>
    </div>
    <div class="admin_form_row content_fields">
      <h3 style="margin: 30px 0 10px;">Документы</h3>
      <?
        foreach($content['field_type'] as $key => $field_type){
          if($field_type['name'] == 'docs'){
            echo HtmlHelper::formField($field_type, 0);
          }
        }
      ?>
      <p id="more_field" class="admin_more_docs" onclick="addField(25)" data-type-id="25" data-type="docs" data-key="2">Добавить ещё документ</p>
    </div>
    <div class="admin_form_row">
      <div id="geo_map_pin" class="admin_form_row">
        <?=HtmlHelper::formField($content['field_type'][3], 0);?>
      </div>
      <div id="geoMapAdmin" class="admin_form_row geo_map_admin"></div>
    </div>
    <!--<div class="admin_form_row">
      <label for="uri">Ссылка <i>/uri</i>*</label>
      <input id="uri" type="text" name="uri" data-table="url" value="/" required/>
    </div>-->
    <div class="admin_form_row">
      <label for="date_creat">Дата публикации</label>
      <input id="date_creat" type="datetime-local" name="date_creat" data-table="content" value=""/>
    </div>
    <div class="admin_form_row">
      <label for="date_end">Дата конца публикации</label>
      <input id="date_end" type="datetime-local" name="date_end" data-table="content" value=""/>
    </div>
    <div class="admin_form_row">
      <input id="active" type="checkbox" name="active" data-table="content" value="" checked/>
      <label for="active">Материал опубликован</label>
    </div>
    <!--<div class="admin_form_row setting closed">
      <p class="setting_btn">Настройки</p>
      <label for="type">Тип</label>
      <input id="type" type="text" name="setting[type]" data-table="setting" value="content"/>
      <label for="action">Action</label>
      <input id="action" type="text" name="setting[action]" data-table="setting" value=""/>
      <label for="tag_id">#Идентификатор</label>
      <input id="tag_id" type="text" name="setting[tag_id]" data-table="setting" value=""/>
      <label for="tag_html">Тег HTML</label>
      <input id="tag_html" type="text" name="setting[tag_html]" data-table="setting" value=""/>
      <label for="class">.Class</label>
      <input id="class" type="text" name="setting[class]" data-table="setting" value=""/>
      <label for="attr">Атрибуты</label>
      <input id="attr" type="text" name="setting[attr]" data-table="setting" value=""/>
      <label for="params">Параметры</label>
      <textarea id="params" name="setting[params]" data-table="setting"></textarea>
      <label for="order">Порядок</label>
      <input id="order" type="text" name="setting[order]" data-table="setting" value=""/>
      <label for="role">Минимальный уровень роли</label>
      <input id="role" type="text" name="setting[role]" data-table="setting" value=""/>
    </div>-->
    <div class="admin_form_row btns">
      <button class="btn brd btn_admin" id="save" data-btn-event="save">Сохранить</button>
    </div>
</form>

<script>
ymaps.ready(function () {
  var myPlacemark;
  var myMap = new ymaps.Map("geoMapAdmin", {
    center: [54.732063, 55.944037],
    zoom: 14
  },{
    searchControlProvider: 'yandex#search'
  });

  // Слушаем клик на карте.
    myMap.events.add('click', function (e) {
        var coords = e.get('coords');

        // Если метка уже создана – просто передвигаем ее.
        if (myPlacemark) {
            myPlacemark.geometry.setCoordinates(coords);
        }
        // Если нет – создаем.
        else {
            myPlacemark = createPlacemark(coords);
            myMap.geoObjects.add(myPlacemark);
            // Слушаем событие окончания перетаскивания на метке.
            myPlacemark.events.add('dragend', function () {
                getAddress(myPlacemark.geometry.getCoordinates());
            });
        }
        getAddress(coords);

        $('#geo_map_pin input').val(coords);
    });

    // Создание метки.
    function createPlacemark(coords) {
        return new ymaps.Placemark(coords, {
            iconCaption: 'поиск...'
        }, {
            preset: 'islands#violetDotIconWithCaption',
            draggable: true
        });
    }

    // Определяем адрес по координатам (обратное геокодирование).
    function getAddress(coords) {
        myPlacemark.properties.set('iconCaption', 'поиск...');
        ymaps.geocode(coords).then(function (res) {
            var firstGeoObject = res.geoObjects.get(0);

            myPlacemark.properties
                .set({
                    iconCaption: firstGeoObject.properties.get('name'),
                    balloonContent: firstGeoObject.properties.get('text')
                });
        });
    }
});

var tid = [];
$('textarea').each(function(){
  tid.push($(this).attr('id'));
});

for(var i = 0; i<$('textarea').length; i++){
  CKEDITOR.replace(tid[i]);
}

$('.setting > .setting_btn').bind('click', function(){
  $(this).parent().toggleClass('closed opened');
});

var defvalue = '';
var ntext = 100;
var nn = 2;
//var new_group = $('.admin_field_group[data-group="1"]').clone();
$('div#add_group').click(function(){
  $.ajax({
    url: 'index.php?r=admin/content/addgroup',
    type: 'post',
    data: {key_group: nn, key: ntext, type: 'geo_group'},
    dataType: 'html',
    success: function(html){
      new_n = nn - 1;
      $('.admin_field_group[data-group="'+new_n+'"]').after(html);
      nn++;
      ntext += 10;
    },
    error: function(xhr, ajaxOptions, thrownError){
      console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
});

/*$('.admin_modal #save').click(function(e){
  e.preventDefault();
  var data = {},
    post_data = {},
    post_data_settig = {};
  $('.admin_form input, .admin_form select, .admin_form textarea').each(function(){
    if($(this).attr('data-table') == 'setting'){
      post_data_settig[$(this).attr('name')] = $(this).val();
    } else {
      post_data[$(this).attr('name')] = $(this).val();
    }
  });

  data['event'] = $('.admin_form').attr('data-params');
  data['setting'] = post_data_settig;
  data[$('.admin_form').attr('data-table')] = post_data;
  console.log(data);
});*/

/*$('.admin_form').submit(function(e){
  var my_form = $(this);
  var error = false;

  my_form.find('input, textarea').each( function(){ // прoбeжим пo кaждoму пoлю в фoрмe
    if ($(this).attr('required') && $(this).val() == '') { // eсли нaхoдим пустoe
      alert('Зaпoлнитe пoлe "'+$(this).prev().text()+'"!'); // гoвoрим зaпoлняй!
      error = true; // oшибкa
    }
  });

  if(!error){
    var postbody = my_form.serialize();

    $.ajax({
      type: 'POST',
      url: my_form.attr('action')+'&type=geo',
      dataType: 'json',
      data: postbody,
      beforeSend: function(json) {
        my_form.find('#save').attr('disabled', 'disabled');
      },
      success: function(json){
        console.log(json);
      },
      error: function(xhr, ajaxOptions, thrownError){
        console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      },
      complete: function(data) { // сoбытиe пoслe любoгo исхoдa
        my_form.find('#save').prop('disabled', false); // в любoм случae включим кнoпку oбрaтнo
      }
    });
  }

  e = e || event;
  e.preventDefault();
});*/
</script>