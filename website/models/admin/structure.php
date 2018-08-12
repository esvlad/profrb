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
		
		$result = $this->$setting_type['action']($s_params, $setting_type);

		return $result;
	}

	public function getContentTypeAll(){
		return $this->db->getAll('SELECT id, name, title FROM '.DB_PREFIX.'content_type ORDER BY id');
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

		$sql_cat = 'SELECT p.id, p.content_type_id, p.name, p.title, p.setting_id FROM '.DB_PREFIX.'category p WHERE p.params = ?s ORDER BY p.name';
		$category = $this->db->getAll($sql_cat, 'geo');

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
			$fields = 'c.id, c.title, ct.title as type_title, c.type_id, c.date_creat, c.date_end, c.active ';
			$from = 'FROM '.DB_PREFIX.'content c, pf_content_type ct ';
			$where = 'WHERE ct.id = c.type_id ';

			$sql_count = $sql . $count . $from;
			$content['count'] = $this->db->getOne($sql_count);

			$sql_content = $sql . $fields . $from . $where . $order . $sort . $limit;
			$content['content'] = $this->db->getAll($sql_content, $arg['page'], $arg['limit']);
		} else {
			$fields = 'c.id, c.title, ct.title as type_title, c.type_id, c.date_creat, c.date_end, c.active ';
			$from = 'FROM pf_content c, pf_content_type ct ';
			$where = 'WHERE ct.name = ?s AND c.type_id = ct.id ';

			if($arg['type'] == 'docs' && $arg['category_id']){
				$where .= ' AND c.category_id = ' . $arg['category_id'];
			}

			$sql_count = $sql . $count . $from . $where;
			$content['count'] = $this->db->getOne($sql_count, $arg['type']);

			$sql_content = $sql . $fields . $from . $where . $order . $sort . $limit;
			$content['content'] = $this->db->getAll($sql_content, $arg['type'], $arg['page'], $arg['limit']);
		}

		return $content;
	}

	public function getNotification(){
		$count = array();
		$sql_faq = 'SELECT count(*) FROM '.DB_PREFIX.'faq WHERE answered = 0';

		$sql_comments = 'SELECT count(*) FROM '.DB_PREFIX.'faq_comments WHERE active = 0';

		$count['faq'] = $this->db->getOne($sql_faq);
		$count['comments'] = $this->db->getOne($sql_comments);

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