<section class="sect events today">
  <div class="wrappall">
    <div class="content">
      <h2>Сегодня</h2>
      <div class="btn brd btn_event_calend"><a href="../today" target="_self"><span>Архив</span></a></div>
      <div class="row_block clearfix">
        <div class="event_owl_carousel clearfix" id="todayCarousel" data-slides="<?=count($content);?>">
          <? foreach($content as $key => $today) : ?>
            <div class="eitem">
              <div class="even_item">
                <h3 class="event_item__title"><?=$today['date_creat'];?></h3>
                <?=Functions::f_typograf($today['body']);?>
              </div>
            </div>
          <? endforeach; ?>
        </div>
      </div>
    </div>
  </div>
</section>