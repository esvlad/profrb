<?php
class ControllerCommonPage extends MVC{
	public function index($arg = array()){
		$data = array();

		$my_theme = new Action(MODEL, 'setting/theme');
		$theme = $my_theme->loader('getTheme', 'active');
		$data['theme_name'] = $theme['name'];
		$page['theme'] = $theme;

		if($arg['page_id']){
			$data['sections'] = array();

			$sections_for_page = new Action(MODEL, 'setting/structure');
			$sections = $sections_for_page->loader('getSections', $arg['page_id']);

			$page_setting = $sections_for_page->loader('getPageSetting', $arg['page_id']);

			foreach ($sections as $sect) {
				$action = new Action(CONTROLLER, $sect['action'].'/'.$sect['name']);

				if($arg['view_id'] != null){
					$sect['view_id'] = $arg['view_id'];
				}

				$sect['page_setting'] = $page_setting;

				if($sect['name'] == 'news'){
					if($arg['view_id'] != null){
						$data['sections'][] = $action->loader('view', $sect);
					} else {
						$data['sections'][] = $action->loader('index', $sect);
					}
				} else {
					$data['sections'][] = $action->loader('index', $sect);
				}
			}

			$page['page'] = $page_setting;
			

			if($this->isAdmin() !== false){
				$page['admin'] = $this->isAdmin();
			}

			$header = new Action(CONTROLLER,'common/header');
			$data['header'] = $header->loader('index', $page);
			
			$footer = new Action(CONTROLLER,'common/footer');
			$data['footer'] = $footer->loader('index', $page);

			return $this->render(THEME_NAME . '/template/main/page.tpl', $data);
		} else {
			
			if($this->isAdmin() !== false){
				$page['admin'] = $this->isAdmin();
			}

			$header = new Action(CONTROLLER, 'common/header');
			$data['header'] = $header->loader('index', $page);
			
			$footer = new Action(CONTROLLER, 'common/footer');
			$data['footer'] = $footer->loader('index', $page);

			$docs_model = new Action(MODEL, 'static/content');

			$docs = $docs_model->loader('getCategory', 14);

			function scd($a, $b){ 
				return strnatcmp($a["params"], $b["params"]); 
			} 

			usort($docs, "scd"); 

			$data['c_docs'] = $docs;
			
			return $this->render(THEME_NAME . '/template/common/404.tpl', $data);
		}
	}	
}
?>