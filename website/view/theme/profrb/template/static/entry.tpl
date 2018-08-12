<? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$cid.', \'edit\');"></span>' : null; ?>
<section class="sect entry">
  <div class="wrapper">
    <div class="content">
      <h1 class="section_title">Как вступить в&nbsp;Профсоюз?<?=$click;?></h1>
      <p class="section_caption">Скачайте, распечатайте, заполните приложенные заявления, следуя инструкциям в&nbsp;пронумерованных пунктах.</p>
      <div class="section_view">
        <div class="view_block clearfix admin_edit">
          <?$s = 1;?>
          <? foreach($content['fields']['stage'] as $stage) : ?>
            <div class="entry_stage admin_edit">
              <p class="entry_stage_number"><?=$s;?></p>
              <?=$stage;?>
            </div>
            <?$s++;?>
          <? endforeach; ?>
        </div>
        <div class="entry_docs">
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
        <div class="view_block entry_advantages clearfix admin_edit" data-block-id="3" data-block-name="entry">
          <h3 class="entry_advantages__title">Преимущества членства в&nbsp;Профсоюзе</h3>
          <div class="entry_advantages__text">
            <?=$content['fields']['text'];?>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>