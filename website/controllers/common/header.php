<?php

class ControllerCommonHeader extends MVC{
	public function index($arg = array()){
		$data = array();

		$data['page_class'] = $arg['page']['class'];
		$data['theme'] = $arg['theme'];
		
		#$search = new Action(CONTROLLER, 'modules/search');
		#$data['search'] = $search->loader('block', $data['search']);
		
		#$main_menu = new Action(CONTROLLER, 'common/menu');
		#$data['main_menu'] = $main_menu->loader();
		
		if(!empty($arg['admin'])){
			$data['level'] = $arg['admin'];
			$data['is_admin'] = true;
			$admin = new Action(CONTROLLER, 'admin/panel');
			$data['admin_panel'] = $admin->loader();
		}

		$content_model = new Action(MODEL, 'static/content');

		/*$faq = $content_model->loader('getCategory', 0);

		function cmp($a, $b){ 
			return strnatcmp($a["params"], $b["params"]); 
		} 

		usort($faq, "cmp"); 

		$data['c_faq'] = $faq;*/

		$docs = $content_model->loader('getCategory', 14);

		function sort_category_docs($a, $b){ 
			return strnatcmp($a["params"], $b["params"]); 
		} 

		usort($docs, "sort_category_docs"); 

		$data['c_docs'] = $docs;

		$data['page'] = $arg['page'];

		return $this->render(THEME_NAME . '/template/common/header.tpl', $data);
	}
	
	private function issetData($data, $value, $default = null){
		if(isset($data)){
			return $data;
		} else {
			if(isset($value)){
				return $value;
			} else {
				return $default;
			}			
		}
	}
	
}
?>