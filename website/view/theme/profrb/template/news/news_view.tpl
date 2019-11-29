<section class="sect news_page">
  <div class="wrapp810">
    <div class="content">
      <ul class="breadcrumbs">
        <li><a href="../" target="_self">Главная</a></li>
        <li><a href="../news" target="_self">Новости</a></li>
      </ul>
      <article class="news_view">
        <? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$cid.', \'edit\');"></span>' : null; ?>
        <?=$click;?>
        <h1 class="news_title"><?=$content_title;?><time datetime="<?=$view_date;?>"><?=$view_date;?></time></h1>
        <? foreach($fields as $field) : ?>
          <? foreach($field as $key => $value) : ?>
            <? if($key == 'text') : ?>
              <div class="news_view_row">
                <?=$value;?>
              </div>
            <? elseif($key == 'news_image') : ?>
              <div class="news_view_row">
                <img class="news_images_big" src="<?=$value['path'];?>" alt="<?=$value['title'];?>" title=""/>
              </div>
            <? elseif($key == 'gallery') : ?>
              <div class="news_view_row">
                <div class="slick_carousel" id="slickCarousel">
                  <? foreach($value as $images) : ?>
                    <? if(!empty($images['path_crop'])) : ?>
                      <img src="..<?=$images['path_crop'];?>" data-img-id="<?=++$images['order'];?>"/>
                    <? else : ?>
                      <img src="..<?=$images['path'];?>" data-img-id="<?=++$images['order'];?>"/>
                    <? endif; ?>
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
        <div id="print_news"><span>Распечатать новость</span></div>
        <div class="social_icons news_view_cs__socials clearfix" data-cid="<?=$cid;?>">
          <span>Поделиться: </span>
          <i class="social_icon" id="social_repost" data-social-type="vk" onclick="window.open('https://vk.com/share.php?url=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>&title=<?=$content_title;?>','sharer','toolbar=0,status=0,width=700,height=400,top='+((screen.height-600)/2)+',left='+((screen.width-700)/2)+'');"></i>
          <i class="social_icon" id="social_repost" data-social-type="tw" onclick="window.open('http://twitter.com/share?url=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>&text=<?=$content_title;?>','sharer','toolbar=0,status=0,width=700,height=400,top='+((screen.height-600)/2)+',left='+((screen.width-700)/2)+'');"></i>
          <i class="social_icon" id="social_repost" data-social-type="fb" onclick="window.open('https://www.facebook.com/sharer.php?u=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>&title=<?=$content_title;?>','sharer','toolbar=0,status=0,width=700,height=400,top='+((screen.height-600)/2)+',left='+((screen.width-700)/2)+'');"></i>
          <i class="social_icon" id="social_repost" data-social-type="ok" onclick="window.open('https://connect.ok.ru/dk?st.cmd=WidgetSharePreview&st.title=<?=$content_title;?>&st.shareUrl=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>','sharer','toolbar=0,status=0,width=700,height=400,top='+((screen.height-600)/2)+',left='+((screen.width-700)/2)+'');"></i>
        </div>
      </article>
      <ul class="news_flippy clearfix">
        <? if(isset($prev_news)) : ?>
          <li class="news_flippy_prev">
            <a href="..<?=$prev_news['url'];?>" target="_self">
               <h2 class="news_flippy__title"><?=$prev_news['title'];?></h2>
               <p class="news_flippy__date"><?=$prev_news['date'];?></p>
               <div class="news_flippy_btn"></div>
            </a>
          </li>
        <? endif; ?>
        <? if(isset($next_news)) : ?>
          <li class="news_flippy_next">
            <a href="..<?=$next_news['url'];?>" target="_self">
                <h2 class="news_flippy__title"><?=$next_news['title'];?></h2>
                <p class="news_flippy__date"><?=$next_news['date'];?></p>
                <div class="news_flippy_btn"></div>
            </a>
          </li>
        <? endif; ?>
      </ul>
    </div>
  </div>
</section>