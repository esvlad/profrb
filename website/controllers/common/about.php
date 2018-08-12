<?php
class ControllerCommonAbout extends MVC{
	public function index($arg = array()){
		$data = array();

		$structure = new Action(MODEL, 'setting/structure');

		$about = new Action(MODEL, 'common/static');
		$content = $about->loader('getStaticContent', $arg['id']);

		$sect_setting = $structure->loader('getSetting', $arg['setting_id']);

		$data['sect_class'] = $sect_setting['class'];
		$data['sect_title'] = $arg['title'];

		if(!empty($arg['page']['class'])) $data['sect_class'] .= ' '.$arg['page']['class'];

		$data['content'] = $content;

		return $this->render(THEME_NAME . '/template/main/about.tpl', $data);
	}
	
}
?>