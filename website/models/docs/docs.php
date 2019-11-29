<?
class ModelDocsDocs extends MVC{
	public function getContents($arg = array()){

		$select = 'SELECT c.id, c.title, c.date_creat, DATE_FORMAT(c.date_creat, "%d.%m.%Y") as view_date, c.date_end, f.id as field_id, f.body';
		$from = ' FROM pf_content c, pf_fields_content fc, pf_fields f';
		$where = ' WHERE c.type_id = ?i AND c.date_creat <= (NOW() + INTERVAL 2 HOUR) AND (c.date_end >= (NOW() + INTERVAL 2 HOUR) OR c.date_end = "0000-00-00 00:00:00" OR c.date_end is null) AND fc.content_id = c.id AND f.id = fc.fields_id AND f.fields_type_id = 25 AND c.active = 1';

		$c_select = 'SELECT count(*)';
		$c_from = ' FROM pf_content c';
		$c_where = ' WHERE c.type_id = ?i AND c.active = 1';

		if(!empty($arg['category_id'])){
			$where .= ' AND c.category_id = ' . $arg['category_id'];
			$c_where .= ' AND c.category_id = ' . $arg['category_id'];
		} else {
			$where .= ' AND c.category_id is not null';
			$c_where .= ' AND c.category_id is not null';
		}

		if(!empty($arg['filter_id'])){
			$from .= ', pf_content_filter fi';
			$where .= ' AND fi.content_id = c.id AND fi.filter_id = ?i';
			$c_from .= ', pf_content_filter fi';
			$c_where .= ' AND fi.content_id = c.id AND fi.filter_id = ?i';
		}

		$order = ' ORDER BY c.date_creat DESC';

		$limit = ' LIMIT ' . $arg['offset'] . ',' . $arg['limit'];

		$sql = $select . $from . $where . $order . $limit;

		$sql_docs_count = $c_select . $c_from . $c_where;

		if(!empty($arg['filter_id'])){
			$content = $this->db->getAll($sql, $arg['content_type_id'], $arg['filter_id']);
			$c_count = $this->db->getOne($sql_docs_count, $arg['content_type_id'], $arg['filter_id']);
		} else {
			$content = $this->db->getAll($sql, $arg['content_type_id']);
			$c_count = $this->db->getOne($sql_docs_count, $arg['content_type_id']);
		}

		$docs = array();
		foreach($content as $file){
			$body = json_decode($file['body'], true);

			$docs[] = array(
				'cid' => $file['id'],
				'title' => $file['title'],
				'date_creat' => $file['date_creat'],
				'view_date' => $file['view_date'],
				'date_end' => $file['date_end'],
				'field_id' => $file['id'],
				'body' => $body,
				'docs_icon_class' => $this->getDocsClass($body['path'])
			);
		}

		#$docs['sql'] = $sql;

		$docs['count'] = $c_count;

		return $docs;
	}

	public function getNewDocs($type_id = 14){
		$sql = 'SELECT c.id, c.title, c.date_creat, DATE_FORMAT(c.date_creat, "%d.%m.%Y") as view_date, c.date_end, f.id as field_id, f.body
				FROM pf_content c, pf_fields_content fc, pf_fields f
				WHERE c.type_id = ?i AND c.date_creat <= (NOW() + INTERVAL 2 HOUR) AND (c.date_end >= (NOW() + INTERVAL 2 HOUR) OR c.date_end = "0000-00-00 00:00:00" OR c.date_end is null) AND fc.content_id = c.id AND f.id = fc.fields_id AND f.fields_type_id = 25 AND c.active = 1
				GROUP BY c.id ORDER BY c.date_creat DESC LIMIT 0,4';

		$content = $this->db->getAll($sql, $type_id);

		$docs = array();
		foreach($content as $file){
			$body = json_decode($file['body'], true);

			$docs[] = array(
				'cid' => $file['id'],
				'title' => $file['title'],
				'date_creat' => $file['date_creat'],
				'view_date' => $file['view_date'],
				'date_end' => $file['date_end'],
				'field_id' => $file['id'],
				'body' => $body,
				'docs_icon_class' => $this->getDocsClass($body['path'])
			);
		}

		return $docs;
	}

	public function getPopularDocs($type_id = 14){
		$sql = 'SELECT c.id, c.title, c.date_creat, DATE_FORMAT(c.date_creat, "%d.%m.%Y") as view_date, c.date_end, f.id as field_id, f.body
				FROM pf_content c, pf_fields_content fc, pf_fields f
				WHERE c.type_id = ?i AND c.date_creat <= (NOW() + INTERVAL 2 HOUR) AND (c.date_end >= (NOW() + INTERVAL 2 HOUR) OR c.date_end = "0000-00-00 00:00:00" OR c.date_end is null) AND fc.content_id = c.id AND f.id = fc.fields_id AND f.fields_type_id = 25 AND c.active = 1
				GROUP BY c.id ORDER BY c.views DESC LIMIT 0,4';

		$content = $this->db->getAll($sql, $type_id);

		$docs = array();
		foreach($content as $file){
			$body = json_decode($file['body'], true);
			
			$docs[] = array(
				'cid' => $file['id'],
				'title' => $file['title'],
				'date_creat' => $file['date_creat'],
				'view_date' => $file['view_date'],
				'date_end' => $file['date_end'],
				'field_id' => $file['id'],
				'body' => $body,
				'docs_icon_class' => $this->getDocsClass($body['path'])
			);
		}

		return $docs;
	}

	public function getPopularDocsAdmin($type_id = 14){
		$docs_popular_fixed = $this->db->getAll('SELECT c.id, c.title, c.date_creat, c.views, ct.title as type_title FROM pf_content c, pf_docs_popular dp, pf_content_type ct 
				WHERE c.type_id = ?i AND dp.content_id = c.id AND ct.id = c.type_id AND c.active = 1 ORDER BY c.date_creat DESC', (int)$type_id);

		$count_docs_popular_fixed = (!empty($docs_popular_fixed)) ? count((array)$docs_popular_fixed) : 0;

		$docs_popular_upload = $this->db->getAll('SELECT c.id, c.title, c.date_creat, c.views, ct.title as type_title FROM pf_content c, pf_content_type ct 
			WHERE c.type_id = ?i AND c.date_creat <= (NOW() + INTERVAL 2 HOUR) AND (c.date_end >= (NOW() + INTERVAL 2 HOUR) OR c.date_end = "0000-00-00 00:00:00" OR c.date_end is null) AND ct.id = c.type_id AND c.active = 1 GROUP BY c.id ORDER BY c.views DESC LIMIT ?i,?i', (int)$type_id, 0, (4 - (int)$count_docs_popular_fixed));

		$docs['content'] = [];

		if($count_docs_popular_fixed > 0){
			$docs['content'] = array_merge($docs_popular_fixed, $docs_popular_upload);

			$popular_ids = $this->db->getCol('SELECT content_id FROM pf_docs_popular');

			foreach($docs['content'] as $key => $value){
				if(in_array($value['id'], $popular_ids)){
					$docs['content'][$key]['popular'] = true;
				}
			}
		} else {
			$docs['content'] = $docs_popular_upload;
		}

		$docs['count'] = count((array)$docs['content']);

		return $docs;
	}

	public function getDocsClass($path){
		$file_type = explode('.', $path);
		$format = array_pop($file_type);

		switch ($format) {
			case 'pdf':
				$docs_icon_class = 'docs_icon__pdf';
				break;
			case 'zip':
				$docs_icon_class = 'docs_icon__zip';
				break;
			case 'rar':
				$docs_icon_class = 'docs_icon__rar';
				break;
			default:
				$docs_icon_class = 'docs_icon__doc';
				break;
		}

		return $docs_icon_class;
	}

	public function getSearchDocs($params){
		$string = trim($params['search']);

		$docs = array();

		$sql_docs = 'SELECT с.id, с.title, f.body, DATE_FORMAT(с.date_creat, "%d.%m.%Y") as view_date FROM pf_content с, pf_fields_content fc, pf_fields f 
		WHERE с.type_id = 14 AND с.title like ?s AND с.date_creat <= (NOW() + INTERVAL 2 HOUR) AND (с.date_end >= (NOW() + INTERVAL 2 HOUR) OR с.date_end = "0000-00-00 00:00:00" OR с.date_end is null) AND fc.content_id = с.id AND f.id = fc.fields_id AND f.fields_type_id = 25 ORDER BY с.date_creat DESC LIMIT ?i,?i';

		$search_docs = $this->db->getAll($sql_docs, "%$string%", $params['offset'], $params['limit']);

		if(count($search_docs) > 0){
			foreach($search_docs as $value){
				$value['cid'] = $value['id'];

				$doc_field = json_decode($value['body'], true);
				$value['body'] = $doc_field;

				$value['docs_icon_class'] = $this->getDocsClass($doc_field['path']);

				$docs[] = $value;
			}
		}

		$sql_docs_count = 'SELECT count(*) FROM pf_content с WHERE с.type_id = 14 AND с.title like ?s';
		$c_count = $this->db->getOne($sql_docs_count, "%$string%");
		$docs['count'] = $c_count;

		return $docs;
	}

	private function getStrlenTitle($str){
		if(iconv_strlen($str) > 68){
			$result = mb_substr($str, 0, 65) . '...';
		} else {
			$result = $str;
		}

		return $result;
	}

	public function getNowCategoryUrl($category_id){
		return $this->db->getOne('SELECT u.uri FROM '.DB_PREFIX.'url u WHERE u.page_id = 11 AND u.view_id = ?i', $category_id);
	}

	public function setUploadDocs($id){
		$sql = 'UPDATE '.DB_PREFIX.'content SET views = views + 1 WHERE id = ?i';
		
		$this->db->query($sql, $id);

		return true;
	}

	public function setPopular($post){
		if($post['set'] == 'i'){
			$this->db->query('INSERT INTO '.DB_PREFIX.'docs_popular SET content_id = ?i', $post['cid']);

			return $this->db->insertId();
		} else {
			$this->db->query('DELETE FROM '.DB_PREFIX.'docs_popular WHERE content_id = ?i', $post['cid']);

			return $post;
		}
	}
}
?>