<?
class ModelFaqCRUD extends MVC{
	public function getCategory($arg){
		return $this->db->getAll('SELECT `id`, `title` FROM `'.DB_PREFIX.'category` WHERE `content_type_id` = ?i ORDER BY `params`', 0);
	}

	public function getCategoryFilter($arg){
		return $this->db->getAll('SELECT `id`, `title` FROM `'.DB_PREFIX.'category` WHERE `content_type_id` = ?i ORDER BY `params`', 0);
	}

	public function getAuthors($arg){
		return $this->db->getAll('SELECT `id`, `name` FROM `'.DB_PREFIX.'faq_answer` ORDER BY `name`');
	}

	public function addContent($post){
		$author = array();
		$question = array();
		foreach($post as $key => $value){
			$value = trim($value);

			switch ($key) {
				case 'caption':
				case 'name':
					$author[$key] = $value;
				break;
				case 'date_creat':
					$value = trim($value);
					if(!isset($value) || $value == '' || $value == null){
						$question[$key] = date('Y-m-d H:i:s');
					} else {
						$question[$key] = $value;
					}
				break;
				case 'to_mail':
					/*$mailer = new ClassMail($post['question_author_mail']);*/
				break;
				case 'no_comment':
				case 'active':
				case 'answered':
				case 'question_author_to_mail':
				case 'question_author_private':
					if($value == true){
						$question[$key] = 1;
					} else {
						$question[$key] = 0;
					}
				break;

					/*$mailer = new ClassMail($post['question_author_mail']);*/
				case 'content_id':
					$content_id = $value;
				break;
				default:
					$question[$key] = $value;
				break;
			}
		}

		if($question['answer_author_id'] == 0){
			$sql_author = 'INSERT INTO '.DB_PREFIX.'faq_answer SET ?u';
			$this->db->query($sql_author, $author);
			$question['answer_author_id'] = $this->db->insertId();
		}

		$sql_question = 'INSERT INTO '.DB_PREFIX.'faq SET ?u';
		$this->db->query($sql_question, $question);
		$question_id = $this->db->insertId();

		$sql_count = 'UPDATE `'.DB_PREFIX.'category` SET `count` = `count` + 1 WHERE `id` = ?i';
		$this->db->query($sql_count, $question['category_id']);

		$url = $this->db->getOne('SELECT CONCAT(\'..\', u.uri) as url FROM '.DB_PREFIX.'category c, '.DB_PREFIX.'url u WHERE c.id = ?i AND u.view_id = c.id', $question['category_id']);

		if($question_id){
			return array('success' => true, 'redirect' => $url);
		} else {
			return false;
		}
	}

	public function updateContent($post){
		$author = array();
		$question = array();
		foreach($post as $key => $value){
			$value = trim($value);

			switch ($key) {
				case 'caption':
				case 'name':
					$author[$key] = $value;
				break;
				case 'date_creat':
					$value = trim($value);
					if(!isset($value) || $value == '' || $value == null){
						$question[$key] = date('Y-m-d');
					} else {
						$question[$key] = $value;
					}
				break;
				case 'to_mail':
					if($value == true){
						$to_mail = true;
					} else {
						$to_mail = false;
					}
				break;
				case 'no_comment':
				case 'active':
				case 'answered':
				case 'question_author_to_mail':
				case 'question_author_private':
					if($value == true){
						$question[$key] = 1;
					} else {
						$question[$key] = 0;
					}
				break;
				case 'content_id':
					$content_id = $value;
				break;
				default:
					$question[$key] = $value;
				break;
			}
		}

		if($question['answer_author_id'] == 0){
			$sql_author = 'INSERT INTO '.DB_PREFIX.'faq_answer SET ?u';
			$this->db->query($sql_author, $author);
			$question['answer_author_id'] = $this->db->insertId();
		}

		/*TO MAILER*/
		if($question['question_author_to_mail'] == 1 && $to_mail == true){

			$mailer = new ClassMail();
			$mailer->setFrom('Башкирская организация Профсоюза');
			$mailer->setTo($post['question_author_mail']);

			if($question['answered'] == 1){
				$mailer->setSubject('Ответ с сайта eduprofrb.ru на вопрос номер ' . $content_id);

				$message = 'Получен ответ на ваш вопрос с сайта eduprofrb.ru<br/><br/>';
				$message .= '<b>Ваш вопрос:</b><br/>' . $question['question'] . '<br/><br/>';
				$message .= '<b>Ответ:</b><br/>' . $question['answer'] . '<br/><br/><br/><br/>';
				$message .= '<i style="font-size:90%;color:#8e8e8e;">Данное письмо сгенерировано сайтом, отвечать или задавать дополнительные вопросы на этот ящик не нужно!</i>';
			} else {
				$mailer->setSubject('Действия с сайта eduprofrb.ru на вопрос номер ' . $content_id);

				$answer_author = $this->db->getOne('SELECT name FROM '.DB_PREFIX.'faq_answer WHERE id = ?i', $question['answer_author_id']);

				$message = 'Здравствуйте, '.$question['question_author_name'].', ваш вопрос №'.$content_id.' передан на рассмотрение специалисту. '.$answer_author.'<br/><br/>';
			}
			
			$mailer->setMessage($message);
			$mailer->sendMail();
		}

		$category_id = $this->db->getOne('SELECT category_id FROM '.DB_PREFIX.'faq WHERE id = ?i', $content_id);

		if($question['category_id'] != $category_id){
			$sql_count_minus = 'UPDATE `'.DB_PREFIX.'category` SET `count` = `count` - 1 WHERE `id` = ?i';
			$sql_count_plus = 'UPDATE `'.DB_PREFIX.'category` SET `count` = `count` + 1 WHERE `id` = ?i';
			
			$this->db->query($sql_count_minus, $category_id);
			$this->db->query($sql_count_plus, $question['category_id']);
		}

		$sql_question = 'UPDATE '.DB_PREFIX.'faq SET ?u WHERE id = ?i';
		$this->db->query($sql_question, $question, $content_id);

		$url = $this->db->getOne('SELECT CONCAT(\'..\', u.uri) as url FROM '.DB_PREFIX.'category c, '.DB_PREFIX.'url u WHERE c.id = ?i AND u.view_id = c.id', $question['category_id']);

		if($url){
			return array('success' => true, 'redirect' => $url);
		} else {
			return false;
		}
	}
	
	public function getContents($arg){
		$sql = 'SELECT f.id, f.date_creat, c.title, CONCAT(\'..\', u.uri) as url, f.question, f.answered, f.active, f.no_comment FROM '.DB_PREFIX.'faq f, '.DB_PREFIX.'category c, '.DB_PREFIX.'url u WHERE';

		$sql_count = 'SELECT count(*) FROM '.DB_PREFIX.'faq f, '.DB_PREFIX.'category c WHERE';
		if(!$arg['category_id']){
			$sql .= ' f.category_id is not null';
			$sql_count .= ' f.category_id is not null';
		} else {
			$sql .= ' f.category_id = '.$arg['category_id'];
			$sql_count .= ' f.category_id = '.$arg['category_id'];
		}

		$sql .= ' AND c.id = f.category_id AND u.view_id = f.category_id';
		$sql_count .= ' AND c.id = f.category_id';

		if($arg['filter']){
			$sql .= ' AND f.answered = 0';
			$sql_count .= ' AND f.answered = 0';
		}

		if($arg['author_id']){
			$sql .= ' AND f.answer_author_id = ' . $arg['author_id'];
			$sql_count .= ' AND f.answer_author_id = ' . $arg['author_id'];
		}

		if($arg['order']){
			$sql .= ' ORDER BY '.$arg['order'].' '.$arg['sort'];
		} else {
			' ORDER BY date_creat '.$arg['sort'];
		}

		$sql .= ' LIMIT ?i,?i';

		$result = $this->db->getAll($sql, $arg['page'], $arg['limit']);
		$count = $this->db->getOne($sql_count);

		foreach($result as $key => $value){
			$date_c = new DateTime($value['date_creat']);
			$result[$key]['date_creat'] = $date_c->format('d-m-Y');
		}

		$content = array(
			'content' => $result,
			'count' => $count
		);

		return $content;
	}

	public function getContentEdit($content_id){
		$sql = 'SELECT * FROM '.DB_PREFIX.'faq WHERE id = ?i';
		$question = $this->db->getRow($sql, $content_id);

		if($question['question_docs'] != ''){
			$question_docs = json_decode($question['question_docs'], true);
		} else {
			$question_docs = null;
		}

		$date = new DateTime($question['date_creat']);
		$date_creat = $date->format('Y-m-d');

		$faq = array(
			'category_id' => $question['category_id'],
			'question' => $question['question'],
			'question_docs' => $question_docs,
			'question_author_bilet' => $question['question_author_bilet'],
			'question_author_name' => $question['question_author_name'],
			'question_author_from' => $question['question_author_from'],
			'question_author_work' => $question['question_author_work'],
			'question_author_mail' => $question['question_author_mail'],
			'question_author_to_mail' => $question['question_author_to_mail'],
			'question_author_private' => $question['question_author_private'],
			'answer' => $question['answer'],
			'author_id' => $question['answer_author_id'],
			'date_creat' => $date_creat,
			'answered' => $question['answered'],
			'active' => $question['active'],
			'no_comment' => $question['no_comment']
		);

		return $faq;
	}

	public function upActive($arg){
		if($arg['a_type'] == 'comment'){
			$sql = 'UPDATE '.DB_PREFIX.'faq_comments SET active = ?i WHERE id = ?i';
		} else {
			$sql = 'UPDATE '.DB_PREFIX.'faq SET active = ?i WHERE id = ?i';
		}
		
		$this->db->query($sql, $arg['active'], $arg['content_id']);

		return true;
	}

	public function upAnswered($arg){
		$sql = 'UPDATE '.DB_PREFIX.'faq SET answered = ?i WHERE id = ?i';
		$this->db->query($sql, $arg['answered'], $arg['content_id']);

		return true;
	}

	public function deleteContent($content_id){

		if(is_array($content_id)){
			foreach($content_id as $key => $value){
				$category_id = $this->db->getOne('SELECT category_id FROM '.DB_PREFIX.'faq WHERE id = ?i', $value);

				$sql_count = 'UPDATE `'.DB_PREFIX.'category` SET `count` = `count` - 1 WHERE `id` = ?i';
				$this->db->query($sql_count, $category_id);

				$this->db->query('DELETE FROM '.DB_PREFIX.'faq WHERE id = ?i', $value);
			}
		} else {
			$category_id = $this->db->getOne('SELECT category_id FROM '.DB_PREFIX.'faq WHERE id = ?i', $content_id);

			$sql_count = 'UPDATE `'.DB_PREFIX.'category` SET `count` = `count` - 1 WHERE `id` = ?i';
			$this->db->query($sql_count, $category_id);

			$this->db->query('DELETE FROM '.DB_PREFIX.'faq WHERE id = ?i', $content_id);
		}
		
		return true;
	}

	public function deleteComment($content_id){
		$sql = 'DELETE FROM '.DB_PREFIX.'faq_comments WHERE ';

		if(is_array($content_id)){
			$sql .= 'id IN (?a)';
		} else {
			$sql .= 'id = ?i';
		}

		$this->db->query($sql, $content_id);
		
		return true;
	}

	public function addQuestion($post){
		$question = array();

		foreach($post as $key => $value){
			switch ($key) {
				case 'not': 
				case 'docs':
				case 'undefined':
				break;
				case 'question_docs':
					$question[$key] = json_encode($value);
				break;
				case 'active':
				case 'answered':
				case 'question_author_private':
					if($value == true){
						$question[$key] = 1;
					} else {
						$question[$key] = 0;
					}
				break;
				case 'question_data_personal' : break;
				case 'question_data_membership': break;
				default:
					$question[$key] = $value;
				break;
			}
		}

		$question['date_creat'] = date('Y-m-d H:i:s');

		$sql_question = 'INSERT INTO '.DB_PREFIX.'faq SET ?u';
		$this->db->query($sql_question, $question);
		$question_id = $this->db->insertId();

		$sql_count = 'UPDATE `'.DB_PREFIX.'category` SET `count` = `count` + 1 WHERE `id` = ?i';
		$this->db->query($sql_count, $question['category_id']);

		if(isset($question_id)){
			return array('question_id'=>$question_id, 'data'=>$question);
		} else {
			return false;
		}
	}

	public function addQuestionFile($file){
		$uploaddir = $_SERVER['DOCUMENT_ROOT'] . '/uploads/files/faq/';

		$files = explode('.', $file['name']);
		$file_format = array_pop($files);
		$file_name = implode('.', $files);
		$filename = $this->translit($file_name) . '.' . $file_format;

		$uploadfile = $uploaddir . basename($filename);
		$path = pathinfo($uploadfile);

		if(file_exists($uploadfile)){
			$upload_path = '../uploads/files/faq/' . basename($path['filename'] . '_' . date('hms') . '.' . $path['extension']);
			$uploadfile = $uploaddir . basename($path['filename'] . '_' . date('hms') . '.' . $path['extension']);
		} else {
			$upload_path = '../uploads/files/faq/' . basename($path['filename'] . '.' . $path['extension']);
			$uploadfile = $uploaddir . basename($path['filename'] . '.' . $path['extension']);
		}

		if (move_uploaded_file($file['tmp_name'], $uploadfile)) {
			return array('title' => $file['name'], 'path' => $upload_path);
		} else {
		    return 'Ошибка, файл не загружен!';
		}
	}

	public function addComments($post){
		$comments = array();

		foreach($post as $key => $value){
			$value = trim($value);

			switch ($key) {
				case 'content_id':
					$content_id = $value;
				break;
				case 'g-recaptcha-response':
					$secret = '6Lf7LiYUAAAAAKF0N2NrCLjJHvXQGy2N68v7x33p';
					$response = false;
					$reCaptcha = new ReCaptcha($secret);

					if ($_POST["g-recaptcha-response"]) {
						$response = $reCaptcha->verifyResponse(
					        $_SERVER["REMOTE_ADDR"],
					        $value
					    );
					}
				break;
				default:
					$comments[$key] = $value;
				break;
			}
		}

		$comments['date_creat'] = date('Y-m-d H:i:s');
		$comments['active'] = 0;

		$admin = $this->isAdmin();
		if(!empty($admin['name'])){
			$comments['user_id'] = $admin['id'];
			$comments['active'] = 1;
		}

		if($response && $response->success){
			$sql_comments = 'INSERT INTO '.DB_PREFIX.'faq_comments SET ?u';
			$this->db->query($sql_comments, $comments);
			$comments_id = $this->db->insertId();
		}

		if(isset($comments_id)){
			return true;
		} else {
			return false;
		}
	}

	public function getComments($arg){
		$select = 'SELECT fc.id, f.id as faq_id, fc.date_creat, fc.author, fc.text, f.question, f.answer, fc.active FROM '.DB_PREFIX.'faq_comments fc, '.DB_PREFIX.'faq f';
		$where = ' WHERE f.id = fc.faq_id';

		switch($arg['filter']){
			case 'admin_comment':
				$where .= ' AND fc.user_id = 1';
			break;
			case 'not_moder':
				$where .= ' AND fc.active = 0';
			break;
			case 'is_moder':
				$where .= ' AND fc.active = 1';
			break;
			default : break;
		}

		if($arg['order'] == 'faq_id'){
			$order = ' ORDER BY f.id';
		} else {
			$order = ' ORDER BY fc.'.$arg['order'];
		}
		
		$sort = ' '.$arg['sort'];
		$limit = ' LIMIT ?i,?i';

		$sql = $select . $where . $order . $sort . $limit;

		$comments = $this->db->getAll($sql, $arg['page'], $arg['limit']);

		return $comments;
	}
}
?>