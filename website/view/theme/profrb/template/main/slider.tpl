<section class="sect slider">
  <div class="wrapp100">
    <div class="content">
      <div class="slider_block">
      	<? $data_slide = 1;?>
      	<? foreach($sliders as $id => $slide) : ?>
      		<? $slide_class = ($data_slide == 1) ? 'active' : null; ?>
          <div class="ms_images clearfix <?=$slide_class;?>" data-slide="<?=$data_slide?>" style="background:url(<?=$slide['bgimage'];?>)">
            <div class="slider_text_block">
              <div class="wrappall">
                <h2 class="slider_title"><?=$slide['slider_title']?></h2>
                <p class="slider_caption"><?=$slide['slider_caption']?></p>
                <? if(isset($slide['btn_slider']) && $slide['btn_slider'] != '') : ?>
                  <? $slide_href = isset($slide['slider_link']) ? 'href="'.$slide['slider_link'].'" target="_self"' : null; ?>
                  <a class="btn brd btn_slider btn_blue" <?=$slide_href;?>><?=$slide['btn_slider'];?></a>
                <? else : ?>
                  <a class="btn brd btn_slider btn_blue" style="opacity: 0;">&nbsp;</a>
                <? endif; ?>
              </div>
            </div>
          </div>
	        <? $data_slide++;?>
	    <? endforeach; ?>
      <? if(IS_MOBILE) : ?>
        <div class="slide_arrows" data-slider-count="<?=count($sliders) - 1;?>">
          <span class="slide_arrows__left" data-slide="1"></span>
          <span class="slide_arrows__right" data-slide="<?=count($sliders) - 1;?>"></span>
        </div>
      <? endif; ?>
      </div>
      <div class="slider_menu">
        <div class="wrappall">
          <ul class="slider_menu_list clearfix">
          	<? $data_slide = 1;?>
          	<? foreach($sliders as $id => $slide) : ?>
          		<? $slideclass = ($data_slide == 1) ? 'class="active"' : null; ?>
              <li id="slider_item" data-slide="<?=$data_slide;?>" <?=$slideclass;?>>
                <div class="slider_line"></div> <span><?=$slide['slider_item'];?></span>
              </li>
            	<? $data_slide++;?>
            <? endforeach; ?>
          </ul>
        </div>
      </div>
    </div>
  </div>
</section>