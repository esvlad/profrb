<?
class ModelModulesLetter extends MVC{
	public function setSubscribe($post){
		$data = array();

		foreach($post as $key => $value){
			if($key == 'letter'){
				foreach($value as $k => $v){
					$data[$v] = 1;
				}
			} else {
				$data[$key] = $value;
			}
		}

		$issets = $this->db->getOne('SELECT id FROM '.DB_PREFIX.'letter WHERE mail = ?s LIMIT 0,1', $data['mail']);

		if(!$issets && $issets == ''){
			$data['code'] = $this->generateCode(20);

			$sql_letter = 'INSERT INTO '.DB_PREFIX.'letter SET ?u';

			$this->db->query($sql_letter, $data);

			$let_id = $this->db->insertId();
		} else {
			$sql_letter = 'UPDATE '.DB_PREFIX.'letter SET ?u WHERE mail = ?s';

			$mail = $data['mail'];
			unset($data['mail']);

			$this->db->query($sql_letter, $data, $mail);
		}

		return true;
	}

	public function getSubscribe($arg){
		$sql_subscribe = 'SELECT mail, code FROM '.DB_PREFIX.'letter WHERE ?n = ?i AND active = 1';
		$subscribe = $this->db->getAll($sql_subscribe, $arg['field_name'], 1);

		$mails = implode(',', $mail_array);

		$letter = new ClassMail();
		$letter->setFrom('Башкирская организация Профсоюза');
		$letter->setSubject($arg['theme']);

		foreach($subscribe as $value){
			$letter->setTo($value['mail']);

			$html = '<div>';

			foreach($arg['message'] as $key => $val){
				$html .= '<p>'.$val.'</p>';
			}

			$html .= '<br/><br/><br/><br/><p style="font-size: 15px; color:#8e8e8e">Для того чтобы отписаться от рассылки перейдите по <a href="'. HTTP_SERVER .'index.php?r=modules/letter/unsubscribe&mail='.$value['mail'].'&code='.$value['code'].'" target="_blank">ссылке</a>.</p><br/><br/>';
			$html .= '<i style="font-size:90%;color:#8e8e8e;">Данное письмо сгенерировано автоматически, отвечать на него не нужно!</i>';

			$html .= '</div>';

			$letter->setMessage($html);
			$letter->sendMail();

			$html = '';	
		}

		return true;
	}

	private function generateCode($length=6) {

		$chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHI JKLMNOPRQSTUVWXYZ0123456789";

		$code = "";

		$clen = strlen($chars) - 1;  
		
		while (strlen($code) < $length) {
			$code .= $chars[mt_rand(0,$clen)];  
		}

		return $code;
    }

    public function getLetters($arg){
    	$sql = 'SELECT * FROM '.DB_PREFIX.'letter ORDER BY '. $arg['order'] . ' '. $arg['sort'] .' LIMIT ?i,?i';

    	$query = $this->db->getAll($sql, $arg['page'], $arg['limit']);
    	
    	return $query;
    }

    public function getCountLetters(){
    	return $this->db->getOne('SELECT count(*) FROM '.DB_PREFIX.'letter');
    }

    public function deleteLetters($ids){
    	$sql = 'DELETE FROM '.DB_PREFIX.'letter WHERE ';

    	if(is_array($ids)){
    		$sql .= 'id IN (?a)';
    	} else {
    		$sql .= 'id = ?i';
    	}

    	$this->db->query($sql, $ids);

    	return true;
    }

    public function upSubscribe($arg){
    	$is_letter = $this->db->getOne('SELECT count(*) FROM '.DB_PREFIX.'letter WHERE mail = ?s AND code = ?s', $arg['mail'], $arg['code']);

    	if($is_letter >= 1){
    		$this->db->query('DELETE FROM '.DB_PREFIX.'letter WHERE mail = ?s', $arg['mail']);
    		return true;
    	}

    	return false;
    }
}
?>