<?
class ModelModulesCalculator extends MVC{
	public function getSetting(){
		return $this->db->getRow('SELECT * FROM `pf_calc` WHERE `id` = ?i', 1);
	}

	public function updateSetting($post){
		$sql = 'UPDATE pf_calc SET title = ?s, caption = ?s, prompt = ?s WHERE id = ?i';
		$this->db->query($sql, $post['title'], $post['caption'], json_encode($post['prompt'], JSON_UNESCAPED_UNICODE), 1);

		return true;
	}

	public function getJobs($data = array()){
		$sql = 'SELECT * FROM pf_calc_job ORDER BY';
		if(!empty($data['sorted']) && $data['sorted'] == 'position'){
			$sql .= ' position ASC';
		} else {
			$sql .= ' id ASC';
		}

		return $this->db->getAll($sql);
	}

	public function getJob($id){
		return $this->db->getRow('SELECT * FROM `pf_calc_job` WHERE `id` = ?i', (int)$id);
	}

	public function deleteJob($id){
		$this->db->query('DELETE FROM pf_calc_job WHERE id = ?i', (int)$id);

		return true;
	}

	public function setJobs($post){
		$sql = 'INSERT INTO pf_calc_job SET ?u';

		$this->db->query($sql, $post);

		return true;
	}

	public function updateJobs($post){
		$data = array();
		$sql = 'UPDATE pf_calc_job SET ?u WHERE id = ?i';

		$id = (int)$post['id'];

		if(!empty($post['name'])){
			$data['name'] = $post['name'];
		}

		if(!empty($post['position'])){
			$data['position'] = $post['position'];
		}

		if(!empty($post['active'])){
			$data['active'] = $post['active'];
		}

		$this->db->query($sql, $data, $id);

		return true;
	}

	public function updateActiveJobs($post){
		$sql = 'UPDATE pf_calc_job SET active = ?i WHERE id = ?i';

		$this->db->query($sql, (int)$post['active'], (int)$post['id']);

		return true;
	}

	public function getPositions($data = array()){
		$sql = 'SELECT p.*, j.name as job_name FROM pf_calc_position p LEFT JOIN pf_calc_job j ON (p.job_id = j.id)';

		if(!empty($data['job_id'])){
			$sql .= ' WHERE p.job_id = ' . (int)$data['job_id'];
		}

		if(!empty($data['sorted']) && $data['sorted'] == 'position'){
			$sql .= ' ORDER BY p.position, p.id ASC';
		} else {
			$sql .= ' ORDER BY p.id ASC';
		}

		return $this->db->getAll($sql);
	}

	public function getPosition($id){
		return $this->db->getRow('SELECT p.*, j.name as job_name FROM pf_calc_position p LEFT JOIN pf_calc_job j ON (p.job_id = j.id) WHERE p.id = ?i', (int)$id);
	}

	public function deletePosition($id){
		$this->db->query('DELETE FROM pf_calc_position WHERE id = ?i', (int)$id);

		return true;
	}

	public function setPositions($post){
		$sql = 'INSERT INTO pf_calc_position SET ?u';

		$this->db->query($sql, $post);

		return true;
	}

	public function updatePositions($post){
		$data = array();
		$sql = 'UPDATE pf_calc_position SET ?u WHERE id = ?i';

		$id = (int)$post['id'];

		if(!empty($post['name'])){
			$data['name'] = $post['name'];
		}

		if(!empty($post['job'])){
			$data['job'] = $post['job'];
		}

		if(!empty($post['oklad'])){
			$data['oklad'] = $post['oklad'];
		}

		if(!empty($post['norm_hour'])){
			$data['norm_hour'] = $post['norm_hour'];
		}

		if(!empty($post['position'])){
			$data['position'] = $post['position'];
		}

		if(!empty($post['active'])){
			$data['active'] = $post['active'];
		}

		$this->db->query($sql, $data, $id);

		return true;
	}

	public function updateActivePositions($post){
		$sql = 'UPDATE pf_calc_position SET active = ?i WHERE id = ?i';

		$this->db->query($sql, (int)$post['active'], (int)$post['id']);

		return true;
	}

	# PAYS and COMPENSATION

	public function getPaysAndCompensations($data = array()){
		if($data['type'] == 'compensation'){
			$table_name = 'pf_calc_compensation cp';
			$to_table_name = 'pf_calc_compensation_to_position tcp';
			$to_name = 'compensation_id';
		} else {
			$table_name = 'pf_calc_pays cp';
			$to_table_name = 'pf_calc_pays_to_position tcp';
			$to_name = 'pays_id';
		}

		$sql = 'SELECT cp.* FROM '.$table_name;

		if(!empty($data['position_id'])){
			$sql .= ' LEFT JOIN '.$to_table_name.' ON (cp.id = tcp.'.$to_name.')';
			$sql .= ' WHERE tcp.position_id = ' . (int)$data['position_id'];
		}

		if(!empty($data['sorted']) && $data['sorted'] == 'name'){
			$sql .= ' ORDER BY cp.name, cp.id ASC';
		} else {
			$sql .= ' ORDER BY cp.id ASC';
		}

		return $this->db->getAll($sql);
	}

	public function getPaysAndCompensation($get){
		if($get['type'] == 'compensation'){
			$table_name = 'pf_calc_compensation';
			$to_table_name = 'pf_calc_compensation_to_position';
			$to_name = 'compensation_id';
		} else {
			$table_name = 'pf_calc_pays';
			$to_table_name = 'pf_calc_pays_to_position';
			$to_name = 'pays_id';
		}

		$id = $get['id'];

		$data = $this->db->getRow('SELECT * FROM ?n WHERE id = ?i', $table_name, (int)$id);
		$data['position_id'] = $this->db->getCol('SELECT position_id FROM ?n WHERE ?n = ?i', $to_table_name, $to_name, (int)$id);

		return $data;
	}

	public function deletePaysAndCompensation($get){
		if($get['type'] == 'compensation'){
			$table_name = 'pf_calc_compensation';
			$to_table_name = 'pf_calc_compensation_to_position';
			$to_name = 'compensation_id';
		} else {
			$table_name = 'pf_calc_pays';
			$to_table_name = 'pf_calc_pays_to_position';
			$to_name = 'pays_id';
		}

		$id = $get['id'];

		$this->db->query('DELETE FROM ?n WHERE id = ?i', $table_name, (int)$id);
		$this->db->query('DELETE FROM ?n WHERE ?n = ?i', $to_table_name, $to_name, (int)$id);

		return true;
	}

	public function setPaysAndCompensation($post){
		if($post['type'] == 'compensation'){
			$table_name = 'pf_calc_compensation';
			$to_table_name = 'pf_calc_compensation_to_position';
			$to_name = 'compensation_id';
		} else {
			$table_name = 'pf_calc_pays';
			$to_table_name = 'pf_calc_pays_to_position';
			$to_name = 'pays_id';
		}

		$data = [];

		if(!empty($post['data']['positions'])){
			$positions = $post['data']['positions'];
		}

		if(!empty($post['data']['variants'])){
			$variants_array = [];

			foreach($post['data']['variants'] as $variants){
				$variants_array[] = [
					'name' => $variants['name'],
					'value' => $variants['value']
				];
			}

			$variants_json = json_encode($variants_array, JSON_UNESCAPED_UNICODE); //, JSON_UNESCAPED_UNICODE
		}

		$data = [
			'name' => $post['data']['name'],
			'value' => $post['data']['value'],
			'variants' => $variants_json ?: null,
			'position' => $post['data']['position'],
			'active' => $post['data']['active'],
		];

		if($post['type'] == 'pays'){
			$data['type'] = $post['data']['type'];
			$data['type_value'] = $post['data']['type_value'];
		}

		$sql = 'INSERT INTO ?n SET ?u';
		$this->db->query($sql, $table_name, $data);

		$insert_id = $this->db->insertId();

		$to_sql = 'INSERT INTO ?n SET ?u';

		$to_data = [];
		foreach($positions as $k => $v){
			$to_data = [
				'position_id' => $v,
				$to_name => $insert_id
			];

			$this->db->query($to_sql, $to_table_name, $to_data);
		}

		return true;
	}

	public function updatePaysAndCompensation($post){
		if($post['type'] == 'compensation'){
			$table_name = 'pf_calc_compensation';
			$to_table_name = 'pf_calc_compensation_to_position';
			$to_name = 'compensation_id';
		} else {
			$table_name = 'pf_calc_pays';
			$to_table_name = 'pf_calc_pays_to_position';
			$to_name = 'pays_id';
		}

		$data = [];

		if(!empty($post['data']['positions'])){
			$positions = $post['data']['positions'];
		}

		if(!empty($post['data']['variants'])){
			$variants_array = [];

			foreach($post['data']['variants'] as $variants){
				$variants_array[] = [
					'name' => $variants['name'],
					'value' => $variants['value']
				];
			}

			$variants_json = json_encode($variants_array, JSON_UNESCAPED_UNICODE);
		}

		$data = [
			'name' => $post['data']['name'],
			'value' => $post['data']['value'],
			'variants' => $variants_json ?: null,
			'position' => $post['data']['position'],
			'active' => $post['data']['active'],
		];

		if($post['type'] == 'pays'){
			$data['type'] = $post['data']['type'];
			$data['type_value'] = $post['data']['type_value'];
		}

		$id = (int)$post['data']['id'];

		$sql = 'UPDATE ?n SET ?u WHERE id = ?i';
		$this->db->query($sql, $table_name, $data, $id);

		$this->db->query('DELETE FROM ?n WHERE ?n = ?i', $to_table_name, $to_name, $id);

		$to_sql = 'INSERT INTO ?n SET ?u';

		$to_data = [];

		foreach($positions as $k => $v){
			$to_data = [
				'position_id' => $v,
				$to_name => $id
			];

			$this->db->query($to_sql, $to_table_name, $to_data);
		}

		return true;
	}

	public function updateActivePaysAndCompensation($post){
		if($post['type'] == 'compensation'){
			$table_name = 'pf_calc_compensation';
		} else {
			$table_name = 'pf_calc_pays';
		}

		$data = $post['data'];

		$sql = 'UPDATE ?n SET active = ?i WHERE id = ?i';

		$this->db->query($sql, $table_name, (int)$data['active'], (int)$data['id']);

		return true;
	}

	# CALCULATOR

	public function getCalculator(){
		$data = array();

		$data['setting'] = $this->getSetting();
		$data['setting']['prompt'] = json_decode($data['setting']['prompt'], true);
		$data['jobs'] = $this->getJobs(['sorted'=>'position']);
		$data['positions'] = $this->getPositions(['sorted'=>'position']);

		return $data;
	}

	public function getCompensationsAndPays($position_id){
		$result = [];

		$c_sql = 'SELECT cp.* FROM pf_calc_compensation cp LEFT JOIN pf_calc_compensation_to_position tcp ON (cp.id = tcp.compensation_id) WHERE tcp.position_id = ?i ORDER BY cp.name, cp.position, cp.id ASC';

		$compensations = $this->db->getAll($c_sql, $position_id);

		$result['compensations'] = $this->calc_cp_handler($compensations);

		$p_sql = 'SELECT cp.* FROM pf_calc_pays cp LEFT JOIN pf_calc_pays_to_position tcp ON (cp.id = tcp.pays_id) WHERE tcp.position_id = ?i ORDER BY cp.name, cp.position, cp.id ASC';

		$pays = $this->db->getAll($p_sql, $position_id);

		$result['pays'] = $this->calc_cp_handler($pays);

		return $result;
	}

	private function calc_cp_handler($data){
		$result = [];

		if(!empty($data)){
			foreach($data as $value){
				$result[] = [
					'id'	=> $value['id'],
					'name'	=> $value['name'],
					'slug'	=> $this->calc_cp_name($value['name']),
					'value'	=> (float)str_replace(',','.', $value['value']) ?: false,
					'type'	=> (int)$value['type'] ?: false,
					'type_value' => (int)$value['type_value'] ?: false,
					'variants'	=> $this->calc_cp_variants($value['id'], $value['variants'])
				];
			}
		} else {
			$result = false;
		}

		return $result;
	}

	private function calc_cp_name($name){
		if(strlen($name) > 100){
			$name = mb_substr($name, 0, 60) . '...';
		}

		return $name;
	}

	private function calc_cp_variants($id, $variants = false){
		if(!empty($variants)){
			$var = [];
			$v = 1;

			$variants = json_decode($variants);

			foreach($variants as $variant){
				$var[] = [
					'id'	=> (int)$id,
					'v'		=> $v,
					'name'	=> $variant->name,
					'value'	=> (float)str_replace(',','.', $variant->value)
				];

				$v++;
			}
		} else {
			$var = false;
		}

		return $var;
	}
}
?>