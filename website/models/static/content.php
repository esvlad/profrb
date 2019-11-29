<?php

class ModelStaticContent extends MVC{

	public function updateContent($data){
		/*echo '<pre>';
		print_r($data);
		echo '</pre>';*/
		

		$content_id = $data['content_id'];

		$ucontent = $this->db->getRow('SELECT * FROM '.DB_PREFIX.'content WHERE id = ?i', $content_id);

		$content_type_id = $data['content_type_id'];

		if(isset($data['category_id']) && $data['category_id'] != ''){
			$category_id = $data['category_id'];
		} else {
			$category_id = 0;
		}

		if(isset($data['active'])){
			$active = 1;
		} else {
			$active = 0;
		}
		
		#CONTENT
		$content = array(
			'category_id' => $category_id,
			'title' => $data['title'],
			'type_id' => $content_type_id,
			'active' => $active,
		);
		
		if(isset($data['date_creat']) && $data['date_creat'] != ''){
			$content['date_creat'] = $data['date_creat'];
		} 
		
		if(isset($data['date_end']) && $data['date_end'] != ''){
			$content['date_end'] = $data['date_end'];
		} else {
			$content['date_end'] = '';
		}

		if(isset($data['geo_id'])){
			$content['geo_id'] = $data['geo_id'];
			$content['title'] = '-';
			unset($data['geo_id']);
		}

		$sql_content = 'UPDATE '.DB_PREFIX.'content SET ?u WHERE id = ?i';
		$this->db->query($sql_content, $content, $content_id);

		$user = $this->isAdmin();
		if($user['level'] < 80){
			$sql_notification = 'INSERT INTO '.DB_PREFIX.'notification SET date = NOW(), user_id = ?i, content_id = ?i, event = ?s';
			$this->db->query($sql_notification, $user['id'], $data['content_id'], 'update');
		}

		#FILTER
		if(isset($data['filter_id']) && $data['filter_id'] != ''){
			$sql_cf = 'UPDATE '.DB_PREFIX.'content_filter SET filter_id = ?i WHERE content_id = ?i';
			$this->db->query($sql_cf, $data['filter_id'], $content_id);
		}

		unset($data['title']);

		if(!empty($data['labor_image'])){
			foreach ($data['labor_image'] as $key => $value) {
				if($key != 0){
					if(isset($value) && $value != ''){
						$this->db->query('UPDATE '.DB_PREFIX.'fields SET body = ?s WHERE id = ?i', $value, $key);
					}
				}
			}
			unset($data['labor_image']);
		}

		if(!empty($data['bgimage'])){
			foreach ($data['bgimage'] as $key => $value) {
				if($key != 0){
					if(isset($value) && $value != ''){
						$this->db->query('UPDATE '.DB_PREFIX.'fields SET body = ?s WHERE id = ?i', $value, $key);
					}
				}
			}
			unset($data['bgimage']);
		}

		if(!empty($data['preview_news'])){
			foreach ($data['preview_news'] as $key => $value) {
				if($key != 0){
					if(isset($value) && $value != ''){
						$this->db->query('UPDATE '.DB_PREFIX.'fields SET body = ?s WHERE id = ?i', $value, $key);
					}
				}
			}
			unset($data['preview_news']);
		}

		if(!empty($data['workers_image'])){
			foreach ($data['workers_image'] as $key => $value) {
				if($key != 0){
					if(isset($value) && $value != ''){
						$this->db->query('UPDATE '.DB_PREFIX.'fields SET body = ?s WHERE id = ?i', $value, $key);
					}
				}
			}
			unset($data['workers_image']);
		}

		/*if(!empty($data['gallery_image'])){
			foreach($data['gallery_image'] as $k => $v){
				if($k != 0){
					$g_ids = explode(',',$data['gallery_image'][$k]);
					$gallery = json_encode($g_ids);
					$this->db->query('UPDATE '.DB_PREFIX.'fields SET body = ?s WHERE id = ?i', $gallery, $k);
				}
			}
			unset($data['gallery_image']);
		}*/

		if($content_type_id == 11){
			$sql_field_update = 'UPDATE `'.DB_PREFIX.'fields` SET `body` = ?s WHERE `id` = ?i';
			$important_news_id = $this->db->getOne('SELECT f.id FROM '.DB_PREFIX.'fields f, '.DB_PREFIX.'fields_type ft, '.DB_PREFIX.'fields_content fc WHERE ft.id = 43 AND f.fields_type_id = ft.id AND fc.content_id = ?i AND fc.fields_id = f.id', $content_id);
			if($data['important_news']){
				$this->db->query($sql_field_update, 1, $important_news_id);
			} else {
				$this->db->query($sql_field_update, 0, $important_news_id);
			}

			unset($data['important_news']);
		}

		if($content_type_id == 2){
			$sql_field_update = 'UPDATE `'.DB_PREFIX.'fields` SET `body` = ?s WHERE `id` = ?i';
			$event_now_id = $this->db->getOne('SELECT f.id FROM '.DB_PREFIX.'fields f, '.DB_PREFIX.'fields_type ft, '.DB_PREFIX.'fields_content fc WHERE ft.id = 40 AND f.fields_type_id = ft.id AND fc.content_id = ?i AND fc.fields_id = f.id', $content_id);
			if($data['event_now']){
				$this->db->query($sql_field_update, 1, $event_now_id);
			} else {
				$this->db->query($sql_field_update, 0, $event_now_id);
			}

			unset($data['event_now']);
		}

		/*if($content_type_id == 14){
			if(!isset($data['docs'][0])){}
		}*/

		#FIELDS
		$files = array();
		foreach($data as $key => $value){
			if(is_array($value)){
				if($key == 'docs_title' || $key == 'docs' || $key == 'news_image' || $key == 'news_image_title' || $key == 'gallery_image' || $key == 'order'){
					if($key == 'docs'){
						foreach($value as $k => $v){
							if($v != ''){
								$files['docs'][$data['docs'][$k]] = $data['docs_title'][$k];

								if($data['order'] != '' || $data['order'] != null){
									if(!array_key_exists($data['docs'][$k], $data['order'])){
										$data['order'][$data['docs'][$k]] = $data['order'][$k];
										unset($data['order'][$k]);
									}
								}
							}
						}
					}

					if($key == 'news_image'){
						foreach($value as $k => $v){
							if($v != '') {
								$files['image'][$data['news_image'][$k]] = $data['news_image_title'][$k];
								
								if(!array_key_exists($data['news_image'][$k], $data['order'])){
									$data['order'][$data['news_image'][$k]] = $data['order'][$k];
									unset($data['order'][$k]);
								}
							}
						}
					}

					if($key == 'gallery_image'){
						foreach($value as $k => $v){
							if($v != ''){
								$g_ids = explode(',',$data['gallery_image'][$k]);
								$files['gallery'][$k] = json_encode($g_ids);
							}
						}
					}
				} else {
					foreach($value as $k => $v){
						$sql_fid = $this->db->getOne('SELECT count(*) FROM '.DB_PREFIX.'fields WHERE id = ?i', $k);

						if($sql_fid != 0){
							$sql_field_update = 'UPDATE `'.DB_PREFIX.'fields` SET `body` = ?s, `order` = ?i WHERE `id` = ?i';
							$this->db->query($sql_field_update, $v, (int)$data['order'][$k], (int)$k);
						} else {
							$ft_id = $this->db->getOne('SELECT p.id FROM '.DB_PREFIX.'fields_type p WHERE p.name = ?s;', $key);
							$sql_field = 'INSERT INTO `'.DB_PREFIX.'fields` SET `fields_type_id` = ?i, `body` = ?s, `order` = ?i, `activ` = 1';
							$this->db->query($sql_field, (int)$ft_id, $v, (int)$data['order'][$k]);
							$fid = $this->db->insertId();
							$this->db->query('INSERT INTO '.DB_PREFIX.'fields_content SET content_id = ?i, fields_id = ?i', $content_id, $fid);
						}
					}
				}
			}
		}

		/*echo '<pre>';
		print_r($files['docs']);
		echo '</pre>';*/

		if(count((array)$files['docs']) > 0){
			foreach($files['docs'] as $id => $file_title){
				$sql_count_field = $this->db->getOne('SELECT count(*) FROM '.DB_PREFIX.'fields_content fc WHERE fc.content_id = ?i AND fc.fields_id = ?i', $content_id, $id);
				if($sql_count_field != 0){
					$jbody = $this->db->getOne('SELECT f.body FROM '.DB_PREFIX.'fields f WHERE f.id = ?i', $id);
					$body = json_decode($jbody, true);
					$body['title'] = $file_title;
					$nbody = json_encode($body);
					$data_order_id = (!empty($data['order'][$id])) ? $data['order'][$id] : null;
					/*Functions::pre_print($nbody);
					Functions::pre_print($data['order'][$id]);
					Functions::pre_print($data['order']);
					Functions::pre_print($data_order_id);
					Functions::pre_print($id);*/
					$this->db->query('UPDATE `'.DB_PREFIX.'fields` SET `body` = ?s, `order` = ?i WHERE `id` = ?i', $nbody, $data_order_id, $id);
				} else {
					$jbody = $this->db->getOne('SELECT f.body FROM '.DB_PREFIX.'fields f WHERE f.id = ?i', $id);
					$body = json_decode($jbody, true);
					$body['title'] = isset($file_title) ? $file_title : '';
					$nbody = json_encode($body);
					$order_f = isset($data['order'][$id]) ? $data['order'][$id] : null;
					$this->db->query('UPDATE `'.DB_PREFIX.'fields` SET `body` = ?s, `order` = ?i WHERE `id` = ?i', $nbody, $order_f, $id);
					$this->db->query('INSERT INTO '.DB_PREFIX.'fields_content SET content_id = ?i, fields_id = ?i', $content_id, $id);
				}
			}
		}

		if(count((array)$files['image']) > 0){
			foreach($files['image'] as $id => $file_title){
				$sql_count_field = $this->db->getOne('SELECT count(*) FROM '.DB_PREFIX.'fields_content fc WHERE fc.content_id = ?i AND fc.fields_id = ?i', $content_id, $id);
				if($sql_count_field != 0){
					$jbody = $this->db->getOne('SELECT f.body FROM '.DB_PREFIX.'fields f WHERE f.id = ?i', $id);
					$body = json_decode($jbody, true);
					$body['title'] = $file_title;
					$nbody = json_encode($body);
					$this->db->query('UPDATE `'.DB_PREFIX.'fields` SET `body` = ?s, `order` = ?i WHERE `id` = ?i', $nbody, $data['order'][$id], $id);
				} else {
					$jbody = $this->db->getOne('SELECT f.body FROM '.DB_PREFIX.'fields f WHERE f.id = ?i', $id);
					$body = json_decode($jbody, true);
					$body['title'] = $file_title;
					$nbody = json_encode($body);
					$this->db->query('UPDATE `'.DB_PREFIX.'fields` SET `body` = ?s, `order` = ?i WHERE `id` = ?i', $nbody, $data['order'][$id], $id);
					$this->db->query('INSERT INTO '.DB_PREFIX.'fields_content SET content_id = ?i, fields_id = ?i', $content_id, $id);
				}
			}
		}

		if(count((array)$files['gallery']) > 0){
			foreach($files['gallery'] as $key => $ids){
				foreach($files['gallery'] as $key => $ids){
					$sql_g = $this->db->getOne('SELECT count(*) FROM '.DB_PREFIX.'fields p WHERE p.id = ?i AND p.fields_type_id = 39', $key);

					if($sql_g != 0){
						$this->db->query('UPDATE `'.DB_PREFIX.'fields` SET `body` = ?s, `order` = ?i WHERE `id` = ?i', $ids, $data['order'][$key], $key);
					} else {
						$this->db->query('INSERT INTO '.DB_PREFIX.'fields SET `fields_type_id` = 39, `body` = ?s, `order` = ?i, `setting_id` = 0, `activ` = 1', $ids, $data['order'][$key]);
						$key = $this->db->insertId();
						$this->db->query('INSERT INTO '.DB_PREFIX.'fields_content SET content_id = ?i, fields_id = ?i', $content_id, $key);
					}
				}
			}
		}

		#URL
		if($content_type_id == 14){
			if(!empty($data['popular'])) $popular = 1;
			$popular_id = $this->db->getOne('SELECT id FROM '.DB_PREFIX.'docs_popular WHERE content_id = ?i', $content_id);

			if($popular && empty($popular_id)){
				$this->db->query('INSERT INTO '.DB_PREFIX.'docs_popular SET content_id = ?i', $content_id);
			}

			if(!$popular && !empty($popular_id)){
				$this->db->query('DELETE FROM '.DB_PREFIX.'docs_popular WHERE id = ?i', $popular_id);
			}

			$url = $this->getUri($category_id, 'docs');
		} else if($content_type_id == 11){
			$url = $this->getUri($content_id, 'news');
		} else if($content_type_id == 17){
			$url = '/geo';
		} else {
			$sql_url = 'SELECT u.uri FROM pf_content_type ct, pf_page_section ps, pf_url u WHERE ct.id = ?i AND ps.section_id = ct.section_id AND u.page_id = ps.page_id';
			$url = $this->db->getOne($sql_url, $content_type_id);
		}

		return array('success' => true, 'redirect' => $url);
	}

	public function addContent($data = array()){
		//$data['content']

		/*echo '<pre>';
		print_r($data);
		echo '</pre>';*/

		$content_type_id = $data['content_type_id'];
		if(!empty($data['is_letter'])) $is_letter = 1;
		$is_active = (!empty($data['active'])) ? 1 : 0;

		if(!empty($data['popular'])) $popular = 1;

		if(isset($data['category_id']) && $data['category_id'] != ''){
			$category_id = $data['category_id'];
		} else {
			$category_id = 0;
		}

		#SETTING
		$setting = array();
		$data['setting'] = array('type'=>'content');
		foreach ($data['setting'] as $key => $value) {
			$setting[$key] = $value;
		}
		$setting_id = $this->addSetting($setting);

		$title = $data['title'];

		#CONTENT
		$content = array(
			'category_id' => $category_id,
			'title' => $title,
			'type_id' => $content_type_id,
			'setting_id' => $setting_id,
			'active' => $is_active,
		);
		
		if(isset($data['date_creat']) && $data['date_creat'] != ''){
			$content['date_creat'] = $data['date_creat'];
		} else {
			$content['date_creat'] = date('Y-m-d H:i:s');
		}
		
		if(isset($data['date_end']) && $data['date_end'] != ''){
			$content['date_end'] = $data['date_end'];
		} else {
			$content['date_end'] = '';
		}

		if(isset($data['geo_id'])){
			$content['geo_id'] = $data['geo_id'];
			$content['title'] = '-';
			unset($data['geo_id']);
		}

		$sql_content = 'INSERT INTO '.DB_PREFIX.'content SET ?u';
		$this->db->query($sql_content, $content);
		$content_id = $this->db->insertId();

		$user = $this->isAdmin();
		if($user['level'] < 80){
			$sql_notification = 'INSERT INTO '.DB_PREFIX.'notification SET date = NOW(), user_id = ?i, content_id = ?i, event = ?s';
			$this->db->query($sql_notification, $user['id'], $content_id, 'add');
		}

		//echo $content_id;

		if($category_id != 0){
			$sql_count = 'UPDATE `'.DB_PREFIX.'category` SET `count` = `count` + 1 WHERE `id` = ?i';
			$this->db->query($sql_count, $category_id);
		}

		#FILTER
		if(isset($data['filter_id']) && $data['filter_id'] != ''){
			$filter = array(
				'filter_id' => $data['filter_id'],
				'content_id' => $content_id
			);

			$sql_cf = 'INSERT INTO '.DB_PREFIX.'content_filter SET ?u';
			$this->db->query($sql_cf, $filter);
		}

		unset($data['title']);

		/**/

		if($content_type_id == 2){
			$sql_field = 'INSERT INTO `'.DB_PREFIX.'fields` SET `fields_type_id` = ?i, `body` = ?s, `setting_id` = ?i, `activ` = 1';
			if($data['event_now']){
				$this->db->query($sql_field, 40, 1, 0);
			} else {
				$this->db->query($sql_field, 40, 0, 0);
			}

			$fidn = $this->db->insertId();
			$this->db->query('INSERT INTO '.DB_PREFIX.'fields_content SET content_id = ?i, fields_id = ?i', $content_id, $fidn);
			unset($data['event_now']);
		}

		if($content_type_id == 11){
			$sql_field = 'INSERT INTO `'.DB_PREFIX.'fields` SET `fields_type_id` = ?i, `body` = ?s, `setting_id` = ?i, `activ` = 1';
			
			if($data['important_news']){
				$this->db->query($sql_field, 43, 1, 0);
			} else {
				$this->db->query($sql_field, 43, 0, 0);
			}

			$fidn = $this->db->insertId();
			$this->db->query('INSERT INTO '.DB_PREFIX.'fields_content SET content_id = ?i, fields_id = ?i', $content_id, $fidn);
			unset($data['important_news']);

			if($data['preview_news']){
				if(count($data['preview_news']) > 1){
					unset($data['preview_news'][1]);
				}
			}
		}

		#FIELDS
		$field_type_id = array();
		$fff = array();
		$files = array();

		$order = 0;
		foreach($data as $key => $value){

			if(is_array($value)){ # || $key = 'preview_news'
				if($key == 'docs_title' || $key == 'docs' || $key == 'news_image' || $key == 'news_image_title' || $key == 'gallery_image'){
					if($key == 'docs'){
						foreach($value as $k => $v){
							$files['docs'][$k][$data['docs'][$k]] = $data['docs_title'][$k];
						}
					}

					if($key == 'news_image'){
						foreach($value as $k => $v){
							$files['image'][$k][$data['news_image'][$k]] = $data['news_image_title'][$k];
						}
					}

					if($key == 'gallery_image'){
						foreach($value as $k => $v){
							$g_ids = explode(',',$data['gallery_image'][$k]);
							$files['gallery'][$k] = json_encode($g_ids);
						}
					}

					/*if($key == 'preview_news'){
						foreach($value as $k => $v){
							if($v != '')
						}
					}*/
				} else {
					foreach($value as $k => $v){
						$ft_id = $this->db->getOne('SELECT ft.id FROM '.DB_PREFIX.'fields_type ft WHERE ft.name = ?s', $key);
						$sql_field = 'INSERT INTO `'.DB_PREFIX.'fields` SET `fields_type_id` = ?i, `body` = ?s, `setting_id` = ?i, `activ` = 1, `order` = ?i';
						$this->db->query($sql_field, (int)$ft_id, $v, (int)$k, (int)$k);
						$fid = $this->db->insertId();
						$this->db->query('INSERT INTO '.DB_PREFIX.'fields_content SET content_id = ?i, fields_id = ?i', $content_id, $fid);
						$field_type_id[$key] = $ft_id;
					}
				}

				#$order++;
			}
		}

		if(count($files['docs']) > 0){
			foreach($files['docs'] as $key => $value){
				foreach($value as $id => $file_title){
					$jbody = $this->db->getOne('SELECT f.body FROM '.DB_PREFIX.'fields f WHERE f.id = ?i', $id);
					$body = json_decode($jbody, true);
					$body['title'] = $file_title;
					$nbody = json_encode($body);
					$this->db->query('UPDATE `'.DB_PREFIX.'fields` SET `body` = ?s, `order` = ?i WHERE `id` = ?i', $nbody, $key, $id);
					$this->db->query('INSERT INTO '.DB_PREFIX.'fields_content SET content_id = ?i, fields_id = ?i', $content_id, $id);
				}
			}
		}

		if(count($files['image']) > 0){
			foreach($files['image'] as $key => $value){
				foreach($value as $id => $file_title){
					$jbody = $this->db->getOne('SELECT f.body FROM '.DB_PREFIX.'fields f WHERE f.id = ?i', $id);
					$body = json_decode($jbody, true);
					$body['title'] = $file_title;
					$nbody = json_encode($body);
					$this->db->query('UPDATE `'.DB_PREFIX.'fields` SET `body` = ?s, `order` = ?i WHERE `id` = ?i', $nbody, $key, $id);
					$this->db->query('INSERT INTO '.DB_PREFIX.'fields_content SET content_id = ?i, fields_id = ?i', $content_id, $id);
				}
			}
		}

		if(count($files['gallery']) > 0){
			foreach($files['gallery'] as $key => $ids){
				$this->db->query('INSERT INTO `'.DB_PREFIX.'fields` SET `fields_type_id` = 39, `body` = ?s, `order` = ?i, `activ` = 1', $ids, $key);
				$gallery_id = $this->db->insertId();
				$this->db->query('INSERT INTO '.DB_PREFIX.'fields_content SET content_id = ?i, fields_id = ?i', $content_id, $gallery_id);
			}
		}

		#URL 
		if($content_type_id == 14){
			$url = $this->getUri($category_id, 'docs');
		} else if($content_type_id == 11){
			$url = $this->addUrl('news', $content_id, $title);
		} else if($content_type_id == 17){
			$url = '/geo';
		} else {
			$sql_url = 'SELECT u.uri FROM pf_content_type ct, pf_page_section ps, pf_url u WHERE ct.id = ?i AND ps.section_id = ct.section_id AND u.page_id = ps.page_id';
			$url = $this->db->getOne($sql_url, $content_type_id);
		}

		#LETTER

		if($content_type_id == 2 || $content_type_id == 11 || $content_type_id == 14){
			$letter = array();

			switch ($content_type_id) {
				case 2:
					$letter['field_name'] = 'events';
					$letter['theme'] = 'Новое событие';
					$letter['message'] = array(
						'title' => $title,
						'caption' => $data['event_caption'][0],
					);
				break;
				case 11:
					$letter['field_name'] = 'news';
					$letter['theme'] = 'Свежая новость';
					$letter['message'] = array(
						'title' => $title,
						'caption' => $data['text'][0],
						'url' => 'Читать полность по <a href="'.HTTP_SERVER . $url .'" target="_blank">ссылке</a>.',
					);
				break;
				case 14:
					$letter['field_name'] = 'docs';
					$letter['theme'] = 'Новый документ';
					$letter['message'] = array(
						'title' => $title,
						'url' => '<a href="'.HTTP_SERVER . $body['path'] .'" target="_blank" download>Скачать документ</a>',
					);
				break;
				default : break;
			}

			if($is_letter){
				$let_model = new Action(MODEL, 'modules/letter');
				$letters = $let_model->loader('getSubscribe', $letter);
			}

			if($popular){
				$this->db->query('INSERT INTO '.DB_PREFIX.'docs_popular SET content_id = ?i', $content_id);
			}
		}
		
		return array('success' => true, 'redirect' => $url);
	}

	private function addUrl($type, $cid, $title){
		if($type == 'news'){
			$uri = '/news/' . $this->translit($title) . '-' . date('d-m-Y');
			$url = array(
				'page_id' => 18,
				'view_id' => $cid,
				'uri' => $uri,
				'type' => 'common/page'
			);
		}

		$sql_url = 'INSERT INTO '.DB_PREFIX.'url SET ?u';
		$this->db->query($sql_url, $url);
		$content_id = $this->db->insertId();

		if($content_id > 1){
			return $uri;
		}
	}

	private function addField($field_type_name, $value){
		$field_type_id = $this->db->getOne('SELECT ft.id FROM '.DB_PREFIX.'fields_type ft WHERE ft.name = ?s', $field_type_name);

		$sql = 'INSERT INTO '.DB_PREFIX.'fields SET fields_type_id = ?i, body = ?s';
		$this->db->query($sql, $field_type_id, $value);
		$field_id = $this->db->insertId();

		if(isset($field_id)){
			return $field_id;
		} else return false;
	}

	private function geoCityParams($citytype){
		$params = array(
			'type' => 'geo',
			'area' => $citytype
		);

		return json_encode($params);
	}

	private function getActive($active){
		$a = isset($active) ? $active : 1;
		
		return $a;
	}

	private function getDate($date = null){
		if(isset($date)){
			return $date;
		} else {
			return date('Y-m-d H:i:s');
		}
	}

	private function addSetting($setting){
		$sql = 'INSERT INTO '.DB_PREFIX.'setting SET ?u';
		$this->db->query($sql, $setting);

		return $this->db->insertId();
	}

	private function getUri($content_id, $page){
		$sql_uri = 'SELECT u.uri FROM pf_url u, pf_page p WHERE p.name = ?s AND u.page_id = p.id AND u.view_id = ?i LIMIT 0,1';

		$uri = $this->db->getOne($sql_uri, $page, $content_id);

		return $uri;	
	}

	private function getDateFormatLocal($date){
		$new_date = new DateTime($date);
		$date_creat = $new_date->format('Y-m-d\TH:i:s');

		return $date_creat;
	}

	public function getContent($category_id = 1){
		#CONTENT
		$sql_content = 'SELECT c.id, c.title, c.setting_id, ct.title as type_title, f.fields_type_id, f.body, cf.filter_id
						FROM '.DB_PREFIX.'content c, '.DB_PREFIX.'content_type ct, '.DB_PREFIX.'fields_content fc, '.DB_PREFIX.'fields f, '.DB_PREFIX.'content_filter cf
						WHERE c.category_id = ?i AND c.type_id = ct.id AND fc.content_id = c.id AND f.id = fc.fields_id AND cf.content_id = c.id';

		#CONTENT
		/*$sql_content = 'SELECT c.id, c.title, c.setting_id, ct.title as type_title, f.fields_type_id, f.body, cf.filter_id
						FROM '.DB_PREFIX.'content c, '.DB_PREFIX.'content_type ct, '.DB_PREFIX.'fields_content fc, '.DB_PREFIX.'fields f, '.DB_PREFIX.'content_filter cf
						WHERE ct.name = ?s AND c.type_id = ct.id AND fc.content_id = c.id AND f.id = fc.fields_id AND cf.content_id = c.id
						ORDER BY c.id';*/
		$content = $this->db->getAll($sql_content, $category_id);

		#MODAL
		$sql_modal = 'SELECT c.id as content_id, fcg.fields_id
					FROM pf_content c, pf_content_fields_group cfg, pf_fields_content_group fcg
					WHERE c.category_id = ?i AND cfg.content_id = c.id AND fcg.id = cfg.fields_group_id';
		$modal = $this->db->getAll($sql_modal, $category_id);

		$fields_group = array();
		foreach($modal as $value){
			$fields_group[] = json_decode($value['fields_id']);
		}

		$fields_id = array();
		foreach($fields_group as $value){
			foreach($value as $val){
				$fields_id[] = $val;
			}
		}

		$sql_fields = 'SELECT f.id, ft.name as field_name, f.body, s.tag_id, s.tag_html, s.class, s.attr
						FROM pf_fields f, pf_fields_type ft, pf_setting s
						WHERE f.id in (?a) AND ft.id = f.fields_type_id AND s.id = ft.setting_id AND f.activ = ?i';
		$fields = $this->db->getAll($sql_fields, $fields_id, 1);

		$fields_content = array();
		foreach($fields as $k => $value){
			foreach($value as $key => $val){
				if(($value['field_name'] == 'view_profile' && $key == 'body') || $value['field_name'] == 'geo_docs' && $key == 'body'){
					$val = json_decode($val, true);
				}
				$fields_content[$value['id']][$key] = $val;				
			}
		}

		$modal_content = array();
		foreach($modal as $value){
			$modal_content[$value['content_id']][] = json_decode($value['fields_id']);
		}

		$view_modal = array();
		foreach($modal_content as $key => $value){
			foreach($value as $k => $val){
				foreach($val as $v){
					$view_modal[$key][$k][$fields_content[$v]['field_name']] = $fields_content[$v];					
				}
			}
		}

		$geo_content = array(
			'content' => $content,
			'modal' => $view_modal
		);

		return $geo_content;
	}

	public function getFilter($content_type_id){
		$sql = 'SELECT f.id, f.name, f.title, f.order FROM '.DB_PREFIX.'filter f, '.DB_PREFIX.'filter_group fg WHERE fg.content_type_id = ?i AND f.group_id = fg.id ORDER BY f.order';

		$filters = $this->db->getAll($sql, $content_type_id);

		if(count($filters) > 0){
			return $filters;
		} else {
			return false;
		}
	}

	public function getCategory($content_type_id){
		$sql = 'SELECT p.id, p.name, p.title, p.count, p.params FROM '.DB_PREFIX.'category p WHERE p.content_type_id = ?i';

		$category = $this->db->getAll($sql, $content_type_id);

		if(count($category) > 0){
			return $category;
		} else {
			return false;
		}
	}

	public function getContentEdit($content_id){
		#CONTENT
		$result = array();

		$sql_content = 'SELECT c.title, c.category_id, c.date_creat, c.date_end, c.geo_id, c.active, ct.id as type_id, ct.name as type_name, ct.title as type_tytle
						FROM '.DB_PREFIX.'content c, '.DB_PREFIX.'content_type ct
						WHERE c.id = ?i AND ct.id = c.type_id';

		$content = $this->db->getRow($sql_content, $content_id);

		$content['date_creat'] = $this->getDateFormatLocal($content['date_creat']);
		$content['date_end'] = $this->getDateFormatLocal($content['date_end']);

		if(isset($content['geo_id'])){
			$result['geo_id'] = $content['geo_id'];
			$result['geo_objects'] = $this->db->getAll('SELECT c.id, c.title FROM pf_content c WHERE c.type_id = ?i ORDER BY c.title ASC', 5);
		}

		$filters = $this->getFilter($content['type_id']);
		$categoryes = $this->getCategory($content['type_id']);

		if(isset($filters) && $filters != ''){
			$content['filter_id'] = $this->db->getOne('SELECT cf.filter_id FROM '.DB_PREFIX.'content_filter cf WHERE cf.content_id = ?i', $content_id);
			$result['filters'] = $filters;
		}

		if(isset($categoryes) && $categoryes != ''){
			$result['category'] = $categoryes;
		}

		$result['content'] = $content;
		
		#FIELDS
		$sql_field = 'SELECT f.id, f.body, ft.name, ft.title, s.params, f.order
						FROM '.DB_PREFIX.'fields_content fc, '.DB_PREFIX.'fields f, '.DB_PREFIX.'fields_type ft, '.DB_PREFIX.'setting s
						WHERE fc.content_id = ?i AND f.id = fc.fields_id AND ft.id = f.fields_type_id AND s.id = ft.setting_id';

		switch($content['type_id']){
			case 9:
			case 10:
			case 11:
			case 15:
				$sql_field .= ' ORDER BY f.order';
			break;
			default :
				$sql_field .= ' ORDER BY f.setting_id';
			break;
		}

		$field_array = $this->db->getAll($sql_field, $content_id);

		$fields = array();
		if(count($field_array) > 0){
			foreach($field_array as $key => $value){
				foreach($value as $k => $v){
					$fields[$key][$k] = $v;
				}
			}
		}

		$result['fields'] = $fields;

		/*echo '<pre>';
		print_r($result);
		echo '</pre>';*/

		return $result;
	}
}
?>