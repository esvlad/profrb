<?php
class ControllerDocsPage extends MVC{
	public function index($arg = array()){
		$data = array();

		$admin = $this->isAdmin();
		if(!empty($admin['name'])) $data['is_admin'] = true;

		$structure = new Action(MODEL, 'setting/structure');
		$sect_setting = $structure->loader('getSetting', $arg['setting_id']);

		$data['sect_class'] = $sect_setting['class'];
		$data['sect_title'] = $arg['title'];

		if(!empty($arg['page']['class'])) $data['sect_class'] .= ' '.$arg['page']['class'];

		$doc_model = new Action(MODEL, 'docs/docs');

		$params = array();

		if(!empty($_COOKIE['filter_docs'])){
			$params['filter_id'] = $_COOKIE['filter_docs'];
			$data['filter_id'] = $_COOKIE['filter_docs'];
		}

		$limits = 20;
		$data['arg'] = $arg;
		$params['category_id'] = isset($arg['view_id']) ? $arg['view_id'] : false;
		$params['content_type_id'] = 14;

		$params['limit'] = isset($_POST['limit']) ? $_POST['limit'] : $limits;
		$params['offset'] = isset($_GET['page']) ? (($_GET['page'] - 1) * $limits) : 0;

		if(isset($_GET['search'])){
			$params['search'] = $_GET['search'];
			$data['contents'] = $doc_model->loader('getSearchDocs', $params);
			$uri = '/docs?search='.$_GET['search'];
		} else {
			$data['contents'] = $doc_model->loader('getContents', $params);

			if(isset($arg['view_id'])){
				$uri = $doc_model->loader('getNowCategoryUrl', $params['category_id']);
			} else {
				$uri = '/docs';
			}
		}

		$c_count = $data['contents']['count'];
		unset($data['contents']['count']);

		#$data['sql'] = $data['filter_id'];

		if($c_count > $limits){
			$pagination = new Paginator();
			$pagination->total = $c_count;
			$pagination->page = $params['offset'];
			$pagination->limit = $params['limit'];
			$pagination->url = '..'.$uri;
			$pagination->page = isset($_GET['page']) ? $_GET['page'] : false;

			$data['paginator'] = $pagination->render();
		}
		
		$data['category_id'] = $arg['view_id'];

		$content_model = new Action(MODEL, 'static/content');

		$category = $content_model->loader('getCategory', 14);
		$data['filters'] = $content_model->loader('getFilter', 14);

		function cmp($a, $b){ 
			return strnatcmp($a["params"], $b["params"]); 
		} 

		usort($category, "cmp"); 

		$data['category'] = $category;

		return $this->render(THEME_NAME . '/template/docs/page.tpl', $data);
	}

	public function filter(){

		if(empty($_POST)) return false;
		$admin = $this->isAdmin();
		if(!empty($admin['name'])) $data['is_admin'] = true;

		$doc_model = new Action(MODEL, 'docs/docs');

		$data = array();
		$params = array();
		$limits = 20;
		$params['category_id'] = (int)$_POST['category'];
		$params['content_type_id'] = 14;
		$params['limit'] = isset($_POST['limit']) ? $_POST['limit'] : $limits;
		$params['offset'] = isset($_GET['page']) ? (($_GET['page'] - 1) * $limits) : 0;
		if($_POST['filter'] != 'false'){
			$params['filter_id'] = $_POST['filter'];
		}

		$data['contents'] = $doc_model->loader('getContents', $params);

		if(isset($params['category_id'])){
			$uri = $doc_model->loader('getNowCategoryUrl', $params['category_id']);
		} else {
			$uri = '/docs';
		}

		$c_count = $data['contents']['count'];
		unset($data['contents']['count']);
		$data['c_count'] = $c_count;

		if($c_count > $limits){
			$pagination = new Paginator();
			$pagination->total = $c_count;
			$pagination->page = $params['offset'];
			$pagination->limit = $params['limit'];
			$pagination->url = '..'.$uri;
			$pagination->page = isset($_GET['page']) ? $_GET['page'] : false;

			$data['paginator'] = $pagination->render();
		}

		return $this->render(THEME_NAME . '/template/docs/page_ajax.tpl', $data);
	}

	public function paginator(){
		$post = $_POST['data'];

		$doc_model = new Action(MODEL, 'docs/docs');

		$params = array();
		$params['category_id'] = $arg['view_id'];
		$params['content_type_id'] = 14;
		$params['offset'] = 0;
		$params['limit'] = 20;

		$html['contents'] = $doc_model->loader('getContents', $params);

		return $this->render(THEME_NAME . '/template/docs/page_ajax.tpl', $data);
	}

	public function search(){
		if(empty($_POST)) return false;
		$admin = $this->isAdmin();
		if(!empty($admin['name'])) $data['is_admin'] = true;

		$doc_model = new Action(MODEL, 'docs/docs');

		$search_text = $_GET['search'];

		$data['contents'] = $doc_model->loader('getSearchDocs', $search_text);

		$content_model = new Action(MODEL, 'static/content');

		$category = $content_model->loader('getCategory', 14);
		$data['filters'] = $content_model->loader('getFilter', 14);

		function cmp($a, $b){ 
			return strnatcmp($a["params"], $b["params"]); 
		} 

		usort($category, "cmp"); 

		$data['category'] = $category;

		return $this->render(THEME_NAME . '/template/docs/search.tpl', $data);
	}
}
?>