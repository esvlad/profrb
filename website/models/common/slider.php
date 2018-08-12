<?php

class ModelCommonSlider extends MVC{
	
	public function getSliders(){
		/*$contents = array();

		$structure = new Action(MODEL, 'setting/structure');
		$content = $structure->loader('getMaterials', $sid);

		$slide = array();
		foreach($content as $key => $value){
			foreach($value['fields'] as $val){
				$slide[$key][$val['name']] = array(
					'setting' => $val['setting'],
					'field' => $val['field']
				);
			}
		}*/

		$sliders_id = $this->db->getCol('SELECT c.id FROM pf_content c, pf_content_type ct WHERE ct.section_id = ?i AND c.type_id = ct.id AND c.active = 1 ORDER BY c.date_creat', 1);

		$sql_fields = 'SELECT fc.content_id, ft.name, f.body FROM pf_fields f, pf_fields_content fc, pf_fields_type ft
						WHERE fc.content_id in (?a) AND f.id = fc.fields_id AND ft.id = f.fields_type_id AND f.fields_type_id != 0
						ORDER BY fc.content_id, f.setting_id';

		$fields = $this->db->getAll($sql_fields, $sliders_id);

		$contents = array();

		foreach($fields as $field){
			if($field['name'] == 'bgimage'){
				$bgimage = $this->db->getOne('SELECT body FROM pf_fields WHERE id = ?i', (int)$field['body']);
				$bgimage_path = json_decode($bgimage, true);
				$path = '..' . $bgimage_path['path'];

				$contents[$field['content_id']][$field['name']] = $path;
			} else {
				$contents[$field['content_id']][$field['name']] = $field['body'];
			}			
		}

		return $contents;
	}
}
?>