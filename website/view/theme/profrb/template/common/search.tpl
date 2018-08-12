<? $getter = isset($post) ? $post : null; 
  #$search_blclass = (isset($search) && $search['counts'] >= 18) ? 'search_view_min10' : 'search_view_max10';
  unset($search['counts']);

  
?>

<section class="sect search_page">
  <div class="wrapper">
    <div class="content">
      <h1 class="section_title">Поиск</h1>
      <form class="search_form">
        <input class="search_form__input brd" type="text" name="search" value="<?=$getter;?>" autocomplete="off" placeholder="Введите слово или фразу"/>
        <input class="search_form__submit" type="submit" value=""/>
      </form>
      <? if(count($search) > 0) : ?>
        <ul class="search_tags">
          <? foreach($search as $key => $value) : ?>
            <li id="search_tag" data-tags="<?=$key;?>"><?=$value['name'];?> (<span class="search_tags__count"><?=$value['count'];?></span>)</li>
          <? endforeach; ?>
        </ul>
      <? endif; ?>
      <div class="search_view">
        <? if(count($search) > 0) : ?>
          <? foreach($search as $key => $value) : ?>
            <div class="search_block" data-name-block="<?=$key;?>">
              <h3 class="search_block__title"><?=$value['name'];?></h3>
              <? foreach($value['content'] as $val) : ?>
                <? if($key == 'faq') : ?>
                  <p data-content-id="<?=$val['id'];?>"><a href="..<?=$val['uri'];?>" target="_self"><?=$val['id'];?><br /><?=$val['date_v'];?> <?=strip_tags($val['title']);?></a><span class=""><?=strip_tags($val['c_body']);?></span></p>
                <? else : ?>
                  <? if(!empty($val['c_body'])) : ?>
                    <p data-content-id="<?=$val['id'];?>"><a href="..<?=$val['uri'];?>" target="_self"><?=$val['date_v'];?> <?=strip_tags($val['title']);?></a><span><?=strip_tags($val['c_body']);?></span></p>
                  <? else : ?>
                    <p data-content-id="<?=$val['id'];?>"><a href="..<?=$val['uri'];?>" target="_self"><?=$val['date_v'];?> <?=strip_tags($val['title']);?></a></p>
                  <? endif; ?>
                <? endif; ?>
              <? endforeach; ?>
            </div>
          <? endforeach; ?>
        <? else : ?>
          <p class="not_search">Ничего не найдено, введите другой запрос.</p>
        <? endif; ?>
      </div>
    </div>
  </div>
</section>