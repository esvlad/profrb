<?php
class MVC{
	protected $db;
	protected $document;
	protected $scripts;
	protected $registry;
	protected $get;
	
	function __construct($db){
		$this->db = $db;
	}
	
	public function document($arguments = null){
		if(isset($arguments)){
			$data = array();
			foreach($arguments as $key => $value){
				$data[$key] = $value;
			}
			return $data;
		} else {
			return null;
		}
	}
	
	public function render($template, $data = null){
		$file = DIR_TEMPLATE . $template;
		
		if (file_exists($file)) {
			if(isset($data)) extract($data);
			
			ob_start();

			require($file);

			$output = ob_get_contents();

			ob_end_clean();
		} else {
			trigger_error('Error: Could not load template ' . $file . '!');
			exit();
		}

		return $output;
	}
	
	public function addScript($href, $postion = 'header') {
		$this->scripts[$postion][$href] = $href;
	}

	public function getScripts($postion = 'header') {
		if (isset($this->scripts[$postion])) {
			return $this->scripts[$postion];
		} else {
			return array();
		}
	}

	public function isAdmin(){
		if(!empty($_COOKIE['userid']) && !empty($_COOKIE['hash'])){
			$user = $this->db->getRow('SELECT u.id, u.name, ul.level FROM '.DB_PREFIX.'user u, '.DB_PREFIX.'user_level ul WHERE u.id = ?i AND u.hash = ?s AND ul.id = u.level_id', $_COOKIE['userid'], $_COOKIE['hash']);

			if($user['level'] > 70){
				return $user;
			} 
		}

		return false;
	}

	public function translit($s){
		$s = (string) $s;
		$s = strip_tags($s);
		$s = str_replace(array("\n", "\r"), " ", $s);
		$s = preg_replace("/\s+/", ' ', $s);
		$s = trim($s);
		$s = function_exists('mb_strtolower') ? mb_strtolower($s) : strtolower($s);
		$s = strtr($s, array('а'=>'a','б'=>'b','в'=>'v','г'=>'g','д'=>'d','е'=>'e','ё'=>'e','ж'=>'j','з'=>'z','и'=>'i','й'=>'y','к'=>'k','л'=>'l','м'=>'m','н'=>'n','о'=>'o','п'=>'p','р'=>'r','с'=>'s','т'=>'t','у'=>'u','ф'=>'f','х'=>'h','ц'=>'c','ч'=>'ch','ш'=>'sh','щ'=>'shch','ы'=>'y','э'=>'e','ю'=>'yu','я'=>'ya','ъ'=>'','ь'=>''));
		$s = preg_replace("/[^0-9a-z-_ ]/i", "", $s);
		$s = str_replace(" ", "-", $s);
		
		return $s;
	}

	public function typograf($text){
	    $typograf = new EMTypograph();
	    $typograf->set_text($text);
	    $typograf->setup(array(
			'Text.paragraphs' => 'off',
			'Text.breakline' => 'off',
			'OptAlign.oa_oquote' => 'off',
			'OptAlign.oa_obracket_coma' => 'off',
		));
	    $result = $typograf->apply(); //$result = $text;

	    $result = str_replace('Ц С', 'ЦС', $result);

	    return $result;
	}
	
}
?>