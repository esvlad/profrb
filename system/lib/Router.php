<?php
final class Router {
	private $data = array();
	private $request;
	private $db;

	function __construct($request_uri){
		$this->request = '/' . $request_uri;
		$this->db = $GLOBALS['db'];
	}

	public function getRoute() {
		$sql = 'SELECT * FROM '.DB_PREFIX.'url WHERE uri = ?s LIMIT 1';
		
		$route = $this->db->getRow($sql, $this->request);
		
		if(empty($sql['page_id'])){
			$route['type'] = 'common/page';
		}
		# id=?, page_id=?, view_id=?
		return $route;
	}
}