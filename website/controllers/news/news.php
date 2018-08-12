<?php
class ControllerNewsNews extends MVC{
	public function index($arg = array()){
		$admin = $this->isAdmin();
		if(!empty($admin['name'])) $data['is_admin'] = true;

		$data = array();

		$news_model = new Action(MODEL, 'news/news');
		
		$filter = $news_model->loader('getFilters');
		#$count_filter = $news_model->loader('getCountFilter', $filter);

		$data['filters'] = $filter;
		#$data['count_filter'] = $count_filter;

		$params = array();

		if($arg['page_setting']['name'] == 'home'){
			$limits = 8;
		} else {
			$limits = 16;
		}

		$params['limit'] = isset($_POST['limit']) ? $_POST['limit'] : $limits;
		$params['offset'] = isset($_GET['page']) ? (($_GET['page'] - 1) * $limits) : 0;

		$news = $news_model->loader('getContents', $params);

		$data['news_imortant'] = $news['important_news'];
		unset($news['important_news']);

		$c_count = $news['news_blocks']['count'];
		unset($news['news_blocks']['count']);

		if($c_count > $limits){
			$pagination = new Paginator();
			$pagination->total = $c_count;
			$pagination->page = $params['offset'];
			$pagination->limit = $params['limit'];
			$pagination->url = '../news';
			$pagination->page = isset($_GET['page']) ? $_GET['page'] : false;

			$data['paginator'] = $pagination->render();
		}

		$data['content'] = $news;

		$data['arg'] = $arg;
		$data['limits'] = $news['dtl'];

		if($arg['page_setting']['name'] == 'home'){
			return $this->render(THEME_NAME . '/template/news/main.tpl', $data);
		} else {
			return $this->render(THEME_NAME . '/template/news/news.tpl', $data);
		}
	}

	public function view($arg = array()){
		$data = array();

		$admin = $this->isAdmin();
		if(!empty($admin['name'])) $data['is_admin'] = true;

		$news_model = new Action(MODEL, 'news/news');
		$news = $news_model->loader('getContent', $arg['view_id']);

		$data['arg'] = $arg;
		$data['cid'] = $arg['view_id'];
		$data['content_title'] = $news['title'];
		$data['view_date'] = $news['view_date'];
		$data['fields'] = $news['fields'];
		$data['prev_news'] = $news['prev'];
		$data['next_news'] = $news['next'];

		return $this->render(THEME_NAME . '/template/news/news_view.tpl', $data);
	}

	public function load(){
		echo $this->render(THEME_NAME . '/template/news/news_ajax.tpl', $data);
	}
}
?>