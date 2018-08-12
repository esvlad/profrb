<?php

class ControllerCommonFooter extends MVC{
	public function index($arg = array()){
		$data = array();

		$data['page_class'] = $arg['page']['class'];
		$data['theme'] = $arg['theme'];

		if(!empty($arg['admin'])){
			$data['is_admin'] = true;
		}

		$letter = new Action(CONTROLLER, 'modules/letter');
		$data['letter'] = $letter->loader();

		$data['page'] = $arg['page'];
		
		return $this->render(THEME_NAME . '/template/common/footer.tpl', $data);
	}
	
	private function issetData($data){
		if(isset($data)){
			return $data;
		} else {
			return null;
		}
	}
}

//echo 123;
?>