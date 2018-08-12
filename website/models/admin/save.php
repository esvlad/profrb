<?php

class ModelAdminSave extends MVC{

	public function addPage($data){
		#$this->isAdmin();

		#SETTING
		$setting_id = $this->addSetting($data['setting']);

		#PAGE
		$data['page']['setting_id'] = $setting_id;
		$sql = 'INSERT INTO '.DB_PREFIX.'page SET ?u';
		$this->db->query($sql, $data['page']);
		$page_id = $this->db->insertId();

		#URL
		$data['url']['page_id'] = $page_id;
		$result = $this->addUrl($data['url']);
		
		if(isset($result)){
			return true;
		} else return false;
	}

	public function addSection($data){
		#SETTING
		$setting_id = $this->addSetting($data['setting']);

		#SECTION
		$data['section']['setting_id'] = $setting_id;
		$sql = 'INSERT INTO '.DB_PREFIX.'section SET ?u';
		$this->db->query($sql, $data['section']);
		$section_id = $this->db->insertId();

		#PAGE_SECTION
		$sql_ps = 'INSERT INTO '.DB_PREFIX.'page_section SET page_id = ?i, section_id = ?i';
		$result = $this->db->query($sql_ps, $data['page_id'], $section_id);
		
		if(isset($result)){
			return true;
		} else return false;
	}

	public function addFieldType($data){
		#SETTING
		$setting_id = $this->addSetting($data['setting']);

		#FIELDTYPE
		$data['fields_type']['setting_id'] = $setting_id;
		$sql = 'INSERT INTO '.DB_PREFIX.'fields_type SET ?u';
		$result = $this->db->query($sql, $data['fields_type']);
		
		if(isset($result)){
			return true;
		} else return false;
	}

	public function addContent($data){
		$model = new Action(MODEL, $data['type'].'/content');
		$result = $model->loader('addContent', $data['content']);

		return $result;
	}

	public function addField($data){
		$field_type_id = $this->db->getOne('SELECT ft.id FROM '.DB_PREFIX.'fields_type ft WHERE ft.name = ?s',$data['field_name']);

		if($data['type'] == 'file'){
			$body = array(
				'title' => $data['title'],
				'path' => $data['file'],
				'order' => $data['sort']
			);
			$set = array(
				'fields_type_id' => $field_type_id,
				'body' => json_encode($body),
				'setting_id' => 0
			);
		}

		$sql = 'INSERT INTO '.DB_PREFIX.'fields SET ?u';
		$this->db->query($sql, $set);
		$field_id = $this->db->insertId();

		if(isset($field_id)){
			return $field_id;
		} else return false;
		#return $data['file'];
	}

	private function addFields($field){}

	private function addSetting($setting){
		$sql = 'INSERT INTO '.DB_PREFIX.'setting SET ?u';
		$this->db->query($sql, $setting);

		return $this->db->insertId();
	}

	private function addUrl($url){
		$sql = 'INSERT INTO '.DB_PREFIX.'url SET ?u';
		$this->db->query($sql, $url);

		return $this->db->insertId();
	}

	####UPDATE####

	public function updateContent($data){
		$model = new Action(MODEL, $data['type'].'/content');
		$result = $model->loader('updateContent', $data['content']);

		return $result;
	}
}
?>