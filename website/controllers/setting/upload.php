<?
class ControllerSettingUpload extends MVC{
	public function images(){
		$error = false;
		$result = array();
		$json = array();
		
		$field_name = explode('[', $_GET['type']);
		$field_name = $field_name[0];

		#Настройки для файлов
		$image = new Action(MODEL, 'setting/upload');
		$image_setting = $image->loader('getFileSetting', $field_name);

		$file_type = array('image/gif', 'image/jpeg', 'image/png');
		#Конец настроек

		$sort = 0;
		foreach($_FILES as $file){
			if(in_array($file['type'], $file_type)){
				$file['setting'] = $image_setting;
				$file['field_name'] = $field_name;

				$files = $image->loader('getImageUpload', $file);

				$f = array(
					'type' => 'file',
					'file' => $files,
					'field_name' => $field_name,
					'sort' => $sort,
					'title' => ''
				);

				$field = new Action(MODEL, 'admin/save');
	    		$field_id = $field->loader('addField', $f);

	    		$result[] = array(
					'files' => $files,
					'field_id' => $field_id,
					'sort' => $sort
				);
			} else {
				$json['error'][] = 'Неверный формат файла!' . $file['name'];
			}
			$sort++;
	    }
	    
	    $json['result'] = $result;
	    return json_encode($json);
	}

	public function docs(){
		$error = false;
		$files = array();
		$json = array();

		$field_name = explode('[', $_GET['type']);
		$field_name = $field_name[0];

		$uploader = new Action(MODEL, 'setting/upload');
		$file_setting = $uploader->loader('getFileSetting', $field_name);
		$file_type = $file_setting['mime_types'];

		foreach($_FILES as $file){
			$path_file = pathinfo($file['name']);
			if(in_array($path_file['extension'], $file_type)){
				$file['setting'] = $file_setting;
				$file['field_name'] = $field_name;

				$files = $uploader->loader('getFileUpload', $file);

				$f = array(
					'type' => 'file',
					'file' => $files,
					'field_name' => $field_name
				);

				$field = new Action(MODEL, 'admin/save');
	    		$field_id = $field->loader('addField', $f);

	    		$path = pathinfo($files);
	    		$file_name = $path['filename'] . '.' . $path['extension'];

	    		$img_file = '/website/view/theme/profrb/img/icon/icon_'.$path_file['extension'].'.png';

	    		$result[] = array(
					'files' => $img_file,
					'file_name' => $file_name,
					'field_id' => $field_id
				);
			} else {
				$json['error'][] = 'Неверный формат файла!';
			}
	    }
	    
	    $json['result'] = $result;
	    return json_encode($json);
	}
}
?>