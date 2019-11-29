<?php
class ControllerAdminContent extends MVC{
	public function index($arg = array()){
		$data = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		return $this->render(THEME_NAME . '/template/admin/panel.tpl', $data);
	}

	public function add(){
		$data = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$data['user_level'] = $admin['level'];

		if($_POST['type'] == 'geo_page' && $admin['org_id'] != 0){
			return false;
		} else {
			$add_content = new Action(MODEL,'admin/structure');
			$data['content'] = $add_content->loader('getStructureContent', $_POST['type']);

			return $this->render(THEME_NAME . '/template/admin/content/add/'.$_POST['type'].'.tpl',$data);
		}
	}

	public function save(){
		$json = array();
		$data = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		if(str_word_count($_GET['type'], 0) > 1) exit('Не пытайтесь обмануть систему!');

		$data['type'] = htmlspecialchars($_GET['type']);

		foreach ($_POST as $key => $value) {
			$data['content'][$key] = $value;
		}

		$content = new Action(MODEL, 'admin/save');
		$result = $content->loader('addContent', $data);

		if($result['success'] === true){
			$data['redirect'] = $result['redirect'];
			return $this->render(THEME_NAME . '/template/admin/content/add/success.tpl', $data);
		}

		if($json['success']){
			unset($json['error']);
		}

		if($result['redirect']){
			$json['redirect'] = $result['redirect'];
			return $this->render(THEME_NAME . '/template/admin/content/add/success.tpl',$json);
		} else {
			return true;
		}
	}

	public function view(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$view = new Action(MODEL, 'admin/structure');

		$arg = array();
		$arg['type'] = $_POST['type'];
		$arg['limit'] = isset($_POST['limit']) ? $_POST['limit'] : 20;
		$arg['page'] = isset($_POST['page']) ? (((int)$_POST['page'] - 1) * $arg['limit']) : 0;
		$arg['order'] = isset($_POST['order']) ? $_POST['order'] : 'id';
		$arg['sort'] = isset($_POST['sort']) ? $_POST['sort'] : 'DESC';
		$arg['user'] = $admin;

		$c_type = $view->loader('getContentType', $arg['type']);
		$data['content_type'] = isset($c_type['title']) ? $c_type['title'] : 'Все';
		$data['c_type'] = $arg['type'];
		$data['sort'] = $arg['sort'];
		$data['order'] = $arg['order'];

		if($arg['type'] == 'docs'){
			$arg['category_id'] = (isset($_POST['category_id']) && $_POST['category_id'] != 0) ? $_POST['category_id'] : false;
			$data['category_id'] = $arg['category_id'];

			$content_model = new Action(MODEL, 'static/content');
			$data['cats'] = $content_model->loader('getCategory', 14);
		}

		if(!empty($_POST['docs_populars'])){
			$docs_model = new Action(MODEL, 'docs/docs');
			
			$content = $docs_model->loader('getPopularDocsAdmin', 14);

			$data['populars'] = true;
		} else {
			$content = $view->loader('getContents', $arg);
		}

		$data['contents'] = $content['content'];

		if($content['count'] > $arg['limit']){
			$pagination = new Paginator();
			$pagination->total = $content['count'];
			$pagination->page = $arg['page'];
			$pagination->limit = $arg['limit'];
			$pagination->url = '';
			$pagination->type = 'admin';
			$pagination->page = isset($_POST['page']) ? $_POST['page'] : false;

			$data['paginator'] = $pagination->render();
		}

		$data['ccc'] = $content['count'];
		$data['lll'] = $arg['limit'];

		$data['user'] = $admin;

		return $this->render(THEME_NAME . '/template/admin/content/view.tpl',$data);
	}

	public function edit(){
		$data = array();
		$json = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$updater = new Action(MODEL,'admin/update');

		if($_POST['data']['data_event'] == 'active'){
			$data = $_POST['data'];
			$active = $updater->loader('upActive', $data);

			if($active == true){
				$json['success'] = true;
			}

			return json_encode($json);
		} else if($_POST['data']['data_event'] == 'edit'){
			$content_id = $_POST['data']['content_id'];

			$content_type_name = $updater->loader('getContentTypeName', $content_id);

			$content = $updater->loader('getContentEdit', $content_id);

			$data = array(
				'content_id' => $content_id,
				'content' => $content['content'],
				'fields' => $content['fields']
			);

			if(isset($content['field_types'])){
				$data['field_types'] = $content['field_types'];
			}

			if(isset($content['view_modal'])){
				$data['field_group'] = $content['view_modal'];
			}

			if(isset($content['category'])){
				$data['category'] = $content['category'];
			}

			if(isset($content['filters'])){
				$data['filters'] = $content['filters'];
			}

			if(isset($content['geo_id'])){
				$data['geo_id'] = $content['geo_id'];
				$data['geo_objects'] = $content['geo_objects'];
			}

			$data['user_level'] = $admin['level'];

			return $this->render(THEME_NAME . '/template/admin/content/edit/'.$content_type_name.'.tpl',$data);
		}
	}

	public function save_update(){
		$json = array();
		$data = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		if(str_word_count($_GET['type'], 0) > 1) exit('Не пытайтесь обмануть систему!');

		$data['type'] = htmlspecialchars($_GET['type']);

		foreach ($_POST as $key => $value) {
			$data['content'][$key] = $value;
		}

		$content = new Action(MODEL, 'admin/save');
		$result = $content->loader('updateContent', $data);

		if($result['success'] === true){
			$data['redirect'] = $result['redirect'];
			return $this->render(THEME_NAME . '/template/admin/content/add/success.tpl', $data);
		}

		if($json['success']){
			unset($json['error']);
		}

		if($result['redirect']){
			$data['redirect'] = $result['redirect'];
			return $this->render(THEME_NAME . '/template/admin/content/add/success.tpl',$data);
		} else {
			return true;
		}
	}

	public function delete(){
		$data = array();
		$json = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$updater = new Action(MODEL,'admin/update');

		if(!empty($_POST['cid'])){
			$cid = (int)$_POST['cid'];
		}

		$result = $updater->loader('deleteContent', $cid);

		if(!empty($result['success'])){
			$json['success'] = true;

			return json_encode($json);
		} else {
			return false;
		}
	}

	public function deletefield(){
		$fid = $_POST['fid'];

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;
		
		$remove = new Action(MODEL, 'setting/upload');
		$result = $remove->loader('removeFieldFile', $fid);

		if($result == true){
			$json = array('success' => true);
		} else {
			$json = array('error' => $result);
		}
		
		return json_encode($json);
	}

	public function addgroup(){
		$data = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$data['key_group'] = $_POST['key_group'];
		$data['key'] = $_POST['key'];

		return $this->render(THEME_NAME . '/template/admin/content/add/field_group/'.$_POST['type'].'.tpl',$data);
	}

	public function addField(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$data = array();

		$data['key'] = $_POST['key'];

		return $this->render(THEME_NAME . '/template/admin/content/add/fields/'.$_POST['type'].'.tpl',$data);
	}
}
?>