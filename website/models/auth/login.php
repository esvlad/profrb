<?php

class ModelAuthLogin extends MVC{

	public function getUser($data){
		if($data['login'] || $data['password']){
			$login = htmlspecialchars(trim($data['login']));
			$password = htmlspecialchars(trim($data['password']));

			$user = $this->db->getRow('SELECT id, password FROM pf_user WHERE login = ?s', $login);

			$mycode = '0Grs56a';

			$password = md5(md5($password));
			$password = strrev($password);
			$password = $password . $mycode;

			if(count($user) > 0){
				if($user['password'] == $password){
					$hash = md5($this->generateCode(10));

					$sql_u = 'UPDATE pf_user SET hash = ?s WHERE id = ?i';
					$this->db->query($sql_u, $hash, $user['id']);

					return array('id'=>$user['id'], 'hash'=>$hash);
				} else {
					return array('text'=>'Не верно введен пароль!', 'label'=>'password');
				}
			} else {
				return array('text'=>'Не верно введен логин!', 'label'=>'login');
			}
		} else {
			return array('text'=>'Не введен логин или пароль!');
		}
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
}
?>