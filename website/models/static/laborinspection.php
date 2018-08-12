<?
class ModelStaticLaborinspection extends MVC{
	public function getContents($sect_id){
		$sql_content = 'SELECT c.id, c.title FROM pf_content c, pf_content_type ct
						WHERE ct.section_id = ?i AND c.type_id = ct.id AND c.active = 1
						ORDER BY c.date_creat';

		$contents = $this->db->getInd('id', $sql_content, $sect_id);

		$contents_id = array();
		foreach($contents as $k => $v){
			$contents_id[] = $k;
		}
		$sql_fields = 'SELECT fc.content_id, ft.name, f.id, f.body, f.setting_id FROM pf_fields f, pf_fields_content fc, pf_fields_type ft
						WHERE fc.content_id in (?a) AND f.id = fc.fields_id AND ft.id = f.fields_type_id AND f.fields_type_id != 0
						ORDER BY fc.content_id, f.setting_id';

		$fields = $this->db->getAll($sql_fields, $contents_id);

		foreach($fields as $field){
			if($field['name'] == 'docs'){

				$field['body'] = json_decode($field['body'], true);

				$format = new Action(MODEL, 'docs/docs');
				$field['body']['docs_icon_class'] = $format->loader('getDocsClass', $field['body']['path']);
				
				$contents[$field['content_id']]['fields'][$field['name']][$field['id']] = $field['body'];

			} elseif($field['name'] == 'labor_image'){
				$limage = $this->db->getOne('SELECT p.body FROM pf_fields p WHERE p.id = ?i', $field['body']);
				$contents[$field['content_id']]['fields'][$field['name']] = json_decode($limage, true);

			} else {

				$contents[$field['content_id']]['fields'][$field['name']] = $this->typograf($field['body']);
				
			}
		}		

		return $contents;
	}
}
?>