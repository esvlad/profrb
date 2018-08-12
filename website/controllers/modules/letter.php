<?
class ControllerModulesLetter extends MVC{
	public function index(){
		return $this->render(THEME_NAME . '/template/modules/letter/view.tpl');
	}

	public function subscribe(){
		$json = array();

		if($_POST['letter'] && $_POST['mail']){
			$letter_modal = new Action(MODEL, 'modules/letter');

			$result = $letter_modal->loader('setSubscribe', $_POST);

			if($result === true){
				$json['success'] = true;
			} else {
				$json['error'] = true;
				$json['error_message'] = 'Что-то пошло не так!';
			}
		} else {
			$json['error'] = true;
			$json['error_message'] = 'Что-то не заполнено!';
		}

		echo json_encode($json);
	}

	public function unsubscribe(){
		$data = array();

		$header = new Action(CONTROLLER,'common/header');
		$data['header'] = $header->loader('index', $page);
			
		$footer = new Action(CONTROLLER,'common/footer');
		$data['footer'] = $footer->loader('index', $page);

		if($_GET['code'] && $_GET['mail']){
			$letter_modal = new Action(MODEL, 'modules/letter');

			$getter = array('code' => $_GET['code'], 'mail' => $_GET['mail']);

			$data['unletter'] = $letter_modal->loader('upSubscribe', $getter);

			return $this->render(THEME_NAME . '/template/modules/letter/unletter.tpl',$data);
		} else {
			$data['error'] = true;

			return $this->render(THEME_NAME . '/template/modules/letter/unletter.tpl',$data);
		}
	}
}
?>