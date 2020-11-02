<?
class ModelModulesCalculator extends MVC{
	public function getSetting(){
		return $this->db->getRow('SELECT * FROM `pf_calc` WHERE `id` = ?i', 1);
	}

	public function updateSetting($post){
		$sql = 'UPDATE pf_calc SET title = ?s, caption = ?s WHERE id = ?i';
		$this->db->query($sql, $post['title'], $post['caption'], 1);

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

	public function getCalculator(){
		$data = array();

		$data['setting'] = $this->getSetting();
		$data['jobs'] = $this->getJobs(['sorted'=>'position']);
		$data['positions'] = $this->getPositions(['sorted'=>'position']);

		return $data;
	}
}
?>