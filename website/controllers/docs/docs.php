<?php
class ControllerDocsDocs extends MVC{
	public function index($arg = array()){
		$data = array();

		$admin = $this->isAdmin();
		if(!empty($admin['name'])) $data['is_admin'] = true;

		$structure = new Action(MODEL, 'setting/structure');
		$sect_setting = $structure->loader('getSetting', $arg['setting_id']);

		$data['sect_class'] = $sect_setting['class'];
		$data['sect_title'] = $arg['title'];

		if(!empty($arg['page']['class'])) $data['sect_class'] .= ' '.$arg['page']['class'];

		$doc_model = new Action(MODEL, 'docs/docs');

		$data['new_docs'] = $doc_model->loader('getNewDocs', 14);
		$data['popular_docs'] = $doc_model->loader('getPopularDocs', 14);

		return $this->render(THEME_NAME . '/template/main/docs.tpl', $data);
	}

	public function download(){
		if(empty($_GET['id'])){
			return false;
		} else {
			$json = array();

			$model = new Action(MODEL, 'docs/docs');

			$result = $model->loader('setUploadDocs', (int)$_GET['id']);

			if($result){
				return true;
			}
		}
	}

	public function popular(){
		$json = array();

		$model = new Action(MODEL, 'docs/docs');

		$json[] = $model->loader('setPopular', $_POST);

		echo json_encode($_POST);
	}
}
?>