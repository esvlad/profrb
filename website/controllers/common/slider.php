<?php
class ControllerCommonSlider extends MVC{
	public function index($arg = array()){
		$data = array();

		$structure = new Action(MODEL, 'setting/structure');

		$slide_action = new Action(MODEL, 'common/slider');
		$data['sliders'] = $slide_action->loader('getSliders');

		return $this->render(THEME_NAME . '/template/main/slider.tpl', $data);
	}
	
}
?>