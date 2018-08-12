<section class="sect events">
  <div class="wrappall">
    <div class="content">
      <h2>Ближайшие события</h2>
      <div class="btn brd btn_event_calend" id="btn_modal" data-modal-id="event_calend"><span>Календарь</span></div>
      <div class="row_block clearfix">
        <div class="event_owl_carousel clearfix" id="eventCarousel" data-slides="<?=count($events);?>">
          <? foreach($events as $key => $event) : ?>
            <div class="eitem" data-event="<?=$key;?>">
              <? if($event['fields']['event_now'] == 1) : ?>
                <div class="event_now">
                  <div class="event_video_thumballs">
                    <a href="<?=$event['fields']['event_link'];?>" target="_blank">
                      <img src="../website/view/theme/profrb/images/event/event1.jpg"/>
                    </a>
                  </div>
                  <h3 class="event_now__title"><?=Functions::f_typograf($event['title']);?></h3>
                  <?=$event['fields']['event_caption'];?>
                  <div class="event_social_repost">
                    <div class="social_icons clearfix">
                      <div class="social_icon" id="social_repost" data-social-type="vk" onclick="window.open('https://vk.com/share.php?url=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>&title=<?=strip_tags($event['fields']['event_caption']);?>','sharer','toolbar=0,status=0,width=700,height=400,top='+((screen.height-600)/2)+',left='+((screen.width-700)/2)+'');"></div>
                      <div class="social_icon" id="social_repost" data-social-type="tw" onclick="window.open('http://twitter.com/share?url=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>&text=<?=strip_tags($event['fields']['event_caption']);?>','sharer','toolbar=0,status=0,width=700,height=400,top='+((screen.height-600)/2)+',left='+((screen.width-700)/2)+'');"></div>
                      <div class="social_icon" id="social_repost" data-social-type="fb" onclick="window.open('https://www.facebook.com/sharer.php?u=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>&title=<?=$date_event .' '. $event['title'];?>&description=<?=strip_tags($event['fields']['event_caption']);?>','sharer','toolbar=0,status=0,width=700,height=400,top='+((screen.height-600)/2)+',left='+((screen.width-700)/2)+'');"></div>
                      <div class="social_icon" id="social_repost" data-social-type="ok" onclick="window.open('https://connect.ok.ru/dk?st.cmd=WidgetSharePreview&st.description=<?=strip_tags($event['fields']['event_caption']);?>&st.title=<?=$date_event .' '. $event['title'];?>&st.shareUrl=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>','sharer','toolbar=0,status=0,width=700,height=400,top='+((screen.height-600)/2)+',left='+((screen.width-700)/2)+'');"></div>
                    </div>
                  </div>
                </div>
              <? else : ?>
                <div class="even_item">
                  <? $date_event = (date('d', strtotime($event['date_creat'])) . (date('.m', strtotime($event['date_creat']))) . date('.Y', strtotime($event['date_creat']))); ?>
                  <h3 class="event_item__title"><?=$date_event;?> <?=Functions::f_typograf($event['title']);?></h3>
                  <?=$event['fields']['event_caption'];?>
                  <div class="event_social_repost">
                    <div class="social_icons clearfix">
                      <div class="social_icon" id="social_repost" data-social-type="vk" onclick="window.open('https://vk.com/share.php?url=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>&title=<?=strip_tags($event['fields']['event_caption']);?>','sharer','toolbar=0,status=0,width=700,height=400,top='+((screen.height-600)/2)+',left='+((screen.width-700)/2)+'');"></div>
                      <div class="social_icon" id="social_repost" data-social-type="tw" onclick="window.open('http://twitter.com/share?url=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>&text=<?=strip_tags($event['fields']['event_caption']);?>','sharer','toolbar=0,status=0,width=700,height=400,top='+((screen.height-600)/2)+',left='+((screen.width-700)/2)+'');"></div>
                      <div class="social_icon" id="social_repost" data-social-type="fb" onclick="window.open('https://www.facebook.com/sharer.php?u=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>&title=<?=$date_event .' '. $event['title'];?>&description=<?=strip_tags($event['fields']['event_caption']);?>','sharer','toolbar=0,status=0,width=700,height=400,top='+((screen.height-600)/2)+',left='+((screen.width-700)/2)+'');"></div>
                      <div class="social_icon" id="social_repost" data-social-type="ok" onclick="window.open('https://connect.ok.ru/dk?st.cmd=WidgetSharePreview&st.description=<?=strip_tags($event['fields']['event_caption']);?>&st.title=<?=$date_event .' '. $event['title'];?>&st.shareUrl=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>','sharer','toolbar=0,status=0,width=700,height=400,top='+((screen.height-600)/2)+',left='+((screen.width-700)/2)+'');"></div>
                    </div>
                  </div>
                </div>
              <? endif; ?>
            </div>
          <? endforeach; ?>
        </div>
      </div>
      <? if(IS_MOBILE) : ?>
        <div class="events_modal_letter">
          <p>Подпишитесь на рассылку</p>
          <p>и не пропускайте анонсы интересных мероприятий</p>
          <form id="letter_event" class="eml_form">
            <input class="display_none" type="checkbox" name="letter[]" value="events" checked/>
            <? $placeholder = IS_MOBILE ? 'Введите ваш e-mail' : 'Введите ваш e-mail и нажмите Enter'; ?>
            <input type="email" name="mail" value="" placeholder="Введите ваш e-mail и нажмите Enter" required/>
            <input class="mini_form_submit brd" type="submit" value="Подписаться">
          </form>
        </div>
      <? endif; ?>
    </div>
  </div>
</section>
<?
function formate_date_event($date){
  $new_date = explode(' ', $date);
  return $new_date[0];
}

$m_array = array(true,'Января','Февраля','Марта','Апреля','Мая','Июня','Июля','Августа','Сентября','Октября','Ноября','Декабря');
?>

<div class="modal events_modal" data-modal-id="event_calend" data-modal-open="false">
  <div class="modal_close"></div>
  <div class="events_modal_head">
    <h3>Все события</h3>
  </div>
  <div class="events_modal_content clearfix">
    <? foreach($daterange as $d => $date) : ?>
    	<?$dd = $date;?>
      <div class="emc_cell">
        <div class="emc_cell__content">
          <? foreach($events as $key => $event) : ?>
            <? if(strtotime(formate_date_event($event['date_creat'])) <= strtotime($date) && strtotime(formate_date_event($event['date_end'])) >= strtotime($date)) : ?>
              <p class="emc_cell__content_title" data-event-type="vebinar"><span><?=$event['title'];?></span></p>
              <div class="emc_cell__content_caption">
                <?=$event['fields']['event_caption'];?>
              </div>
            <? endif; ?>
          <? endforeach; ?>
        </div>
        <p class="emc_cell_num"><?=date('j',strtotime($dd));?> <span class="month"><?=$m_array[date('n',strtotime($dd))];?></span></p>
      </div>
    <? endforeach; ?>
  </div>
  <div class="events_modal_footer">
    <div class="events_modal_letter">
      <p>Подпишитесь на рассылку</p>
      <p>и не пропускайте анонсы интересных мероприятий</p>
      <form id="letter_event" class="eml_form">
      	<input class="display_none" type="checkbox" name="letter[]" value="events" checked/>
        <input type="email" name="mail" value="" placeholder="Введите ваш e-mail и нажмите Enter" required/>
      </form>
    </div>
  </div>
</div>