<?php
class ControllerCommonEvents extends MVC{
	public function index($arg = array()){
		$data = array();

		$structure = new Action(MODEL, 'setting/structure');

		$sect_setting = $structure->loader('getSetting', $arg['setting_id']);

		$data['sect_class'] = $sect_setting['class'];
		$data['sect_title'] = $arg['title'];

		if(!empty($arg['page']['class'])) $data['sect_class'] .= ' '.$arg['page']['class'];

		$events = new Action(MODEL, 'common/events');
		$data['events'] = $events->loader('getContents', $arg['id']);

		$data['daterange'] = $events->loader('getCalend');

		if(empty($data['events'])) return false;

		return $this->render(THEME_NAME . '/template/main/events.tpl', $data);
	}

	/*public function save(){
		$data = $_POST;

		echo '<pre>';
		print_r($data);
		echo '</pre>';
	}*/
	
}
?>