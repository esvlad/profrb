<?php

class ModelCommonStatic extends MVC{
	
	public function getStaticContent($sid){
		$content = array();

		$structure = new Action(MODEL, 'setting/structure');
		$result = $structure->loader('getMaterials', $sid);

		foreach($result as $key => $value){
			foreach($value['fields'] as $val){
				$content[$key][$val['name']] = array(
					'field' => $val['field']
				);
			}
		}

		return $content;
	}
}
?>