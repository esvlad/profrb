<?
class ModelModulesToday extends MVC{

	public function getContents($page){
		$o = 10;
		$l = ($page - 1) * $o;

		$select = 'SELECT DATE_FORMAT(c.`date_creat`, "%d.%m.%Y") as date_creat, f.`body`';
    	$from = ' FROM `'.DB_PREFIX.'content` c, `'.DB_PREFIX.'fields` f, `'.DB_PREFIX.'fields_content` fc';
    	$where = ' WHERE c.`type_id` = 16 AND fc.`content_id` = c.`id` AND f.`id` = fc.`fields_id` AND f.`fields_type_id` = 26 AND c.`active` = 1';
    	$order = ' ORDER BY c.`date_creat` DESC';
    	$limit = ' LIMIT ?i, ?i';

    	$sql = $select . $from . $where . $order . $limit;

    	return $this->db->getAll($sql, $l, $o);
    }

    public function getContentsNowDay(){
        $date = date('Y-m-d');
    	$select = 'SELECT DATE_FORMAT(c.`date_creat`, "%d.%m.%Y") as date_creat, f.`body`';
    	$from = ' FROM `'.DB_PREFIX.'content` c, `'.DB_PREFIX.'fields` f, `'.DB_PREFIX.'fields_content` fc';
    	$where = ' WHERE c.`type_id` = 16 AND c.`date_creat` like "'.$date.'%" AND fc.`content_id` = c.`id` AND f.`id` = fc.`fields_id` AND f.`fields_type_id` = 26 AND c.`active` = 1';
    	$order = ' ORDER BY c.`date_creat` DESC';
    	
    	$sql = $select . $from . $where . $order;

    	return $this->db->getAll($sql);
    }

    public function getTodayCount(){
    	$sql = 'SELECT count(*) FROM `'.DB_PREFIX.'content` WHERE `type_id` = 16 AND `active` = 1';
    	
    	return $this->db->getOne($sql);
    }
}
?>