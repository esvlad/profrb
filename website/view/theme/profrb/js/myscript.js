window.winWidth = $(window).width();

$(document).ready(function() {
	$(window).trigger('scroll');
	$('a, .btn').click(function(e){
		//e.preventDefault();
		btn_id = $(this).attr('id')
		if(btn_id) console.log(btn_id);
	});

	var special_vision = JSON.parse(localStorage.getItem('vision'));

	if(special_vision != null){
		set_vision(special_vision);

		$.ajax({
			url: 'index.php?r=common/home/vision',
			dataType: 'html',
			success: function(html){
				$('body > .modal_bg').after(html);
			}
		});
	}

	if(winWidth > 1024){
		$('.search_block[data-name-block="other"]').appendTo($('.search_block[data-name-block="docs"]'));
	}

	//localStorage.removeItem('vision')
	//localStorage.setItem('vision', JSON.stringify(s_vision));
	
	//Обработчик сабмита для отправки всей фигни	
	var timer = null;
  	var self = $("btn_submit button");
  	var clicked = false;
  	$(".btn_submit button").on("click", function () {
    	if(clicked === false){
    		self.removeClass("filled");
    		self.addClass("circle");
    		self.html("");
    		clicked = true;
    		$(".btn_submit svg").css("display", "block");
    		$(".circle_2").attr("class", "circle_2 fill_circle");

    		timer = setInterval(
        	function tick() {
        		self.removeClass("circle");
        		self.addClass("filled");
        		// self.html("b");
        		$(".btn_submit img").css("display", "block");
        		$(".btn_submit svg").css("display", "none");
        		clearInterval(timer);
    		}, 2500);
    	}
	});
	
	//Анимация верхнего поиска
	var $search = $(".search_miniform .search"),
    	$input = $(".search_miniform .search-input"),
    	$close = $(".search_miniform .search-close"),
    	$svg = $(".search_miniform .search-svg"),
    	$path = $(".search_miniform .search-svg__path")[0],
    	initD = $svg.data("init"),
    	midD = $svg.data("mid"),
    	finalD = $svg.data("active"),
    	backDelay = 400,
    	midAnim = 200,
    	bigAnim = 400,
    	animating = false;
  
  	$(document).on("click", ".search:not(.active), .search_miniform:not(.focus)", function() {
    	if (animating) return;
    	animating = true;
    	$search.addClass("active");
		$('.search_miniform').addClass('focus');
    
    	Snap($path).animate({"path": midD}, midAnim, mina.backin, function() {
    		Snap($path).animate({"path": finalD}, bigAnim, mina.easeinout, function() {
    		    $input.addClass("visible");
    		    $input.focus();
    		    $close.addClass("visible");
    		    animating = false;
    		});
    	});
	});
	
	var scroll_top = 0;
	$(window).bind('scroll',function(){
		scroll_top = $(this).scrollTop();
	});
	$(window).trigger('scroll');

	//Обработка модалок
	$('#btn_modal, h3#btn_modal, li#btn_modal, p#geo_modal, div#footer_popup').click(function(){
		var $modal_id = $(this).attr('data-modal-id');
		var $modal = $('.modal[data-modal-id="'+$modal_id+'"]');
		if(winWidth > 640) $modal.css('top',(scroll_top - (- 120))+'px');
		console.log('click' + scroll_top);
			
		if($modal.attr('data-modal-open') == 'false'){
			if(winWidth > 1024){
				$('div.modal_bg').fadeIn(300);
			} else {
				$('body').addClass('modal_bg');
			}
			$modal.fadeIn(300);
			$modal.attr('data-modal-open','true');

			var $f_h = $('.footer').height();
			var $f_b = $(document).height() - $f_h - 500;
			if(winWidth > 768){
				$('.footer').css({'position':'absolute', 'bottom': -$f_b+'px'});
			}
		} else {
			if(winWidth > 1024){
				$('div.modal_bg').fadeOut(300);
			} else {
				$('body').removeClass('modal_bg');
			}
			$modal.fadeOut(300);
			$modal.attr('data-modal-open','false');
			$('.footer').removeAttr('style');
		}
	});
	
	$('.modal_close').click(function(){
		if($(this).parents('.btn_letter').hasClass('opened')){
			$(this).parents('.btn_letter').removeClass('opened');
			$(this).parents('.btn_letter').addClass('closed');
		} else {
			var $btn_clicked = $(this).parents('.modal').attr('data-modal-id');
			$('#btn_modal[data-modal-id="'+$btn_clicked+'"]').trigger('click');
		}
	});

	$('div.modal_bg').click(function(){
		$(this).fadeOut(300);
		$('.modal').attr('data-modal-open','false').fadeOut(300);
		$('.footer').removeAttr('style');
	});
  
  	$(document).on("click", ".search-close", function() {
	    if (animating) return;
	    animating = true;
	    $input.removeClass("visible");
	    $close.removeClass("visible");
	    $search.removeClass("active");
			setTimeout(function(){
				$('.search_miniform').removeClass('focus');
			},700);
	    
	    setTimeout(function() {
	      Snap($path).animate({"path": midD}, bigAnim, mina.easeinout, function() {
	        Snap($path).animate({"path": initD}, midAnim, mina.easeinout, function() {
	          animating = false;
	        });
	      });
	    }, backDelay);
  	});
	
	//Крутецкое меню
	var trigger = $('#hamburger'),
		isMenu = $('#menu > span'),
		menuBlock = $('.sect.menu'),
      	isClosed = false;

  	trigger.click(function () {
  		burgerTime();
  	});
	
	isMenu.click(function(){
		trigger.click();
	});

  	function burgerTime() {
	    if (isClosed == true) {
	    	trigger.removeClass('is-open');
	    	trigger.addClass('is-closed');
	    	/*if(JSON.parse(localStorage.getItem('vision')) == null){
	    		isMenu.animate({'opacity':1},300);
	    	}*/
	    	isMenu.animate({'opacity':1},300);
			$('body').removeClass('modal_bg');
			menuBlock.slideUp(300);
	    	isClosed = false;
	    } else {
	    	trigger.removeClass('is-closed');
	    	trigger.addClass('is-open');
	    	trigger.removeClass('opened');

	    	/*if(JSON.parse(localStorage.getItem('vision')) == null){
	    		isMenu.animate({'opacity':0},300);
	    	}*/
	    	isMenu.animate({'opacity':0},300);
				
			menuBlock.delay(200).slideDown(300);
			$('body').addClass('modal_bg');
	    	isClosed = true;
	    }
  	}
	
	//Делаем одинаковую высоту у блоков с вопросами и ответами
	var faq_q_h, faq_a_h;
	/*$('.faq_block').each(function(){
		var faq_q = $(this).find('.faq_question');
		var faq_a = $(this).find('.faq_answer');
		faq_q_h = faq_q.innerHeight();
		faq_a_h = faq_a.innerHeight();
		
		if(faq_q_h > faq_a_h){
			faq_a.css('height', faq_q_h);
		} else if(faq_q_h < faq_a_h){
			faq_q.css('height', (faq_a_h - (-12)));
		}
	});*/

	if(location.pathname == '/labor-inspection'){
		if(location.search == '?ds=teh'){
			$('.switch_label.active, .vin_block.active').removeClass('active');
			$('.switch_label[data-switch="93"], .vin_block[data-switch="93"]').addClass('active');
		}
	}

	if(location.pathname == '/activity'){
		var str = location.search.split('=');
		var num_modal = parseInt(str[1]);

		$('#btn_modal[data-modal-id="'+num_modal+'"]').trigger('click');
		console.log(str[1]);
	}

	if(winWidth > 700){
		$('.comments_block').each(function(){
			$(this).appendTo($('.modals_block'));
			//$(this).wrapAll('<div class="modal_open"></div>');
			console.log('asd');
		});
	}
});

/*$('.cb_opened').click(function(){
	var cb_element = $(this);
	var comment_block = cb_element.parents('.comments_block');
	var cb_type = cb_element.attr('data-type');
	var cb_opened = cb_element.attr('data-open');

	if(cb_type == 'comments'){
		var cb_now_type = 'form';
	} else {
		var cb_now_type = 'comments';
	}

	if(cb_opened == 'false'){
		comment_block.find('.cb_blocks[data-type="'+cb_type+'"] .cb_block').slideDown();
		comment_block.find('.cb_blocks[data-type="'+cb_now_type+'"] .cb_block').slideUp();

		cb_element.attr('data-open','true');

		setTimeout(function(){
			comment_block.find('.cb_opened[data-type="'+cb_now_type+'"]').attr('data-open','false');
		},200);
	}
});*/

var s_vision = {};
$('#verius').click(function(){
	//console.log('clcik');
	if($('body > .special_vision').is('section')){
		localStorage.removeItem('vision');
		$('body > .special_vision').detach();
		set_vision(false);
		$('.menu .btn_site_version').text('Версия для слабовидящих');
	} else {
		s_vision.bg = 'vision_bg_blue';
		s_vision.font = 'vision_font_100';

		set_vision(s_vision);
		localStorage.setItem('vision', JSON.stringify(s_vision));

		console.log(s_vision);

		$.ajax({
			url: 'index.php?r=common/home/vision',
			dataType: 'html',
			success: function(html){
				$('body > .modal_bg').after(html);
			}
		});
	}
	location.reload();
});

function vision_off(){
	localStorage.removeItem('vision');
	$('body > .special_vision').detach();
	
	set_vision(false);
}

function set_vision(vision){
	if(vision){
		$('body').addClass(vision.bg).addClass(vision.font).addClass('special_vision');
		$('.sect.header').removeClass('front');
		$('.menu .btn_site_version').text('Обычная версия сайта');

		if(location.pathname == '/geo'){
			$('.switch_label[data-switch="2"]').trigger('click');
			$('.switch_label[data-switch="1"]').css('display','none');
		}
	} else {
		$('body').removeClass('special_vision vision_bg_white vision_bg_black vision_bg_blue vision_font_100 vision_font_125 vision_font_150');
		if(location.pathname == '/' || location.pathname == '/home'){
			$('.sect.header').addClass('front');
		}
		$('.menu .btn_site_version').text('Версия для слабовидящих');
	}
}

var data_count_slide_mb = $('.slide_arrows').attr('data-slider-count');
$('.slide_arrows > span').click(function(){
	var data_slide = $(this).attr('data-slide');

	var data_slide_now = $('.slider_block > .ms_images.active').index();
	console.log(data_slide);
	console.log(data_slide_now);

	$('.ms_images').removeClass('active');

	if($('.ms_images').eq(data_slide).css('position') != 'relative'){
		$('.ms_images').eq(data_slide_now).css({'position':'absolute', 'z-index':3}).animate({'opacity':'0'},1000);
		$('.ms_images').eq(data_slide).css({'position':'relative', 'z-index':4}).animate({'opacity':'1'},1000);

		$('.ms_images').eq(data_slide).addClass('active');
	}

	var data_next_slide = data_slide - (-1);
	var data_prev_slide = data_slide - 1;

	if(data_next_slide > data_count_slide_mb){
		$('.slide_arrows__left').attr('data-slide',0);
	} else {
		$('.slide_arrows__left').attr('data-slide',data_next_slide);
	}

	if(data_prev_slide < 0){
		$('.slide_arrows__right').attr('data-slide', data_count_slide_mb);
	} else {
		$('.slide_arrows__right').attr('data-slide', data_prev_slide);
	}
});

function vision_font(font_size){
	class_font = 'vision_font_' + font_size;
	special_vision_font = JSON.parse(localStorage.getItem('vision'));

	now_class_font = special_vision_font.font;

	special_vision_font.font = class_font;
	localStorage.setItem('vision', JSON.stringify(special_vision_font));

	$('body').removeClass(now_class_font).addClass(class_font);
}

function vision_bg(color){
	class_color = 'vision_bg_' + color;
	
	special_vision_bg = JSON.parse(localStorage.getItem('vision'));

	now_class_bg = special_vision_bg.bg;

	special_vision_bg.bg = class_color;
	localStorage.setItem('vision', JSON.stringify(special_vision_bg));

	$('body').removeClass(now_class_bg).addClass(class_color);
}

$('#mq_form_data_personal, #mq_form_data_membership').change(function(){
	if(!$(this).is(':checked')){
		$('#question_add').data('disabled',true).addClass('disabled');
	} else {
		$('#question_add').data('disabled',false).removeClass('disabled');
	}
});

if(location.pathname == '/' || location.pathname == '/home'){
	var ds_now = $('li#slider_item.active').attr('data-slide');

	var slidePlay;
	function slide_play(data){
		if(winWidth <= 1024) return false;

		if(data == 'start'){
			slidePlay = setInterval(function(){
				++ds_now;
				if(ds_now == 5) ds_now = 1;

				$('li#slider_item[data-slide="'+ds_now+'"]').trigger('click');
			}, 5000);
		}

		if(data == 'stop'){
			clearInterval(slidePlay);
		}
	}

	slide_play('start');
	$('li#slider_item.active').children('.slider_line').animate({'width': '100%'},5000);
	var slider_line;
	$('.sect.slider').mouseout(function(e){
		//console.log('out');
		slide_play('start');
		$('li#slider_item.active').children('.slider_line').animate({'width': '100%'},5000);
	});

	$('.sect.slider').mouseover(function(e){
		//console.log('over');
		clearInterval(slidePlay);

		$('li#slider_item.active').children('.slider_line').stop();
		//slider_line = $('li#slider_item.active').children('.slider_line').css('width');
	});
}

$('.menu_first').each(function(){
	if($(this).children('a').data('path') == location.pathname){
		$(this).children('a').addClass('active');
	}
});

$('.menu_group').each(function(){
	menu_group = $(this);
	menu_group.children('li').each(function(){
		if($(this).children('a').data('path') == location.pathname){
			$(this).children('a').addClass('active');
			menu_group.addClass('active');
			menu_group.parent().find('.menu_first').addClass('active');
		}
	});
});

if(winWidth <= 640){
	//var eitem_width = winWidth;
	var eitem_count = $('.events .eitem').length;
	/*$('.events .eitem').each(function(){
		$(this).css('width','calc(100% / ' + eitem_count + ')');
	});*/
	var str_eitem_width = '(100% * ' + eitem_count + ') - ' + ((eitem_count * 60) - 40) + 'px';
	
	$('.events .event_owl_carousel').css('width','calc(' + str_eitem_width + ')');
	//console.log('length = '+$('.events .eitem').length);

	$('.geo_block_list > li > p').each(function(){
		$(this).wrapInner('<span></span>');
	});

	$('.docs .docs_type').click(function(){
		$('#docs_filter').trigger('click');
		//$('#docs_filter').css('opacity',1);
	});

	$('.mb_sub_view').click(function(){
		var elem_sub_view = $(this).parents('.menu_col').find('.menu_group');
		if(elem_sub_view.css('display') != 'block'){
			elem_sub_view.slideDown(300);
			$(this).addClass('invert');
		} else {
			elem_sub_view.slideUp(300);
			$(this).removeClass('invert');
		}
	});
}

$('.search_tags > li').click(function(){
	var this_elem = $(this);
	var search_tag = this_elem.data('tags');

	if(!this_elem.hasClass('active')){
		$('.search_tags > li').removeClass('active');
		this_elem.addClass('active');

		$('.search_block').each(function(){
			if($(this).data('name-block') != search_tag){
				$(this).addClass('display_none');
			} else {
				$(this).removeClass('display_none');
			}
		});
	} else {
		this_elem.removeClass('active');
		$('.search_block').removeClass('display_none');
	}
});

$('#letter').click(function(){
	if(!$(this).hasClass('opened')){
		$(this).addClass('opened');
	} else {
		$(this).removeClass('closed');
	}
});

$('.view_docs .docs_title > a').click(function(){
	var doc_id = $(this).data('id');
	console.log(doc_id);

	$.get(
		'index.php?r=docs/docs/download',
		{
			id: doc_id
		},
		onAjaxSuccess
	);
});

function onAjaxSuccess(data){
	console.log(data);
}

var e_lets;
$('#letter_event').submit(function(e){
	e = e || event;
	e.preventDefault();

	e_lets = $(this).serialize();
	console.log(e_lets);

	$.ajax({
		url: 'index.php?r=modules/letter/subscribe',
		type: 'POST',
		data: e_lets,
		dataType: 'json',
		success: function(json){
			console.log(json);
			if(json.success == true){
				$('.events_modal_letter').html('<p>Спасибо подписка оформлена!</p>');
			}
		},
		error: function(xhr, ajaxOptions, thrownError){
	    	console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	    }
	});
});

var lets;
$('#subscribe').submit(function(e){
	e = e || event;
	e.preventDefault();

	lets = $(this).serialize();

	console.log(lets);

	$.ajax({
		url: 'index.php?r=modules/letter/subscribe',
		type: 'POST',
		data: lets,
		dataType: 'json',
		success: function(json){
			if(json.success == true){
				$('.footer_letter_modal > form').detach();
				$('.footer_letter_modal > .flm_title').addClass('letter_success').text('Спасибо подписка оформлена!');
			}
		},
		error: function(xhr, ajaxOptions, thrownError){
	    	console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	    }
	});
});

$('p#mq_selected').click(function(){
	var mq_selected_text = $(this).text();
	$('.selected_activ > label').text(mq_selected_text);
	$('.selected_checkbox').trigger('click');

	$('#mqf_subject').val($(this).attr('data-value'));
});

//Главный слайдер
$('li#slider_item').click(function(){
	var data_slide = $(this).attr('data-slide');
	//ds_now = data_slide;
	var data_slide_now = $('.slider_menu_list > li.active').attr('data-slide');
	console.log(data_slide);

	$('.ms_images').removeClass('active');

	if($('.ms_images[data-slide="'+data_slide+'"]').css('position') != 'relative'){
		$('.ms_images[data-slide="'+data_slide_now+'"]').css({'position':'absolute', 'z-index':3}).animate({'opacity':'0'},1000);
		$('.ms_images[data-slide="'+data_slide+'"]').css({'position':'relative', 'z-index':4}).animate({'opacity':'1'},1000);

		$('#slider_item.active').children('.slider_line').stop().fadeOut(1000).delay(1000).css({'width':'0%'}).delay(100).fadeIn();
		$('#slider_item.active').removeClass('active');
		$(this).addClass('active');

		$('#slider_item').children('.slider_line').css('width','0%').fadeIn(200);
		$(this).children('.slider_line').animate({'width':'100%'},5000);
	}
		/*setTimeout(function(){
			//$('.ms_images.active').removeClass('active');
			//$('#slider_item').children('.slider_line').css('width','0%').fadeIn(200);
			//$('.ms_images[data-slide="'+data_slide+'"]').addClass('active');
		}, 1000);*/
});

//Слайдер событий, моя библиотека гы-гы

var count_item = $('#eventCarousel').data('slides');

var item_number = 4;
if(winWidth <= 768 && winWidth > 640){
	item_number = 3;
}

$('#eventCarousel').esSlider({
	step: 1,
	items: item_number,
	count: count_item,
	paramPrevNext: 'invert',
	btnText: false
});

$('.btn_es_slider > .btn').click(function(){
	var $this = $(this);
	if($this.attr('data-btn-id') == 'next' && $('.btn_es_slider > .btn[data-btn-id="prev"]').attr('data-enabled') == 'true'){
		if(!$this.hasClass('next_top'))	$this.addClass('next_top');
	} 
	
	if($this.attr('data-btn-id') == 'next' && $this.attr('data-enabled') == 'false'){
		if(!$('.btn_es_slider > .btn[data-btn-id="prev"]').hasClass('next_out')){
			$('.btn_es_slider > .btn[data-btn-id="prev"]').addClass('next_out');
		} 
	}
	
	if($('.btn_es_slider > .btn[data-btn-id="prev"]').attr('data-enabled') == 'false' && $('.btn_es_slider > .btn[data-btn-id="next"]').attr('data-enabled') == 'true'){
		 $('.btn_es_slider > .btn[data-btn-id="next"]').removeClass('next_top');
	}
	
	if($('.btn_es_slider > .btn[data-btn-id="next"]').attr('data-enabled') == 'true' && $('.btn_es_slider > .btn[data-btn-id="prev"]').attr('data-enabled') == 'true'){
		 $('.btn_es_slider > .btn[data-btn-id="prev"]').removeClass('next_out');
	}
});

//Фильтр новостей
var $news_filter;
$('#news_filter > .btn').click(function(){
	$news_filter = $(this);
	$nft = $news_filter.attr('data-news-type');
	
	if($nft == 'photo'){
		$_nft = 'video';
	} else {
		$_nft = 'photo';
	}
	
	if($news_filter.hasClass('active')){
		$news_filter.removeClass('active');
		
		//Функция обработчик
		
		$('.'+$nft+'_blocks').fadeOut(200);
		$('.news_blocks').delay(200).fadeIn(200);
		
	} else {
		if($('.btn_news_filter[data-news-type="'+$_nft+'"]').hasClass('active')){
			$('.btn_news_filter').removeClass('active');
			$news_filter.addClass('active');
			
			//Функция обработчик
			
			$('.'+$_nft+'_blocks').fadeOut(200);
			$('.'+$nft+'_blocks').delay(200).fadeIn(200);
		} else {
			$news_filter.addClass('active');
			
			//Функция обработчик
			
			$('.news_blocks').fadeOut(200);
			$('.'+$nft+'_blocks').delay(200).fadeIn(200);
		}
	}
});

//Документы - показать категории
$('.docs_category__block_preview > p').click(function(){
	$(this).fadeOut(200);
	$('.docs_category__block_view').delay(200).slideDown(300);
});

$('.docs_category__block_view > .modal_close').click(function(){
	$(this).fadeOut(200);
	$(this).delay(400).fadeIn();
	$('.docs_category__block_view').slideUp(300);
	$('.docs_category__block_preview > p').delay(300).fadeIn(200);
});

$('.geografy_name > span').click(function(){
	if($('.geo_city_list').css('display') != 'block'){
		$('.geo_city_list').fadeIn(300);
	} else {
		$('.geo_close').trigger('click');
	}
});

$('.geo_close').click(function(){
	$('.geo_city_list').fadeOut(300);
});

//Документы - скрыть категории
$(document).mouseup(function (e) {
	if($('.docs_search_category').is('div')){
		var container = $(".docs_search_category");
	  if (container.has(e.target).length === 0){
	    $('.docs_category__block_view').slideUp(300);
		$('.docs_category__block_preview > p').delay(300).fadeIn(200);
	  }
	}
});

//История - работаем с галереей
//$('.field_images > img').after('<p class="img_caption_small">'+$('.field_images > img').attr('alt')+'</p>');
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
      $(this).parents('.news_view_row').find('.slick_carousel').slick('slickPrev');
    } else {
      $(this).parents('.field_gallery').find('.slick_carousel').slick('slickNext');
      $(this).parents('.news_view_row').find('.slick_carousel').slick('slickNext');
    }
});

    // On before slide change
$('.slick_carousel').on('beforeChange', function(event, slick, currentSlide, nextSlide){
  $(this).next('.pn_count').find('.owl_now').text(++nextSlide);
});

$('.history_date > li').click(function(){
	if(!$(this).hasClass('active')){
		$('.history_date > li').removeClass('active');
		$(this).addClass('active');

		var content_id = $(this).data('block-id');

		$.ajax({
			url: 'index.php?r=news/history/load',
			type: 'POST',
			data: {cid: content_id},
			dataType: 'html',
			success: function(html){
				$('.view_block.history_block').html(html);
			},
		});
	}
});

//Явление свитчера
$('#switch > .switch_label').click(function(e){
	if(!$(this).hasClass('active')){
		var $data_switch = $(this).attr('data-switch');
		var label_old = $('.switch_label.active').attr('data-switch');
		
		$('.switch_label.active').removeClass('active');
		$(this).addClass('active');

		if($(this).index() == 2){
			$('#switch > .switch_label').eq(1).addClass('rlabel');
		} else {
			$('#switch > .switch_label').removeClass('rlabel');
		}

		$('.view_block').removeClass('active');
		
		//$('.view_block[data-switch="'+$data_switch+'"]').before($('.view_block[data-switch="'+label_old+'"]'));
		$('.view_block[data-switch="'+label_old+'"]').css({'display':'none'});
		$('.view_block[data-switch="'+$data_switch+'"]').css({'display':'block'});
		/*setTimeout(function(){
			$('.view_block[data-switch="'+$data_switch+'"]').before($('.view_block[data-switch="'+label_old+'"]'));
		}, 200);*/
	} else {
		e.preventDefault();
	}
});

//Модалка в географии
/*$('p#geo_modal').click(function(){
	var $geo_modal_id = $(this).attr('data-modal-id');
	console.log($geo_modal_id);
	var $geo_modal = $('.modal_geo[data-modal-id="'+$geo_modal_id+'"]');
	if($geo_modal.attr('data-modal-open') == 'false'){
		$('.modal_geo[data-modal-open="true"]').fadeOut(200);
		$geo_modal.fadeIn(200);
		$geo_modal.attr('data-modal-open', 'true');
		var $f_h = $('.footer').height();
		var $f_b = $(document).height() - $f_h - 500;
		$('.footer').css({'position':'absolute', 'bottom': -$f_b+'px'});
	} else {
		$geo_modal.fadeOut(200);
		$geo_modal.attr('data-modal-open', 'false');
		$('.footer').removeAttr('style');
	}
});

$('.modal_geo > .modal_close').click(function(){
	$('.modal_geo[data-modal-open="true"]').fadeOut(200);
	$('.footer').removeAttr('style');
});*/

//Категории вопросов
$('.faq_category__block_preview > p').click(function(){
	$(this).fadeOut(200);
	$('.faq_category__block_view').delay(200).slideDown(300);
});

$('.faq_category__block_view > .modal_close').click(function(){
	$(this).fadeOut(200);
	$(this).delay(400).fadeIn();
	$('.faq_category__block_view').slideUp(300);
	$('.faq_category__block_preview > p').delay(300).fadeIn(200);
});

$(document).mouseup(function (e) {
	if($('.faq_search_category').is('div')){
		var container = $(".faq_search_category");
	 	if(container.has(e.target).length === 0){
	    	$('.faq_category__block_view').slideUp(300);
			$('.faq_category__block_preview > p').delay(300).fadeIn(200);
		}
	}
});

//Djghjcs vjlfkrb rjvtyns b ng
/*
$('#c_body, #c_body + div').click(function(){
	$('#c_body + div').fadeOut(200);
	$('#c_body').focus();
});

$('#c_body').focusout(function(){
	$('#c_body + div').fadeIn(200);
});*/

/*function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}*/

//DOCS FP
if(winWidth > 640){
	$('.docs_type > li').click(function(){
		var filter_id = $(this).attr('data-filter-id');
		var sect_docs = $('.sect.docs');

		if($(this).hasClass('active')){
			sect_docs.data('filter', false);
			$(this).removeClass('active');
			deleteCookie('filter_docs');
		} else {
			sect_docs.data('filter', filter_id);
			$('.docs_type > li').removeClass('active');
			$(this).addClass('active');
			setCookie('filter_docs', filter_id, {expires: 3600});
		}

		var data_docs = sect_docs.data();

		console.log(data_docs);
		
		$.ajax({
			url: 'index.php?r=docs/page/filter',
			type: 'post',
		    data: data_docs,
		    dataType: 'html',
		    success: function(html){
		    	sect_docs.find('.section_view').html(html);
		    	console.log('success');
		    },
		    error: function(xhr, ajaxOptions, thrownError){
		    	console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		    },
		});
	});
} else {
	$('#docs_filter').change(function(){
		var filter_id = $(this).val();
		var sect_docs = $('.sect.docs');

		if(filter_id == -1){
			sect_docs.data('filter', false);
			deleteCookie('filter_docs');
		} else {
			sect_docs.data('filter', filter_id);
			setCookie('filter_docs', filter_id, {expires: 3600});
		}

		var data_docs = sect_docs.data();

		console.log(data_docs);

		//$(this).css('opacity',1);
		
		$.ajax({
			url: 'index.php?r=docs/page/filter',
			type: 'post',
		    data: data_docs,
		    dataType: 'html',
		    success: function(html){
		    	sect_docs.find('.section_view').html(html);
		    	console.log('success');
		    },
		    error: function(xhr, ajaxOptions, thrownError){
		    	console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		    },
		});
	});
}

$('.docs_category__block_view > li > a').click(function(){
	var cat_id = $(this).parent().data('category');
	var cat_id_now = $('.sect.docs').data('category');

	if(cat_id != cat_id_now){
		deleteCookie('filter_docs');
	}
});

function deleteCookie(name) {
  setCookie(name, "", {
    expires: -1
  })
}

/*var search_docs;
$('.docs_search__form_input').bind('input',function(e){
	search_docs = $(this).val();
	console.log(search_docs);
	var sect_docs = $('.sect.docs');

	if(search_docs == '' || search_docs == undefined){
		var data_ds = {};
		data_ds.category = sect_docs.data('category');
		data_ds.page = 1;
		data_ds.filter = false;

		$.ajax({
			url: 'index.php?r=docs/page/filter',
			type: 'post',
			data: data_ds,
			dataType: 'html',
			success: function(html){
				sect_docs.find('.section_view').html(html);
			},
			error: function(xhr, ajaxOptions, thrownError){
				console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	} else {
		$.ajax({
			url: 'index.php?r=docs/page/search',
			type: 'post',
			data: {search: search_docs},
			dataType: 'html',
			success: function(html){
				sect_docs.find('.section_view').html(html);
			},
			error: function(xhr, ajaxOptions, thrownError){
				console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
});

$('#docs_search').submit(function(e){
	e.preventDefault();
});*/

/*var search_faq;
$('.faq_search__form_input').bind('input',function(e){
	search_faq = $(this).val();
	console.log(search_faq);
	var sect_faq = $('.sect.faq');

	if(search_faq == '' || search_faq == undefined){
		var data_ds = {};
		data_ds.category = sect_faq.data('category');
		data_ds.page = 1;

		$.ajax({
			url: 'index.php?r=docs/page/filter',
			type: 'post',
			data: data_ds,
			dataType: 'html',
			success: function(html){
				sect_faq.find('.section_view').html(html);
			},
			error: function(xhr, ajaxOptions, thrownError){
				console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	} else {
		$.ajax({
			url: 'index.php?r=docs/page/search',
			type: 'post',
			data: {search: search_faq},
			dataType: 'html',
			success: function(html){
				sect_faq.find('.section_view').html(html);
			},
			error: function(xhr, ajaxOptions, thrownError){
				console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
});*/

var $c_block, $c_block_fid, $faq_id;
$('p#faq_comments').click(function(){
	$faq_id = $(this).attr('data-faq-id');
	$c_block = $('.comments_block[data-faq-id="'+$faq_id+'"]');
	$c_block_fid = $c_block.attr('data-block-fid');

	if($c_block.css('display') == 'none'){
		$('body').addClass('modal_bg');
		if(winWidth > 700){
			$('.modals_block').addClass('open');
			$('.comment_modal').fadeIn(200);
		}
		
		$('.comments_block').fadeOut(200);
		$c_block.delay(150).fadeIn(200);

		var c_block_height = $c_block.height();
		var c_w_height = $(window).height();
		if(c_block_height < (c_w_height - 60)){
			var c_block_top = (100 - (c_block_height / (c_w_height / 100))) / 2;
			$c_block.css('top',c_block_top+'%');
		}

		$c_block.addClass('in');

		console.log($c_block.height());
	} else {
		console.log('error');
		$('.comment_modal').fadeOut(200);
		$('.comments_block').delay(150).fadeOut(200);
		$('body').removeClass('modal_bg');
		$('.modals_block').fadeOut(200);
	}
});

function com_close(){
	console.log('clicked');
	$('.comment_modal').fadeOut(200);
	$('.comments_block').delay(150).fadeOut(200);
	$('body').removeClass('modal_bg');
	$('.modals_block').fadeOut(200);
}

$('.comments_block > .modal_close').click(function(){
	$('.comment_modal').fadeOut(200);
	$('.comments_block').delay(150).fadeOut(200);
	$('body').removeClass('modal_bg');
	$('.modals_block').fadeOut(200);
});

$(document).mouseup(function (e) {
	if($('.comment_modal').is('div')){
		var container = $(".comments_block");
	  if (container.has(e.target).length === 0){
	    $('.comment_modal').fadeOut(200);
		$('.comments_block').delay(150).fadeOut(200);
	  	$('body').removeClass('modal_bg');
		$('.modals_block').fadeOut(200)
	  }
	}
});

//Генерируем карту
console.log(location);
if(location.pathname == '/contacts'){
	ymaps.ready(function () {
		var myMap = new ymaps.Map("yaMaps", {
			center: [54.732063, 55.944037],
			zoom: 14
		});
		
		myPlacemark = new ymaps.Placemark([54.732041, 55.944058], {
			hintContent: '',
			balloonContent: ''
		}, {
			iconLayout: 'default#image',
			iconImageHref: '/website/view/theme/profrb/img/icon/icon_geo_map_pin.svg',
			iconImageSize: [80, 115],
			iconImageOffset: [-40, -110]
		});

		myMap.behaviors.disable(['scrollZoom']);
		
		myMap.geoObjects.add(myPlacemark);
	});
}

//Карта географии
if(location.pathname == '/geo'){
	ymaps.ready(init);

	var myMap, objectManager, searchControl;
	function init () {
	    myMap = window.map = new ymaps.Map('yaMapsGeo', {
	            center: [54.732063, 55.944037],
	            zoom: 14
	        }, {
	            searchControlProvider: 'yandex#search'
	        }),
	        objectManager = new ymaps.ObjectManager({
	            clusterize: false,
	        });

	    searchControl = new ymaps.control.SearchControl({
	        options: {
	            provider: 'yandex#search'
	        }
	    });

	    myMap.controls.add(searchControl);

	    objectManager.objects.options.set('iconLayout', 'default#image');
	    objectManager.objects.options.set('iconImageHref', '/website/view/theme/profrb/img/icon/icon_geo_map_pin.svg');
	    objectManager.objects.options.set('iconImageSize', [23, 40]);
	    //objectManager.objects.options.set('iconImageOffset', [-18, -22]);
	    myMap.geoObjects.add(objectManager);

	    $.ajax({
	        url: '../website/models/geo/geo2.json'
	    }).done(function(data) {
	        objectManager.add(data);
	        console.log(data);
	    });

	    objectManager.objects.events.add('click', function (e) {
        	var obj_id = e.get('objectId');
        	getModalGeo(obj_id);
        });

        myMap.events.add('click', function (e) {
		    var eMap = e.get('target');// Получение ссылки на объект, сгенерировавший событие (карта).
		    console.log(eMap);
		});

		myMap.behaviors.disable(['scrollZoom']);
	}
}


function geo_map_filter(val){
	console.log(val);

	var filter_map_val = [];

	//objectManager.setFilter('properties.iconCaption == 1');

	$('.maps_filter > input').each(function(){
		if($(this).is(':checked')){
			filter_map_val.push($(this).val());
		}
	});

	obj_str = 'properties.iconCaption == 1'
	for(f = 0; f < filter_map_val.length; f++){
		obj_str = obj_str + ' || properties.iconCaption == '+filter_map_val[f];
	}

	console.log(obj_str);
	objectManager.setFilter(obj_str);
}

var modals_geo = $('.modal_geo');
function getModalGeo(cid){
	modals_geo.find('.modal_view').detach();
	console.log(cid);
	//''
	$.ajax({
		url: 'index.php?r=geo/search/modal',
		type: 'post',
		data: {content_id: cid},
		dataType: 'html',
		success: function(html){
			modals_geo.append(html);
			$('#btn_modal').trigger('click');
		},
		error: function(xhr, ajaxOptions, thrownError){
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function setCookie(name, value, options) {
  options = options || {};

  var expires = options.expires;

  if (typeof expires == "number" && expires) {
    var d = new Date();
    d.setTime(d.getTime() + expires * 1000);
    expires = options.expires = d;
  }
  if (expires && expires.toUTCString) {
    options.expires = expires.toUTCString();
  }

  value = encodeURIComponent(value);

  var updatedCookie = name + "=" + value;

  for (var propName in options) {
    updatedCookie += "; " + propName;
    var propValue = options[propName];
    if (propValue !== true) {
      updatedCookie += "=" + propValue;
    }
  }

  document.cookie = updatedCookie;
}

$('#authForm').submit(function(e){
	  e = e || event;
	  e.preventDefault();
	  
	  var authForm = $(this);
	  var error = false;

	  if(!error){
	    var postbody = authForm.serialize();

	    if(authForm.find('.auth_error')){
	      authForm.find('.auth_error').detach();
	      authForm.find('.auth_form_row').removeClass('error');
	    }

	    $.ajax({
	      url: authForm.attr('action'),
	      type: 'post',
	      data: postbody,
	      dataType: 'json',
	      beforeSend: function(json) {
	        authForm.find('input[type="submit"]').attr('disabled', 'disabled');
	      },
	      success: function(json){
	    		if(json.success){
	    			authForm.find('.auth_set_group').fadeOut(400);
	    			authForm.html('<div class="auth_success" style="display: none;"><p>Вход выполнен успешно!</p></div>');
	    			authForm.find('.auth_success').fadeIn(400);

	          setCookie('userid', json.userid, {expires: (3600 * 24 * 30)});
	          setCookie('hash', json.hash, {expires: (3600 * 24 * 30)});

	    			setTimeout(function(){
	    				window.location.reload();
	    			},1000);
	    		}

	        if(json.error){
	          authForm.prepend('<div class="auth_error"><p>'+json.error.text+'</p></div>');

	          if(json.error['label']){
	            error_input = authForm.find('input[name="'+json.error['label']+'"]');
	            error_input.parent().addClass('error');
	          }
	        }
	        console.log(json);
	      },
	      error: function(xhr, ajaxOptions, thrownError){
	        console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	      },
	      complete: function(json) { // сoбытиe пoслe любoгo исхoдa
	        authForm.find('input[type="submit"]').prop('disabled', false); // в любoм случae включим кнoпку oбрaтнo
	      }
	    });
	  }

	  return false;
});

var comments_error;
$('.comments_form').submit(function(e){
	e = e || event;
	e.preventDefault();

	comments_error = false;

	var my_form = $(this);

	if(my_form.find('input[required], textarea[required]')){
	    my_form.find('input[required], textarea[required]').removeClass('error_form');

	    my_form.find('input[required], textarea[required]').each(function(){
	    	my_text = $(this).val();
	      	if(my_text == '' || my_text == undefined){
	        	$(this).addClass('error_form');
	        	comments_error = true;
	      	}
	    });
	}

	my_form.find('.captcha .error_captcha').detach();

	if(!comments_error){
		var post_data = {};

		my_form.find('input[type="text"], input[type="hidden"], textarea').each(function(){
			post_data[$(this).attr('name')] = $(this).val();
		});

		$.ajax({
			url: 'index.php?r=faq/add/comments',
			type: 'post',
		    data: post_data,
		    dataType: 'json',
		    success: function(json){
		    	if(json.success == true){
		    		my_form.parent().html('<div class="modal_close" onclick="com_close();"></div><p class="form_cmoder">Спасибо, ваш комментарий отправлен на проверку модератору!</p>');
        		} else {
					if(json.error){
						my_form.find('.captcha').append('<p class="error_captcha">Вы не ввели капчу!</p>');
						console.log('Не введена chaptcha!');
					} else {
						console.log('Что-то пошло не так!');
					}
				}
		    },
		    error: function(xhr, ajaxOptions, thrownError){
	        	console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	      	}
		});
	}
});

var file_question;
$('#mq_upload_file').change(function(){
	file_question = this.files;
	console.log(file_question);

	$.each( $(this).prop('files') , function( key, value ){
        if(value.size > 5100000){
        	$('.mq_form__file_label').append('<p>Файл: '+value.name+' слишком большой!</p>');
        } else {
        	$('.mq_form__file_label').append('<p>'+value.name+'</p>');
        }
    });
});

function find_file(array, value) {
	if (array.indexOf) { // если метод существует
		return array.indexOf(value);
	}
    
	for (var i = 0; i < array.length; i++) {
		if (array[i] === value) return i;
	}
    
	return -1;
}

var file_question, question_error;
$('#mq_upload_file').change(function(){
	file_question = this.files;
	console.log(file_question);

	question_error = false;

	$('.mq_form__file_label').empty().addClass('clearfix');

	var file_format = ['application/msword', 'application/pdf', 'image/jpeg', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'image/png'];

	$.each( $(this).prop('files') , function( key, value ){
        if(value.size > 5100000){
        	$('.mq_form__file_label').append('<p>Файл: '+value.name+' слишком большой!</p>');
        	question_error = true;
        } else {
        	if(find_file(file_format, value.type) != -1){
        		$('.mq_form__file_label').append('<p>'+value.name+'</p>');
        	} else {
        		question_error = true;
        		$('.mq_form__file_label').append('<p style="color: red;"> Неверный формат файла: '+value.name+'</p>');
        	}
        }
    });
});

var scroller;
$(window).bind('scroll',function(){
	scroller = $(this).scrollTop();
});

$('#mq_form_private, #mq_form_tomail').change(function(){
	if(!$(this).is(':checked')){
		$(this).val(0);
	} else {
		$(this).val(1);
	}
});

$('#add_question').submit(function(e){
	e = e || event;
	e.preventDefault();

	var my_form = $(this);

	if(my_form.find('input.required, textarea.required')){
	    my_form.find('input.required, textarea.required').removeClass('error_form');

	    my_form.find('input.required, textarea.required').each(function(){
	    	$(this).removeClass('error_form');
	    	my_text = $(this).val();
	      	if(my_text == '' || my_text == undefined){
	        	$(this).addClass('error_form');
	        	question_error = true;
	      	}
	    });
	}

	if(!question_error){
		var post_data = {};

		my_form.find('input, textarea').each(function(){
			if($(this).attr('type') != 'submit'){
				post_data[$(this).attr('name')] = $(this).val();
			}
		});

		console.log(post_data);

		my_form.find('.btn_submit').attr('disabled','disabled');

		if(file_question){
		    var file_error = false;
		    var data_file = new FormData();

		    $.each( file_question, function( key, value ){
		        data_file.append( key, value );
		    });

	    	$.ajax({
				url: 'index.php?r=faq/add/question_file',
				type: 'post',
				data: data_file,
				cache: false,
				dataType: 'json',
				processData: false,
				contentType: false,
				success: function(json){
					console.log(json);
					post_data['question_docs'] = json.file_question;
					
					$.ajax({
						url: 'index.php?r=faq/add/question',
						type: 'post',
						data: post_data,
						dataType: 'json',
						success: function(json){
							console.log(json);
							if(json.success == true){
								my_form.find('.mq_form_row').detach();
								my_form.parents('.modal_question').css('top',(scroller - (-120))+'px');
								my_form.html('<p class="faq_success">Ваш вопрос принят на рассмотрение! Вашему вопросу присвоен номер <b>'+json.question_id+'</b></p>');
							} else {
								if(json.error){
									$('.captcha').append('<p class="error_captcha">Вы не ввели капчу!</p>');
									console.log('Не введена chaptcha!');
								} else {
									console.log('Что-то пошло не так!');
								}
							}
						},
						error: function(xhr, ajaxOptions, thrownError){
							console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						}
					});
				},
				error: function(xhr, ajaxOptions, thrownError){
					console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
	    } else {
	    	$.ajax({
				url: 'index.php?r=faq/add/question',
				type: 'post',
				data: post_data,
				dataType: 'json',
				success: function(json){
					console.log(json);
					if(json.success == true){
						my_form.find('.mq_form_row').detach();
						my_form.parents('.modal_question').css('top',(scroller - (-120))+'px');
						my_form.html('<p class="faq_success">Ваш вопрос принят на рассмотрение! Вашему вопросу присвоен номер <b>'+json.question_id+'</b></p>');
					} else {
						if(json.error){
							$('.captcha').append('<p class="error_captcha">Вы не ввели капчу!</p>');
							console.log('Не введена chaptcha!');
						} else {
							console.log('Что-то пошло не так!');
						}
					}
				},
				error: function(xhr, ajaxOptions, thrownError){
					console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
	    }
	}
});

jQuery.expr[":"].Contains = jQuery.expr.createPseudo(function(arg) {
    return function( elem ) {
        return jQuery(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
    };
});

var search_workers;
$('.search_workers__input').bind('input',function(e){
	search_workers = $(this).val();
	search_workers = search_workers.toLowerCase();

	console.log(search_workers);
	$('.worker_block').removeClass('active');
	$('.worker_block:Contains("'+search_workers+'")').addClass('active');
});

$('#search_workers').submit(function(e){
	e.preventDefault();
});

$('.news_block.news_block__big__image_small').each(function(){
	$(this).appendTo($('.news_views__important'));
});

var search_area_page;
$('.page_geo .search_form .search_form__input').bind('input',function(e){
	search_area_page = $(this).val();
	search_area_page = search_area_page.toLowerCase();

	console.log(search_area_page);
	if(!$('.switch_label[data-switch="2"]').hasClass('active')){
		//
	} else {
		$('.geo_list_block__lists > li').removeClass('visible');
		$('.geo_list_block__lists > li:contains("'+search_area_page+'")').addClass('visible');
	}
});

$('.page_geo .search_form').submit(function(e){	
	str = $(this).find('.search_form__input').val();
	searchControl.search(str);

	e.preventDefault();
});


var search_area_city;
$('.geografy_view .search_form .search_form__input').bind('input',function(e){
	search_area_city = $(this).val();
	search_area_city = search_area_city.toLowerCase();

	//console.log(search_area_city);

	if($('.view_block.geo_block.geo_city_list').css('display') != 'block'){
		$('.geografy_name > span').trigger('click');
	}

	if($('.view_block.geo_block.geo_city_list').css('margin-top') == '0px'){
		if(winWidth > 640){
			$('.view_block.geo_block.geo_city_list').css('margin-top','110px');
		} else {
			$('.view_block.geo_block.geo_city_list').css('margin-top','145px');
		}
	}

	$('.geo_list_block__lists > li').removeClass('visible');
	$('.geo_list_block__lists > li:Contains("'+search_area_city+'")').addClass('visible');
});

$('.view_block.geo_block.geo_city_list').click(function(){
	$(this).removeAttr('style');
});

$('.news_block.news_block__big__image_small').each(function(){
	$(this).appendTo($('.news_views__important'));
});

var CaptchaCallback = function() {
    $('.g-recaptcha').each(function(index, el) {
    	grecaptcha.render(el, {'sitekey' : '6Lf7LiYUAAAAAAp4px2co8wMvUHRDwFOQ023zBLw'});
    });
};

window.onload = function(){
	
	//Выравниваем изображения по высоте у новостей
	$('.news_views__important .news_block').each(function(){
		var image_height = $(this).find('.news_field_image > img').height();
		var block_height = $(this).height();
		var difference = block_height - image_height;
		console.log(block_height+' - '+image_height+' = '+difference);
		if(difference < 0){
			var block_padding_bottom = parseInt($(this).find('.news_preview_text').css('padding-bottom'));
			var difference_padding = block_padding_bottom - difference;
			
			$(this).find('.news_preview_text').css('padding-bottom', difference_padding+'px');
		} else {
			image_height += difference - (-4);
			$(this).find('.news_field_image > img').css({'height': image_height});
		}
	});
};
