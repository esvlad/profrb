<?
class ControllerModulesCalculator extends MVC{
	public function index(){
		$calculator = new Action(MODEL,'modules/calculator');

		$data = $calculator->loader('getCalculator');

		return $this->render(THEME_NAME . '/template/modules/calculator/view.tpl', $data);
	}

	public function get_positions(){
		$json = array();

		$calculator = new Action(MODEL,'modules/calculator');

		$json['list'] = $calculator->loader('getPositions', ['job_id' => $_GET['job_id']]);
		$json['success'] = true;

		echo json_encode($json);
	}
}
?>