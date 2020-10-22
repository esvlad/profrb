<?
class ControllerModulesCalculator extends MVC{
	public function index(){
		return $this->render(THEME_NAME . '/template/modules/calculator/view.tpl');
	}
}
?>