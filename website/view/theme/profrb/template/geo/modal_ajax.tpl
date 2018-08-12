<?
function json_file($js){
  $data = json_decode($js, true);

  return $data['path'];
}
?>
<? $content_title = $contents['content'][0]['title']; ?>
<? $dogovor = 'Коллективный договор'; ?>
<? foreach($contents['view_modal'] as $content) : ?>
<? 
  if($content['modal_title']['body'] == 'Профсоюз трудящихся'){
    $title = 'Профсоюзная организация работников';
  } elseif($content['modal_title']['body'] == 'Профсоюз учащихся'){
    $title = 'Профсоюзная организация студентов';
  } else {
    $title = $content_title;
    $dogovor = 'Отраслевое соглашение';
  }
?>
<div class="modal_view clearfix">
  <h4 class="modal_title"><?=$title;?></h4>
  <div class="modal_view__profile clearfix">
    <img src="..<?=json_file($content['view_profile']['body']);?>"/>
    <p class="modal_view__profile_title"><?=$content['view_profile_title']['body'];?></p>
    <? if(isset($content['view_profile_mail']['body'])) : ?>
      <p class="modal_view__profile_title"><?=$content['view_profile_phone']['body'];?></p>
      <p class="modal_view__profile_phone"><?=$content['view_profile_mail']['body'];?></p>
    <? else : ?>
      <p class="modal_view__profile_phone"><?=$content['view_profile_phone']['body'];?></p>
    <? endif; ?>
    <?=$content['position']['body'];?>
  </div>
  <ul class="modal_view__docs view_docs">
    <? if($title != 'Профсоюзная организация студентов') : ?>
      <li class="view_docs__item">
        <i class="docs_icon docs_icon__doc"></i>
        <div class="docs_title">
          <a href="..<?=$geo['geo_docs']['body']['path'];?>"><?=$dogovor;?></a>
        </div>
      </li>
    <? endif; ?>
  </ul>
  <div class="modal_view__caption clearfix">
    <?=$content['geo_profile']['body'];?>
  </div>
</div>
<? endforeach; ?>