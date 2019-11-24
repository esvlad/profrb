<?php
class SystemAction{
	private $action;
	private $controller;
	private $path;
	
	function __construct($path = null){
		$controller = $this->route($path);
		
		$this->path = DIR_SYSTEM . $path .'.php';
		$this->controller = $controller;
		
		require_once $this->path;
	}
	
	public function loader($action = null, $arguments = null){
		$action = isset($action) ? $action : $this->action;
		
		if(isset($arguments)) $arguments = implode(',',$arguments);
		
		$controller = $this->controller;
		$object = new $controller();
		
		return $object->$action($arguments);
	}
	
	private function route($data){
		$data = explode('/', $data);

		return array_pop($data);
	}
	
}
?>