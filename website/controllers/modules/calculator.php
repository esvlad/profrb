<?
class ControllerModulesCalculator extends MVC{
	public function index(){
		$data = [];

		$calculator = new Action(MODEL,'modules/calculator');

		$data['calculator'] = $calculator->loader('getCalculator');

		return $this->render(THEME_NAME . '/template/modules/calculator/view.tpl', $data);
	}
}
?>