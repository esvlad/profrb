<?
class ControllerAdminComments extends MVC{
	public function view(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$view = new Action(MODEL, 'faq/crud');

		$limits = 20;

		$arg = array();
		$arg['filter'] = isset($_POST['filter']) ? $_POST['filter'] : 'all';
		$arg['limit'] = isset($_POST['limit']) ? $_POST['limit'] : $limits;
		$arg['page'] = isset($_POST['page']) ? ($_POST['page'] * $limits) : 0;
		$arg['order'] = isset($_POST['order']) ? $_POST['order'] : 'date_creat';
		$arg['sort'] = isset($_POST['sort']) ? $_POST['sort'] : 'desc';

		$data['contents'] = $view->loader('getComments', $arg);

		$data['sort'] = $arg['sort'];
		$data['order'] = $arg['order'];

		if($content['count'] > $arg['limit']){
			$pagination = new Paginator();
			$pagination->total = $content['count'];
			$pagination->limit = $arg['limit'];
			$pagination->url = '';
			$pagination->type = 'admin';
			$pagination->page = isset($_POST['page']) ? $_POST['page'] : false;

			$data['paginator'] = $pagination->render();
		}

		$data['page'] = isset($_POST['page']) ? $_POST['page'] : 1;

		return $this->render(THEME_NAME . '/template/admin/comments/view.tpl', $data);
	}

	public function delete(){
		$data = array();
		$json = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$faq_model = new Action(MODEL,'faq/crud');

		if(!empty($_POST['cid'])){
			$result = $faq_model->loader('deleteComment', $_POST['cid']);
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