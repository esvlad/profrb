<?
class Functions{
  public static function news_img_preview($preview = null, $attr){
    if(isset($preview) && $preview != ''){
      if($attr == 'class'){
        return 'image_vert';
      } else if($attr == 'div'){
        $html = '<div class="news_field_image">';
        $html .= '<img src="..'.$preview.'"/>';
        $html .= '</div>';

        return $html;
      }
    } else {
      if($attr == 'class'){
        return 'no_image';
      } else if($attr == 'div'){
        $html = null;

        return $html;
      }
    }
  }

  public static function f_typograf($text){
    $typograf = new EMTypograph();
    $typograf->set_text($text);
    $typograf->setup(array(
      'Text.paragraphs' => 'off',
      'OptAlign.oa_oquote' => 'off',
      'OptAlign.oa_obracket_coma' => 'off',
    ));
    $result = $typograf->apply();

    return $result;
  }

  public static function pre_print($data){
    echo '<pre>';
    print_r($data);
    echo '</pre>';

    return true;
  }

  public static function odd_even($i){
    if($i % 2 == 0){
      return 'odd';
    } else {
      return 'even';
    }
  }
}
?>