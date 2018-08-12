<?php
class ControllerAdminPanel extends MVC{
	public function index($arg = array()){
		$data = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$content_type = new Action(MODEL, 'admin/structure');
		$data['content_type'] = $content_type->loader('getContentTypeAll');
		$data['pages'] = $content_type->loader('getPageViews');
		$data['sections'] = $content_type->loader('getSections');

		$data['notification'] = $content_type->loader('getNotification');
		
		return $this->render(THEME_NAME . '/template/admin/panel.tpl', $data);
	}

	public function structure(){
		$data = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		if($_POST['type'] == 'content'){
			if($_POST['events'] == 'add'){
				return $this->render(THEME_NAME . '/template/admin/structure/addmaterials.tpl');
			}
		}

		if($_POST['type'] == 'field_type'){
			if($_POST['events'] == 'add'){
				return $this->render(THEME_NAME . '/template/admin/structure/add_field_type.tpl');
			}
		}

		if($_POST['type'] == 'section'){
			if($_POST['events'] == 'add'){
				$page = new Action(MODEL, 'admin/structure');
				$data['page'] = $page->loader('getPageViews');

				return $this->render(THEME_NAME . '/template/admin/structure/add_section.tpl', $data);
			}
		}

		if($_POST['type'] == 'page'){
			if($_POST['events'] == 'add'){
				return $this->render(THEME_NAME . '/template/admin/structure/add_page.tpl');
			}
		}
	}
}
?>