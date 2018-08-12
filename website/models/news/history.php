<?
class ModelNewsHistory extends MVC{
	public function getContent($sect_id){
		$data = array();

		$sql = 'SELECT c.id, c.title FROM pf_content c, pf_content_type ct
				WHERE ct.section_id = ?i AND c.type_id = ct.id AND c.active = 1
				ORDER BY c.date_creat LIMIT 0,1';

		$content = $this->db->getRow($sql, $sect_id);

		$sql_field = 'SELECT f.id, ft.name, f.body, f.setting_id FROM pf_fields f, pf_fields_content fc, pf_fields_type ft
						WHERE fc.content_id = ?i AND f.id = fc.fields_id AND ft.id = f.fields_type_id AND f.fields_type_id != 0 
						ORDER BY f.order';

		$fields = $this->db->getAll($sql_field, $content['id']);

		$data['content'] = $content;
		$data['fields'] = array();
		$data['sql_field'] = $fields;

		foreach($fields as $field){
			if($field['name'] == 'gallery'){

				$gallery_fields = json_decode($field['body'], true);

				$sql_field_gallery = 'SELECT p.body FROM pf_fields p WHERE p.id in (?a)';
				$gallery_images = $this->db->getAll($sql_field_gallery, $gallery_fields);

				foreach($gallery_images as $k => $v){
					$data['fields'][$field['id']][$field['name']][$k] = json_decode($v['body'], true);
				}

			} elseif($field['name'] == 'news_image') {

				$data['fields'][$field['id']][$field['name']] = json_decode($field['body'], true);

			} else {

				$data['fields'][$field['id']][$field['name']] = $this->typograf($field['body']);

			}
		}

		return $data;
	}

	public function getLoadContent($content_id){
		$data = array();

		$sql_field = 'SELECT f.id, ft.name, f.body, f.setting_id FROM pf_fields f, pf_fields_content fc, pf_fields_type ft
						WHERE fc.content_id = ?i AND f.id = fc.fields_id AND ft.id = f.fields_type_id AND f.fields_type_id != 0 
						ORDER BY f.order';

		$fields = $this->db->getAll($sql_field, $content_id);

		$data['fields'] = array();

		foreach($fields as $field){
			if($field['name'] == 'gallery'){

				$gallery_fields = json_decode($field['body'], true);

				$sql_field_gallery = 'SELECT p.body FROM pf_fields p WHERE p.id in (?a)';
				$gallery_images = $this->db->getAll($sql_field_gallery, $gallery_fields);

				foreach($gallery_images as $k => $v){
					$data['fields'][$field['id']][$field['name']][$k] = json_decode($v['body'], true);
				}

			} elseif($field['name'] == 'news_image') {

				$data['fields'][$field['id']][$field['name']] = json_decode($field['body'], true);

			} else {

				$data['fields'][$field['id']][$field['name']] = $field['body'];

			}
		}

		return $data;
	}

	public function getContentsAll($sect_id){
		$sql = 'SELECT c.id, c.title, c.date_creat FROM pf_content c, pf_content_type ct
				WHERE ct.section_id = ?i AND c.type_id = ct.id AND c.active = 1
				ORDER BY c.date_creat';

		$content = $this->db->getAll($sql, $sect_id);

		return $content;
	}
}
?>