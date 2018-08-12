<?php

class ModelSettingUpload extends MVC{
	
	public function getFileSetting($field_name){
		$setting = $this->db->getOne('SELECT s.params FROM '.DB_PREFIX.'fields_type ft, pf_setting s WHERE ft.name = ?s AND s.id = ft.setting_id', $field_name);
		$st = json_decode($setting, true);

		return $st['file_setting'];
	}

	public function getImageUpload($file){

		$setting = $file['setting'];
		$field_name = $file['field_name'];
		unset($file['setting']);
		unset($file['field_name']);

		$folder = 'images/'.$setting['folder'];
		$upfolder = '/uploads/'.$folder.'/';
		$uploaddir = $_SERVER['DOCUMENT_ROOT'] . $upfolder;

		$images = $this->uploadHelper($file, $uploaddir);

		if(!empty($setting['fixed_crop']) && file_exists($images)){
			$crop_img = new Image();
			$crop_img->load($images);

			$crop_width = $setting['fixed_crop']['w'];
			$crop_height = $setting['fixed_crop']['h'];
			$crop_image_info = pathinfo($images);
			$new_prefix_name = '_'. $crop_width .'x'. $crop_height . '.';

			$image_width = $crop_img->getWidth();
			$image_height = $crop_img->getHeight();

			$cratio = $crop_width / $image_width;
			$cheight = $image_height * $cratio;

			if((int)$cheight > $crop_height){
				$crop_img->resizeToWidth($crop_width);

				$crop_x = 0;
				$crop_y = (int)$cheight - $crop_height;

				$crop_img->crop($crop_x, ($crop_y - ($crop_y / 2)), $crop_width, $crop_height);
			} elseif((int)$cheight < $crop_height) {
				$cratio = $crop_height / $image_height;
		        $cwidth = $image_width * $cratio;

				$crop_x = (int)$cwidth - $crop_width;
				$crop_y = 0;

				$crop_img->resizeToHeight($crop_height);
				$crop_img->crop(($crop_x - ($crop_x / 2)), $crop_y, $crop_width, $crop_height);
			} else {
				$crop_img->resizeToWidth($crop_width);
			}

			$crop_images = $uploaddir . $crop_image_info['filename'] . $new_prefix_name . $crop_image_info['extension'];

			$crop_img->save($crop_images);
			$return_crop_images = $upfolder . $crop_image_info['filename'] . $new_prefix_name . $crop_image_info['extension'];
		}

		if(file_exists($images)){
			$img = new Image();
			$img->load($images);
			if($setting['wh_size']['min']['w'] > $setting['wh_size']['max']['w']){
				$width = $setting['wh_size']['min']['w'];
			} else {
				$width = $setting['wh_size']['max']['w'];
			}

			
			if($setting['wh_size']['max']['h'] != 'false'){
				$img->resize($width, $setting['wh_size']['max']['h']);
			} else {
				$img->resizeToWidth($width);
			}
			$img->save($images);

			if(!empty($return_crop_images)) return $return_crop_images;

			return $upfolder.basename($images);
		} else {
			return 'Файла нет!';
		}

		##"":{"format":"image","size": true,"folder":"slider","wh_size":{"max":{"w":false,"h":false},"min":{"w":"1920","h":"1000"}},"quality":"100"}
	}

	public function getFileUpload($file){
		$setting = $file['setting'];
		$field_name = $file['field_name'];
		unset($file['setting']);
		unset($file['field_name']);

		$folder = 'documents/'.$setting['folder'];
		$upfolder = '/uploads/'.$folder.'/';
		$uploaddir = $_SERVER['DOCUMENT_ROOT'] . $upfolder;

		$files = $this->uploadHelper($file, $uploaddir);

		if(file_exists($files)){
			return $upfolder.basename($files);
		} else {
			return 'Файла нет!';
		}
	}

	private function uploadHelper($file, $uploaddir){
		$files = explode('.', $file['name']);
		$file_format = array_pop($files);
		$file_name = implode('.', $files);
		$filename = $this->translit($file_name) . '.' . $file_format;

		$uploadfile = $uploaddir . basename($filename);
		$path = pathinfo($uploadfile);

		if(file_exists($uploadfile)){
			$uploadfile = $uploaddir . basename($path['filename'] . '_' . date('hms') . '.' . $path['extension']);
		} else {
			$uploadfile = $uploaddir . basename($path['filename'] . '.' . $path['extension']);
		}

		if (move_uploaded_file($file['tmp_name'], $uploadfile)) {
			return $uploadfile;
		} else {
		    return false;
		}
	}

	public function removeFieldFile($fid){
		$files = $this->db->getOne('SELECT f.body FROM '.DB_PREFIX.'fields f WHERE f.id = ?i',$fid);

		$file = json_decode($files, true);

		$fff = $_SERVER['DOCUMENT_ROOT'] . $file['path'];
		
		unlink($fff);
		$this->db->query('DELETE FROM '.DB_PREFIX.'fields WHERE id = ?i',$fid);
		return $fff;
	}
}
?>