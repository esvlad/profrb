<?php

class ModelModulesNotification extends MVC{

	public function getNotifications($arg){
		$sql = 'SELECT n.* FROM pf_notification n';

        $sql .= ' ORDER BY n.' . $arg['order'];

        $sql .= ' ' . $arg['sort'] . ' LIMIT ?i,?i';

        $result = $this->db->getAll($sql, $arg['page'], $arg['limit']);

        $ids = array();
        foreach($result as $key => $value){
            $msg = '';
            if($value['event'] == 'add'){
                $msg .= 'Пользователь ' . $this->db->getOne('SELECT `login` FROM `pf_user` WHERE `id`=?i', $value['user_id']) . ' добавил <span class="notifi_link" onclick="content_event('.$value['content_id'].', \'edit\');">новость</span> в карточку организации ';
                $cid = $this->db->getOne('SELECT `geo_id` FROM `pf_content` WHERE `id` = ?i', $value['content_id']);
                $msg .= '<span class="notifi_link" onclick="content_event('.$cid.', \'edit\');">' . $this->db->getOne('SELECT `title` FROM `pf_content` WHERE `id` = ?i', $cid) .'</span>';
            } elseif($value['event'] == 'update'){
                $msg .= 'Пользователь ' . $this->db->getOne('SELECT `login` FROM `pf_user` WHERE `id`=?i', $value['user_id']) . ' изменил ';

                $content = $this->db->getRow('SELECT `id`, `title`, `type_id`, `geo_id` FROM `pf_content` WHERE `id`=?i', $value['content_id']);

                if($content['type_id'] == 5){
                    $msg .= 'информацию в карточке организации  <span class="notifi_link" onclick="content_event('.$content['id'].', \'edit\');">' . $content['title'] .'</span>';
                } else {
                    $body = $this->db->getOne('SELECT f.body FROM pf_fields f, pf_fields_content fc, pf_fields_type ft WHERE fc.content_id = ?i AND f.id = fc.fields_id AND ft.name = ?s AND f.fields_type_id = ft.id', $content['id'], 'text');
                    $body = mb_substr(trim(strip_tags($body)), 0, 35).'...';
                    $msg .= 'новость <span class="notifi_link" onclick="content_event('.$content['id'].', \'edit\');">' . $body . '</span> для карточки оргазинации <span class="notifi_link" onclick="content_event('.$content['geo_id'].', \'edit\');">' . $this->db->getOne('SELECT `title` FROM `pf_content` WHERE `id` = ?i', $content['geo_id']) .'</span>';
                }
            }

            $result[$key]['message'] = $msg;

            //$this->db->query('UPDATE pf_user SET active = ?i WHERE id = ?i', 1, $value['id']);
        }

    	return $result;
	}

	public function getCountgetNotifications(){
		return $this->db->query('SELECT count(*) FROM `pf_notification`');
	}

	public function getNotificationActive($post){
        if(is_array($post)){
            foreach($post as $k => $v){
                $sql = 'UPDATE pf_notification SET view = 1 WHERE id = ?i';
                $this->db->query($sql, (int)$v);
            }
        } else {
            $sql = 'UPDATE pf_notification SET view = 1 WHERE id = ?i';
            $this->db->query($sql, $post);
        }

        return array('success'=>true);
    }
}
?>