<section class="sect today">
  <div class="wrappall">
    <div class="content">
      <h1 class="section_title">Архив ежедневных событий</h1>
      <div id="today" class="today_content clearfix">
        <? $i = 0; ?>
        <? foreach($content as $value) : ?>
          <div class="today_content_block today_content_block_<?=Functions::odd_even($i);?>">
            <h3><?=$value['date_creat'];?></h3>
            <?=Functions::f_typograf($value['body']);?>
          </div>
          <? $i++; ?>
        <? endforeach; ?>
      </div>
      <? if(!empty($paginator)) echo $paginator; ?>
    </div>
  </div>
</section>