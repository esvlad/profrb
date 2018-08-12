<? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$content['id'].', \'edit\');"></span>' : null; ?>
<section class="sect kpk_education">
  <div class="wrapper">
    <div class="content">
      <h1 class="section_title"><?=$content['title'];?><?=$click;?></h1>
      <div class="view_block clearfix admin_edit" data-block-id="5" data-block-name="kpk_education">
        <div class="kpkedu__region_head">
          <?=$content['fields']['text'];?>
        </div>
        <div class="kpkedu__region_table">
          <?=$content['fields']['static_table'];?>
        </div>
        <div class="kpkedu__region_left">
          <div class="kpk_overtext">
            <?=$content['fields']['static_overtext'];?>
          </div>
        </div>
        <div class="kpkedu__region_right">
          <div class="kpk_address">
            <? foreach($content['fields']['static_address'] as $key => $address) : ?>
              <div class="kpk_address_block">
                <?=$address;?>
              </div>
            <? endforeach; ?>
          </div>
          <div class="kpk_docs">
            <h3>Документы</h3>
            <ul class="view_docs">
              <? foreach($content['fields']['docs'] as $docs) : ?>
                <li class="view_docs__item">
                  <i class="docs_icon <?=$docs['docs_icon_class'];?>"></i>
                  <div class="docs_title">
                    <a href="..<?=$docs['path'];?>"><?=$docs['title'];?></a>
                  </div>
                </li>
              <? endforeach; ?>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>