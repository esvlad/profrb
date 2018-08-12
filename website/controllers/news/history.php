<?php
class ControllerNewsHistory extends MVC{
	public function index($arg = array()){
		$data = array();

		$admin = $this->isAdmin();
		if(!empty($admin['name'])) $data['is_admin'] = true;

		$structure = new Action(MODEL, 'setting/structure');
		$sect_setting = $structure->loader('getSetting', $arg['setting_id']);

		$data['sect_class'] = $sect_setting['class'];
		$data['sect_title'] = $arg['title'];

		if(!empty($arg['page']['class'])) $data['sect_class'] .= ' '.$arg['page']['class'];

		$history_model = new Action(MODEL, 'news/history');
		$history = $history_model->loader('getContent', $arg['id']);

		$data['content'] = $history['content'];
		$data['fields'] = $history['fields'];

		$data['more_content'] = $history_model->loader('getContentsAll', $arg['id']);
		
		#$data['get'] = $_GET;

		return $this->render(THEME_NAME . '/template/news/history.tpl', $data);
	}

	public function load(){
		$data = array();

		$admin = $this->isAdmin();
		if(!empty($admin['name'])) $data['is_admin'] = true;

		$history_model = new Action(MODEL, 'news/history');

		$content_id = (int)$_POST['cid'];
		$data['content_id'] = $content_id;
		$data['fields'] = $history_model->loader('getLoadContent', $content_id);

		return $this->render(THEME_NAME . '/template/news/history_ajax.tpl', $data);
	}
}
?>