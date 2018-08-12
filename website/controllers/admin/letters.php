<?
class ControllerAdminLetters extends MVC{
	public function view(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$view = new Action(MODEL, 'modules/letter');

		$limits = 50;

		$arg = array();
		
		$arg['limit'] = isset($_POST['limit']) ? $_POST['limit'] : $limits;
		$arg['page'] = isset($_POST['page']) ? (($_POST['page'] - 1) * $limits) : 0;
		$arg['order'] = isset($_POST['order']) ? $_POST['order'] : 'id';
		$arg['sort'] = isset($_POST['sort']) ? $_POST['sort'] : 'DESC';

		$data['contents'] = $view->loader('getLetters', $arg);
		$count = $view->loader('getCountLetters');

		$data['sort'] = $arg['sort'];
		$data['order'] = $arg['order'];

		if($count > $arg['limit']){
			$pagination = new Paginator();
			$pagination->total = $count;
			$pagination->limit = $arg['limit'];
			$pagination->url = '';
			$pagination->type = 'admin';
			$pagination->page = isset($_POST['page']) ? $_POST['page'] : false;

			$data['paginator'] = $pagination->render();
		}

		$data['page'] = isset($_POST['page']) ? $_POST['page'] : 1;

		return $this->render(THEME_NAME . '/template/admin/letters/view.tpl', $data);
	}

	public function delete(){
		$data = array();
		$json = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$faq_model = new Action(MODEL, 'modules/letter');

		if(!empty($_POST['ids'])){
			$result = $faq_model->loader('deleteLetters', $_POST['ids']);
		}

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}
}
?>