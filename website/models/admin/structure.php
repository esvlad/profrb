<?php

class ModelAdminStructure extends MVC{
	public function getPageViews(){
		return $this->db->getAll('SELECT p.id, p.title FROM '.DB_PREFIX.'page p ORDER BY p.name');
	}

	public function getSections(){
		return $this->db->getAll('SELECT p.id, p.title FROM '.DB_PREFIX.'section p ORDER BY p.name');
	}

	public function getStructureContent($type){
		$result = array();

		$sql_st = 'SELECT ct.id, ct.title, s.action, s.params FROM '.DB_PREFIX.'content_type ct, '.DB_PREFIX.'setting s WHERE ct.name = ?s AND s.id = ct.setting_id';
		$setting_type = $this->db->getRow($sql_st, $type);

		$s_params = json_decode($setting_type['params'], true);
		
		$result = $this->{$setting_type['action']}($s_params, $setting_type);

		return $result;
	}

	public function getContentTypeAll(){
		$user = $this->isAdmin();

		if($user['org_id'] != 0){
			$result = $this->db->getAll('SELECT id, name, title FROM pf_content_type WHERE id IN(5,17) ORDER BY id');
		} else {
			$result = $this->db->getAll('SELECT id, name, title FROM '.DB_PREFIX.'content_type ORDER BY id');
		}

		return $result;
	}

	public function getContentType($name){
		return $this->db->getRow('SELECT id, title FROM '.DB_PREFIX.'content_type WHERE name = ?s', $name);
	}

	public function getStaticContent($s_params, $setting_type){
		$sql_ft = 'SELECT ft.name, ft.title, s.action, s.params FROM '.DB_PREFIX.'fields_type ft, '.DB_PREFIX.'setting s WHERE ft.id in (?a) AND s.id = ft.setting_id ORDER BY s.order';
		$field_type = $this->db->getAll($sql_ft, $s_params['field_type']['access']);

		#$ft = json_decode($field_type['params'])

		$result = array(
			'content_type_title' => $setting_type['title'],
			'field_type' => $field_type
		);

		if($setting_type['action'] == 'getGeoNewsContent'){
			$user = $this->isAdmin();

			if($user['org_id'] != 0){
				$geo_objects = $this->db->getOne('SELECT c.id FROM pf_content c WHERE c.id = ?i ORDER BY c.title ASC', $user['org_id']);
			} else {
				$geo_objects = $this->db->getAll('SELECT c.id, c.title FROM pf_content c WHERE c.type_id = ?i ORDER BY c.title ASC', 5);
			}

			$result['geo_objects'] = $geo_objects;
		}

		return $result;
	}

	public function getSlider($s_params, $setting_type){
		return $this->getStaticContent($s_params, $setting_type);
	}

	public function getStage($s_params, $setting_type){
		return $this->getStaticContent($s_params, $setting_type);
	}

	public function getContactsContent($s_params, $setting_type){
		return $this->getStaticContent($s_params, $setting_type);
	}

	public function getAboutContent($s_params, $setting_type){
		return $this->getStaticContent($s_params, $setting_type);
	}

	public function getEventsContent($s_params, $setting_type){
		return $this->getStaticContent($s_params, $setting_type);
	}

	public function getActivityContent($s_params, $setting_type){
		return $this->getStaticContent($s_params, $setting_type);
	}

	public function getWorkersContent($s_params, $setting_type){
		return $this->getStaticContent($s_params, $setting_type);
	}

	public function getStructurePage($s_params, $setting_type){
		return $this->getStaticContent($s_params, $setting_type);
	}

	public function getHistoryContent($s_params, $setting_type){
		return $this->getStaticContent($s_params, $setting_type);
	}

	public function getLaborContent($s_params, $setting_type){
		return $this->getStaticContent($s_params, $setting_type);
	}

	public function getNewsContent($s_params, $setting_type){
		return $this->getStaticContent($s_params, $setting_type);
	}

	public function getTodayContent($s_params, $setting_type){
		return $this->getStaticContent($s_params, $setting_type);
	}

	public function getGeoNewsContent($s_params, $setting_type){
		return $this->getStaticContent($s_params, $setting_type);
	}

	public function getDocsContent($s_params, $setting_type){
		$sql_ft = 'SELECT ft.id, ft.name, ft.title, s.action, s.params FROM '.DB_PREFIX.'fields_type ft, '.DB_PREFIX.'setting s WHERE ft.id in (?a) AND s.id = ft.setting_id ORDER BY s.order';
		$field_type = $this->db->getAll($sql_ft, $s_params['field_type']['access']);

		#$content_type_id = $field_type['id'];

		$content_model = new Action(MODEL, 'static/content');

		$result = array(
			'content_type_title' => $setting_type['title'],
			'field_type' => $field_type,
			'category' => $content_model->loader('getCategory', $setting_type['id']),
			'filters' => $content_model->loader('getFilter', $setting_type['id'])
		);

		return $result;
	}

	public function getGeoPage($s_params, $setting_type){
		$sql_fg = 'SELECT p.title, p.fields_ids FROM pf_fields_group p WHERE p.name = ?s';
		$field_group = $this->db->getRow($sql_fg, 'geo_group');

		$fields_id = explode(',', $field_group['fields_ids']);

		$sql_field_not_group = 'SELECT ft.name, ft.title, s.action, s.params 
								FROM '.DB_PREFIX.'fields_type ft, '.DB_PREFIX.'setting s 
								WHERE ft.id in (?a) AND ft.id not in (?a) AND s.id = ft.setting_id 
								ORDER BY s.order ASC';
		$field_not_group = $this->db->getAll($sql_field_not_group, $s_params['field_type']['access'], $fields_id);

		$sql_cat = 'SELECT p.id, p.content_type_id, p.name, p.title, p.setting_id FROM '.DB_PREFIX.'category p WHERE p.params like "%geo%" ORDER BY p.name';
		$category = $this->db->getAll($sql_cat);

		$result = array(
			'content_type_title' => $setting_type['title'],
			'category' => $category,
			'field_group' => $this->getGroupFields($fields_id),
			'field_type' => $field_not_group
		);

		return $result;
	}

	public function getGroupFields($fields_id){
		$sql_ft = 'SELECT fg.name as group_name, fg.title as group_title, ft.name, ft.title, s.action, s.params 
		FROM '.DB_PREFIX.'fields_group fg, '.DB_PREFIX.'fields_type ft, '.DB_PREFIX.'setting s 
		WHERE ft.id in (?a) AND s.id = ft.setting_id
		ORDER BY s.order ASC';
		$field_type = $this->db->getAll($sql_ft, $fields_id);

		$f_group = array('group_name'=>$field_type[0]['group_name'],'group_title'=>$field_type[0]['group_title']);

		$field_group = array(
			'group' => $f_group,
			'field_type' => $field_type
		);

		return $field_group;
	}

	public function getContents($arg = array()){
		$sql = 'SELECT ';

		$count = 'count(*) ';
		$order = ' ORDER BY c.'.$arg['order'].' ';
		$sort = $arg['sort'].' ';
		$limit = ' LIMIT ?i,?i ';

		$content = array();

		if($arg['type'] == 'all'){
			$fields = 'c.id, c.title, ct.title as type_title, c.type_id, c.date_creat, c.date_end, c.views, c.active ';
			$from = 'FROM '.DB_PREFIX.'content c, pf_content_type ct ';
			$where = 'WHERE ct.id = c.type_id ';

			$sql_count = $sql . $count . $from;
			$content['count'] = $this->db->getOne($sql_count);

			$sql_content = $sql . $fields . $from . $where . $order . $sort . $limit;
			$content['content'] = $this->db->getAll($sql_content, $arg['page'], $arg['limit']);
		} else {
			$fields = 'c.id, c.title, ct.title as type_title, c.type_id, c.geo_id, c.date_creat, c.date_end, c.views, c.active ';
			$from = 'FROM pf_content c, pf_content_type ct ';
			$where = 'WHERE ct.name = ?s AND c.type_id = ct.id ';

			if($arg['type'] == 'docs' && $arg['category_id']){
				$where .= ' AND c.category_id = ' . $arg['category_id'];
			}

			if($arg['user']['org_id'] != 0){
				if($arg['type'] == 'geo_page'){
					$where .= ' AND c.id = ' . $arg['user']['org_id'];
				} else {
					$where .= ' AND c.geo_id = ' . $arg['user']['org_id'];
				}
			}

			$sql_count = $sql . $count . $from . $where;
			$content['count'] = $this->db->getOne($sql_count, $arg['type']);

			$sql_content = $sql . $fields . $from . $where . $order . $sort . $limit;
			$content['content'] = $this->db->getAll($sql_content, $arg['type'], $arg['page'], $arg['limit']);
		}

		if($arg['type'] == 'docs'){
			$popular_ids = $this->db->getCol('SELECT content_id FROM pf_docs_popular');
		}

		foreach($content['content'] as $key => $value){
			if($value['title'] == '-'){
				$title = $this->db->getOne('SELECT f.body FROM pf_fields f, pf_fields_content fc, pf_fields_type ft WHERE fc.content_id = ?i AND f.id = fc.fields_id AND ft.name = ?s AND f.fields_type_id = ft.id', $value['id'], 'text');

				$content['content'][$key]['title'] = mb_substr(trim(strip_tags($title)), 0, 60).'...';

				$content['content'][$key]['geo_title'] = $this->db->getOne('SELECT `title` FROM `pf_content` WHERE `id` = ?i', $value['geo_id']);
			}

			if($arg['type'] == 'docs' && !empty($popular_ids) && in_array($value['id'], $popular_ids)){
				$content['content'][$key]['popular'] = true;
			}
		}

		return $content;
	}

	public function getNotification(){
		$count = array();
		$sql_faq = 'SELECT count(*) FROM '.DB_PREFIX.'faq WHERE answered = 0';

		$sql_comments = 'SELECT count(*) FROM '.DB_PREFIX.'faq_comments WHERE active = 0';

		$sql_user = 'SELECT count(*) FROM '.DB_PREFIX.'notification WHERE view = 0';

		$count['faq'] = $this->db->getOne($sql_faq);
		$count['comments'] = $this->db->getOne($sql_comments);
		$count['notification'] = $this->db->getOne($sql_user);

		$notifi = array();

		$counts = 0;
		foreach($count as $k => $v){
			if($v != 0){
				$counts += $v;
				$notifi[] = array(
					'href' => 'admin/'.$k.'/view',
					'type' => $k,
					'count' => $v,
					'type_text' => $this->getNotifiText($k, $v)
				);
			}
		}

		$data = array(
			'count' => $counts,
			'content' => $notifi
		);

		if($counts > 0){
			return $data;
		} else {
			return false;
		}
	}

	private function getNotifiText($key, $count){
		switch($key){
			case 'faq':
				$text = $this->plural_form($count, array('вопрос','вопроса','вопросов'));
			break;
			case 'comments':
				$text = $this->plural_form($count, array('комментарий','комментария','комментариев'));
			break;
			case 'notification':
				$text = $this->plural_form($count, array('действие','действия','действий'));
			break;
			default : 
				$text = null;
			break;
		}

		return $text;
	}

	private function plural_form($number, $after) {
		$cases = array (2, 0, 1, 1, 1, 2);
		return $after[ ($number%100>4 && $number%100<20)? 2: $cases[min($number%10, 5)] ];
	}


}
?>