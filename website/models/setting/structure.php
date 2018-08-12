<?php

class ModelSettingStructure extends MVC{

	public function getPageSetting($page_id){
		$sql = 'SELECT p.id, p.setting_id, p.views, p.name, p.title, ps.action, ps.tag_id, ps.tag_html, ps.class, ps.attr, ps.params, ps.role
				FROM '.DB_PREFIX.'page p, '.DB_PREFIX.'setting ps
				WHERE p.id = ?i AND p.setting_id=ps.id
				LIMIT 0,1';

		return $this->db->getRow($sql, $page_id);
	}
	
	public function getSections($page_id){
		$section_id = $this->db->getCol('SELECT section_id FROM '.DB_PREFIX.'page_section WHERE page_id = ?i', $page_id);

		$sections = $this->db->getAll('SELECT * FROM `'.DB_PREFIX.'section` WHERE `id` IN (?a) ORDER BY `order`', $section_id);

		return $sections;
	}

	public function getContentsID($sid){
		$cids = $this->db->getCol('SELECT `content_id` FROM `'.DB_PREFIX.'section_content` WHERE `section_id` = ?i', $sid);

		return $cids;
	}

	public function getContent($cid){
		return $this->db->getRow('SELECT * FROM `'.DB_PREFIX.'content` WHERE `id` = ?i AND `active` = ?i LIMIT 0,1', $cid, 1);
	}

	public function getFieldsID($cid){
		return $this->db->getCol('SELECT `fields_id` FROM `'.DB_PREFIX.'fields_content` WHERE `content_id` = ?i', $cid);
	}

	public function getFields($fid){
		return $this->db->getRow('SELECT * FROM `'.DB_PREFIX.'fields` WHERE `id` = ?i', $fid);
	}

	public function getFieldType($ftid){
		return $this->db->getRow('SELECT * FROM `'.DB_PREFIX.'fields_type` WHERE `id`=?i', $ftid);
	}

	public function getSetting($id){
		$setting = $this->db->getRow('SELECT * FROM `'.DB_PREFIX.'setting` WHERE `id` = ?i', $id);

		$result = array();

		foreach($setting as $key => $value){
			switch ($key) {
				case 'attr':
				case 'params':
					$value = $this->helperSettingParams($value);
					break;
				default: break;
			}
			$result[$key] = $value;
		}

		return $result;
	}

	public function getMaterial($sid){
	}

	public function getContents($sid, $params = array()){
		$sql = 'SELECT c.id as cid, c.title as content_title, c.date_creat as content_dc, c.date_end as content_de, c.views as content_views,
				ct.name as ctype_name, ct.title as ctype_title, ct.setting_id as ctype_setting_id,
				s.id as setting_id, s.type as setting_type, s.action as setting_action, s.tag_id as setting_tag_id, s.tag_html as setting_tag_html, s.class as setting_class, s.attr as setting_attr, s.params as setting_params, s.order as setting_order
				FROM '.DB_PREFIX.'content c, '.DB_PREFIX.'setting s, '.DB_PREFIX.'content_type ct
				WHERE ct.section_id = ?i AND c.type_id = ct.id AND c.setting_id = s.id AND c.active = 1';

		if(!empty($params['date_end'])){
			$sql .= ' AND pc.date_end ' . $params['date_end'];
		}

		if(!empty($params['order'])){
			$sql .= ' ORDER BY ' . $params['order'];
			if(!empty($params['order_desc'])) $sql .= ' DESC';
		}

		if(!empty($params['limit'])){
			$offset = isset($params['offset']) ? $params['offset'] : 1;
			$sql .= ' LIMIT '.$offset.','.$params['limit'];
		}
		return $this->db->getAll($sql, $sid);
	}

	public function getMaterials($sid){
		$materials = array();

		$contents = $this->getContents($sid);
		$cids = [];
		foreach($contents as $content){
			$cids[] = $content['cid'];
		}

		$fields = $this->getContentFields($cids);

		foreach($contents as $content){
			$materials[] = array(
				'content' => [
					'id' => $content['cid'],
					'title' => $content['content_title'],
					'date_creat' => $content['content_dc'],
					'date_end' => $content['content_de'],
					'content_views' => $content['content_views'],
					'content_type' => [
						'name' => $content['ctype_name'],
						'title' => $content['ctype_title'],
						'setting_id' => $content['ctype_setting_id']
					],
					'setting' => [
						'id' => $content['setting_id'],
						'type' => $content['setting_type'],
						'action' => $content['setting_action'],
						'tag_id' => $content['setting_tag_id'],
						'tag_html' => $content['setting_tag_html'],
						'class' => $content['setting_class'],
						'attr' => $this->helperSettingParams($content['setting_attr']),
						'params' => $this->helperSettingParams($content['setting_params']),
						'order' => $content['setting_order'],
						'role' => $content['setting_role']
					],
				], 
				'fields' => $this->helperFieldsContent($fields, $content['cid'])
			);
			#$materials['fields'] = $this->helperFieldsContent($fields, $content['cid']);
		}

		return $materials;
	}

	private function helperSettingParams($params){
		if(!empty($params)){
			$res = json_decode($params, true);
			$result = array();

			foreach($res as $k => $v){
				$result[] = $k.'="'.$v.'"';
			}

			$result = implode(' ', $result);

			return $result;
		} else return false;
	}

	private function helperFieldsContent($fields, $cid){
		$field = array();

		foreach ($fields as $key => $value) {
			if($value['content_id'] == $cid){
				foreach ($value as $k => $v){
					$pos_field_type = stripos($k, 'field_type');
					$pos_fields = stripos($k, 'fields');
					$pos_setting = stripos($k, 'setting_ft');

					if($pos_field_type !== false){
						$field[$key][substr($k, 11)] = $v;
					}

					if($pos_setting !== false){
						if($k == 'setting_ft_attr') $v = $this->helperSettingParams($v);
						if($k == 'setting_ft_params') $v = json_decode($v, true);
						$field[$key]['setting'][substr($k, 11)] = $v;
					}

					if($pos_fields !== false){
						$field[$key]['field'][substr($k, 7)] = $v;
						if($k == 'fields_setting_id' && !empty($v)){
							$field[$key]['field']['setting'] = $this->getSetting($v);
						}
					}
				}
			}
		}

		return $field;
	}

	public function getContentFields($cids = array()){
		$sql = 'SELECT pfc.content_id, pft.id as field_type_id, pft.name as field_type_name, pft.title as field_type_title, pft.setting_id as field_type_setting_id, pft.params as field_type_params, pf.id as field_id,
				pf.body as fields_body, pf.setting_id as fields_setting_id, 
				ps.type as setting_ft_type, ps.action as setting_ft_action, ps.tag_id as setting_ft_tag_id,
				ps.tag_html as setting_ft_tag_html, ps.class as setting_ft_class, ps.attr as setting_ft_attr, ps.params as setting_ft_params, ps.order as setting_ft_order
				FROM '.DB_PREFIX.'fields_content pfc, '.DB_PREFIX.'fields pf, '.DB_PREFIX.'fields_type pft, '.DB_PREFIX.'setting ps
				WHERE pfc.content_id IN (?a) AND pfc.fields_id = pf.id AND pf.fields_type_id = pft.id AND pft.setting_id = ps.id AND pf.activ = 1
				ORDER BY ps.order';

		return $this->db->getAll($sql, $cids);
	}
}
?>