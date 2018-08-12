<?
class ControllerGeoSearch extends MVC{
	public function index($arg = array()){
		$data = array();
	
		$geo_model = new Action(MODEL, 'geo/content');

		$data['content'] = $geo_model->loader('getContentMaps');

		$data['area_city'] = $geo_model->loader('getAreaCity');

		return $this->render(THEME_NAME . '/template/geo/page.tpl', $data);
	}

	public function modal(){
		$data = array();

		$geo_model = new Action(MODEL, 'geo/content');

		$data['contents'] = $geo_model->loader('getModalGeo', (int)$_POST['content_id']);

		return $this->render(THEME_NAME . '/template/geo/modal_ajax.tpl', $data);
	}
}
?>