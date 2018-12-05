<?
class ModelFaqView extends MVC{
	public function getContents($arg = array()){
		$sql = 'SELECT fa.name as answer_name, fa.caption as answer_caption, c.title as category_title, f.* FROM '.DB_PREFIX.'faq f, '.DB_PREFIX.'faq_answer fa, '.DB_PREFIX.'category c WHERE';

		$sql_count = 'SELECT count(*) FROM '.DB_PREFIX.'faq f, '.DB_PREFIX.'category c WHERE';
		if(!$arg['category_id']){
			$sql .= ' f.category_id is not null AND f.category_id != 113';
			$sql_count .= ' f.category_id is not null AND f.category_id != 113';

			$url_link = '/faq';
		} else {
			$sql .= ' f.category_id = '.$arg['category_id'];
			$sql_count .= ' f.category_id = '.$arg['category_id'];

			$url_link = $this->db->getOne('SELECT u.uri FROM pf_url u WHERE u.page_id = 12 AND u.view_id = ?i',$arg['category_id']);
		}

		$sql .= ' AND fa.id = f.answer_author_id AND c.id = f.category_id AND f.active = 1 ORDER BY f.id DESC LIMIT ?i,?i'; //f.date_creat, 
		$sql_count .= ' AND c.id = f.category_id AND f.active = 1';

		$result = $this->db->getAll($sql, $arg['page'], $arg['limit']);
		$count = $this->db->getOne($sql_count);

		$sql_comments = 'SELECT fc.faq_id, fc.id, fc.author, DATE_FORMAT(fc.date_creat, "%d.%m.%Y") as view_date, fc.text FROM '.DB_PREFIX.'faq_comments fc, '.DB_PREFIX.'faq f WHERE f.id IN (?a) AND fc.faq_id = f.id AND fc.active = ?i';
		$faq_id = array();

		foreach($result as $key => $value){
			$faq_id[] = $value['id'];

			$value['question'] = $this->typograf($value['question']);

			if(isset($value['answer'])) $this->typograf($value['answer']);

			$value['date_creat'] = $this->getNewsDate($value['date_creat']);
			$result[$key] = $value;
		}

		$comments = $this->db->getAll($sql_comments, $faq_id, 1);
		$com = array();
		foreach($comments as $comment){
			$com[$comment['faq_id']][] = $comment;
		}

		$content = array(
			'content' => $result,
			'uri' => $url_link,
			'count' => $count,
			'comments' => $com
		);

		return $content;
	}

	public function getContent($id){
		$comments = array();

		$sql = 'SELECT fa.name as answer_name, fa.caption as answer_caption, f.* FROM '.DB_PREFIX.'faq f, '.DB_PREFIX.'faq_answer fa WHERE';
		$sql .= ' f.id = ?i AND f.active = ?i LIMIT ?i,?i';
		$result = $this->db->getAll($sql, $id, 1, 0, 1);

		$sql_comments = 'SELECT fc.faq_id, fc.id, fc.author, DATE_FORMAT(fc.date_creat, "%d.%m.%Y") as view_date, fc.text 
		FROM '.DB_PREFIX.'faq_comments fc, '.DB_PREFIX.'faq f WHERE f.id = ?i AND fc.faq_id = f.id AND fc.active = ?i';
		$comments[$id] = $this->db->getAll($sql_comments, $id, 1);

		$content = array(
			'content' => $result,
			'comments' => $comments
		);

		return $content;
	}

	private function getNewsDate($date){
		$monthes = array(
		    1 => 'Января', 2 => 'Февраля', 3 => 'Марта', 4 => 'Апреля',
		    5 => 'Мая', 6 => 'Июня', 7 => 'Июля', 8 => 'Августа',
		    9 => 'Сентября', 10 => 'Октября', 11 => 'Ноября', 12 => 'Декабря'
		);

		return $format_date = (date('d ', strtotime($date)) . $monthes[(date('n', strtotime($date)))] . date(' Y', strtotime($date)));
	}

	public function getSearchContent($string){
		$string = trim($string);

		$sql_faq = 'SELECT fq.id FROM pf_faq fq, pf_url u
			WHERE (fq.question like ?s OR fq.answer like ?s OR fq.id = ?i) AND fq.active = 1 AND u.page_id = 12 AND u.view_id = fq.category_id
			GROUP BY fq.id';
		$search_faq = $this->db->getCol($sql_faq, "%$string%", "%$string%", (int)$string);

		$sql = 'SELECT fa.name as answer_name, fa.caption as answer_caption, c.title as category_title, f.* FROM '.DB_PREFIX.'faq f, '.DB_PREFIX.'faq_answer fa, '.DB_PREFIX.'category c 
		WHERE f.id IN (?a) AND c.id = f.category_id GROUP BY f.id ORDER BY f.date_creat DESC';

		$result = $this->db->getAll($sql, $search_faq);

		#var_dump($search_faq);

		$sql_comments = 'SELECT fc.id, fc.author, fc.text FROM '.DB_PREFIX.'faq_comments fc, '.DB_PREFIX.'faq f WHERE f.id IN (?a) AND fc.faq_id = f.id AND fc.active = ?i';

		foreach($result as $key => $value){
			$value['question'] = $this->typograf($value['question']);
			$value['answer'] = $this->typograf($value['answer']);

			$value['date_creat'] = $this->getNewsDate($value['date_creat']);
			$result[$key] = $value;
		}

		$comments = $this->db->getInd('id', $sql_comments, $search_faq, 1);

		$content = array(
			'content' => $result,
			'count' => count($result)
		);

		return $content;
	}

	public function getCounter(){
		$counter = 'SELECT category_id FROM pf_faq WHERE active = 1';
		$cc = $this->db->getCol($counter);
		$count = array_count_values($cc);

		return $count;
	}
}
?>