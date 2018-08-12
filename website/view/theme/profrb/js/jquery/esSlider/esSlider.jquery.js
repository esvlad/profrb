(function(){
	$.fn.esSlider = function(options){
		options = $.extend({
			step: 1,
			items: 4,
			count: false,
			margin: [],
			padding: [],
			paddingParams: 'px',
			marginParams: 'px',
			abated: false,
			abatedParam: 'px',
			paramPrevNext: 'normal',
			blockWidth: false,
			blockWidthParam: '%',
			btnText: ['prev','next','clear'],
			btnClass: false,
			clearBtn: false,
			animateSpeed: 300,
		}, options);
		
		var make = function(){
			var $this = $(this);
			var el = $this.children();
			var device_width = $(window).width();
			
			var data_block = [];
			var is_data_block = [];
			
			if(options.count > options.items){
				if(options.btnClass !== false){
					$(options.btnClass).after('<div class="btn_es_slider"/>');
				} else {
					$this.after('<div class="btn_es_slider"/>');
				}
			} else {
				if(options.btnClass !== false){
					$(options.btnClass).after('<div class="btn_es_slider display_none"/>');
				} else {
					$this.after('<div class="btn_es_slider display_none"/>');
				}
			}
			
			if(options.btnText === false) options.btnText = ['','',''];

			switch(options.paramPrevNext){
				case 'normal' : 
					$('.btn_es_slider').append('<div class="btn" data-btn-id="prev" data-enabled="false">'+options.btnText[0]+'</div>');
					$('.btn_es_slider').append('<div class="btn" data-btn-id="next" data-enabled="true">'+options.btnText[1]+'</div>');
					break;
				case 'invert' :
					$('.btn_es_slider').append('<div class="btn" data-btn-id="next" data-enabled="true">'+options.btnText[1]+'</div>');
					$('.btn_es_slider').append('<div class="btn" data-btn-id="prev" data-enabled="false">'+options.btnText[0]+'</div>');
					break;
				default : break;
			}
			
			if(options.clearBtn === true) $('.btn_es_slider').append('<div class="btn" data-btn-id="clear" data-enabled="true">'+options.btnText[2]+'</div>');
			
			var el_count = el.length;
			var $this_width = $this.width();

			switch(options.blockWidthParam){
				case 'px' :
					options.blockWidth = parseFloat($this_width / options.items);
					break;
				default :
					options.blockWidth = parseFloat(($this_width / options.items) / ($this_width / 100)).toFixed(2);
					break;
			}
			
			var calcOptionMargin = 0;
			if(options.margin != 0){
				for(var m = 0; m < options.margin.length; m++){
					calcOptionMargin += options.margin[m];
				}
				
				if(options.margin.length > 1){
					var marginLeft = options.margin[0];
				}
			}
			
			var calcOptionPadding = 0;
			if(options.padding != 0){
				for(var p = 0; p < options.padding.length; p++){
					calcOptionPadding += options.padding[p];
				}
				console.log(options.padding.length);
				if(options.padding.length > 1){
					el.css({'padding-left': options.padding[0] + options.paddingParams, 'padding-right': options.padding[1] + options.paddingParams});
				} else {
					el.css({'padding-left': options.padding[0] + options.paddingParams, 'padding-right': options.padding[0] + options.paddingParams});
				}
			}
			
			var calcAbated = '0px';
			if(options.abated !== false){
				calcAbated = options.abated + options.abatedParam;
			}
			
			if(device_width > 640){
				if(options.margin != 0 || options.padding != 0){
					el.css({'width' : 'calc(' + options.blockWidth + options.blockWidthParam + ' - ' + calcOptionMargin + options.marginParams + ' - ' + calcOptionPadding + options.paddingParams + ' - '+ calcAbated +')'});
				} 
				else {
					el.css({'width' : 'calc('+ options.blockWidth + options.blockWidthParam + ' - ' + calcAbated +')'});
				}
			}
			
			//console.log(options.blockWidth);
			
			var $this_height = 0;
			for(var i = 0; i < el_count; i++){
				var j = options.blockWidth * i;
				if(device_width > 640){
					if(marginLeft){
						el.eq(i).css('left', 'calc('+ j + options.blockWidthParam +' + '+ marginLeft + options.marginParams +')');
					} else {
						el.eq(i).css('left', j + options.blockWidthParam);
					}
				}
				
				if(el.eq(i).outerHeight(true) > $this_height) $this_height = el.eq(i).outerHeight(true);
				
				//el.eq(i).children('p').after('<h5>element ' + (i - (-1)) + '</h5>');
				data_block.push(j);
				is_data_block.push(j);
				console.log(el.eq(i).outerHeight(true));
			}
			
			$this.css({'height': ($this_height - (-2))+'px'});
			
			function event_array(p){
				var array_block = data_block;
				
				switch(p){
					case 'prev' :
						console.log(array_block);
						console.log(is_data_block);

						if(array_block[0] != is_data_block[0]){
							for(var j = 0; j < array_block.length; j++){
								array_block[j] = (array_block[j] - (- options.blockWidth)) * options.step;
							}
							
							if(array_block[0] == is_data_block[0]){
								$('.btn_es_slider > .btn[data-btn-id="prev"]').attr('data-enabled','false');
							}
						}
						
						if(array_block[array_block.length - 1] != is_data_block[array_block.length - 1] || array_block.length == (options.items - (-1))){
							if($('.btn_es_slider > .btn[data-btn-id="next"]').attr('data-enabled') == 'false'){
								$('.btn_es_slider > .btn[data-btn-id="next"]').attr('data-enabled','true');
							}
						}
						break;
					case 'next' :
						if(array_block[0] != -(is_data_block[array_block.length - options.items])){
							for(var j = 0; j < array_block.length; j++){
								array_block[j] = (array_block[j] - options.blockWidth) * options.step;
							}

							if(array_block[0] == -(is_data_block[array_block.length - options.items])){
								$('.btn_es_slider > .btn[data-btn-id="next"]').attr('data-enabled','false');
							}
						} 
						
						if(array_block[0] != is_data_block[0]){
							if($('.btn_es_slider > .btn[data-btn-id="prev"]').attr('data-enabled') == 'false'){
								$('.btn_es_slider > .btn[data-btn-id="prev"]').attr('data-enabled','true');
							}
						}
						break;
					default :
						for(var i = 0; i < el.length; i++){
							j = options.blockWidth * i;
							array_block[i] = j;
						}
						$('.btn_es_slider > .btn[data-btn-id="prev"]').attr('data-enabled','false');
						$('.btn_es_slider > .btn[data-btn-id="next"]').attr('data-enabled','true');
						break;
				}

				return array_block;
			}

			$('.btn_es_slider > .btn').click(function(e){
				var data_enabled = $(this).attr('data-enabled');
				var btn_data = $(this).attr('data-btn-id');	
				var data = event_array(btn_data);

				var b = 0;
				el.each(function(){
					$(this).animate({'left':data[b]+options.blockWidthParam}, options.animateSpeed);
					$(this).children('p').text(data[b]);
					b++;
				});
			});
		};
		
		return this.each(make);
	};
})(jQuery);