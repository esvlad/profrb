<?
class ControllerFaqViewFaq extends MVC{
	public function index($arg = array()){
		$data = array();

		$admin = $this->isAdmin();
		if(!empty($admin['name'])) $data['is_admin'] = true;

		if(isset($_GET['id'])){
			$fid = (int)$_GET['id'];

			return $this->get_faq_id($fid);
		};

		$structure = new Action(MODEL, 'setting/structure');
		$sect_setting = $structure->loader('getSetting', $arg['setting_id']);

		$data['arg'] = $arg;

		$faq_model = new Action(MODEL, 'faq/view');

		$limits = 20;

		$params = array();
		$params['category_id'] = isset($arg['view_id']) ? $arg['view_id'] : false;
		$params['limit'] = isset($_POST['limit']) ? $_POST['limit'] : $limits;
		$params['page'] = isset($_GET['page']) ? (($_GET['page'] - 1) * $limits) : 0;

		if(!empty($_GET['search'])){
			$questions = $faq_model->loader('getSearchContent', $_GET['search']);
		} else {
			$questions = $faq_model->loader('getContents', $params);
		}


		$data['category_count'] = $faq_model->loader('getCounter');

		$data['count'] = array($questions['count'], $limits);

		$data['category_id'] = isset($arg['view_id']) ? $arg['view_id'] : false;

		$content_model = new Action(MODEL, 'static/content');

		$category = $content_model->loader('getCategory', 0);

		function cmp($a, $b){ 
			return strnatcmp($a["params"], $b["params"]); 
		} 

		usort($category, "cmp"); 

		$data['category'] = $category;

		$data['contents'] = $questions['content'];

		$data['comments'] = !empty($questions['comments']) ? $questions['comments'] : null;

		if($questions['count'] > $limits){
			$pagination = new Paginator();
			$pagination->total = $questions['count'];
			$pagination->page = $params['page'];
			$pagination->limit = $params['limit'];
			$pagination->url = '..'.$questions['uri'];
			$pagination->page = isset($_GET['page']) ? $_GET['page'] : false;

			$data['paginator'] = $pagination->render();
		}

		return $this->render(THEME_NAME . '/template/faq/view.tpl', $data);
	}

	public function get_faq_id($id){
		$faq_model = new Action(MODEL, 'faq/view');

		$questions = $faq_model->loader('getContent', $id);

		$data['contents'] = $questions['content'];
		$data['comments'] = !empty($questions['comments']) ? $questions['comments'] : null;

		$data['category_count'] = $faq_model->loader('getCounter');
		$data['count'] = array($questions['count'], $limits);
		$data['category_id'] = isset($arg['view_id']) ? $arg['view_id'] : false;
		
		$content_model = new Action(MODEL, 'static/content');
		$category = $content_model->loader('getCategory', 0);

		function cmp($a, $b){ 
			return strnatcmp($a["params"], $b["params"]); 
		} 

		usort($category, "cmp"); 
		$data['category'] = $category;

		return $this->render(THEME_NAME . '/template/faq/view.tpl', $data);
	}

	public function filter(){
		if(empty($_POST)) return false;
		$admin = $this->isAdmin();
		if(!empty($admin['name'])) $data['is_admin'] = true;

		$doc_model = new Action(MODEL, 'docs/docs');

		$data = array();
		$params = array();
		$params['category_id'] = $_POST['category'];
		$params['page'] = isset($_POST['page']) ? ($_POST['page'] * $limits) : 0;
		$params['limit'] = isset($_POST['limit']) ? $_POST['limit'] : $limits;

		$data['contents'] = $doc_model->loader('getContents', $params);

		return $this->render(THEME_NAME . '/template/docs/page_ajax.tpl', $data);
	}

	public function search(){
		if(empty($_POST)) return false;
		$admin = $this->isAdmin();
		if(!empty($admin['name'])) $data['is_admin'] = true;

		$doc_model = new Action(MODEL, 'docs/docs');

		$search_text = $_POST['search'];

		$data['contents'] = $doc_model->loader('getSearchDocs', $search_text);

		return $this->render(THEME_NAME . '/template/docs/docs_search.tpl', $data);
	}
}
?>