<?php

class ModelAdminUpdate extends MVC{

	public function upActive($data){
		$sql = 'UPDATE '.DB_PREFIX.'content SET active = ?i WHERE id = ?i';
		$this->db->query($sql, $data['params'], $data['content_id']);

		return true;
	}

	public function getContentTypeName($content_id){
		$sql = 'SELECT ct.name FROM '.DB_PREFIX.'content c, '.DB_PREFIX.'content_type ct WHERE c.id = ?i AND ct.id = c.type_id';

		return $this->db->getOne($sql, $content_id);
	}

	public function getContentEdit($content_id){
		$content_type = $this->db->getOne('SELECT ct.name FROM pf_content c, pf_content_type ct WHERE c.id = ?i AND ct.id = c.type_id', $content_id);
		$content_type = trim($content_type);

		if($content_type == 'geo_page'){
			$edit_geo = new Action(MODEL, 'geo/content');
			$result = $edit_geo->loader('getContentEdit', $content_id);
		} else {
			$edit = new Action(MODEL, 'static/content');
			$result = $edit->loader('getContentEdit', $content_id);
		}

		return $result;
	}

	public function deleteContent($content_id){
		$field_group_id = $this->db->getAll('SELECT cfg.fields_group_id FROM '.DB_PREFIX.'content_fields_group cfg WHERE cfg.content_id = ?i', $content_id);

		$fields_id = array();
		if(count($field_group_id) > 0){
			foreach($field_group_id as $group_id){
				$fid = $this->db->getOne('SELECT fcg.fields_id FROM '.DB_PREFIX.'fields_content_group fcg WHERE fcg.id = ?i', $group_id['fields_group_id']);
				$fid = json_decode($fid, true);
				foreach($fid as $key => $value){
					$fields_id[] = $value;
				}
				$this->db->query('DELETE FROM '.DB_PREFIX.'fields_content_group WHERE id = ?i', $group_id['fields_group_id']);
			}
			$this->db->query('DELETE FROM '.DB_PREFIX.'content_fields_group WHERE content_id = ?i', $content_id);
		}

		$filter_id = $this->db->getOne('SELECT count(*) FROM '.DB_PREFIX.'content_filter p WHERE p.content_id = ?i', $content_id);
		if($filter_id > 0){
			$this->db->query('DELETE FROM '.DB_PREFIX.'content_filter WHERE content_id = ?i', $content_id);
		}

		$fields = $this->db->getAll('SELECT p.fields_id FROM '.DB_PREFIX.'fields_content p WHERE p.content_id = ?i', $content_id);

		if(count($fields) > 0){
			foreach($fields as $value){
				$fields_id[] = $value['fields_id'];
			}
			$this->db->query('DELETE FROM '.DB_PREFIX.'fields_content WHERE content_id = ?i', $content_id);
		}

		#SETTINGS
		$setting_id = array();
		$sql_fset = 'SELECT f.id, ft.setting_id FROM '.DB_PREFIX.'fields f, '.DB_PREFIX.'fields_type ft WHERE f.id in (?a) AND ft.id = f.fields_type_id';
		$field_set = $this->db->getAll($sql_fset, $fields_id);
		foreach($field_set as $value){
			$set_type = $this->db->getOne('SELECT p.params FROM pf_setting p WHERE p.id = ?i', $value['setting_id']);
			$field_params = json_decode($set_type, true);
			if($field_params['tag']['attr']['type'] == 'file'){
				$file = $this->db->getOne('SELECT p.body FROM pf_fields p WHERE p.id = ?i', $value['id']);
				$file_path = json_decode($file, true);
				if(file_exists($_SERVER['DOCUMENT_ROOT'] . $file_path['path'])){
					#unlink($_SERVER['DOCUMENT_ROOT'] . $file_path['path']);
				}
			}
		}

		$setting_id[] = $this->db->getOne('SELECT setting_id FROM '.DB_PREFIX.'content WHERE id = ?i', $content_id);

		$pins = $this->db->getOne('SELECT count(*) FROM '.DB_PREFIX.'geo_pins p WHERE p.content_id = ?i', $content_id);
		if($pins > 0){
			$this->db->query('DELETE FROM '.DB_PREFIX.'geo_pins WHERE content_id = ?i', $content_id);
		}

		$content_category_id = $this->db->getOne('SELECT p.category_id FROM '.DB_PREFIX.'content p WHERE p.id = ?i', $content_id);

		if($content_category_id != 0){
			$sql_count_category = 'UPDATE `'.DB_PREFIX.'category` SET `count` = `count` - 1 WHERE `id` = ?i';
			$this->db->query($sql_count_category, $content_category_id);
		}

		$this->db->query('DELETE FROM '.DB_PREFIX.'fields WHERE id in (?a)', $fields_id);

		$this->db->query('DELETE FROM '.DB_PREFIX.'setting WHERE id in (?a)', $setting_id);

		$this->db->query('DELETE FROM '.DB_PREFIX.'content WHERE id = ?i', $content_id);
		
		return array('success' => true);
	}
}
?>