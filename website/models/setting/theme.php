<?php

class ModelSettingTheme extends MVC{
	
	public function getTheme($data){
		if($data == 'active'){
			$theme = $this->db->getRow('SELECT * FROM `'. DB_PREFIX .'theme` WHERE `active` = 1');
			return $theme;
		}
	}
	
}
?>