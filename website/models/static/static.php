<?
class ModelStaticStatic extends MVC{
	public function getContent($content_id){
		$sql_content = 'SELECT c.title FROM pf_content c WHERE c.id = ?i AND c.active = 1 LIMIT 0,1';

		$content_title = $this->db->getOne($sql_content, $content_id);

		$content = array(
			'id' => $content_id,
			'title' => $content_title
		);

		$sql_fields = 'SELECT fc.content_id, ft.name, f.body, f.setting_id FROM pf_fields f, pf_fields_content fc, pf_fields_type ft
						WHERE fc.content_id = ?i AND f.id = fc.fields_id AND ft.id = f.fields_type_id AND f.fields_type_id != 0
						ORDER BY fc.content_id, f.setting_id';

		$fields = $this->db->getAll($sql_fields, $content_id);

		foreach($fields as $field){
			if($field['name'] == 'docs'){

				$field['body'] = json_decode($field['body'], true);

				$format = new Action(MODEL, 'docs/docs');
				$field['body']['docs_icon_class'] = $format->loader('getDocsClass', $field['body']['path']);

				$content['fields'][$field['name']][] = $field['body'];

			} elseif($field['name'] == 'static_address'){

				$content['fields'][$field['name']][] = $this->typograf($field['body']);

			} else {

				$content['fields'][$field['name']] = $this->typograf($field['body']);
				
			}
		}		

		return $content;
	}
}
?>