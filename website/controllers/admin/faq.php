<?php
class ControllerAdminFaq extends MVC{

	public function add(){
		$data = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$faq_model = new Action(MODEL,'faq/crud');
		$data['category'] = $faq_model->loader('getCategory');

		$data['answer_author'] = $faq_model->loader('getAuthors');

		return $this->render(THEME_NAME . '/template/admin/faq/add.tpl', $data);
	}

	public function save(){
		$json = array();
		$data = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$faq_model = new Action(MODEL,'faq/crud');

		$result = $faq_model->loader('addContent', $_POST);

		if($result['success'] == true){
			$json = array(
				'success' => true,
				'redirect' => $result['redirect']
			);
		} else {
			$json['error'] = true;
		}

		echo json_encode($json);
	}

	public function view(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$view = new Action(MODEL, 'faq/crud');

		$limits = 20;

		$arg = array();
		$arg['category_id'] = (isset($_POST['category_id']) && $_POST['category_id'] != 0) ? $_POST['category_id'] : false;
		$arg['author_id'] = (isset($_POST['author_id']) && $_POST['author_id'] != 0) ? $_POST['author_id'] : false;
		$arg['filter'] = isset($_POST['filter']) ? $_POST['filter'] : false;
		$arg['type'] = $_POST['type'];
		$arg['limit'] = isset($_POST['limit']) ? $_POST['limit'] : $limits;
		$arg['page'] = isset($_POST['page']) ? (($_POST['page'] - 1) * $limits) : 0;
		$arg['order'] = isset($_POST['order']) ? $_POST['order'] : 'id';
		$arg['sort'] = isset($_POST['sort']) ? $_POST['sort'] : 'DESC';

		$content = $view->loader('getContents', $arg);

		$data['sort'] = $arg['sort'];
		$data['order'] = $arg['order'];

		$data['contents'] = $content['content'];

		$data['cats'] = $view->loader('getCategory', 0);
		$data['authors_answer'] = $view->loader('getAuthors');

		$data['category_id'] = $arg['category_id'];
		$data['author_id'] = $arg['author_id'];

		if($content['count'] > $arg['limit']){
			$pagination = new Paginator();
			$pagination->total = $content['count'];
			$pagination->limit = $arg['limit'];
			$pagination->url = '';
			$pagination->type = 'admin';
			$pagination->page = isset($_POST['page']) ? $_POST['page'] : false;

			$data['paginator'] = $pagination->render();
		}

		$data['count'] = $content['count'];
		$data['limit'] = $arg['limit'];

		$data['page'] = isset($_POST['page']) ? $_POST['page'] : 1;

		return $this->render(THEME_NAME . '/template/admin/faq/view.tpl', $data);
	}

	public function edit(){
		$data = array();
		$json = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$faq_model = new Action(MODEL,'faq/crud');

		$content_id = $_POST['data']['content_id'];

		$faq = $faq_model->loader('getContentEdit', $content_id);

		$data['content_id'] = $content_id;

		foreach($faq as $key => $value){
			$data[$key] = $value;
		}

		$data['category'] = $faq_model->loader('getCategory');
		$data['answer_author'] = $faq_model->loader('getAuthors');

		return $this->render(THEME_NAME . '/template/admin/faq/edit.tpl',$data);
	}

	public function update(){
		$json = array();
		$data = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$faq_model = new Action(MODEL,'faq/crud');

		$result = $faq_model->loader('updateContent', $_POST);

		if($result['success'] == true){
			$json = array(
				'success' => true,
				'redirect' => $result['redirect']
			);
		} else {
			$json['error'] = true;
		}

		echo json_encode($json);
	}

	public function delete(){
		$data = array();
		$json = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$faq_model = new Action(MODEL,'faq/crud');

		if(!empty($_POST['cid'])){
			$result = $faq_model->loader('deleteContent', $_POST['cid']);
		}

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}

	public function deletefield(){
		$fid = $_POST['fid'];

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;
		
		$remove = new Action(MODEL, 'faq/crud');
		$result = $remove->loader('removeFieldFile', $fid);

		if($result == true){
			$json = array('success' => true);
		} else {
			$json = array('error' => $result);
		}
		
		return json_encode($json);
	}

	public function active(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$json = array();

		$updater = new Action(MODEL,'faq/crud');
		$active = $updater->loader('upActive', $_POST);

		if($active === true){
			$json['success'] = true;
		}

		echo json_encode($json);
	}

	public function answered(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$json = array();

		$updater = new Action(MODEL,'faq/crud');
		$answered = $updater->loader('upAnswered', $_POST);

		if($answered === true){
			$json['success'] = true;
		}

		echo json_encode($json);
	}

}
?>