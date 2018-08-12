<?
class ControllerAdminSaved extends MVC{
	public function index(){
		$admin = $this->isAdmin();
		if(empty($admin['name'])) return false;

		$data = $_POST['set'];
		$json = array();
		if($data['event'] == 'save'){
			unset($data['event']);
			$save = new Action(MODEL, 'admin/save');

			switch ($data['type']) {
				case 'page' :
					$sql_data = array(
						'setting' => $data['setting'],
						'page' => $data['page'],
						'url' => $data['url']
					);

					$json['result'] = $save->loader('addPage', $sql_data);
				break;
				case 'section' :
					$sql_data = array(
						'setting' => $data['setting'],
						'section' => $data['section'],
						'page_id' => $data['page_id']
					);

					$json['result'] = $save->loader('addSection', $sql_data);
				break;
				case 'field_type' :
					$sql_data = array(
						'setting' => $data['setting'],
						'fields_type' => $data['field_type']
					);

					$json['result'] = $save->loader('addFieldType', $sql_data);
				break;
				default : break;
			}
		}
		
		return json_encode($json);
	}

	public function success(){
		if($_POST['type'] == 'page'){
			return $this->render(THEME_NAME . '/template/admin/structure/view_page.tpl');
		}
	}
}
?>