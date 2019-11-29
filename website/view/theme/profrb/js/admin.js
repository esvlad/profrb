var scroll_top = 0;
$(window).bind('scroll',function(){
	scroll_top = $(this).scrollTop();
});

var $role = 91;
var admin_url = {};
$('.admin_section a').click(function(e){
	if($(this).attr('id') == 'notification') return false;

	e.preventDefault();
	var $this = $(this);
	var $uri = $this.attr('href');

	if($uri == '' || $uri == undefined) return;

	var $role = $this.attr('data-admin-role'),
			$option_type = $this.attr('data-post-type'),
			$option_events = $this.attr('data-post-events');
	console.log($uri+' = '+$option_type+'=>'+$option_events);
	
	var $modal_id = 999;
	var $modal = $('.modal[data-modal-id="'+$modal_id+'"]');
	//$modal.css('top',(scroll_top - (- 120))+'px');
			
	/*if($modal.attr('data-modal-open') == 'false'){
		if(winWidth >= 1024){
			$('div.modal_bg').fadeIn(300);
		} else {
			$('body').addClass('modal_bg');
		}
		$modal.fadeIn(300);
		$modal.attr('data-modal-open','true');
	}*/
	$modal.parent().fadeIn();
	$('body').addClass('modal-open');

	admin_url = {
		url: 'index.php?r='+$uri,
		type: $option_type
	}

	$.ajax({
		url: 'index.php?r='+$uri,
		type: 'post',
		data: {type: $option_type, events: $option_events},
		dataType: 'html',
		success: function(html){
			$('.admin_modal .admin_modal_view').html(html);
			localStorage.setItem('admin_url', JSON.stringify(admin_url));
		},
		error: function(xhr, ajaxOptions, thrownError){
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('.admin_modal .modal_close').click(function(){
	/*if(winWidth >= 1024){
		$('div.modal_bg').fadeOut(300);
	} else {
		$('body').removeClass('modal_bg');
	}
	$('.admin_modal').fadeOut(300);
	$('.admin_modal').attr('data-modal-open','false');*/

	$(this).parents('.modal_panel').fadeOut();
	$('body').removeClass('modal-open');
});

$('a#notification').click(function(){
	var noti_url = $(this).attr('href');
	var notise = $(this).data('notise');
	var data_notise = {};

	switch(notise){
		case 'faq' :
			data_notise['filter'] = 'answered';
		break;
		default :
			data_notise['active'] = 0;
		break;
	}

	var urles = 'index.php?r='+noti_url;

	$.ajax({
		url: urles,
		type: 'post',
		data: data_notise,
		dataType: 'html',
		success: function(html){
			var $modal_id = 999;
			var $modal = $('.modal[data-modal-id="'+$modal_id+'"]');
			//$modal.css('top',(scroll_top - (- 120))+'px');
					
			/*if($modal.attr('data-modal-open') == 'false'){
				if(winWidth >= 1024){
					$('div.modal_bg').fadeIn(300);
				} else {
					$('body').addClass('modal_bg');
				}
				$modal.fadeIn(300);
				$modal.attr('data-modal-open','true');
			}*/
			$modal.parent().fadeIn();
			$('body').addClass('modal-open');

			//console.log(data_notise);

			$('.admin_modal .admin_modal_view').html(html);
			localStorage.setItem('admin_url', JSON.stringify(urles));
		},
		error: function(xhr, ajaxOptions, thrownError){
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

function logout(){
	deleteCookie('userid');
	deleteCookie('hash');
	location.reload();
}

function get_populars_docs(value){
	if(value == 0){
		sorted('date_creat');
	} else {
		$.ajax({
			url: 'index.php?r=admin/content/view',
			type: 'post',
			data: {type: 'docs', docs_populars: true},
			dataType: 'html',
			success: function(html){
				$('.admin_modal .admin_modal_view').html(html);
			},
			error: function(xhr, ajaxOptions, thrownError){
				console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
}

var csort, c_type, sortered, sort_active, new_url, u_type, sort_url;
function sorted(id){
	sortered = $('.sorted#'+id);
	sort_active = sortered.attr('data-sort-active');
	csort = sortered.attr('data-sorted');
  	c_type = $('.admin_content_table > thead').attr('data-types');

  	if(sort_active == 0){
  		$('.sorted').attr({'data-sort-active':0, 'data-sorted':'none'});
  		sortered.attr({'data-sort-active':1,'data-sorted':'ask'});
  		csort = 'asc';
  	}

  	console.log(csort);

  	if(csort == 'desc'){
  		csort = 'asc'
  		sortered.attr('data-sorted','asc');
  	} else if(csort == 'asc'){
  		csort = 'desc'
  		sortered.attr('data-sorted','desc');
  	}

  	if(sortered.parents('.admin_content_view').hasClass('admin_faq')){
  		u_type = 'faq';
  	} else if(sortered.parents('.admin_content_view').hasClass('admin_comments')) {
  		u_type = 'comments';
  	} else if(sortered.parents('.admin_content_view').hasClass('admin_letters')) {
  		u_type = 'letters';
  	} else {
  		u_type = 'content';
  	}

  	if(id == 'faq_id') u_type = 'comments';

  	console.log(u_type);

  	new_url = 'index.php?r=admin/'+u_type+'/view';

  	console.log(new_url);

  	sort_url = JSON.parse(localStorage.getItem('admin_url'));

  	sort_url['order'] = id;
  	sort_url['sort'] = csort
  	localStorage.setItem('admin_url', JSON.stringify(sort_url));

  	$.ajax({
		url: new_url,
		type: 'post',
		data: {type: c_type, order: id, sort: csort},
		dataType: 'html',
		success: function(html){
			$('.admin_modal .admin_modal_view').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError){
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

var filter_c, filter_curl;
function filter_comments(filter){

	filter_curl = JSON.parse(localStorage.getItem('admin_url'));
	filter_curl['filter'] = filter;

  	localStorage.setItem('admin_url', JSON.stringify(filter_curl));

	$.ajax({
		url: 'index.php?r=admin/comments/view',
		type: 'post',
		data: {filter: filter},
		dataType: 'html',
		success: function(html){
			$('.admin_modal .admin_modal_view').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError){
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function faq_filter(data, type){
	filter_curl = JSON.parse(localStorage.getItem('admin_url'));
	filter_curl[type] = data;

  	localStorage.setItem('admin_url', JSON.stringify(filter_curl));

	if(type == 'category'){
		$.ajax({
			url: 'index.php?r=admin/faq/view',
			type: 'post',
			data: {category_id: data},
			dataType: 'html',
			success: function(html){
				$('.admin_modal .admin_modal_view').html(html);
			},
			error: function(xhr, ajaxOptions, thrownError){
				console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	} else if(type == 'author'){
		$.ajax({
			url: 'index.php?r=admin/faq/view',
			type: 'post',
			data: {author_id: data},
			dataType: 'html',
			success: function(html){
				$('.admin_modal .admin_modal_view').html(html);
			},
			error: function(xhr, ajaxOptions, thrownError){
				console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
}

function docs_filter(data){
	filter_curl = JSON.parse(localStorage.getItem('admin_url'));
	filter_curl['category_id'] = data;

  	localStorage.setItem('admin_url', JSON.stringify(filter_curl));

  	$.ajax({
		url: 'index.php?r=admin/content/view',
		type: 'post',
		data: {type: 'docs', category_id: data},
		dataType: 'html',
		success: function(html){
			$('.admin_modal .admin_modal_view').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError){
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

var pag_url;
function pagination(href){
	var local_url = JSON.parse(localStorage.getItem('admin_url'));

	if(!local_url.sort){
		local_url.sort = 'ASC';

		if(local_url.url == 'index.php?r=admin/letters/view'){
			local_url.sort = 'DESC';
		}
	}

	if(!local_url.order){
		local_url.order = 'date_creat';

		if(local_url.url == 'index.php?r=admin/letters/view'){
			local_url.order = 'id';
		}
	}

	/*console.log(local_url.url);
	console.log(href);
	console.log(event);*/
	//console.log(local_url);

	var data_array = {
		type: local_url.type,
		order: local_url.order, 
		sort: local_url.sort, 
		page: href
	};

	if(local_url.category_id){
		data_array.category_id = local_url.category_id;
	}

	//console.log(data_array);

	$.ajax({
		url: local_url.url,
		type: 'post',
		data: data_array,
		dataType: 'html',
		success: function(html){
			$('.admin_modal .admin_modal_view').html(html);

			$('.modal_panel').animate({scrollTop: 0}, 1000);
		},
		error: function(xhr, ajaxOptions, thrownError){
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function reload_content(type_content, page){
	var local_url = JSON.parse(localStorage.getItem('admin_url'));

	if(!local_url.sort){
		local_url.sort = 'ASC';

		if(type_content == 'letters'){
			local_url.sort = 'DESC';
		}
	}

	if(!local_url.order){
		local_url.order = 'date_creat';

		if(type_content == 'letters'){
			local_url.order = 'id';
		}
	}

	$.ajax({
		url: local_url.url,
		type: 'post',
		data: {type: local_url.type, order: local_url.order, sort: local_url.sort, page: page},
		dataType: 'html',
		success: function(html){
			$('.admin_modal .admin_modal_view').html(html);

			$('body,html').animate({scrollTop: $('.admin_modal').css('top')}, 1000);
		},
		error: function(xhr, ajaxOptions, thrownError){
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function saveData(post, btn){
	$.ajax({
		url: 'index.php?r=admin/saved/index',
		type: 'post',
		data: {set: post},
		dataType: 'json',
		success: function(json){
			console.log(json);
			if(json['result'] == true){
				if(btn == 'save_close'){
					$('.admin_modal').fadeOut(300);
					location.reload();
				} else {
					$.ajax({
						url: 'index.php?r=admin/saved/success',
						type: 'post',
						data: {type: post.type},
						dataType: 'html',
						success: function(html){
							$('.admin_modal .admin_modal_view').html(html);
						}
					});
				}
			}
		},
		error: function(xhr, ajaxOptions, thrownError){
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function getUploadFiles(id){
	var $data_file = $('input#'+id);//.find('input[type="file"]');
	var set_type = $data_file.attr('data-file-type');
	var field_name = $data_file.attr('name');
	//var count_files = $data_file.prop('files').length;

	var file = new FormData;

	$.each( $data_file.prop('files') , function( key, value ){
        file.append( key, value );
    });

	//var load_img = new Image();
	load_img = '/website/view/theme/profrb/img/other/load_img.gif';
    $('input#'+id+' + .file_viewed').slideDown(500).append('<img id="imgload'+id+'" src="'+load_img+'" width="100px" height="100px" />');

    if(!$data_file.attr('multiple')){
    	$data_file.attr('disabled','disabled');
    }

    if(id != 'labor_image' || id != 'workers_image'){
    	var is_fid = $('input#'+id+' ~ .file_upload_filed').val();
    }
    var i_fid = [];

	$.ajax({
		url: 'index.php?r=setting/upload/'+set_type+'&type='+$data_file.attr('name'),
		type: 'post',
		data: file,
		cache: false,
		dataType: 'json',
		processData: false,
		contentType: false,
		success: function(json){
			console.log(json);
			$('#'+id).find('#fileUploaded').fadeOut(300);
			$('#imgload'+id).detach();
			$.each( json.result , function(){
				if(set_type == 'images'){
					$('input#'+id+' + .file_viewed').append('<div id="fib'+this.field_id+'" class="img_block" data-sort="'+this.sort+'"><img src="'+this.files+'" /><div class="btn img_delete" onclick="removeFile('+this.field_id+',\''+id+'\');">Удалить</div></div>');
				}

				if(set_type == 'docs'){
					$('input#'+id+' + .file_viewed').append('<div id="fib'+this.field_id+'" class="img_block" data-sort="'+this.sort+'"><img src="'+this.files+'" /><p class="file_name">'+this.file_name+'</p><div class="btn img_delete" onclick="removeFile('+this.field_id+',\''+id+'\');">Удалить</div></div>');
				}

				i_fid.push(this.field_id);
		    });

			if(is_fid && is_fid != ''){
				$('input#'+id+' ~ .file_upload_filed').val(is_fid +','+ i_fid);
			} else {
				$('input#'+id+' ~ .file_upload_filed').val(i_fid);
			}
		},
		error: function(xhr, ajaxOptions, thrownError){
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
	//console.log(id);
}

function addField(type_id){
	var more_field = $('p#more_field[data-type-id="'+type_id+'"]');
	var more_key = more_field.attr('data-key');
	var more_type = more_field.attr('data-type');
	console.log(more_type);
	$.ajax({
		url: 'index.php?r=admin/content/addfield',
		type: 'post',
		data: {key: more_key, type: more_type},
		dataType: 'html',
		success: function(html){
			console.log(more_type);
			if(more_field.hasClass('activties')){
				more_field.before(html);
			} else {
				$('.admin_form_row.content_fields').append(html);
			}
			more_key++;
			$('p#more_field').attr('data-key',more_key);

			/*if(type_id == 38){
				more_field.detach();
			}*/
		},
		error: function(xhr, ajaxOptions, thrownError){
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function fileUploadBtn(fileUploaded){
	//console.log('click');
	$('input#'+fileUploaded).trigger('click');
}

function removeFile(field_id, id){
	var fuf_ids = $('input#'+id+' ~ .file_upload_filed').val();

	console.log('field_id = '+field_id+'; id = '+id);

	$.ajax({
		url: 'index.php?r=admin/content/deletefield',
		type: 'post',
		data: {fid: field_id},
		dataType: 'json',
		success: function(json){
			if(json.success){
				//console.log('id='+id+' fid='+field_id);
				$('input#'+id+' + .file_viewed').find('#fib'+field_id).fadeOut(300);
				setTimeout(function(){
					$('input#'+id+' + .file_viewed').find('#fib'+field_id).detach();

					if($('input#'+id+' + .file_viewed').find('.img_block').length == 0){
						$('input#'+id+' + .file_viewed').slideUp(300);
						$('input#'+id+' ~ #fileUploaded').delay(300).fadeIn(300);
					}

					if(!$('input#'+id).attr('multiple')){
				    	$('input#'+id).prop('disabled', false);
				    }
				},300);

				fuf_ids = fuf_ids.replace(field_id, '');
				$('input#'+id+' ~ .file_upload_filed').val(fuf_ids);
			} else {
				console.log(json);
			}
		},
		error: function(xhr, ajaxOptions, thrownError){
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function change_popular(content_id){
	console.log('#popular'+content_id);
	console.log($('#popular'+content_id).is(':checked'));

	if($('#popular'+content_id).is(':checked')){
		var popular = 'i';
	} else {
		var popular = 'd';
	}

	$.ajax({
		url: 'index.php?r=docs/docs/popular',
		data: {set: popular, cid: content_id},
		type: 'post',
		dataType: 'json',
		success: function(json){
			console.log(json);
		},
		error: function(xhr, ajaxOptions, thrownError){
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function content_event(content_id, data_event){
	var data = {};
	data.data_event = data_event;
	data.content_id = content_id;

	console.log(data);

	$.ajax({
		url: 'index.php?r=admin/content/'+data_event,
		type: 'post',
		data: {data},
		dataType: 'html',
		success: function(html){
			console.log($('.admin_modal').attr('data-modal-open'));

			var $modal_id = 999;
			var $modal = $('.modal[data-modal-id="'+$modal_id+'"]');
			/*$modal.css('top',(scroll_top - (- 120))+'px');
					
			if($modal.attr('data-modal-open') == 'false'){
				if(winWidth >= 1024){
					$('div.modal_bg').fadeIn(300);
				} else {
					$('body').addClass('modal_bg');
				}
				$modal.fadeIn(300);
				$modal.attr('data-modal-open','true');
			}*/

			$modal.parent().fadeIn();
			$('body').addClass('modal-open');
			
			$('.admin_modal .admin_modal_view').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError){
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});

	console.log(content_id+' -> '+data_event);
}

function faq_event(content_id, data_event){
	var data = {};
	data.data_event = data_event;
	data.content_id = content_id;

	//console.log(data);

	$.ajax({
		url: 'index.php?r=admin/faq/'+data_event,
		type: 'post',
		data: {data},
		dataType: 'html',
		success: function(html){
			console.log($('.admin_modal').attr('data-modal-open'));

			var $modal_id = 999;
			var $modal = $('.modal[data-modal-id="'+$modal_id+'"]');
			/*$modal.css('top',(scroll_top - (- 120))+'px');
					
			if($modal.attr('data-modal-open') == 'false'){
				if(winWidth >= 1024){
					$('div.modal_bg').fadeIn(300);
				} else {
					$('body').addClass('modal_bg');
				}
				$modal.fadeIn(300);
				$modal.attr('data-modal-open','true');
			}*/
			$modal.parent().fadeIn();
			$('body').addClass('modal-open');
			
			$('.admin_modal .admin_modal_view').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError){
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});

	//console.log(content_id+' -> '+data_event);
}

function remove_field_file(id){
	var data_field_files = $('#remove_field[data-remove-ffile="'+id+'"]');
	var data_row_data_field = data_field_files.parent();
	var data_field_files_type = data_row_data_field.find('#fileUpload > input').attr('id');

	type_file = data_row_data_field.find('input[type="file"]').attr('data-file-type');

	data_row_data_field.slideUp(300, function(){
		$(this).detach();

		if(type_file == 'docs'){
			files_input = $('input[name="docs_title['+id+']"]');
			files_input.parent().detach();
		}
	});

	removeFile(id, data_field_files_type);
}

var faq_answer, faq_answer_val;
function answered_faq(cid){
	faq_answer_val = $('input#answered'+cid).val();
  if(faq_answer_val == 1) {
    faq_answer = 0;
  } else {
    faq_answer = 1;
  }

  $.ajax({
    url: 'index.php?r=admin/faq/answered',
    type: 'post',
    data: {content_id: cid, answered: faq_answer_val},
    dataType: 'json',
    success: function(json){
      console.log(json);
      if(json.success == true){
		$('input#answered'+cid).val(faq_answer);
      }
    },
    error: function(xhr, ajaxOptions, thrownError){
      console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}

var faq_active, faq_active_text, faq_active_val;
function active_faq(cid, type){
	faq_active_val = $('input#faq_active'+cid).val();

	if(!type) type = 'faq';

  	if(faq_active_val == 1) {
    	faq_active = 0;
    	if(type == 'comment'){
    		faq_active_text = 'Не опубликован';
    	} else {
    		faq_active_text = 'Отключить';
    	}
  	} else {
    	faq_active = 1;
    	if(type == 'comment'){
    		faq_active_text = 'Опубликован';
    	} else {
    		faq_active_text = 'Включить';
    	}
  	}

  	console.log('val = '+faq_active_val+' a = '+faq_active+' t = '+faq_active_text);

  	$.ajax({
	    url: 'index.php?r=admin/faq/active',
	    type: 'post',
	    data: {content_id: cid, active: faq_active, a_type: type},
	    dataType: 'json',
	    success: function(json){
	      console.log(json);
	      if(json.success == true){
			$('.admin_faq_active[data-content-id="'+cid+'"]').text(faq_active_text);
			$('input#faq_active'+cid).val(faq_active);
	      }
	    },
	    error: function(xhr, ajaxOptions, thrownError){
	      console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	    }
  	});
}

function delete_faq(content_id){
	var data_tag = $('span#deleted[data-content-id="'+content_id+'"]');
  	var element = $('.admin_content_row[data-content-id="'+content_id+'"]');

  	data_tag.parent().addClass('mini_load');  

  	var data_confirm = confirm('Вы уверены, что хотите удалить этот вопрос?');

  	if(data_confirm){
  		$.ajax({
	      url: 'index.php?r=admin/faq/delete',
	      type: 'post',
	      data: {cid: content_id},
	      dataType: 'json',
	      success: function(json){
	        console.log(json);
	        if(json.success){
	          data_tag.parent().removeClass('mini_load');
	          element.slideUp(300);
	          setTimeout(function(){
	            element.detach();
	          },300);
	        }
	      },
	      error: function(xhr, ajaxOptions, thrownError){
	        console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	      }
	    });
  	} else {
	  data_tag.parent().removeClass('mini_load');
	}
}

function delete_comments(comment_id){
	var data_tag = $('span#deleted[data-content-id="'+comment_id+'"]');
  	var element = $('.admin_content_row[data-content-id="'+comment_id+'"]');

  	data_tag.parent().addClass('mini_load');  

  	var data_confirm = confirm('Вы уверены, что хотите удалить этот вопрос?');

  	if(data_confirm){
  		$.ajax({
	      url: 'index.php?r=admin/comments/delete',
	      type: 'post',
	      data: {cid: comment_id},
	      dataType: 'json',
	      success: function(json){
	        console.log(json);
	        if(json.success){
	          data_tag.parent().removeClass('mini_load');
	          element.slideUp(300);
	          setTimeout(function(){
	            element.detach();
	          },300);
	        }
	      },
	      error: function(xhr, ajaxOptions, thrownError){
	        console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	      }
	    });
  	} else {
	  data_tag.parent().removeClass('mini_load');
	}
}

function log(data){
	console.log(data);
}

function action_user(action, data_form){
	$.ajax({
      url: 'index.php?r=admin/user/'+action,
      type: 'post',
      data: data_form,
      dataType: 'json',
      success: function(json){
        console.log(json);
        if(json.success){
        	$('.admin_section a[href="admin/user/view"]').trigger('click');
        	//$('.modal_title').after('<div class="message_success">Пользователь успешно добавлен!</div>');
        }
      },
      error: function(xhr, ajaxOptions, thrownError){
        console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
}

function user_update(uid){
	$.ajax({
      url: 'index.php?r=admin/user/edit',
      type: 'post',
      data: {user_id: uid},
      dataType: 'html',
      success: function(html){
        $('.admin_modal .admin_modal_view').html(html);
      },
      error: function(xhr, ajaxOptions, thrownError){
        console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
}

function password_generator( len ) {
    var length = (len)?(len):(10);
    var string = "abcdefghijklmnopqrstuvwxyz"; //to upper 
    var numeric = '0123456789';
    var punctuation = '!@#$%^&*()_+~`|}{[]\:;?><,./-=';
    var password = "";
    var character = "";
    var crunch = true;
    while( password.length<length ) {
        entity1 = Math.ceil(string.length * Math.random()*Math.random());
        entity2 = Math.ceil(numeric.length * Math.random()*Math.random());
        entity3 = Math.ceil(punctuation.length * Math.random()*Math.random());
        hold = string.charAt( entity1 );
        hold = (entity1%2==0)?(hold.toUpperCase()):(hold);
        character += hold;
        character += numeric.charAt( entity2 );
        character += punctuation.charAt( entity3 );
        password = character;
    }
    return password;
}
