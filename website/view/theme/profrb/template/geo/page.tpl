<section class="sect second_menu">
  <div class="wrapper">
    <div class="content">
      <ul class="second_menu__list_view">
        <li><a href="../history" target="_self">История</a></li>
        <li class="active"><a href="../geo" target="_self">География</a></li>
        <li><a href="../workers" target="_self">Сотрудники</a></li>
        <li><a href="../structure" target="_self">Структура</a></li>
      </ul>
    </div>
  </div>
</section>
<section class="sect geografy page_geo">
  <div class="wrappall">
    <div class="content">
      <h1 class="section_title">География</h1>
      <div class="section_switch" id="switch">
        <div class="switch_label active btn_dotted" data-switch="1" data-block-id="13" data-btn-text="Карта">Карта</div>
        <div class="switch_label btn_dotted" data-switch="2" data-block-id="14" data-btn-text="Список">Список</div>
      </div>
      <form class="search_form">
        <input class="search_form__input brd" type="text" name="search" value="" placeholder="Введите название населенного пункта" autocomplete="off"/>
        <input class="search_form__submit" type="submit" value=""/>
      </form>
      <div class="view_block geo_block active admin_edit" data-block-id="13" data-block-name="geo_maps" data-switch="1">
        <div class="maps maps_geo" id="yaMapsGeo"></div>
        <form class="maps_filter"><span>Показать: </span>
          <input id="geo_map_vvuz" type="checkbox" name="letter" value="3" onchange="geo_map_filter(this.value);" checked/>
          <label for="geo_map_vvuz">ВУЗы</label>
          <input id="geo_map_colledje" type="checkbox" name="letter" value="2" onchange="geo_map_filter(this.value);" checked/>
          <label for="geo_map_colledje">Колледжи</label>
        </form>
      </div>
      <div class="view_block geo_block admin_edit" data-block-id="14" data-block-name="geo_list" data-switch="2">
        <? if(in_array('city', $area_city['areas'])) : ?>
              <div class="geo_list_block active geo_lict_city">
                  <h4 class="geo_list_block__title">Города</h4>
                  <ul class="geo_list_block__lists">
                    <? foreach($area_city['category'] as $value) : ?>
                <? if($value['params'] == 'city') : ?>
                        <li class="visible"><a href="./geo_city/<?=$value['id']?>"><?=mb_strtolower($value['title']);?></a></li>
                <? endif; ?>
              <? endforeach; ?>
                  </ul>
              </div>
            <? endif; ?>
            <? if(in_array('area', $area_city['areas'])) : ?>
              <div class="geo_list_block geo_lict_area">
            <h4 class="geo_list_block__title">Районы</h4>
            <ul class="geo_list_block__lists">
                    <? foreach($area_city['category'] as $value) : ?>
                <? if($value['params'] == 'area') : ?>
                        <li class="visible"><a href="./geo_city/<?=$value['id']?>"><?=mb_strtolower($value['title']);?></a></li>
                <? endif; ?>
              <? endforeach; ?>
                  </ul>
              </div>
        <? endif; ?>
      </div>
    </div>
  </div>
</section>
<div id="btn_modal" class="display_none" data-btn="gro_modals" data-modal-id="0"></div>
<div class="modal modal_geo" data-modal-id="0" data-modal-open="false">
    <div class="modal_close"></div>
</div>