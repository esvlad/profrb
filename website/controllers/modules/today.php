<?php
class ControllerModulesToday extends MVC{
	public function index($arg = array()){
		$data = array();

		if($arg['page_setting']['name'] == 'home') return $this->get_home();

		$page = isset($_GET['page']) ? $_GET['page'] : 1;

		$today = new Action(MODEL, 'modules/today');
		
		$data['content'] = $today->loader('getContents', $page);
		$_count = $today->loader('getTodayCount');

		if($_count > 10){
			$pagination = new Paginator();
			$pagination->total = $_count;
			$pagination->limit = 10;
			$pagination->url = '../today';
			$pagination->page = $page;

			$data['paginator'] = $pagination->render();
		}

		return $this->render(THEME_NAME . '/template/modules/today/page.tpl', $data);
	}

	public function get_home($arg = array()){
		$data = array();

		$today = new Action(MODEL, 'modules/today');
		$data['content'] = $today->loader('getContentsNowDay');

		if(empty($data['content'])) return false;

		return $this->render(THEME_NAME . '/template/modules/today/home.tpl', $data);
	}
	
}
?>