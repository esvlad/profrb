<section class="sect front docs">
  <div class="wrappall">
    <div class="content clearfix">
      <div class="row_block clearfix">
        <div class="col_left">
          <h2>Новые документы</h2><a class="btn brd btn_main_docs" href="../docs" target="_self"> <span>Все документы</span></a>
          <? if(IS_MOBILE) : ?>
           <div class="form_docs_mb">
          <? endif; ?>
          <ul class="view_docs view_docs_new">
            <? if(!empty($new_docs)) : ?>
              <? foreach($new_docs as $docs) : ?>
                <li class="view_docs__item">
                  <i class="docs_icon <?=$docs['docs_icon_class'];?>"></i>
                  <div class="docs_title">
                    <a href="..<?=$docs['body']['path'];?>" download data-id="<?=$docs['cid'];?>"><?=$docs['title'];?></a>
                    <time datetime="<?=$docs['view_date'];?>"><?=$docs['view_date'];?></time>
                  </div>
                </li>
              <? endforeach; ?>
            <? endif; ?>
          </ul>
          <? if(IS_MOBILE) : ?>
           </div>
          <? endif; ?>
        </div>
        <div class="col_right">
          <h2>Популярные документы</h2>
          <? if(IS_MOBILE) : ?>
           <div class="form_docs_mb">
          <? endif; ?>
          <ul class="view_docs view_docs_popular">
            <? if(!empty($popular_docs)) : ?>
              <? foreach($popular_docs as $docs) : ?>
                <li class="view_docs__item">
                  <i class="docs_icon <?=$docs['docs_icon_class'];?>"></i>
                  <div class="docs_title">
                    <a href="..<?=$docs['body']['path'];?>" download data-id="<?=$docs['cid'];?>"><?=$docs['title'];?></a>
                    <time datetime="<?=$docs['view_date'];?>"><?=$docs['view_date'];?></time>
                  </div>
                </li>
              <? endforeach; ?>
            <? endif; ?>
          </ul>
          <? if(IS_MOBILE) : ?>
           </div>
          <? endif; ?>
        </div>
      </div>
    </div>
  </div>
</section>