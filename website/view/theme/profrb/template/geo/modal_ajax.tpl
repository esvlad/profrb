<?
function json_file($js){
  $data = json_decode($js, true);

  return $data['path'];
}
$cordinates = $contents['cordinates'];
?>

<? $content_title = $contents['content'][0]['title']; ?>
<? $dogovor = 'Коллективный договор'; ?>
<? foreach($contents['view_modal'] as $content) : ?>
<? 
  if($content['modal_title']['body'] == 'Профсоюз трудящихся'){
    $title = 'Профсоюзная организация работников';
  } elseif($content['modal_title']['body'] == 'Профсоюз учащихся'){
    $title = 'Профсоюзная организация студентов';
  } else {
    $title = $content_title;
    $dogovor = 'Отраслевое соглашение';
  }
?>
<div class="modal_view clearfix">
  <div class="modal_view__profile clearfix">
    <img src="../website/view/theme/profrb/img/logo_geo.jpg"/>
    <p class="modal_view__profile_title"><?=$content['view_profile_title']['body'];?></p>
    <? if(isset($content['view_profile_mail']['body'])) : ?>
      <p class="modal_view__profile_title"><?=$content['view_profile_phone']['body'];?></p>
      <p class="modal_view__profile_phone"><?=$content['view_profile_mail']['body'];?></p>
    <? else : ?>
      <p class="modal_view__profile_phone"><?=$content['view_profile_phone']['body'];?></p>
    <? endif; ?>
    <?=$content['position']['body'];?>
  </div>
  <? if(is_file($_SERVER['DOCUMENT_ROOT'] . $geo['geo_docs']['body']['path'])) : ?>
    <ul class="modal_view__docs view_docs">
      <? if($title != 'Профсоюзная организация студентов') : ?>
        <li class="view_docs__item">
          <i class="docs_icon docs_icon__doc"></i>
          <div class="docs_title">
            <a href="..<?=$geo['geo_docs']['body']['path'];?>"><?=$dogovor;?></a>
          </div>
        </li>
      <? endif; ?>
    </ul>
  <? endif; ?>
  <div class="modal_view__caption clearfix">
    <?=$content['geo_profile']['body'];?>
  </div>
</div>
<? endforeach; ?>
<?
  $cord = explode(',', $cordinates);
  $cord_x = $cord[0];
  $cord_y = $cord[1];
?>
<div class="modal_view modal_view__maps clearfix">
  <div class="btn_geo_map" data-cords="<?=$cordinates;?>" data-cordx="<?=$cord_x;?>" data-cordy="<?=$cord_y;?>" data-open-map="false">Показать на карте</div>
  <div class="geo_map" data-id="GMap" data-map="false">
    <div id="GMap"></div>
    <script>
      //Карта в модалке
      var cord_x, cord_y;
      $('.btn_geo_map').click(function(){
        cord_x = $(this).data('cordx');
        cord_y = $(this).data('cordy');
        var map_tag = $(this).next();

        if($(this).attr('data-open-map') != 'false'){
          map_tag.slideUp(300);
          $(this).attr('data-open-map','false');
          $(this).text('Показать на карте');
        } else {
          if(map_tag.attr('data-map') == 'false'){
            map_tag.slideDown(300,function(){
              ymaps.ready(init_modal_map);
            });
            map_tag.attr('data-map','true');
            $(this).attr('data-open-map','true');
            $(this).text('Скрыть карту');
          } else {
            map_tag.slideDown(300);
            $(this).attr('data-open-map','true');
            $(this).text('Скрыть карту');
          }
        }
      });

      function init_modal_map (){
        modalMap = window.map = new ymaps.Map('GMap', {
              center: [cord_x, cord_y],
              zoom: 14
          });

          myPlacemark = new ymaps.Placemark([cord_x, cord_y], {
          hintContent: '',
          balloonContent: ''
        }, {
          iconLayout: 'default#image',
          iconImageHref: '/website/view/theme/profrb/img/icon/icon_geo_map_pin.svg',
          iconImageSize: [23, 40],
          iconImageOffset: [-18, -22]
        });

        modalMap.behaviors.disable(['scrollZoom']);
        
        modalMap.geoObjects.add(myPlacemark);
      }
    </script>
  </div>
</div>
<? if(!empty($content['docs'])) : ?>
  <div class="modal_view documents clearfix">
    <h4 class="modal_title">Документы</h4>
    <div class="view_docs clearfix">
      <? foreach($content['docs'] as $value) : ?>
        <? $doc = json_decode($value['body'], true); ?>
        <li class="view_docs__item">
          <i class="docs_icon docs_icon__pdf"></i>
          <div class="docs_title">
            <a href="<?=$doc['path'];?>" download="" data-id="642"><?=$doc['title'];?></a>
          </div>
        </li>
      <? endforeach; ?>
    </div>
  </div>
<? endif; ?>
<? if(!empty($content['news'])) : ?>
  <div class="modal_view geo_news clearfix">
    <h4 class="modal_title">Новости</h4>
    <div class="geo_news_block clearfix">
      <? foreach($content['news'] as $value) : ?>
        <div class="geo_news__content">
          <time datetime="<?=$value['date_creat'];?>"><?=$value['date_creat'];?></time>
          <?=$value['body'];?>
        </div>
      <? endforeach; ?>
    </div>
    <? if($count_news > 10) : ?>
      <div id="more_geo_news" class="btn brd btn_submit btn_geo_news" data-page="2">Показать ещё</div>
    <? endif; ?>
  </div>
<? endif; ?>
