<?php
class ControllerAuthLogin extends MVC{
	public function index(){
		$data['admin'] = $this->isAdmin();

		return $this->render(THEME_NAME . '/template/auth/login.tpl', $data);
	}
	
	public function verification(){
		$json = array();
		
		$model = new Action(MODEL, 'auth/login');
		$user = $model->loader('getUser', $_POST);
		
		if(isset($user['id'])){
			$json['success'] = true;
			$json['userid'] = $user['id'];
			$json['hash'] = $user['hash'];
		} else {
			$json['error'] = $user;
		}
		
		return json_encode($json);
	}
	
}
?>