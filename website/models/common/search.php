<?
class ModelCommonSearch extends MVC{
	public function getSearch($params = array()){
		$string = trim($params['search']);

		$data = array();
		$data['counts'] = 0;

		#DOCS

		$sql_docs = 'SELECT с.id, с.title, f.body, DATE_FORMAT(с.date_creat, "%d.%m.%Y") as date_v FROM pf_content с, pf_fields_content fc, pf_fields f 
		WHERE с.type_id = 14 AND с.title like ?s AND fc.content_id = с.id AND f.id = fc.fields_id AND f.fields_type_id = 25 ORDER BY с.id DESC';

		$search_docs = $this->db->getInd('id', $sql_docs, "%$string%");

		if(count($search_docs) > 0){
			$data['docs'] = array();
			$data['docs']['name'] = 'Документы';
			$data['docs']['count'] = count($search_docs);
			$data['counts'] += count($search_docs);
			//$data['docs']['content'] = $search_docs;

			foreach($search_docs as $value){
				if($value['body']){
					$doc_field = json_decode($value['body'], true);
					$value['uri'] = $doc_field['path'];
					unset($value['body']);
				}

				$value['c_body'] = $value['title'];
				$value['title'] = $this->getStrlenTitle($value['title']);

				$data['docs']['content'][] = $value;
			}
		}

		#NEWS

		$sql_news_title = 'SELECT c.id, c.title, u.uri, DATE_FORMAT(c.date_creat, "%d.%m.%Y") as date_v FROM pf_content c, pf_url u WHERE c.type_id = 11 AND c.title like ?s AND c.active = 1 AND u.page_id = 18 AND u.view_id = c.id ORDER BY c.id DESC';
		$search_news_title = $this->db->getInd('id', $sql_news_title, "%$string%");

		$sql_news_body = 'SELECT c.id, c.title, u.uri FROM pf_fields f, pf_fields_content fc, pf_content c, pf_url u
			WHERE f.body like ?s AND f.fields_type_id = 26 AND fc.fields_id = f.id AND c.id = fc.content_id AND c.type_id = 11 AND c.active = 1 AND u.page_id = 18 AND u.view_id = c.id
			GROUP BY fc.content_id ORDER BY fc.content_id DESC';
		$search_news_body = $this->db->getInd('id', $sql_news_body, "%$string%");

		if(count($search_news_title) > 0 || count($search_news_body) > 0){
			$news_array = $search_news_title + $search_news_body;
			$data['news'] = array();
			$data['news']['name'] = 'Новости';
			$data['news']['count'] = count($news_array);
			$data['counts'] += count($news_array);

			foreach($news_array as $value){
				$value['title'] = $this->getStrlenTitle($value['title']);

				$data['news']['content'][] = $value;
			}
		}

		#FAQ

		$sql_faq = 'SELECT fq.id, fq.question as title, u.uri, DATE_FORMAT(fq.date_creat, "%d.%m.%Y") as date_v FROM pf_faq fq, pf_url u
			WHERE (fq.question like ?s OR fq.answer like ?s) AND fq.active = 1 AND u.page_id = 12 AND u.view_id = fq.category_id
			GROUP BY fq.id ORDER BY fq.id DESC;';
		$search_faq = $this->db->getInd('id', $sql_faq, "%$string%", "%$string%");

		if(count($search_faq) > 0){
			$data['faq'] = array();
			$data['faq']['name'] = 'Вопросы и ответы';
			$data['faq']['count'] = count($search_faq);
			$data['counts'] += count($search_faq);

			foreach($search_faq as $value){
				$value['uri'] = '/faq?id='.$value['id'];
				$value['c_body'] = $value['title'];
				$value['title'] = $this->getStrlenTitle($value['title']);

				$data['faq']['content'][] = $value;
			}
		}

		
		#OTHER

		$sql_other = 'SELECT c.id, ct.title, u.uri FROM pf_fields f, pf_fields_type ft, pf_fields_content fc, pf_content c, pf_content_type ct, pf_page_section ps, pf_url u
			WHERE f.body like ?s AND ft.id = f.fields_type_id AND fc.fields_id = f.id AND c.id = fc.content_id AND ct.id = c.type_id AND c.type_id !=5 AND c.type_id !=11 AND c.type_id !=14 AND ps.section_id = ct.section_id AND ps.page_id != 1 AND u.page_id = ps.page_id
			GROUP BY ct.id ORDER BY c.id DESC';
		$search_other = $this->db->getInd('id', $sql_other, "%$string%");
		
		#GEO

		$sql_geo_fid = 'SELECT f.id FROM pf_fields f WHERE f.body like ?s AND (f.fields_type_id = 18 OR f.fields_type_id = 23)';
		$search_geo_fid = $this->db->getAll($sql_geo_fid, "%$string%");

		if(count($search_geo_fid) > 0){
			$w_fid = array();
			foreach($search_geo_fid as $value){
				$w_fid[] = 'fcg.fields_id like \'%'.$value['id'].'%\''; #$this->db->parse('fcg.fields_id like ?s');
			}
			$where = ' WHERE (' . implode(' OR ', $w_fid) .') AND cfg.fields_group_id = fcg.id AND c.id = cfg.content_id AND u.page_id = 8 AND u.view_id = c.category_id';

			$sql_fields_group = 'SELECT c.id, c.title, u.uri FROM pf_fields_content_group fcg, pf_content_fields_group cfg, pf_content c, pf_url u';
			$sql_fields_group .= $where .' GROUP BY c.id ORDER BY c.id DESC';

			$search_geo = $this->db->getInd('id', $sql_fields_group);
		}

		if(count($search_geo) > 0 && count($search_other) > 0){
			$search_others = $search_geo + $search_other;
		} else if(count($search_geo) > 0 && count($search_other) == 0){
			$search_others = $search_geo;
		} else if(count($search_other) > 0 && count($search_geo) == 0){
			$search_others = $search_other;
		} else {
			$search_others = false;
		}

		if($search_others){
			$data['other'] = array();
			$data['other']['name'] = 'Прочее';
			$data['other']['count'] = count($search_others);
			$data['counts'] += count($search_others);

			foreach($search_others as $value){
				$value['title'] = $this->getStrlenTitle($value['title']);

				$data['other']['content'][] = $value;
			}
		}
		
		return $data;
	}

	private function getStrlenTitle($str){
		if(iconv_strlen($str) > 150){
			$result = mb_substr($str, 0, 148) . '...';
		} else {
			$result = $str;
		}

		return $result;
	}
}
?>