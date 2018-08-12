<?
class ControllerCommonSearch extends MVC{
	public function index($arg = array()){
		$data = array();

		$search_model = new Action(MODEL, 'common/search');

		$data['arg'] = $arg;
		if(isset($_GET['search'])){
			$data['post'] = $_GET['search'];
			$params['search'] = $_GET['search'];
		}

		if(isset($_POST['type'])){
			$params['type'] = $_POST['type'];
		}

		$data['search'] = $search_model->loader('getSearch', $params);

		return $this->render(THEME_NAME . '/template/common/search.tpl', $data);
	}
}
?>