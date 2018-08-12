<?php
class ControllerCommonHome extends MVC{
	public function index(){
		$data = array();
		
		$header = new Action(CONTROLLER,'common/header');
		$data['header'] = $header->loader('index');
		
		$footer = new Action(CONTROLLER,'common/footer');
		$data['footer'] = $footer->loader('index');

		return $this->render(THEME_NAME . '/template/main/home.tpl', $data);
	}

	public function vision(){
		return $this->render(THEME_NAME . '/template/common/vision.tpl');
	}	
}

//
?>