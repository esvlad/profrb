<?php
class HtmlHelper{
	
	public static function viewField(){
		#=$content[0]['about_body']['field']['body']

		$tr = array(
			'tag'=>array(
				'name'=>'input',
				'attr'=>array(
					'id'=>'preview_news',
					'type'=>'file',
					'name'=>'preview_news',
					'data-table'=>'fields',
					'data-file-type'=>'images'
				),
				'label'=>array(
					'position'=>'top',
					'attr'=>array(
						'for'=>'preview_news'
					)
				),
				'caption'=>array(
					'position'=>'bottom',
					'text'=>'<b>Обязательно для важных новостей и фото/видео отчетов.</b> Можно прикрепить лишь 1 картинку. Разрешены форматы: JPG, PNG, GIF'
				),
				'file_setting'=>array(
					'format'=>'image',
					'folder'=>'news/prev',
					'size'=>'true',
					'wh_size'=>array(
						'max'=>array(
							'w'=>770,
							'h'=>510
						),
						'min'=>array(
							'w'=>310,
							'h'=>false
						),
						'resize'=>array(
							array('w'=>310,'h'=>165),
							array('w'=>415,'h'=>335),
							array('w'=>420,'h'=>500),
						),
					),
					'quality'=>100
				)
			)
		);

		#{"tag":{"name":"input","attr":{"id":"preview_news","type":"file","name":"preview_news","data-table":"fields","data-file-type":"images"},"label":{"position":"top","attr":{"for":"preview_news"}},"caption":{"position":"bottom","text":"<b>\u041e\u0431\u044f\u0437\u0430\u0442\u0435\u043b\u044c\u043d\u043e \u0434\u043b\u044f \u0432\u0430\u0436\u043d\u044b\u0445 \u043d\u043e\u0432\u043e\u0441\u0442\u0435\u0439 \u0438 \u0444\u043e\u0442\u043e\/\u0432\u0438\u0434\u0435\u043e \u043e\u0442\u0447\u0435\u0442\u043e\u0432.</b> \u041c\u043e\u0436\u043d\u043e \u043f\u0440\u0438\u043a\u0440\u0435\u043f\u0438\u0442\u044c \u043b\u0438\u0448\u044c 1 \u043a\u0430\u0440\u0442\u0438\u043d\u043a\u0443. \u0420\u0430\u0437\u0440\u0435\u0448\u0435\u043d\u044b \u0444\u043e\u0440\u043c\u0430\u0442\u044b: JPG, PNG, GIF"},"file_setting":{"format":"image","folder":"news\/prev","size":"true","wh_size":{"max":{"w":770,"h":510},"min":{"w":310,"h":false},"resize":[{"w":310,"h":165},{"w":415,"h":335},{"w":420,"h":500}]},"quality":100}}}
		return $tr;
	}

	public static function formField($fields, $key = null, $group = false){
		$params = json_decode($fields['params'], true);
		$tag_attr = $params['tag']['attr'];
		$label = $params['tag']['label'];
		$value = isset($fields['body']) ? $fields['body'] : null;
		$field_id = isset($fields['id']) ? $fields['id'] : null;
		$name = isset($fields['name']) ? $fields['name'] : null;

		$tag_caption = isset($params['tag']['caption']) ? $params['tag']['caption'] : null;

		$html = '<div class="admin_form_row">';

		switch($params['tag']['name']){
			case 'input':
				if($params['tag']['attr']['type'] == 'file'){
					$tag = '';

					if(isset($name) && ($name == 'news_image' || $name == 'docs')){
						if(isset($value)){
							$name_value = json_decode($value, true);
							$name_val = $name_value['title'];
						} 
						if($name == 'docs'){
							$tag .= '<label for="docs_title">Название документа</label>';
  							$tag .= '<input id="docs_title" class="docs_title" type="text" name="docs_title['.$field_id.']" value="'.$name_val.'" required>';
						} elseif($name == 'news_image'){
							$tag .= '<label for="news_image_title">Описание изображения</label>';
  							$tag .= '<input id="news_image_title" class="docs_title" type="text" name="news_image_title['.$field_id.']" value="'.$name_val.'">';
						}
					}

					if(isset($name) && ($name == 'news_image' || $name == 'docs')){
						$tag .= '<div id="fileUpload'.$key.'" class="file_upload clearfix">';
						$tag .= '<input '.static::viewAttr($tag_attr, $group, $field_id).' class="file_upload_input" onchange="getUploadFiles(\''.$tag_attr['id'].'\');" value="">';
					} elseif(isset($name) && $name == 'gallery') {
						$tag .= '<div id="fileUpload'.$key.'" class="file_upload clearfix">';
						$tag .= '<input '.static::viewAttr($tag_attr, $group, $field_id).' class="file_upload_input" onchange="getUploadFiles(\''.$tag_attr['id'].$field_id.'\');" value="">';
					} else {
						$tag .= '<div id="fileUpload" class="file_upload clearfix">';
						$group_fid = !empty($group) ? $group : false;
						$tag .= '<input '.static::viewAttr($tag_attr,$group_fid).' class="file_upload_input" onchange="getUploadFiles(\''.$tag_attr['id'].$group_fid.'\');" value="">';
					} /*else {
						$tag .= '<div id="fileUpload'.$key.'" class="file_upload clearfix">';
						$tag .= '<input '.static::viewAttr($tag_attr, $group, $key).' class="file_upload_input" onchange="getUploadFiles(\''.$tag_attr['id'].$group.'\');" value="">';
					}*/
					
					if(isset($value)){
						$files = json_decode($value, true);

						$tag .= '<div class="file_viewed clearfix" style="display:block;">';

						$paths = explode('.',$files['path']);
						$format = array_pop($paths);

						if(isset($name) && ($name == 'gallery')){
							$tag .= static::viewGallery($fields['id']);
						} else {
							if($format == 'doc' || $format == 'docx' || $format == 'pdf' || $format == 'rar' || $format == 'zip'){
								switch ($format) {
									case 'docx':
										$f_type = '<img src="../website/view/theme/profrb/img/icon/icon_docx.png" />';
										break;
									case 'pdf':
										$f_type = '<img src="../website/view/theme/profrb/img/icon/icon_pdf.png" />';
										break;
									case 'rar':
										$f_type = '<img src="../website/view/theme/profrb/img/icon/icon_tgz.png" />';
										break;
									case 'zip':
										$f_type = '<img src="../website/view/theme/profrb/img/icon/icon_zip.png" />';
										break;
									default:
										$f_type = '<img src="../website/view/theme/profrb/img/icon/icon_doc.png" />';
										break;
								}
								$tag .= '<div id="fib'.$fields['id'].'" class="img_block">'.$f_type.'<p class="file_name">'.$files['title'].'</p><div class="btn img_delete" onclick="removeFile('.$fields['id'].',\''.$tag_attr['id'].$group.'\');">Удалить</div></div>';
							} else {
								$tag .= '<div id="fib'.$fields['id'].'" class="img_block"><img src="'.$files['path'].'" /><div class="btn img_delete" onclick="removeFile('.$fields['id'].',\''.$tag_attr['id'].$group.'\');">Удалить</div></div>';
							}
						}

						$field_id = $field_id;

						$tag .= '</div>';
					} else {
						$tag .= '<div class="file_viewed clearfix"></div>';
						$field_id = null;
					}
					if(isset($name) && ($name == 'news_image')){
						$tag .= '<div id="fileUploaded" class="btn btn_admin" onclick="fileUploadBtn(\''.$tag_attr['id'].$field_id.'\');">Добавить файл</div>';
						$tag .= '<input class="file_upload_filed" type="hidden" name="'.$tag_attr['name'].'[group]['.$field_id.']" value="'.$field_id.'">';
						$tag .= static::ordered($field_id).'<span id="remove_field" data-remove-ffile="'.$field_id.'" onclick="remove_field_file('.$field_id.');">Удалить поле с названием</span>';
					} elseif(isset($name) && $name == 'docs'){
						$tag .= '<div id="fileUploaded" class="btn btn_admin" onclick="fileUploadBtn(\''.$tag_attr['id'].$field_id.'\');">Добавить файл</div>';
						$tag .= '<input class="file_upload_filed" type="hidden" name="'.$tag_attr['name'].'['.$field_id.']" value="'.$field_id.'">';
						$tag .= static::ordered($field_id).'<span id="remove_field" data-remove-ffile="'.$field_id.'" onclick="remove_field_file('.$field_id.');">Удалить поле с названием</span>';
					} elseif(isset($name) && $name == 'gallery'){
						$tag .= '<div id="fileUploaded" class="btn btn_admin" onclick="fileUploadBtn(\''.$tag_attr['id'].$field_id.'\');">Добавить файл</div>';
						$tag .= '<input class="file_upload_filed" type="hidden" name="'.$tag_attr['name'].'['.$field_id.']" value="'.static::viewGalleryIDs($field_id).'">';
						$tag .= static::ordered($field_id);
						$tag .= '<span id="remove_field" data-remove-ffile="'.$field_id.'" onclick="remove_field_file('.$field_id.');">Удалить галерею</span>';
					} else {
						$tag .= '<div id="fileUploaded" class="btn btn_admin" onclick="fileUploadBtn(\''.$tag_attr['id'].$group.'\');">Добавить файл</div>';
						$tag .= '<input class="file_upload_filed" type="hidden" name="'.$tag_attr['name'].'[group]['.$field_id.']" value="'.$field_id.'">';
					}
					$tag .= '</div>';
				} else {
					$tag = '<input '.static::viewAttr($tag_attr, $group, $field_id).' value="'.$value.'">';

					if($tag_attr['type'] != 'checkbox') $tag .= static::ordered($field_id);
				}
			break;
			case 'textarea':
				$tag = '<textarea data-tarea="'.$field_id.'" '.static::viewAttr($tag_attr, $group, $field_id).'>'.$value.'</textarea>'.static::ordered($field_id).'<span id="remove_field" data-remove-ffile="'.$field_id.'" onclick="remove_field_file('.$field_id.');">Удалить поле с текстом</span>';
			break;
			case 'select':
				$tag = '<select '.static::viewAttr($tag_attr, $group, $field_id).'>';
				$tag .= static::viewTagOption($params['tag']['option'], $value);
				$tag .= '</select>';
			break;
			case 'datalist':
				$tag = '<input '.static::viewAttr($tag_attr, $group, $field_id).' list="list_'.$tag_attr['id'].'" value="'.$value.'">';
				$tag .= '<datalist id="list_'.$tag_attr['id'].'">';
				$tag .= static::viewTagDataOption($params['tag']['option'], $tag_attr['id']);
				$tag .= '</datalist>';
			break;
			default : break;
		}

		if($label['position'] == 'top'){
			$html .= '<label '.static::viewAttr($label['attr']).'>'.$fields['title'].'</label>';
			if(isset($tag_caption) && $tag_caption['position'] == 'top') $html .= '<p class="admin_form_caption">'.$tag_caption['text'].'</p>';
			$html .= $tag;
			if(isset($tag_caption) && $tag_caption['position'] == 'bottom') $html .= '<p class="admin_form_caption">'.$tag_caption['text'].'</p>';
		} else {
			$html .= $tag;
			$html .= '<label '.static::viewAttr($label['attr']).'>'.$fields['title'].'</label>';
			if(isset($tag_caption)) $html .= '<p class="admin_form_caption">'.$tag_caption['text'].'</p>';
		}

		$html .= '</div>';

		return $html;
	}

	public static function updateFormField($filed_name, $value = null, $key = null, $group_id = null){
	}

	public static function crutchLaborImage($field = array()){
		$file = $GLOBALS['db']->getOne('SELECT f.body FROM pf_fields f WHERE f.id = ?i', $field['body']);

		if(isset($file) && $file != ''){
			$file_json = json_decode($file, true);
			$file_path = $file_json['path'];

			$html = '<div class="file_viewed clearfix" style="display:block;">';
			$html .= '<div id="fib'.$field['body'].'" class="img_block">';
			$html .= '<img src="'.$file_path.'">';
			$html .= '<div class="btn img_delete" onclick="removeFile('.$field['body'].',\''.$field['name'].'\');">Удалить</div>';
			$html .= '</div></div>';
		} else {
			$html = '<div class="file_viewed clearfix">';
			$html .= '</div>';
		}
		
        return $html;            
	}

	private function viewGallery($fields_ids){
		$view_fields_id = $GLOBALS['db']->getOne('SELECT f.body FROM pf_fields f WHERE f.id = ?i', $fields_ids);
		$ids = json_decode($view_fields_id, true);

		$view_images = $GLOBALS['db']->getAll('SELECT f.id, f.body FROM pf_fields f WHERE f.id IN (?a)', $ids);
		
		$html = '';
		foreach($view_images as $image){
			$path = json_decode($image['body'], true);
			$html .= '<div id="fib'.$image['id'].'" class="img_block"><img src="'.$path['path'].'" /><div class="btn img_delete" onclick="removeFile('.$image['id'].',\'gallery_image'.$fields_ids.'\');">Удалить</div></div>';
		}

		return $html;
	}

	private function ordered($field_id = null){
		if(isset($field_id)){
			$order = $GLOBALS['db']->getOne('SELECT f.order FROM pf_fields f WHERE f.id = ?i', $field_id);
		} else {
			$order = 0;
		}

		$select = '<label class="sortered">Порядок отображения: <select class="order_fields" name="order['.$field_id.']">';

		for($o = -20; $o <= 20; $o++){
			if($o == $order){
				$select .= '<option value="'.$o.'" selected>'.$o.'</option>';
			} else {
				$select .= '<option value="'.$o.'">'.$o.'</option>';
			}
		}

		$select .= '</select></label>';

		return $select;
	}

	private function viewGalleryIDs($field_id){
		$view_fields_id = $GLOBALS['db']->getOne('SELECT f.body FROM pf_fields f WHERE f.id = ?i', $field_id);
		$ids = json_decode($view_fields_id, true);
		$id = implode(',', $ids);
		
		return $id;
	}

	private function viewAttr($attr = array(), $group_id = false, $id = null){
		$attributes = array();

		if(!empty($attr)){
			foreach($attr as $key => $value){
				switch($key){
					case 'id':
						if($group_id) {
							$attributes[] = $key . '=' . $value.$group_id;
						} else {
							$attributes[] = $key . '=' . $value.$id;
						}						
					case 'name':
						if($group_id){
							$attributes[] = $key . '=' . $value.'[group]['.$id.']';
						} else {
							$attributes[] = $key . '=' . $value.'['.$id.']';
						}
					default :
						$attributes[] = $key . '=' . $value;
					break;
				}
			}
		}

		$result = implode(' ', $attributes);
		return $result;
	}

	private function viewTagOption($option = array(), $selected = false){
		$html = '';
		foreach($option as $key => $value){
			if($selected == $value){
				$html .= '<option selected value="'.$value.'">'.$value.'</option>';
			} else {
				$html .= '<option value="'.$value.'">'.$value.'</option>';
			}			
		}
		return $html;
	}

	private function viewTagDataOption($option, $getter){

		$content_type_id = $GLOBALS['db']->getOne('SELECT id FROM '.DB_PREFIX.'content_type WHERE name = ?s', $getter);
		$html = '';
		$sql_opt = 'SELECT id, title FROM ?n WHERE content_type_id = ?s';
		$option_list = $GLOBALS['db']->getAll($sql_opt, DB_PREFIX.$option, $content_type_id);

		if(count($option_list) > 0){
			foreach($option_list as $value){
				$html .= '<option value="'.$value['title'].'"></option>';
			}
		}

		return $html;
	}
}

#{"tag":{"name":"input","attr":{"id":"slider_title","type":"text","name":"slider_title","data-table":"fields"},"label":{"position":"top","attr":{"for":"slider_title"}}}}
#{"tag":{"name":"input","attr":{"id":"slider_title","type":"text","name":"slider_title","data-table":"fields",}},"label":{"position":"top","attr":{"for":"slider_title"}}}
?>





