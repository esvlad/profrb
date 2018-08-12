<?php
class ControllerNewsMain extends MVC{
	public function index($arg = array()){
		$data = array();

		$admin = $this->isAdmin();
		if(!empty($admin['name'])) $data['is_admin'] = true;

		/*$structure = new Action(MODEL, 'setting/structure');
		$sect_setting = $structure->loader('getSetting', $arg['setting_id']);

		$data['sect_class'] = $sect_setting['class'];
		$data['sect_title'] = $arg['title'];

		if(!empty($arg['page']['class'])) $data['sect_class'] .= ' '.$arg['page']['class'];

		$history_model = new Action(MODEL, 'news/history');
		$history = $history_model->loader('getContent', $arg['id']);

		$data['content'] = $history['content'];
		$data['fields'] = $history['fields'];

		$data['more_content'] = $history_model->loader('getContentsAll', $arg['id']);*/

		return $this->render(THEME_NAME . '/template/news/main.tpl', $data);
	}
}
?>