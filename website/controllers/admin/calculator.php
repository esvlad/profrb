<?php
class ControllerAdminCalculator extends MVC{
	public function setting(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$data = $calculator->loader('getSetting');

		$data['prompt'] = json_decode($data['prompt'], true);

		return $this->render(THEME_NAME . '/template/admin/calculator/edit_setting.tpl', $data);
	}

	public function update_setting(){
		$json = array();
		$data = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$result = $calculator->loader('updateSetting', $_POST);

		if($result == true){
			$json = array(
				'success' => true
			);
		} else {
			$json['error'] = true;
		}

		echo json_encode($json);
	}

	public function addJobs(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		return $this->render(THEME_NAME . '/template/admin/calculator/add_jobs.tpl');
	}

	public function editJob(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$data = $calculator->loader('getJob', $_GET['id']);

		return $this->render(THEME_NAME . '/template/admin/calculator/edit_jobs.tpl', $data);
	}

	public function viewJobs(){
		$data = array();

		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$data['contents'] = $calculator->loader('getJobs');

		return $this->render(THEME_NAME . '/template/admin/calculator/view_jobs.tpl', $data);
	}

	public function saveJob(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$result = $calculator->loader('setJobs', $_POST);

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}

	public function updateJob(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$result = $calculator->loader('updateJobs', $_POST);

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}

	public function activeJob(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$result = $calculator->loader('updateActiveJobs', $_POST);

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}

	public function deleteJob(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$result = $calculator->loader('deleteJob', $_POST['id']);

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}

	# POSITIONS

	public function addPositions(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$data['jobs'] = $calculator->loader('getJobs');

		return $this->render(THEME_NAME . '/template/admin/calculator/add_positions.tpl', $data);
	}

	public function editPositions(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$data['content'] = $calculator->loader('getPosition', $_GET['id']);
		$data['jobs'] = $calculator->loader('getJobs');

		return $this->render(THEME_NAME . '/template/admin/calculator/edit_positions.tpl', $data);
	}

	public function viewPositions(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$data = array();

		if(!empty($_GET['job_id'])){
			$data['job_id'] = $_GET['job_id'];
		}

		$data['contents'] = $calculator->loader('getPositions', $data);
		$data['jobs'] = $calculator->loader('getJobs');

		return $this->render(THEME_NAME . '/template/admin/calculator/view_positions.tpl', $data);
	}

	public function savePosition(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$result = $calculator->loader('setPositions', $_POST);

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}

	public function updatePosition(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$result = $calculator->loader('updatePositions', $_POST);

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}

	public function activePosition(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$result = $calculator->loader('updateActivePositions', $_POST);

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}

	public function deletePosition(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$result = $calculator->loader('deletePosition', $_POST['id']);

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}

	# COMPENSATION

	public function addCompensation(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$data['positions'] = $calculator->loader('getPositions');

		return $this->render(THEME_NAME . '/template/admin/calculator/add_compensation.tpl', $data);
	}

	public function editCompensation(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$get = [
			'type' => 'compensation',
			'id' => $_GET['id']
		];

		$data['content'] = $calculator->loader('getPaysAndCompensation', $get);
		$data['positions'] = $calculator->loader('getPositions');

		return $this->render(THEME_NAME . '/template/admin/calculator/edit_compensation.tpl', $data);
	}

	public function viewCompensation(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$data = array();
		$post = array();

		if(!empty($_GET['position_id'])){
			$post['position_id'] = $data['position_id'] = $_GET['position_id'];
		}

		if(!empty($_GET['sorted'])){
			$post['sorted'] = $_GET['sorted'];
		}

		$post['type'] = 'compensation';

		$data['contents'] = $calculator->loader('getPaysAndCompensations', $post);
		$data['positions'] = $calculator->loader('getPositions');

		return $this->render(THEME_NAME . '/template/admin/calculator/view_compensation.tpl', $data);
	}

	public function saveCompensation(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$post = [
			'type' => 'compensation',
			'data' => $_POST
		];

		$result = $calculator->loader('setPaysAndCompensation', $post);

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}

	public function updateCompensation(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$post = [
			'type' => 'compensation',
			'data' => $_POST
		];

		$result = $calculator->loader('updatePaysAndCompensation', $post);

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}

	public function activeCompensation(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$post = [
			'type' => 'compensation',
			'data' => $_POST
		];

		$result = $calculator->loader('updateActivePaysAndCompensation', $post);

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}

	public function deleteCompensation(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$get = [
			'type' => 'compensation',
			'id' => $_POST['id']
		];

		$result = $calculator->loader('deletePaysAndCompensation', $get);

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}

	# PAYS

	public function addPays(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$data['positions'] = $calculator->loader('getPositions');

		return $this->render(THEME_NAME . '/template/admin/calculator/add_pays.tpl', $data);
	}

	public function editPays(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$get = [
			'type' => 'pays',
			'id' => $_GET['id']
		];

		$data['content'] = $calculator->loader('getPaysAndCompensation', $get);
		$data['positions'] = $calculator->loader('getPositions');

		return $this->render(THEME_NAME . '/template/admin/calculator/edit_pays.tpl', $data);
	}

	public function viewPays(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$data = array();
		$post = array();

		if(!empty($_GET['position_id'])){
			$post['position_id'] = $data['position_id'] = $_GET['position_id'];
		}

		if(!empty($_GET['sorted'])){
			$post['sorted'] = $_GET['sorted'];
		}

		$post['type'] = 'pays';

		$data['contents'] = $calculator->loader('getPaysAndCompensations', $post);
		$data['positions'] = $calculator->loader('getPositions');

		return $this->render(THEME_NAME . '/template/admin/calculator/view_pays.tpl', $data);
	}

	public function savePays(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$post = [
			'type' => 'pays',
			'data' => $_POST
		];

		$result = $calculator->loader('setPaysAndCompensation', $post);

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}

	public function updatePays(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$post = [
			'type' => 'pays',
			'data' => $_POST
		];

		$result = $calculator->loader('updatePaysAndCompensation', $post);

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}

	public function activePays(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$post = [
			'type' => 'pays',
			'data' => $_POST
		];

		$result = $calculator->loader('updateActivePaysAndCompensation', $post);

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}

	public function deletePays(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$calculator = new Action(MODEL,'modules/calculator');

		$get = [
			'type' => 'pays',
			'id' => $_POST['id']
		];

		$result = $calculator->loader('deletePaysAndCompensation', $get);

		if($result === true){
			$json['success'] = true;

			echo json_encode($json);
		} else {
			return false;
		}
	}
}
?>