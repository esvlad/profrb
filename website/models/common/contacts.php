<?
class ModelCommonContacts extends MVC{
	public function getContents($sect_id){
		$sql_content = 'SELECT c.id, c.title FROM pf_content c, pf_content_type ct
						WHERE ct.section_id = ?i AND c.type_id = ct.id AND c.active = 1
						ORDER BY c.id LIMIT 0,1';

		$content = $this->db->getRow($sql_content, $sect_id);

		$sql_fields = 'SELECT fc.content_id, ft.name, f.body, f.setting_id FROM pf_fields f, pf_fields_content fc, pf_fields_type ft
						WHERE fc.content_id = ?i AND f.id = fc.fields_id AND ft.id = f.fields_type_id AND f.fields_type_id != 0
						ORDER BY fc.content_id, f.setting_id';

		$fields = $this->db->getAll($sql_fields, $content['id']);

		foreach($fields as $field){
			$content['fields'][$field['name']] = $field['body'];		
		}		

		return $content;
	}
}
?>