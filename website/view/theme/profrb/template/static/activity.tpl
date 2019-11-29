<section class="sect about_us activity">
  <div class="wrapper">
    <div class="content">
      <h1 class="section_title">Деятельность</h1>
      <div class="section_view clearfix">
        <div class="view_block">
          <? foreach($contents as $key => $content) : ?>
            <? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$key.', \'edit\');"></span>' : null; ?>
            <div class="block__activity">
              <?=$click;?>
              <h3 class="block__activity_title" id="btn_modal" data-modal-id="<?=$key?>"><?=$content['title'];?></h3>
              <p><?=$content['fields']['title_caption'];?></p>
            </div>
          <? endforeach; ?>
        </div>
      </div>
    </div>
  </div>
</section>
<? foreach($contents as $key => $content) : ?>
  <div class="modal_panel">
    <? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$key.', \'edit\');"></span>' : null; ?>
    <div class="modal modal_activity" data-modal-id="<?=$key?>" data-modal-open="false">
      <?=$click;?>
      <div class="modal_close"></div>
      <div class="modal_head">
        <h4 class="modal_title"><?=$content['title'];?></h4>
        <p class="modal_caption"><?=$content['fields']['title_caption'];?></p>
      </div>
      <div class="modal_view clearfix">
        <div class="modal_text">
          <?=$content['fields']['text'];?>
        </div>
        <div class="modal_docs view_docs">
          <? foreach($content['fields']['docs'] as $docs) : ?>
            <li class="view_docs__item">
              <i class="docs_icon <?=$docs['docs_icon_class'];?>"></i>
              <div class="docs_title">
                <a href="<?=$docs['path'];?>" download><?=$docs['title'];?></a>
              </div>
            </li>
          <? endforeach; ?>
        </div>
      </div>
    </div>
  </div>
<? endforeach; ?>