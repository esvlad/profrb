<?

class Paginator {
  public $total = 0;
  public $page = 1;
  public $limit = 20;
  public $limits = false;
  public $num_links = 8;
  public $url = null;
  public $type = false;

  public function render() {
    $total = $this->total;

    if ($this->page < 1) {
      $page = 1;
    } else {
      $page = $this->page;
    }

    if (!(int)$this->limit) {
      $limit = 10;
    } else {
      $limit = $this->limit;
    }

    $num_links = $this->num_links;
    $num_pages = ceil($total / $limit);

    if($this->type == 'admin'){
      $onclick = ' onclick="pagination(this.getAttribute(\'data-paginator\'));"';
    } else {
      $onclick = null;
    }

    $output = '<div class="pagination">';
    $output .= '<ul class="pagination_number">';

    if ($num_pages > 1) {
      if($num_pages <= 6){
        for ($i = 1; $i <= $num_pages; $i++){
          $uri = $this->url . '&page=' .$i;

          if ($page == $i){
            $output .= '<li id="pag" class="active" data-paginator-type="num"><a href="'.$uri.'" data-paginator="'.$i.'" target="_self"'.$onclick.'>'.$i.'</a></li>';
          } else {
            $output .= '<li id="pag" data-paginator-type="num"><a href="'.$uri.'" data-paginator="'.$i.'" target="_self"'.$onclick.'>'.$i.'</a></li>';
          }
        }
      } else {
        if($page < 4) {
          
          for($i = 1; $i <= 5; $i++){
            $uri = $this->url . '&page=' .$i;

            if ($page == $i){
              $output .= '<li id="pag" class="active" data-paginator-type="num"><a href="'.$uri.'" data-paginator="'.$i.'" target="_self"'.$onclick.'>'.$i.'</a></li>';
            } else {
              $output .= '<li id="pag" data-paginator-type="num"><a href="'.$uri.'" data-paginator="'.$i.'" target="_self"'.$onclick.'>'.$i.'</a></li>';
            }
          }

          $uri = $this->url . '&page=' .$num_pages;
          $output .= '<li id="pag" data-paginator-type="num">...</li>';
          $output .= '<li id="pag" data-paginator-type="num"><a href="'.$uri.'" data-paginator="'.$num_pages.'" target="_self"'.$onclick.'>'.$num_pages.'</a></li>';

        } elseif($page > ($num_pages - 4)) {
          
          $uri = $this->url . '&page=1';
          $output .= '<li id="pag" data-paginator-type="num"><a href="'.$uri.'" data-paginator="1" target="_self"'.$onclick.'>1</a></li>';
          $output .= '<li id="pag" data-paginator-type="num">...</li>';

          for($i = ($num_pages - 5); $i <= $num_pages; $i++){
            $uri = $this->url . '&page=' .$i;

            if ($page == $i){
              $output .= '<li id="pag" class="active" data-paginator-type="num"><a href="'.$uri.'" data-paginator="'.$i.'" target="_self"'.$onclick.'>'.$i.'</a></li>';
            } else {
              $output .= '<li id="pag" data-paginator-type="num"><a href="'.$uri.'" data-paginator="'.$i.'" target="_self"'.$onclick.'>'.$i.'</a></li>';
            }
          }

        } else {
          
          $uri = $this->url . '&page=1';
          $output .= '<li id="pag" data-paginator-type="num"><a href="'.$uri.'" data-paginator="1" target="_self"'.$onclick.'>1</a></li>';
          $output .= '<li id="pag" data-paginator-type="num">...</li>';

          for($i = ($page - 1); $i <= ($page + 3); $i++){
            $uri = $this->url . '&page=' .$i;

            if ($page == $i){
              $output .= '<li id="pag" class="active" data-paginator-type="num"><a href="'.$uri.'" data-paginator="'.$i.'" target="_self"'.$onclick.'>'.$i.'</a></li>';
            } else {
              $output .= '<li id="pag" data-paginator-type="num"><a href="'.$uri.'" data-paginator="'.$i.'" target="_self"'.$onclick.'>'.$i.'</a></li>';
            }
          }

          $uri = $this->url . '&page=' .$num_pages;
          $output .= '<li id="pag" data-paginator-type="num">...</li>';
          $output .= '<li id="pag" data-paginator-type="num"><a href="'.$uri.'" data-paginator="'.$num_pages.'" target="_self"'.$onclick.'>'.$num_pages.'</a></li>';
        }
      }
    }

    $output .= '</ul>';

	if($this->page > 1){
		$output .= '<span class="pagination_text" id="pag" data-paginator-type="next"><a href="'.$this->url.'&page='.($page - 1).'" data-paginator="'.($page - 1).'" target="_self"'.$onclick.'>Предыдущая</a></span>';
	}
	
    if ($page < $num_pages) {
		$output .= '<span class="pagination_text" id="pag" data-paginator-type="next"><a href="'.$this->url.'&page='.($page + 1).'" data-paginator="'.($page + 1).'" target="_self"'.$onclick.'>Следующая</a></span>';
    } 

    if($this->limits == 'all'){
      $output .= '<span class="pagination_text" id="pag" data-paginator-type="full"><a href="'.$this->url.'&page=0" data-paginator="0" target="_self"'.$onclick.'>Показать все сразу</a></span>';
    }

    $output .= '</div>';

    if ($num_pages > 1) {
      return $output;
    } else {
      return '';
    }
  }
}
?>