<?
class ControllerAdminNotification extends MVC{
	public function view(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$view = new Action(MODEL, 'modules/notification');

		$limits = 50;

		$arg = array();
		
		$arg['limit'] = isset($_POST['limit']) ? $_POST['limit'] : $limits;
		$arg['page'] = isset($_POST['page']) ? (($_POST['page'] - 1) * $limits) : 0;
		$arg['order'] = isset($_POST['order']) ? $_POST['order'] : 'id';
		$arg['sort'] = isset($_POST['sort']) ? $_POST['sort'] : 'DESC';

		$data['notifications'] = $view->loader('getNotifications', $arg);
		$count = $view->loader('getCountgetNotifications');

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

		return $this->render(THEME_NAME . '/template/admin/notification/view.tpl', $data);
	}

	public function active(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$view = new Action(MODEL, 'modules/notification');
		$result = $view->loader('getNotificationActive', $_POST['ids']);

		echo json_encode($result);
	}
}
?>