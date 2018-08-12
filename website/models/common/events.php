<?php

class ModelCommonEvents extends MVC{
	
	public function getEvents($sid){
		$contents = array();

		$params['date_end'] = '> NOW()';

		$structure = new Action(MODEL, 'setting/structure');
		$content = $structure->loader('getMaterials', $sid, $params);

		foreach($content as $key => $value){
			foreach($value['fields'] as $val){
				$contents[$key][$val['name']] = array(
					'setting' => $val['setting'],
					'field' => $val['field']
				);
			}
		}

		return $contents;
	}

	public function getContents($sect_id){
		$sql_content = 'SELECT c.id, c.title, c.date_creat, c.date_end FROM pf_content c, pf_content_type ct
						WHERE ct.section_id = ?i AND c.type_id = ct.id AND c.date_end >= ?s AND c.active = 1
						ORDER BY c.date_creat';

		$date_now = date('Y-m-d');

		$contents = $this->db->getInd('id', $sql_content, $sect_id, $date_now);

		$contents_id = array();
		foreach($contents as $k => $v){
			$contents_id[] = $k;
		}
		$sql_fields = 'SELECT fc.content_id, ft.name, f.body, f.setting_id FROM pf_fields f, pf_fields_content fc, pf_fields_type ft
						WHERE fc.content_id in (?a) AND f.id = fc.fields_id AND ft.id = f.fields_type_id AND f.fields_type_id != 0
						ORDER BY fc.content_id, f.setting_id';

		$fields = $this->db->getAll($sql_fields, $contents_id);

		foreach($fields as $field){
			if($field['name'] == 'event_caption') {
				$contents[$field['content_id']]['fields'][$field['name']] = $this->typograf($field['body']);
			} else {
				$contents[$field['content_id']]['fields'][$field['name']] = $field['body'];
			}
		}		

		return $contents;
	}

	public function getCalend(){
		$begin = new DateTime(date('Y-m-d'));
		$end = new DateTime(date('Y-m-d'));
		$end->add(new DateInterval('P20D'));

		$end = $end->modify( '+1 day' );

		$interval = new DateInterval('P1D');
		$daterange = new DatePeriod($begin, $interval ,$end);

		$date = array();

		foreach($daterange as $dates){
			$date[$dates->format('j')] = $dates->format('Y-m-d');
		}

		return $date;
	}
}
?>