<section class="sect second_menu">
  <div class="wrapper">
    <div class="content">
      <ul class="second_menu__list_view">
            <li>
              <a href="/history" target="_self">История</a>
            </li>
            <li>
              <a href="/geo" target="_self">География</a>
            </li>
            <li>
              <a href="/workers" target="_self">Сотрудники</a>
            </li>
            <li class="active">
              <a href="/structure" target="_self">Структура</a>
            </li>
      </ul>
      </div>
    </div>
</section>
<section class="sect about_us structure">
  <div class="wrapper">
    <div class="content">
      <h1 class="section_title">Структура</h1>
      <div class="section_switch" id="switch">
        <div class="switch_label active btn_dotted" data-switch="1" data-block-id="11" data-btn-text="Организации Профсоюза">Организации Профсоюза</div>
        <div class="switch_label btn_dotted" data-switch="2" data-block-id="12" data-btn-text="Выборные органы">Выборные органы</div>
      </div>
      <div class="view_block structure_block structure_org active clearfix admin_edit" data-switch="1" data-block-id="11" data-block-name="structure">
        <div class="field_block__title">
          <div class="structure_org_caption">
            <p class="text_org__bold">Башкирская республиканская организация</p>
          </div>
        </div>
        <div class="field_block__left brd figure_block__light_blue">
          <div class="field_block__row">
            <div class="structure_org_caption">
              <p class="count_org">68</p>
              <p class="text_org">территориальных организаций Профсоюза</p>
            </div>
          </div>
          <div class="figure_block__blue">
            <div class="structure_org_caption">
              <p class="count_org">2569</p>
              <p class="text_org">первичных профсоюзных организаций</p>
            </div>
          </div>
          <div class="brd field_block__row figure_block__light_blue">
            <div class="structure_org_caption">
              <p class="count_org">989</p>
              <p class="text_org">первичных профсоюзных организаций дошкольных организаций</p>
            </div>
            <div class="structure_org_caption">
              <p class="count_org">1275</p>
              <p class="text_org">первичных профсоюзных организаций общеобразовательных организаций</p>
            </div>
            <div class="structure_org_caption">
              <p class="count_org">199</p>
              <p class="text_org">первичных профсоюзных организаций дополнительного образования</p>
            </div>
            <div class="structure_org_caption">
              <p class="count_org">106</p>
              <p class="text_org">первичных профсоюзных организаций в других организациях</p>
            </div>
          </div>
        </div>
        <div class="field_block__right brd figure_block__light_blue">
          <div class="field_block__row">
            <div class="structure_org_caption">
              <p class="count_org">26</p>
              <p class="text_org">первичных профсоюзных организаций профессионального образования</p>
            </div>
            <div class="structure_org_caption">
              <p class="count_org">20</p>
              <p class="text_org">первичная профсоюзная организация высшего профессионального образования</p>
            </div>
            <div class="structure_org_caption">
              <p class="count_org">2</p>
              <p class="text_org">первичные профсоюзные организации научных организаций</p>
            </div>
          </div>
        </div>
      </div>
      <div class="view_block structure_block structure_upr clearfix admin_edit" data-switch="2" data-block-id="11" data-block-name="structure">
        <ul class="field_block__list" id="upravlenie">
          <? foreach($contents as $key => $content) : ?>
            <? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$key.', \'edit\');"></span>' : null; ?>
            <li id="btn_modal" data-modal-id="<?=$key;?>">
              <?=$click;?>
              <span><?=$content['title'];?></span>
            </li>
          <? endforeach; ?>
        </ul>
      </div>
    </div>
  </div>
</section>

<? foreach($contents as $key => $content) : ?>
  <div class="modal_panel">
    <? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$key.', \'edit\');"></span>' : null; ?>
    <div class="modal modal_structure" data-modal-id="<?=$key;?>" data-modal-open="false">
      <?=$click;?>
      <div class="modal_close"></div>
      <div class="modal_head">
        <h4 class="modal_title"><?=$content['title'];?></h4>
        <? if(!empty($content['title_caption'])) : ?>
          <p class="modal_caption"><?=$content['title_caption'];?></p>
        <? endif; ?>
      </div>
      <div class="modal_view clearfix">
        <div class="modal_list grid_col_2">
          <?=$content['fields']['text'];?>
        </div>
      </div>
    </div>
  </div>
<? endforeach; ?>