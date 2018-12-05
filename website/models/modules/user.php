<?
class ModelModulesUser extends MVC{

	public function getUsers($arg){
        $sql = 'SELECT u.*, c.title as org_name FROM pf_user u, pf_content c WHERE c.id = u.org_id AND u.level_id = ?i';

        if($arg['order'] == 'org_name'){
            $sql .= ' ORDER BY c.title';
        } else {
            $sql .= ' ORDER BY u.' . $arg['order'];
        }

        $sql .= ' ' . $arg['sort'] . ' LIMIT ?i,?i';

        $users = $this->db->getAll($sql, 1, $arg['page'], $arg['limit']);

    	return $users;
    }

    public function getGeoObjects(){
        return $this->db->getAll('SELECT c.id, c.title FROM pf_content c WHERE c.type_id = ?i ORDER BY c.title ASC', 5);
    }

    public function getCountUsers(){
        return $this->db->getOne('SELECT count(*) FROM pf_user u WHERE u.level_id = ?i', 1);
    }

    public function getUser($user_id){
        $sql = 'SELECT u.*, c.title as org_name FROM pf_user u, pf_content c WHERE c.id = u.org_id AND u.id = ?i';

        return $this->db->getRow($sql, $user_id);
    }

    public function addUser($data){
        unset($data['event']);
        $data['login'] = htmlspecialchars(trim($data['login']));
        $data['password'] = htmlspecialchars(trim($data['password']));

        $user = $this->db->getRow('SELECT id, login FROM pf_user WHERE login = ?s', $data['login']);

        if(isset($user)){
            return array('error'=>isset($user));
        } else {

            if(!isset($data['email'])) unset($data['email']);

            $mycode = '0Grs56a';

            $password = md5(md5($data['password']));
            $password = strrev($password);
            $data['password'] = $password . $mycode;

            $sql = 'INSERT INTO pf_user SET ?u';
            $this->db->query($sql, $data);

            return array('success'=>$this->db->insertId());
        }
    }

    public function updateUser($data){
        $user_id = $data['user_id'];

        unset($data['event']);
        unset($data['user_id']);

        $data['login'] = htmlspecialchars(trim($data['login']));
        $data['password'] = htmlspecialchars(trim($data['password']));

        $mycode = '0Grs56a';

        $password = md5(md5($data['password']));
        $password = strrev($password);
        $data['password'] = $password . $mycode;

        $sql = 'UPDATE pf_user SET ?u WHERE id = ?i';
        $this->db->query($sql, $data, $user_id);

        return array('success'=>true);
    }

    public function deleteUser($user_id){
        $sql = 'DELETE FROM pf_user WHERE';

        if(is_array($user_id)){
            $sql .= ' id IN (?a)';
        } else {
            $sql .= ' id = ?i';
        }

        $this->db->query($sql, $user_id);

        return array('success'=>true);
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

    public function userBanned($data){
        $this->db->query('UPDATE pf_user SET active = ?i WHERE id = ?i', $data['params'], $data['user_id']);
        
        return array('success'=>true);
    }
}
?>