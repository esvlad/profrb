<?php
class ControllerCommonMenu extends MVC{
	public function index(){
		$data = array();
		
		#$menu = new Action(MODEL, 'common/menu');
		#$data['menu_links'] = $menu->loader('getMenu');

		return $this->render(THEME_NAME . '/template/common/menu.tpl', $data);
	}
	
}
?>