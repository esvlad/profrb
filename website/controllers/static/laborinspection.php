<?php
class ControllerStaticLaborinspection extends MVC{
	public function index($arg = array()){
		$data = array();

		$admin = $this->isAdmin();
		if(!empty($admin['name'])) $data['is_admin'] = true;

		$structure = new Action(MODEL, 'setting/structure');
		$sect_setting = $structure->loader('getSetting', $arg['setting_id']);

		$data['sect_class'] = $sect_setting['class'];
		$data['sect_title'] = $arg['title'];

		if(!empty($arg['page']['class'])) $data['sect_class'] .= ' '.$arg['page']['class'];

		$laborinspection_model = new Action(MODEL, 'static/laborinspection');
		$data['contents'] = $laborinspection_model->loader('getContents', $arg['id']);

		return $this->render(THEME_NAME . '/template/static/laborinspection.tpl', $data);
	}
}
?>