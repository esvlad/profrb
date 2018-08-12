<? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$content['id'].', \'edit\');"></span>' : null; ?>
<section class="sect contacts">
  <div class="wrappall">
    <div class="content">
      <h1 class="section_title"><?=$content['title'];?></h1>
      <div class="view_block contacts_block">
        <?=$click;?>
        <?=$content['fields']['contacts'];?>
      </div>
    </div>
  </div>
</section>
<section class="sect ya_maps_all">
  <div class="maps" id="yaMaps"></div>
</section>