<?php
class ControllerGeoCity extends MVC{
	public function index($arg = array()){
		$data = array();

		$admin = $this->isAdmin();
		if(!empty($admin['name'])) $data['is_admin'] = true;

		$structure = new Action(MODEL, 'setting/structure');
		$sect_setting = $structure->loader('getSetting', $arg['setting_id']);

		$data['sect_class'] = $sect_setting['class'];
		$data['sect_title'] = $arg['title'];

		if(!empty($arg['page']['class'])) $data['sect_class'] .= ' '.$arg['page']['class'];

		if(!empty($arg['view_id'])) $category_id = $arg['view_id'];

		$geo_model = new Action(MODEL, 'geo/content');
		$geo = $geo_model->loader('getContent', $category_id);

		$area_city = $geo_model->loader('getAreaCity');

		$data['category_id'] = $category_id;
		$data['area_city'] = $area_city;
		$data['content'] = $geo['content'];
		$data['modal'] = $geo['modal'];
		$data['filters'] = $geo['filters'];

		return $this->render(THEME_NAME . '/template/geo/city.tpl', $data);
	}	
}
?>