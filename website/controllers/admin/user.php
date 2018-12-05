<?
class ControllerAdminUser extends MVC{
	public function view(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$view = new Action(MODEL, 'modules/user');

		$limits = 50;

		$arg = array();
		
		$arg['limit'] = isset($_POST['limit']) ? $_POST['limit'] : $limits;
		$arg['page'] = isset($_POST['page']) ? (($_POST['page'] - 1) * $limits) : 0;
		$arg['order'] = isset($_POST['order']) ? $_POST['order'] : 'id';
		$arg['sort'] = isset($_POST['sort']) ? $_POST['sort'] : 'DESC';

		$data['users'] = $view->loader('getUsers', $arg);
		$count = $view->loader('getCountUsers');

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

		return $this->render(THEME_NAME . '/template/admin/user/view.tpl', $data);
	}

	public function add(){
		$data = array();
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$user = new Action(MODEL, 'modules/user');
		$data['geo_objects'] = $user->loader('getGeoObjects');

		return $this->render(THEME_NAME . '/template/admin/user/add.tpl', $data);
	}

	public function edit(){
		$data = array();
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$user = new Action(MODEL, 'modules/user');
		$data['user'] = $user->loader('getUser',$_POST['user_id']);
		$data['geo_objects'] = $user->loader('getGeoObjects');

		return $this->render(THEME_NAME . '/template/admin/user/edit.tpl', $data);
	}

	public function save(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$user = new Action(MODEL, 'modules/user');

		if($_POST['event'] == 'add'){
			$json = $user->loader('addUser', $_POST);
		}

		if($_POST['event'] == 'update'){
			$json = $user->loader('updateUser', $_POST);
		}

		echo json_encode($json);
	}

	public function delete(){
		$json = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$user = new Action(MODEL, 'modules/user');

		if(!empty($_POST['ids'])){
			$json = $user->loader('deleteUser', $_POST['ids']);
		}

		echo json_encode($json);
	}

	public function active(){
		$json = array();
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$user = new Action(MODEL, 'modules/user');

		$json = $user->loader('userBanned', $_POST);

		echo json_encode($json);
	}
}
?>