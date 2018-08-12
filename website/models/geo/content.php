<?php

class ModelGeoContent extends MVC{

	public function updateContent($data){
		/*echo '<pre>';
		print_r($data['view_profile']);
		echo '</pre>';*/

		$ucontent = $this->db->getRow('SELECT * FROM '.DB_PREFIX.'content WHERE id = ?i', $data['content_id']);

		$category_name = trim($data['geo_category'][0]);
		$category_id = $this->db->getOne('SELECT p.id FROM '.DB_PREFIX.'category p WHERE p.title = ?s AND p.content_type_id = ?i', $category_name, $ucontent['type_id']);

		if(!isset($category_id)) {
			$category = array(
				'content_type_id' => $ucontent['type_id'],
				'name' => $this->translit($category_name),
				'title' => $category_name,
				'params' => $this->geoCityParams($data['citytype']),
				'setting_id' => null,
				'count' => 1
			);
			$sql_cat = 'INSERT INTO '.DB_PREFIX.'category SET ?u';
			$this->db->query($sql_cat, $category);
			$category_id = $this->db->insertId();
		}

		#FILTER
		$filter_id = $this->db->getOne('SELECT p.id FROM '.DB_PREFIX.'filter p WHERE p.title like \'%'.$data['geo_filter'][0].'%\'');

		if($filter_id != ''){
			$sql_cf = 'UPDATE '.DB_PREFIX.'content_filter SET filter_id = ?i WHERE content_id = ?i';
			$this->db->query($sql_cf, $filter_id, $data['content_id']);
		}

		$title_cation_id = $this->db->getOne('SELECT f.id FROM '.DB_PREFIX.'fields_content fc, '.DB_PREFIX.'fields f, '.DB_PREFIX.'fields_type ft WHERE fc.content_id = ?i AND f.id = fc.fields_id AND ft.id = f.fields_type_id', $data['content_id']);
		$this->db->query('UPDATE '.DB_PREFIX.'fields SET body = ?s WHERE id = ?i', $data['title_caption'][24], $title_cation_id);

		$geo_map_pin_id = $this->db->getOne('SELECT p.id FROM '.DB_PREFIX.'geo_pins p WHERE p.content_id = ?i', $data['content_id']);
		$this->db->query('UPDATE '.DB_PREFIX.'geo_pins SET coordinates = ?s WHERE id = ?i', $data['geo_map_pin'][0], $geo_map_pin_id);
		
		foreach($data['modal_title']['group'] as $key => $value){
			$this->db->query('UPDATE '.DB_PREFIX.'fields SET body = ?s WHERE id = ?i', $value, $key);
		}

		foreach($data['view_profile_title']['group'] as $key => $value){
			$this->db->query('UPDATE '.DB_PREFIX.'fields SET body = ?s WHERE id = ?i', $value, $key);
		}

		foreach($data['position']['group'] as $key => $value){
			$this->db->query('UPDATE '.DB_PREFIX.'fields SET body = ?s WHERE id = ?i', $value, $key);
		}

		foreach($data['geo_profile']['group'] as $key => $value){
			$this->db->query('UPDATE '.DB_PREFIX.'fields SET body = ?s WHERE id = ?i', $value, $key);
		}

		foreach($data['view_profile_phone']['group'] as $key => $value){
			$this->db->query('UPDATE '.DB_PREFIX.'fields SET body = ?s WHERE id = ?i', $value, $key);
		}

		$mg = 0;
		foreach($data['view_profile_mail']['group'] as $key => $value){
			$field_mail = $this->db->getOne('SELECT count(*) FROM '.DB_PREFIX.'fields WHERE id = ?i AND fields_type_id = 46', $key);

			if($field_mail == 0){
				$sql_fcg_select = 'SELECT fcg.fields_id, fcg.id FROM pf_content_fields_group cfg, pf_fields_content_group fcg WHERE cfg.content_id = ?i AND fcg.id = cfg.fields_group_id LIMIT ?i,1';
				$fcg_select = $this->db->getRow($sql_fcg_select, $data['content_id'], $mg);

				$fcg = json_decode($fcg_select['fields_id'], true);
				$this->db->query('INSERT INTO '.DB_PREFIX.'fields SET fields_type_id = 46, body = ?s, activ = 1', $value);
				$fm_id = $this->db->insertId();
				$fcg[] = $fm_id;
				$new_fcg = json_encode($fcg);

				$sql_fcg = 'UPDATE '.DB_PREFIX.'fields_content_group SET fields_id = ?s WHERE id = ?i';
				$this->db->query($sql_fcg, $new_fcg, $fcg_select['id']);

				$mg++;
			} else {
				$this->db->query('UPDATE '.DB_PREFIX.'fields SET body = ?s WHERE id = ?i', $value, $key);

				$mg++;
			}
		}

		foreach($field_group as $k => $v){
			$fields_ids = json_encode($v);

			$this->db->query($sql_fcg, $fields_ids);
			$cf_group_id = $this->db->insertId();

			$this->db->query($sql_cfg, $content_id, $cf_group_id);
		}

		$field_group = $this->db->getAll('SELECT fcg.id, fcg.fields_id FROM '.DB_PREFIX.'content_fields_group cfg, '.DB_PREFIX.'fields_content_group fcg WHERE cfg.content_id = ?i AND fcg.id = cfg.fields_group_id', $data['content_id']);

		foreach($data['geo_docs']['group'] as $key => $value){
			if(isset($value) && $value != '' && $key != $value){
				#echo '<br>' . $key . ' -> ' . $value;				

				foreach($field_group as $k => $val){
					$strrr = json_decode($val['fields_id']);
					foreach($strrr as $kk => $vv){
						if($vv == $key){
							$new_val = str_replace($key, $value, $val['fields_id']);
							$this->db->query('UPDATE '.DB_PREFIX.'fields_content_group SET fields_id = ?s WHERE id = ?i', $new_val, $val['id']);
						} else {
							$sr = 1;
						}
					}

					if(isset($sr) && $sr == 1){

						array_push($strrr, $value);
						$json_s = json_encode($strrr);
						/*echo '<pre>';
						print_r($strrr);
						echo '</pre>';*/
						$this->db->query('UPDATE '.DB_PREFIX.'fields_content_group SET fields_id = ?s WHERE id = ?i', $json_s, $val['id']);
						$sr++;
					}
				}

			}
		}

		foreach($data['view_profile']['group'] as $key => $value){
			if(isset($value) && $value != '' && $key != $value){
				#echo '<br>' . $key . ' -> ' . $value;
				foreach($field_group as $k => $val){
					$strrr = json_decode($val['fields_id']);
					foreach($strrr as $kk => $vv){
						if($vv == $key){
							$new_val = str_replace($key, $value, $val['fields_id']);
							$this->db->query('UPDATE '.DB_PREFIX.'fields_content_group SET fields_id = ?s WHERE id = ?i', $new_val, $val['id']);
						}
					}
				}

			}
		}

		$sql_content_update = 'UPDATE '.DB_PREFIX.'content SET ?u WHERE id = ?i';

		$up_content = array(
			'category_id' => $category_id,
			'title' => $data['title'],
			'date_creat' => $data['date_creat'],
			'date_end' => $data['date_end'],
			'active' => $data['active']
		);

		if($data['date_creat'] == null){
			unset($up_content['date_creat']);
		}

		$this->db->query($sql_content_update, $up_content, $data['content_id']);

		$url = $this->getUri($category_id);

		return array('success' => true, 'redirect' => $url);
	}

	public function addContent($data = array()){
		//$data['content']

		$content_type_id = $this->db->getOne('SELECT p.id FROM '.DB_PREFIX.'content_type p WHERE p.name =?s', 'geo_page');

		$category_name = trim($data['geo_category'][0]);
		$category_id = $this->db->getOne('SELECT p.id FROM '.DB_PREFIX.'category p WHERE p.title = ?s AND p.content_type_id = ?i', $category_name, $content_type_id);

		if($category_id < 1) {
			$category = array(
				'content_type_id' => $content_type_id,
				'name' => $this->translit($category_name),
				'title' => $category_name,
				'params' => $this->geoCityParams($data['citytype']),
				'setting_id' => null,
				'count' => 1
			);
			$sql_cat = 'INSERT INTO '.DB_PREFIX.'category SET ?u';
			$this->db->query($sql_cat, $category);
			$category_id = $this->db->insertId();
		}

		#SETTING
		$setting = array();
		$data['setting'] = array('type'=>'content');
		foreach ($data['setting'] as $key => $value) {
			$setting[$key] = $value;
		}
		$setting_id = $this->addSetting($setting);

		#$category_id $setting_id

		#CONTENT
		$content = array(
			'category_id' => $category_id,
			'title' => $data['title'],
			'type_id' => $content_type_id,
			'date_creat' => $this->getDate($data['date_create']),
			'date_end' => null,
			'setting_id' => $setting_id,
			'active' => 1,
		);

		$sql_content = 'INSERT INTO '.DB_PREFIX.'content SET ?u';
		$this->db->query($sql_content, $content);
		$content_id = $this->db->insertId();

		#FILTER
		$filter_id = $this->db->getOne('SELECT p.id FROM '.DB_PREFIX.'filter p WHERE p.title like \'%'.$data['geo_filter'][0].'%\'');

		if($filter_id != ''){
			$filter = array(
				'filter_id' => $filter_id,
				'content_id' => $content_id
			);

			$sql_cf = 'INSERT INTO '.DB_PREFIX.'content_filter SET ?u';
			$this->db->query($sql_cf, $filter);
		}

		#MAP_PIN
		$sql_pin = 'INSERT INTO '.DB_PREFIX.'geo_pins SET coordinates = ?s, content_id = ?i';
		$this->db->query($sql_pin, $data['geo_map_pin'][0], $content_id);

		#TITLE_CAPTION
		$title_caption = array(
			'fields_type_id' => 24,
			'body' => $data['title_caption'][0],
			'setting_id' => null,
			'activ' => 1
		);

		$sql_tc = 'INSERT INTO '.DB_PREFIX.'fields SET ?u';
		$this->db->query($sql_tc, $title_caption);
		$tc_fid = $this->db->insertId();

		$sql_c_tc = 'INSERT INTO '.DB_PREFIX.'fields_content SET content_id = ?i, fields_id = ?i';
		$this->db->query($sql_c_tc, $content_id, $tc_fid);

		#FIELDS_GROUP
		$group = array();

		foreach ($data as $k => $value) {
			if(is_array($value)){
				foreach($value as $key => $val){
					$key = trim($key);
					if($key == 'group' || $k == 'view_profile' || $k == 'geo_docs'){
						$group[$k] = $val;
					}
				}
			}
		}

		$field_group =array();
		foreach($group as $key => $value){
			if(is_array($value)){
				foreach ($value as $k => $v) {
					if($key == 'view_profile' || $key == 'geo_docs'){
						$field_group[$k][] = $v;
					} else {
						$field_group[$k][] = $this->addField($key, $v);
					}
				}
			}
		}

		#CONTENT_FIELDS_GROUP
		$sql_fcg = 'INSERT INTO '.DB_PREFIX.'fields_content_group SET fields_id = ?s';
		$sql_cfg = 'INSERT INTO '.DB_PREFIX.'content_fields_group SET content_id = ?i, fields_group_id = ?i';

		foreach($field_group as $k => $v){
			$fields_ids = json_encode($v);

			$this->db->query($sql_fcg, $fields_ids);
			$cf_group_id = $this->db->insertId();

			$this->db->query($sql_cfg, $content_id, $cf_group_id);
		}

		#URL
		$url = $this->getUri($category_id);

		return array('success' => true, 'redirect' => $url);
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

	private function getUri($category_id){
		$uri = $this->db->getOne('SELECT uri FROM '.DB_PREFIX.'url p WHERE p.page_id = 8 AND p.view_id = ?i', $category_id);

		if($uri == ''){
			$sql = 'INSERT INTO '.DB_PREFIX.'url SET ?u';
			$url = array(
				'page_id' => 8,
				'view_id' => $category_id,
				'uri' => '/geo_city/' . $category_id,
				'type' => 'common/page'
			);
			$this->db->query($sql, $url);

			return $url['uri'];
		} else {
			return $uri;
		}		
	}

	public function getContent($category_id = 1){
		#CONTENT
		$sql_content = 'SELECT c.id, c.title, c.setting_id, ct.title as type_title, f.fields_type_id, f.body, cf.filter_id
						FROM '.DB_PREFIX.'content c, '.DB_PREFIX.'content_type ct, '.DB_PREFIX.'fields_content fc, '.DB_PREFIX.'fields f, '.DB_PREFIX.'content_filter cf
						WHERE c.category_id = ?i AND c.type_id = ct.id AND fc.content_id = c.id AND f.id = fc.fields_id AND cf.content_id = c.id';

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

		#FILTER
		$filter_id = array();
		foreach($content as $value){
			$filter_id[] = $value['filter_id'];
		}

		$filter_id = array_unique($filter_id);

		$filters = $this->db->getAll('SELECT `id`, `name`, `title` FROM `pf_filter` WHERE `group_id` = 1 AND `id` IN (?a) ORDER BY `order`', $filter_id);

		$geo_content = array(
			'content' => $content,
			'modal' => $view_modal,
			'filters' => $filters
		);

		return $geo_content;
	}

	public function getAreaCity(){
		$categories = $this->db->getAll('SELECT p.id, p.name, p.title, p.params FROM '.DB_PREFIX.'category p WHERE p.content_type_id = ?i ORDER BY p.title', 5);

		$category = array();
		$parea = array();
		foreach($categories as $key => $value){
			foreach($value as $k=>$v){
				if($k == 'params'){
					$p = json_decode($v, true);
					$category[$key][$k] = $p['area'];
					$parea[] = $p['area'];
				} else {
					$category[$key][$k] = $v;
				}
			}
		}

		return array('category' => $category, 'areas'=> $parea);
	}

	public function getContentMaps(){
		return true;
	}

	public function getModalGeo($content_id){
		$contents = array();

		$sql_content = 'SELECT c.title, cfg.fields_group_id, fcg.fields_id FROM pf_content c, pf_content_fields_group cfg, pf_fields_content_group fcg WHERE c.id = ?i AND cfg.content_id = c.id AND fcg.id = cfg.fields_group_id';
		$field_groups = $this->db->getAll($sql_content, $content_id);

		$sql_fields = '';

		if(count($field_groups) > 0){
			$fields_group = array();
			foreach($field_groups as $value){
				$fields_group[$value['fields_group_id']] = json_decode($value['fields_id']);
			}

			$fields_id = array();
			foreach($fields_group as $value){
				foreach($value as $val){
					$fields_id[] = $val;
				}
			}

			$sql_fields = 'SELECT f.id, ft.name as field_name, f.body, s.tag_id, s.tag_html, s.class, s.attr, s.params
						FROM pf_fields f, pf_fields_type ft, pf_setting s
						WHERE f.id in (?a) AND ft.id = f.fields_type_id AND s.id = ft.setting_id AND f.activ = ?i';
			$fields = $this->db->getAll($sql_fields, $fields_id, 1);

			$fields_content = array();
			foreach($fields as $value){
				foreach($value as $key => $val){
					$fields_content[$value['id']][$key] = $val;
				}
			}

			$modal_content = array();
			foreach($field_groups as $value){
				$modal_content[$value['content_id']][$value['fields_group_id']] = json_decode($value['fields_id']);
			}

			$view_modal = array();
			foreach($modal_content as $key => $value){
				foreach($value as $k => $val){
					foreach($val as $v){
						$view_modal[$k][$fields_content[$v]['field_name']] = $fields_content[$v];
					}
				}
			}
		} else {
			$view_modal = '';
		}

		$result = array(
			'content' => $field_groups,
			'view_modal' => $view_modal
		);

		return $result;

		/*$contents = array();

		foreach($c as $v){
			$contents[] = array(
				'title' => $v[''],
				'profile_image' => $v[''],
				'profile_title' => $v[''],
				'profile_mail' => $v[''],
				'profile_phone' => $v[''],
				'profile_mail' => $v[''],
				'profile_phone' => $v[''],
				'profile_caption' => $v[''],
				'docs' => $v[''], #path
				'caption' => $v[''],
			);
		}*/
	}

	######################

	public function getContentEdit($content_id){
		#CONTENT
		$sql_content = 'SELECT cat.name as category_name, cat.title as category_title, cat.params as category_params, 
						f.name as filter_name, f.title as filter_title,
						c.title, c.date_creat, c.date_end,
						ct.id as type_id, ct.name as type_name, ct.title as type_tytle,
						gp.id as pin_id, gp.coordinates
						FROM '.DB_PREFIX.'content c, '.DB_PREFIX.'content_type ct, '.DB_PREFIX.'category cat, '.DB_PREFIX.'geo_pins gp, '.DB_PREFIX.'filter f, '.DB_PREFIX.'content_filter cf
						WHERE c.id = ?i AND ct.id = c.type_id AND cat.id = c.category_id AND gp.content_id = c.id AND cf.content_id = c.id AND f.id = cf.filter_id';

		$content = $this->db->getRow($sql_content, $content_id);

		#FIELDS_CROUP
		$sql_fields_group_id = 'SELECT cfg.fields_group_id, fcg.fields_id FROM '.DB_PREFIX.'content_fields_group cfg, '.DB_PREFIX.'fields_content_group fcg WHERE cfg.content_id = ?i AND fcg.id = cfg.fields_group_id ORDER BY cfg.sort_order';
		$group_fields_id = $this->db->getAll($sql_fields_group_id, $content_id);

		if(count($group_fields_id) > 0){
			$fields_group = array();
			foreach($group_fields_id as $value){
				$fields_group[$value['fields_group_id']] = json_decode($value['fields_id']);
			}

			$fields_id = array();
			foreach($fields_group as $value){
				foreach($value as $val){
					$fields_id[] = $val;
				}
			}

			$sql_fields = 'SELECT f.id, ft.name as field_name, f.body, s.tag_id, s.tag_html, s.class, s.attr, s.params
						FROM pf_fields f, pf_fields_type ft, pf_setting s
						WHERE f.id in (?a) AND ft.id = f.fields_type_id AND s.id = ft.setting_id AND f.activ = ?i';
			$fields = $this->db->getAll($sql_fields, $fields_id, 1);

			$fields_content = array();
			foreach($fields as $value){
				foreach($value as $key => $val){
					$fields_content[$value['id']][$key] = $val;
				}
			}

			$modal_content = array();
			foreach($group_fields_id as $value){
				$modal_content[$value['content_id']][$value['fields_group_id']] = json_decode($value['fields_id']);
			}

			$view_modal = array();
			foreach($modal_content as $key => $value){
				foreach($value as $k => $val){
					foreach($val as $v){
						$view_modal[$k][$fields_content[$v]['field_name']] = $fields_content[$v];
					}
				}
			}
		} else {
			$view_modal = '';
		}

		#FILEDS_TYPES
		if($content['type_name'] == 'geo_page'){
			$ids = array(20, 21, 22, 24);
		}

		$sql_fields_type = 'SELECT ft.name, ft.title, s.action, s.params 
							FROM '.DB_PREFIX.'fields_type ft, '.DB_PREFIX.'setting s 
							WHERE ft.id in (?a) AND s.id = ft.setting_id';

		$field_types = $this->db->getAll($sql_fields_type, $ids);

		#FIELDS
		$sql_field = 'SELECT f.id, f.body, ft.id, ft.name, ft.title, s.params
						FROM '.DB_PREFIX.'fields_content fc, '.DB_PREFIX.'fields f, '.DB_PREFIX.'fields_type ft, '.DB_PREFIX.'setting s
						WHERE fc.content_id = ?i AND f.id = fc.fields_id AND ft.id = f.fields_type_id AND s.id = ft.setting_id';

		$field_array = $this->db->getAll($sql_field, $content_id);

		if(count($field_array) < 1){
			$field_array = '';
		}

		if(count($field_types) < 0){
			$field_types = '';
		}

		$result = array(
			'content' => $content,
			'view_modal' => $view_modal,
			'fields' => $field_array,
			'field_types' => $field_types
		);

		return $result;
	}
}
?>