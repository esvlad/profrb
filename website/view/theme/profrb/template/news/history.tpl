<section class="sect second_menu">
  <div class="wrapper">
    <div class="content">
      <ul class="second_menu__list_view">
            <li class="active">
              <a href="/history" target="_self">История</a>
            </li>
            <li>
              <a href="/geo" target="_self">География</a>
            </li>
            <li>
              <a href="/workers" target="_self">Сотрудники</a>
            </li>
            <li>
              <a href="/structure" target="_self">Структура</a>
            </li>
      </ul>
      </div>
    </div>
</section>
<section class="sect about_us history">
  <div class="wrapper">
    <div class="content">
      <h1 class="section_title">История</h1>
      <p class="section_caption"></p><!--с&nbsp;самого основания с&nbsp;фотографиями.-->
      <? if(IS_MOBILE) echo '<div class="history_mb_scroll">'; ?>
      <ul class="history_date">
        <? foreach($more_content as $history_date) : ?>
          <? if($history_date['id'] == $content['id']) : ?>
            <li class="active" data-block-id="<?=$history_date['id'];?>"><?=$history_date['title'];?></li>
          <? else : ?>
            <li data-block-id="<?=$history_date['id'];?>"><?=$history_date['title'];?></li>
          <? endif; ?>
        <? endforeach; ?>
      </ul>
      <? if(IS_MOBILE) echo '</div>'; ?>
      <? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$content['id'].', \'edit\');"></span>' : null; ?>
      <div class="view_block history_block active">
        <?=$click;?>
        <? foreach($fields as $field) : ?>
          <? foreach($field as $key => $value) : ?>
            <? if($key == 'text') : ?>
              <div class="field_text">
                <?=$value;?>
              </div>
            <? elseif($key == 'news_image') : ?>
              <div class="field_images">
                <img class="images_big" src="<?=$value['path'];?>" alt="<?=$value['title'];?>" title=""/>
              </div>
            <? elseif($key == 'gallery') : ?>
              <div class="field_gallery">
                <div class="slick_carousel" id="slickCarousel">
                  <? foreach($value as $images) : ?>
                    <img src="..<?=$images['path'];?>" data-img-id="<?=++$images['order'];?>"/>
                  <? endforeach; ?>
                </div>
                <div class="pn_count clearfix">
                  <div class="owl_click owl_prev"></div>
                  <div class="owl_text">
                    <span class="owl_now">1</span>
                    <span class="owl_tt">из</span>
                    <span class="owl_count"><?=count($value);?></span>
                  </div>
                  <div class="owl_click owl_next"></div>
                </div>
              </div>
            <? endif; ?>
          <? endforeach; ?>
        <? endforeach; ?>
      </div>
    </div>
  </div>
</section>