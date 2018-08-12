<?
class ModelNewsNews extends MVC{
	public function getContent($content_id){
		$data = array();

		$sql = 'SELECT c.title, c.date_creat FROM pf_content c WHERE c.id = ?i AND c.active = 1';

		$content_row = $this->db->getRow($sql, $content_id);

		$content_title = $content_row['title'];

		$this->db->query('UPDATE pf_content SET views = views + 1 WHERE id = ?i', $content_id);

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

					$g_crop_images = json_decode($v['body'], true);
					$g_crop_images_info = pathinfo($g_crop_images['path']);

					if(file_exists($_SERVER['DOCUMENT_ROOT'] . $g_crop_images_info['dirname'] . '/' . $g_crop_images_info['filename'] . '_810x520.' . $g_crop_images_info['extension'])){
						$data['fields'][$field['id']][$field['name']][$k]['path_crop'] = $g_crop_images_info['dirname'] . '/' . $g_crop_images_info['filename'] . '_810x520.' . $g_crop_images_info['extension'];
					}
				}

			} elseif($field['name'] == 'news_image') {

				$data['fields'][$field['id']][$field['name']] = json_decode($field['body'], true);

			} else {

				$data['fields'][$field['id']][$field['name']] = $this->typograf($field['body']);

			}
		}

		$sql_prev = 'SELECT c.id, c.title, c.date_creat FROM pf_content c WHERE c.id < ?i AND c.type_id = 11 AND c.active = 1 ORDER BY c.date_creat DESC LIMIT 0,1';
		$sql_next = 'SELECT c.id, c.title, c.date_creat FROM pf_content c WHERE c.id > ?i AND c.type_id = 11 AND c.active = 1 ORDER BY c.date_creat ASC LIMIT 0,1';

		$content_prev = $this->db->getRow($sql_prev, ($content_id));
		$content_next = $this->db->getRow($sql_next, ($content_id));

		if(isset($content_prev)){
			$prev = array(
				'title' => $this->typograf($content_prev['title']),
				'date' => $this->getNewsDate($content_prev['date_creat']),
				'url' => $this->getUrl($content_prev['id'])
			);
		} else {
			$prev = null;
		}

		if(isset($content_next)){
			$next = array(
				'title' => $this->typograf($content_next['title']),
				'date' => $this->getNewsDate($content_next['date_creat']),
				'url' => $this->getUrl($content_next['id'])
			);
		} else {
			$next = null;
		}

		$content = array(
			'title' => $this->typograf($content_title),
			'view_date' => $this->getNewsDate($content_row['date_creat']),
			'fields' => $data['fields'],
			'prev' => $prev,
			'next' => $next
		);

		return $content;
	}

	private function getUrl($content_id){
		return $this->db->getOne('SELECT u.uri FROM pf_url u WHERE u.page_id = 18 AND u.view_id = ?i', $content_id);
	}

	private function getNewsDate($date){
		$monthes = array(
		    1 => 'Января', 2 => 'Февраля', 3 => 'Марта', 4 => 'Апреля',
		    5 => 'Мая', 6 => 'Июня', 7 => 'Июля', 8 => 'Августа',
		    9 => 'Сентября', 10 => 'Октября', 11 => 'Ноября', 12 => 'Декабря'
		);

		return $format_date = (date('d ', strtotime($date)) . $monthes[(date('n', strtotime($date)))] . date(' Y', strtotime($date)));
	}

	public function getContents($arg = array()){

		if($arg['offset'] == 0){
			$date_important = date('Y-m-d', strtotime('-15 days'));

			$sql_news_important = 'SELECT c.id, c.title, c.date_creat, c.views, u.uri, cf.filter_id, f.body as important
						FROM pf_content c, pf_content_type ct, pf_url u, pf_content_filter cf, pf_fields f, pf_fields_content fc, pf_fields_type ft
						WHERE ct.section_id = 5 AND c.type_id = ct.id AND c.date_creat > ?s AND c.active = 1 AND u.page_id = 18 AND u.view_id = c.id AND cf.content_id = c.id AND cf.filter_id = 6
						AND fc.content_id = c.id AND f.id = fc.fields_id AND ft.id = f.fields_type_id AND f.fields_type_id = 43 AND f.body = 1
						ORDER BY c.date_creat DESC LIMIT ?i,?i';

			$news_important = $this->db->getAll($sql_news_important, $date_important, 0, 2);

			$news_important_count = count($news_important);

			$i_news = array();
			$i_news_ids = array();
			foreach($news_important as $value){
				$c_image = $this->db->getOne('SELECT p.body FROM pf_fields p WHERE p.id = (SELECT f.body FROM pf_fields f, pf_fields_content fc, pf_fields_type ft WHERE fc.content_id = ?i AND f.id = fc.fields_id AND ft.id = f.fields_type_id AND f.fields_type_id = 44);', $value['id']);
				$image = json_decode($c_image, true);

				$value['preview'] = isset($image['path']) ? $image['path'] : null;
				$value['date'] = $this->getNewsDate($value['date_creat']);
				$value['title'] = $this->typograf($value['title']);

				$i_news_ids[] = $value['id'];
				$i_news[] = $value;
			}
		}

		$sql_news = 'SELECT c.id, c.title, c.date_creat, c.views, u.uri, cf.filter_id, f.body as important
						FROM pf_content c, pf_content_type ct, pf_url u, pf_content_filter cf, pf_fields f, pf_fields_content fc, pf_fields_type ft
						WHERE ct.section_id = 5 AND c.type_id = ct.id AND c.active = 1 AND u.page_id = 18 AND u.view_id = c.id AND cf.content_id = c.id AND cf.filter_id = 6
						AND fc.content_id = c.id AND f.id = fc.fields_id AND ft.id = f.fields_type_id AND f.fields_type_id = 43
						ORDER BY c.date_creat DESC LIMIT ?i,?i';

		$news_blocks = $this->db->getAll($sql_news, $arg['offset'], $arg['limit']);
		$news = array();

		$ni = 0;
		foreach($news_blocks as $value){
			if(in_array($value['id'], $i_news_ids)) continue;
			$c_image = $this->db->getOne('SELECT p.body FROM pf_fields p WHERE p.id = (SELECT f.body FROM pf_fields f, pf_fields_content fc, pf_fields_type ft WHERE fc.content_id = ?i AND f.id = fc.fields_id AND ft.id = f.fields_type_id AND f.fields_type_id = 44);', $value['id']);
			$image = json_decode($c_image, true);

			if(isset($image['path']) && $image['path'] != ''){
				$value['preview'] = $image['path'];
			} else {
				$value['preview'] = false;
			}

			$value['title'] = $this->typograf($value['title']);

			$value['date'] = $this->getNewsDate($value['date_creat']);

			$news[] = $value;
		}

		$news['count'] = $this->db->getOne('SELECT count(*) as preview FROM pf_content c, pf_content_type ct, pf_url u, pf_content_filter cf WHERE ct.section_id = 5 AND c.type_id = ct.id AND c.active = 1 AND u.page_id = 18 AND u.view_id = c.id AND cf.content_id = c.id AND cf.filter_id = 6');

		$sql_photo = 'SELECT c.id, c.title, c.date_creat, c.views, u.uri, cf.filter_id, f.body as preview
						FROM pf_content c, pf_content_type ct, pf_url u, pf_content_filter cf, pf_fields f, pf_fields_content fc, pf_fields_type ft
						WHERE ct.section_id = 5 AND c.type_id = ct.id AND c.active = 1 AND u.page_id = 18 AND u.view_id = c.id AND cf.content_id = c.id AND cf.filter_id = 4
						AND fc.content_id = c.id AND f.id = fc.fields_id AND ft.id = f.fields_type_id AND f.fields_type_id = 44
						ORDER BY c.date_creat DESC'; // LIMIT ?i,?i

		$news_photo = $this->db->getAll($sql_photo); //, $arg['offset'], $arg['limit']

		$photo = array();
		foreach($news_photo as $value){
			$c_image = $this->db->getOne('SELECT p.body FROM pf_fields p WHERE p.id = ?i', $value['preview']);
			$image = json_decode($c_image, true);
			
			if(file_exists($_SERVER['DOCUMENT_ROOT'] . $image['path'])){
				$news_prev_images = pathinfo($image['path']);

				if(file_exists($_SERVER['DOCUMENT_ROOT'] . $news_prev_images['dirname'] . '/' . $news_prev_images['filename'] . '_770x627.jpg')){
					$value['preview_crop'] = $news_prev_images['dirname'] . '/' . $news_prev_images['filename'] . '_770x627.jpg';
				}

				$value['preview'] = $image['path'];
			} else {
				$value['preview'] = false;
			}

			#$value['preview'] = isset($image['path']) ? $image['path'] : null;
			$value['date'] = $this->getNewsDate($value['date_creat']);
			$value['title'] = $this->typograf($value['title']);

			$photo[] = $value;
		}
		$photo['count'] = $this->db->getOne('SELECT count(*) as preview FROM pf_content c, pf_content_type ct, pf_url u, pf_content_filter cf WHERE ct.section_id = 5 AND c.type_id = ct.id AND c.active = 1 AND u.page_id = 18 AND u.view_id = c.id AND cf.content_id = c.id AND cf.filter_id = 4');

		$sql_video = 'SELECT c.id, c.title, c.date_creat, c.views, u.uri, cf.filter_id, f.body as preview
						FROM pf_content c, pf_content_type ct, pf_url u, pf_content_filter cf, pf_fields f, pf_fields_content fc, pf_fields_type ft
						WHERE ct.section_id = 5 AND c.type_id = ct.id AND c.active = 1 AND u.page_id = 18 AND u.view_id = c.id AND cf.content_id = c.id AND cf.filter_id = 5
						AND fc.content_id = c.id AND f.id = fc.fields_id AND ft.id = f.fields_type_id AND f.fields_type_id = 44
						ORDER BY c.date_creat DESC'; // LIMIT ?i,?i

		$news_video = $this->db->getAll($sql_video); //, $arg['offset'], $arg['limit']

		$video = array();
		foreach($news_video as $value){
			$c_image = $this->db->getOne('SELECT p.body FROM pf_fields p WHERE p.id = ?i', $value['preview']);
			$image = json_decode($c_image, true);
			
			if(file_exists($_SERVER['DOCUMENT_ROOT'] . $image['path'])){
				$news_prev_images = pathinfo($image['path']);

				if(file_exists($_SERVER['DOCUMENT_ROOT'] . $news_prev_images['dirname'] . '/' . $news_prev_images['filename'] . '_770x627.jpg')){
					$value['preview_crop'] = $news_prev_images['dirname'] . '/' . $news_prev_images['filename'] . '_770x627.jpg';
				}

				$value['preview'] = $image['path'];
			} else {
				$value['preview'] = false;
			}

			#$value['preview'] = isset($image['path']) ? $image['path'] : null;
			$value['date'] = $this->getNewsDate($value['date_creat']);
			$value['title'] = $this->typograf($value['title']);

			$video[] = $value;
		}
		$video['count'] = $this->db->getOne('SELECT count(*) as preview FROM pf_content c, pf_content_type ct, pf_url u, pf_content_filter cf WHERE ct.section_id = 5 AND c.type_id = ct.id AND c.active = 1 AND u.page_id = 18 AND u.view_id = c.id AND cf.content_id = c.id AND cf.filter_id = 5');

		/*$sql = 'SELECT c.id, c.title, c.date_creat FROM pf_content c, pf_content_type ct
				WHERE ct.section_id = 5 AND c.type_id = ct.id AND c.active = 1
				ORDER BY c.date_creat';

		$content = $this->db->getAll($sql);*/

		if(!$i_news) $i_news = null;

		$content = array(
			'important_news' => $i_news,
			'news_blocks' => $news,
			'video_blocks' => $video,
			'photo_blocks' => $photo,
		);

		return $content;
	}

	public function getFilters(){
		$filters = $this->db->getAll('SELECT f.id, f.name, f.title, f.order FROM pf_filter f WHERE f.group_id = 2 ORDER BY f.order');
		$i = 0;

		foreach($filters as $filter){
			$sql_fc = 'SELECT count(cf.content_id) FROM pf_filter f, pf_content_filter cf WHERE f.id = ?i AND cf.filter_id = f.id';
			$filters[$i]['count'] = $this->db->getOne($sql_fc, $filter['id']);
			$i++;
		}

		return $filters;
	}

	/*public function getCountFilter($filters){
		$nf = $filters;
		$i = 0;

		foreach($filters as $filter){
			$sql_fc = 'SELECT count(cf.content_id) as count_content FROM pf_filter f, pf_content_filter cf WHERE f.id = ?i AND cf.filter_id = f.id';
			$nf[$i]['count'] = $this->db->getOne($sql_fc, $filter['id']); 
		}

		return $nf;
	}*/
}
?>