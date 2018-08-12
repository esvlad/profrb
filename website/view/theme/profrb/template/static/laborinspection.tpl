<section class="sect statick_page">
  <div class="wrapper">
    <div class="content">
      <h1 class="section_title">Внештатная инспекция труда</h1>
      <div class="section_switch" id="switch">
        <? $sw = 0; ?>
        <? foreach($contents as $key => $content) : ?>
          <? $s_active = ($sw == 0) ? 'active' : null; ?>
          <div class="switch_label btn_dotted <?=$s_active;?>" data-switch="<?=$key;?>" data-btn-text="<?=$content['title'];?>"><?=$content['title'];?></div>
          <? $sw++; ?>
        <? endforeach; ?>
      </div>
      <? $sw = 0; ?>
      <? foreach($contents as $key => $content) : ?>
        <? $s_active = ($sw == 0) ? 'active' : null; ?>
        <? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$key.', \'edit\');"></span>' : null; ?>
        <div class="view_block vin_block clearfix <?=$s_active;?>" data-switch="<?=$key;?>">
          <?=$click;?>
          <div class="vin_block_row vin_block_head">
            <img src="..<?=$content['fields']['labor_image']['path'];?>"/>
            <p class="vin_block_row__title"><?=$content['fields']['labor_name'];?></p>
            <p class="vin_block_row__caption"><?=$content['fields']['labor_position'];?></p>
            <p class="vin_block_row__addr"><a href="tel:<?=strip_tags($content['fields']['labor_phone']);?>"><?=$content['fields']['labor_phone'];?></a></p>
            <p class="vin_block_row__addr"><?=$content['fields']['labor_mail'];?></p>
          </div>
          <div class="vin_block_row vin_block_caption">
            <?=$content['fields']['text'];?>
          </div>
          <div class="vin_block_row vin_block_docs">
            <ul class="view_docs">
              <?
                $v_docs = $content['fields']['docs'];
                ksort($v_docs);
              ?>
              <? foreach($v_docs as $docs) : ?>
                <li class="view_docs__item">
                  <i class="docs_icon <?=$docs['docs_icon_class'];?>"></i>
                  <div class="docs_title">
                    <a href="..<?=$docs['path'];?>" download><?=$docs['title'];?></a>
                  </div>
                </li>
              <? endforeach; ?>
            </ul>
          </div>
        </div>
        <? $sw++; ?>
      <? endforeach; ?>
    </div>
  </div>
</section>