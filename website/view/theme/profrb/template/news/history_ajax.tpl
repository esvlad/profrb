<? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$content_id.', \'edit\');"></span>' : null; ?>
<?=$click;?>
        <? foreach($fields as $field) : ?>
          <? foreach($field as $k => $v) : ?>
            <? foreach($v as $key => $value) : ?>
              <?#=$k.'<br>';?>
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
                  <div class="slick_carousel" id="slickCarouselAjax">
                    <? $img_num = 1; ?>
                    <? foreach($value as $images) : ?>
                      <img src="..<?=$images['path'];?>"/>
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
        <? endforeach; ?>
      <pre><?#print_r($fields);?></pre>
<script>
  $('.field_images > img').each(function(){
    $(this).after('<p class="img_caption_small">'+$(this).attr('alt')+'</p>');
  });

  $('.slick_carousel').slick({
    dots: true,
    infinite: true,
    speed: 500,
    fade: true,
    cssEase: 'linear'
  });

  $('.pn_count > .owl_click').click(function(){
    if($(this).hasClass('owl_prev')){
      $(this).parents('.field_gallery').find('.slick_carousel').slick('slickPrev');
    } else {
      $(this).parents('.field_gallery').find('.slick_carousel').slick('slickNext');
    }
  });

    // On before slide change
    $('.slick_carousel').on('beforeChange', function(event, slick, currentSlide, nextSlide){
      $(this).next('.pn_count').find('.owl_now').text(++nextSlide);
    });

  /*var owl_gallery_ajax = [];
  var g = 0;
  $('.field_gallery').each(function(){
    $(this).find('#owlCarouselAjax').attr({'id':'owlCarouselAjax'+g, 'data-galery-id':g});
    owl_gallery_ajax.push($('#owlCarouselAjax'+g));

    g++;
  });

  for(gg = 0; gg < owl_gallery_ajax.length; gg++){
    $('#owlCarouselAjax'+gg).owlCarousel({
      animateOut: 'fadeOut',
      animateIn: 'fadeIn',
      items: 1,
      autoHeight: true,
      loop: true,
      center: true,
      mouseDrag: false,
      nav: true,
      navText: [
        '',
          ''
      ]
    });
  }*/

  /*var owl_data = $('#owlCarouselAjax');
  owl_data.owlCarousel({
    animateOut: 'fadeOut',
    animateIn: 'fadeIn',
    items: 1,
    autoHeight: true,
    loop: true,
    center: true,
    mouseDrag: false,
    nav: true,
    navText: [
      '',
        ''
    ]
  });*/

  /*var gid;
  $('.owl_click').click(function(){
    gid = $(this).parents('.field_gallery').find('.owl-carousel').data('galery-id');
    
    
    if($(this).hasClass('owl_prev')){
      $('#owlCarouselAjax'+gid).trigger('prev.owl.carousel');
    }
      
    if($(this).hasClass('owl_next')){
      $('#owlCarouselAjax'+gid).trigger('next.owl.carousel');
    }

    $('#owlCarouselAjax'+gid).on('changed.owl.carousel', function (e) {
      $('.owl_text > .owl_now').text(++e.page.index);
    });
  });*/
</script>