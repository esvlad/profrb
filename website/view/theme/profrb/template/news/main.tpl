<section class="sect front news_sect">
  <div class="wrappall">
    <div class="content clearfix">
      <h2><a href="../news" target="_self">Новости</a></h2>
      <div class="news_filters clearfix" id="news_filter">
        <? foreach($filters as $filter) : ?>
          <? if($filter['order'] != -1) : ?>
            <div class="btn brd btn_news_filter" data-news-type="<?=$filter['name'];?>" data-btn-text="<?=$filter['title'];?> (<?=$filter['count'];?>)"><?=$filter['title'];?> <span class="news_count">(<?=$filter['count'];?>)</span></div>
          <? endif; ?>
        <? endforeach; ?>
      </div>
      <? foreach($content as $key => $value) : ?>
        <div class="news_views <?=$key;?> clearfix">
          <? if($key == 'news_blocks') : ?>
            <? $n = 0; ?>
              <? if(isset($news_imortant)) : ?>
                <? if(count($news_imortant) == 1){
                      $right_nl = array(0,4,8,12);
                      $right_nr = array(1,5,9,13);
                      $left_nl = array(2,6,10);
                      $left_nr = array(3,7,11);
                    } else {
                      $right_nl = array(0,2,6,10);
                      $right_nr = array(1,3,7,11);
                      $left_nl = array(4,8);
                      $left_nr = array(5,9);
                    } ?>
                <div class="news_col_50">
                  <div class="news_views__important">
                    <? foreach($news_imortant as $key => $news) : ?>
                      <? if($key < 2) : ?>
                        <div class="news_block news_block__big__image_small clearfix admin_edit">
                          <a href="..<?=$news['uri'];?>" target="_self">
                            <div class="news_field_image">
                              <img src="..<?=$news['preview'];?>"/>
                            </div>
                            <div class="news_preview_text">
                              <h3 class="news_title"><span><?=$news['title'];?></span></h3>
                              <time class="news_date"><?=$news['date'];?></time>
                              <p class="news_count_view"><?=$news['views'];?></p>
                            </div>
                          </a>
                        </div>
                      <? endif; ?>
                    <? endforeach; ?>
                  </div>
                  <div class="news_views__blocks">
                    <div class="news_views__blocks_left">
                      <? foreach($value as $k => $news) : ?>
                        <? if(empty($news['title'])) break; ?>
                        <? if(in_array($k, $left_nl)) : ?>
                          <? if(!$news['preview']) : ?>
                            <div class="news_block <?=Functions::news_img_preview($news['preview'], 'class');?> small clearfix" data-k="<?=$k;?>">
                              <a href="..<?=$news['uri'];?>" target="_self">
                                <?=Functions::news_img_preview($news['preview'], 'div');?>
                                <div class="news_preview_text">
                                  <h3 class="news_title"><span><?=$news['title'];?></span></h3>
                                  <time class="news_date"><?=$news['date'];?></time>
                                  <p class="news_count_view"><?=$news['views'];?></p>
                                </div>
                              </a>
                            </div>
                          <? else : ?>
                            <div class="news_block <?=Functions::news_img_preview($news['preview'], 'class');?> small clearfix" data-k="<?=$k;?>">
                              <?=$click;?>
                              <a href="..<?=$news['uri'];?>" target="_self">
                                <?=Functions::news_img_preview($news['preview'], 'div');?>
                                <div class="news_preview_text">
                                  <h3 class="news_title"><span><?=$news['title'];?></span></h3>
                                  <time class="news_date"><?=$news['date'];?></time>
                                  <p class="news_count_view"><?=$news['views'];?></p>
                                </div>
                              </a>
                            </div>
                          <? endif; ?>
                        <? endif; ?>
                      <? endforeach; ?>
                    </div>
                    <div class="news_views__blocks_right">
                      <? foreach($value as $k => $news) : ?>
                        <? if(empty($news['title'])) break; ?>
                        <? if(in_array($k, $left_nr)) : ?>
                            <div class="news_block <?=Functions::news_img_preview($news['preview'], 'class');?> large clearfix" data-k="<?=$k;?>">
                              <a href="..<?=$news['uri'];?>" target="_self">
                                <?=Functions::news_img_preview($news['preview'], 'div');?>
                                <div class="news_preview_text">
                                  <h3 class="news_title"><span><?=$news['title'];?></span></h3>
                                  <time class="news_date"><?=$news['date'];?></time>
                                  <p class="news_count_view"><?=$news['views'];?></p>
                                </div>
                              </a>
                            </div>
                        <? endif; ?>
                      <? endforeach; ?>
                    </div>
                  </div>
                </div>
                <div class="news_col_50">
                  <div class="news_views__blocks">
                    <div class="news_views__blocks_left">
                      <? foreach($value as $k => $news) : ?>  
                        <? if(empty($news['title'])) break; ?>
                        <? if(in_array($k, $right_nl)) : ?>
                          <? if(!$news['preview']) : ?>
                            <div class="news_block <?=Functions::news_img_preview($news['preview'], 'class');?> small clearfix">
                              <a href="..<?=$news['uri'];?>" target="_self">
                                <?=Functions::news_img_preview($news['preview'], 'div');?>
                                <div class="news_preview_text">
                                  <h3 class="news_title"><span><?=$news['title'];?></span></h3>
                                  <time class="news_date"><?=$news['date'];?></time>
                                  <p class="news_count_view"><?=$news['views'];?></p>
                                </div>
                              </a>
                            </div>
                          <? else : ?>
                            <div class="news_block <?=Functions::news_img_preview($news['preview'], 'class');?> small clearfix">
                              <a href="..<?=$news['uri'];?>" target="_self">
                                <?=Functions::news_img_preview($news['preview'], 'div');?>
                                <div class="news_preview_text">
                                  <h3 class="news_title"><span><?=$news['title'];?></span></h3>
                                  <time class="news_date"><?=$news['date'];?></time>
                                  <p class="news_count_view"><?=$news['views'];?></p>
                                </div>
                              </a>
                            </div>
                          <? endif; ?>
                        <? endif; ?>
                      <? endforeach; ?>
                    </div>
                    <div class="news_views__blocks_right">
                      <? foreach($value as $k => $news) : ?>
                        <? if(empty($news['title'])) break; ?>
                        <? if(in_array($k, $right_nr)) : ?>
                            <div class="news_block <?=Functions::news_img_preview($news['preview'], 'class');?> large clearfix">
                              <a href="..<?=$news['uri'];?>" target="_self">
                                <?=Functions::news_img_preview($news['preview'], 'div');?>
                                <div class="news_preview_text">
                                  <h3 class="news_title"><span><?=$news['title'];?></span></h3>
                                  <time class="news_date"><?=$news['date'];?></time>
                                  <p class="news_count_view"><?=$news['views'];?></p>
                                </div>
                              </a>
                            </div>
                        <? endif; ?>
                      <? endforeach; ?>
                    </div>
                  </div>
                </div>
              <? else : ?>
                <?
                  $right_nl = array(2,6,10,14);
                  $right_nr = array(3,7,11,15);
                  $left_nl = array(0,4,8,12);
                  $left_nr = array(1,5,9,13);
                ?>
                <div class="news_col_50">
                  <div class="news_views__blocks">
                    <div class="news_views__blocks_left">
                      <? foreach($value as $k => $news) : ?>
                        <? if(empty($news['title'])) break; ?>
                        <? if(in_array($k, $left_nl)) : ?>
                          <? if(!$news['preview']) : ?>
                            <div class="news_block <?=Functions::news_img_preview($news['preview'], 'class');?> small clearfix">
                              <a href="..<?=$news['uri'];?>" target="_self">
                                <?=Functions::news_img_preview($news['preview'], 'div');?>
                                <div class="news_preview_text">
                                  <h3 class="news_title"><span><?=$news['title'];?></span></h3>
                                  <time class="news_date"><?=$news['date'];?></time>
                                  <p class="news_count_view"><?=$news['views'];?></p>
                                </div>
                              </a>
                            </div>
                          <? else : ?>
                            <div class="news_block <?=Functions::news_img_preview($news['preview'], 'class');?> small clearfix">
                              <a href="..<?=$news['uri'];?>" target="_self">
                                <?=Functions::news_img_preview($news['preview'], 'div');?>
                                <div class="news_preview_text">
                                  <h3 class="news_title"><span><?=$news['title'];?></span></h3>
                                  <time class="news_date"><?=$news['date'];?></time>
                                  <p class="news_count_view"><?=$news['views'];?></p>
                                </div>
                              </a>
                            </div>
                          <? endif; ?>
                        <? endif; ?>
                      <? endforeach; ?>
                    </div>
                    <div class="news_views__blocks_right">
                      <? foreach($value as $k => $news) : ?>
                        <? if(empty($news['title'])) break; ?>
                        <? if(in_array($k, $left_nr)) : ?>
                            <div class="news_block <?=Functions::news_img_preview($news['preview'], 'class');?> large clearfix">
                              <a href="..<?=$news['uri'];?>" target="_self">
                                <?=Functions::news_img_preview($news['preview'], 'div');?>
                                <div class="news_preview_text">
                                  <h3 class="news_title"><span><?=$news['title'];?></span></h3>
                                  <time class="news_date"><?=$news['date'];?></time>
                                  <p class="news_count_view"><?=$news['views'];?></p>
                                </div>
                              </a>
                            </div>
                        <? endif; ?>
                      <? endforeach; ?>
                    </div>
                  </div>
                </div>
                <div class="news_col_50">
                  <div class="news_views__blocks">
                    <div class="news_views__blocks_left">
                      <? foreach($value as $k => $news) : ?>
                        <? if(empty($news['title'])) break; ?>
                        <? if(in_array($k, $right_nl)) : ?>
                          <? if(!$news['preview']) : ?>
                            <div class="news_block <?=Functions::news_img_preview($news['preview'], 'class');?> small clearfix">
                              <a href="..<?=$news['uri'];?>" target="_self">
                                <?=Functions::news_img_preview($news['preview'], 'div');?>
                                <div class="news_preview_text">
                                  <h3 class="news_title"><span><?=$news['title'];?></span></h3>
                                  <time class="news_date"><?=$news['date'];?></time>
                                  <p class="news_count_view"><?=$news['views'];?></p>
                                </div>
                              </a>
                            </div>
                          <? else : ?>
                            <div class="news_block <?=Functions::news_img_preview($news['preview'], 'class');?> small clearfix">
                              <a href="..<?=$news['uri'];?>" target="_self">
                                <?=Functions::news_img_preview($news['preview'], 'div');?>
                                <div class="news_preview_text">
                                  <h3 class="news_title"><span><?=$news['title'];?></span></h3>
                                  <time class="news_date"><?=$news['date'];?></time>
                                  <p class="news_count_view"><?=$news['views'];?></p>
                                </div>
                              </a>
                            </div>
                          <? endif; ?>
                        <? endif; ?>
                      <? endforeach; ?>
                    </div>
                    <div class="news_views__blocks_right">
                      <? foreach($value as $k => $news) : ?>
                        <? if(empty($news['title'])) break; ?>
                        <? if(in_array($k, $right_nr)) : ?>
                            <div class="news_block <?=Functions::news_img_preview($news['preview'], 'class');?> large clearfix">
                              <a href="..<?=$news['uri'];?>" target="_self">
                                <?=Functions::news_img_preview($news['preview'], 'div');?>
                                <div class="news_preview_text">
                                  <h3 class="news_title"><span><?=$news['title'];?></span></h3>
                                  <time class="news_date"><?=$news['date'];?></time>
                                  <p class="news_count_view"><?=$news['views'];?></p>
                                </div>
                              </a>
                            </div>
                        <? endif; ?>
                      <? endforeach; ?>
                    </div>
                  </div>
                </div>
              <? endif; ?>
          <? else : ?>
            <? foreach($value as $k => $news) : ?>
              <? if(empty($news['title'])) break; ?>
              <div class="news_block">
                <a href="..<?=$news['uri'];?>" target="_self">
                  <? if(!empty($news['preview_crop'])) : ?>
                    <img src="..<?=$news['preview_crop'];?>"/>
                  <? else : ?>
                    <img src="..<?=$news['preview'];?>"/>
                  <? endif; ?>
                  <h3 class="clearfix"><time class="news_date_other"><?=$news['date'];?></time><br /><?=$news['title'];?></h3>
                </a>
              </div>
            <? endforeach; ?>
          <? endif; ?>
        </div>
      <? endforeach; ?>
      <? if(IS_MOBILE) : ?>
        <a class="btn brd btn_all_news_mb" href="../news" target="_self">Все новости</a>
      <? endif; ?>
    </div>
  </div>
</section>