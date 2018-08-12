<?
$city_type = json_decode($content['category_params'], true);

$city = $field_types[2];
$city['body'] = $content['category_title'];

$filter = $field_types[1];
$filter['body'] = $content['filter_title'];

$coordinates = $field_types[0];
$coordinates['body'] = $content['coordinates'];
?>

<h2 class="modal_title">Редактирование материала <?=$content['type_tytle'];?></h2>
<form id="adminForm" class="admin_form clearfix" method="post" action="index.php?r=admin/content/save_update&type=geo" data-table="content" data-params="save">
    <input type="hidden" name="content_id" value="<?=$content_id;?>">
    <div class="admin_form_row">
      <label for="title">Название материала</label>
      <p class="admin_form_caption">Название объекта (УГАТУ) или района (Октябрьский РК)</p>
      <input id="title" type="text" name="title" data-table="content" value="<?=$content['title'];?>" required/>
    </div>
    <div class="admin_form_row">
      <?=HtmlHelper::formField($fields[0]);?>
    </div>
    <div class="admin_form_row">
      <?=HtmlHelper::formField($city);?>
    </div>
    <div class="admin_form_row">
      <label for="citytype">Тип местности</label>
      <p class="admin_form_caption">Город или район, только для новых, если есть, выбирать не нужно</p>
      <select id="citytype" name="citytype">
        <? if($city_type['area'] == 'city') : ?>
          <option value="">-</option>
          <option value="city" selected>Город</option>
          <option value="area">Район</option>
        <? else : ?>
          <option value="">-</option>
          <option value="city">Город</option>
          <option value="area" selected>Район</option>
        <? endif; ?>
      </select>
    </div>
    <div class="admin_form_row">
      <?=HtmlHelper::formField($filter);?>
    </div>
    <div class="admin_form_row content_fields is_field_group">
      <? $i = 1;?>
      <? foreach($field_group as $key => $value) : ?>
        <input type="hidden" name="field_group[]" value="<?=$key;?>">
        <div id="geo_group" data-group="<?=$key;?>" class="admin_field_group">
          <p class="admin_field_group_title">Данные в модалке</p>
          <?
          $param_mail = array('tag'=>array('name'=>'input','attr'=>array('id'=>'view_profile_mail','name'=>'view_profile_mail','data-table'=>'fields'),'label'=>array('position'=>'top','attr'=>array('for'=>'view_profile_mail')),'caption'=>array('position'=>'top','text'=>'E-mail адрес ответственного лица или руководителя')));
            if(!$value['view_profile_mail']){
              $value['view_profile_mail'] = array(
                'id' => null,
                'field_name' => 'view_profile_mail',
                'body' => '',
                'tag_id' => null,
                'tag_html' => null,
                'class' => null,
                'attr' => null,
                'params' => json_encode($param_mail)
              );
            }
          ?>
          <? foreach($value as $fields) : ?>
            <?=HtmlHelper::formField($fields, $i, $key);?>
            <? if($fields['field_name'] == 'geo_docs') $d = 1; ?>
          <? endforeach; ?>
        </div>
        <? $i++; ?>
      <? endforeach; ?>
      <!--<div class="admin_form_row clearfix">
        <div id="add_group" class="btn brd btn_admin">Добавить группу</div>
      </div>-->
    </div>
    <? if(!$d) : ?>
    <div class="admin_form_row">
      <label for="geo_docs">Коллективный договор</label>
      <div id="fileUpload" class="file_upload clearfix">
        <input id="geo_docs" type="file" name="geo_docs[group][]" data-table="fields" data-file-type="docs" required="required" class="file_upload_input" onchange="getUploadFiles('geo_docs');" value="">
        <div class="file_viewed clearfix"></div>
        <div id="fileUploaded" class="btn btn_admin" onclick="fileUploadBtn('geo_docs');">Добавить файл</div>
        <input class="file_upload_filed" type="hidden" name="geo_docs[group][]" value="">
      </div>
      <p class="admin_form_caption">Можно прикрепить лишь 1 документ. Разрешены форматы: DOC, DOCX, PDF</p>
    </div>
    <? endif; ?>
    <div class="admin_form_row">
      <div id="geo_map_pin" class="admin_form_row">
        <?=HtmlHelper::formField($coordinates);?>
      </div>
      <div id="geoMapAdmin" class="admin_form_row geo_map_admin"></div>
    </div>
    <div class="admin_form_row">
      <label for="date_creat">Дата публикации</label>
      <input id="date_creat" type="datetime-local" name="date_creat" data-table="content" value="<?=$content['date_creat'];?>"/>
    </div>
    <div class="admin_form_row">
      <label for="date_end">Дата конца публикации</label>
      <input id="date_end" type="datetime-local" name="date_end" data-table="content" value="<?=$content['date_end'];?>"/>
    </div>
    <div class="admin_form_row">
      <input id="active" type="checkbox" name="active" data-table="content" value="1" checked/>
      <label for="active">Материал опубликован</label>
    </div>

    <div class="admin_form_row btns">
      <button class="btn brd btn_admin" id="save" data-btn-event="save">Сохранить изменения</button>
    </div>
</form>

<script>
$('input[type="file"]').removeAttr('required');

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

  console.log(tid);

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
</script>
<!--
<?/*
*/?>
-->