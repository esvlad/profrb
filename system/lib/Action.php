<?php
class Action{
	private $action;
	private $controller;
	private $path;
	private $get;
	
	function __construct($type, $route = null){
		$route = $this->route($route);

		$this->path = DIR_APPLICATION . $type .'s/' . $route[0].'/'.$route[1].'.php';
		
		$this->controller = ucfirst($type).ucfirst($route[0]).ucfirst($route[1]);
		$this->action = $route[2];
		
		require_once $this->path;
	}
	
	public function loader($action = null, $arguments = null){
		$action = isset($action) ? $action : $this->action;
		if(isset($arguments)) $arguments = $arguments;
		
		$controller = $this->controller;
		$object = new $controller($GLOBALS['db']);
		
		return $object->$action($arguments);
	}
	
	private function route($data){
		if(!isset($data)){
			$controller = array('common', 'home', 'index');
			return $controller;
		} else {
			$data = explode('/', $data);
			
			$controller[] = $data[0];
			$controller[] = $data[1];
			if(count($data) < 3){
			$controller[] = 'index';
			} else {
				$controller[] = $data[2];
			}
			
			return $controller;
		}
	}
	
}
?>