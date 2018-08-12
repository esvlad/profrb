<?php
class Theme extends MVC{
	
	public function isThemeName(){
		$sql = 'SELECT `name` FROM `bo_theme` WHERE `activ`=?i';
		
		return $this->db->getOne($sql, 1);
	}
	
}
?>