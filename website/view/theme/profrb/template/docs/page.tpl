<? $placeholder = IS_MOBILE ? 'Быстрый поиск по документам' : 'Быстрый поиск по документам: введите ключевые слова, № постановления'; ?>
<section class="sect docs" data-category="<?=$category_id;?>" data-page="1">
  <div class="wrapper">
    <div class="content">
      <h1 class="section_title">Документы</h1>
      <div class="docs_search_category">
        <form class="docs_search__form" id="docs_search" action="../docs" method="get">
          <input class="docs_search__form_input" type="text" name="search" value="<?=isset($_GET['search']) ? $_GET['search'] : null;?>" placeholder="<?=$placeholder;?>" autocomplete="off"/>
          <input class="docs_search__form_submit" type="submit" value=""/>
        </form>
        <? if($category_id == 22 && IS_MOBILE) {$hpr = 'style="height: 140px;"';} else {$hpr = null;} ?>
        <div class="docs_category__block_preview" <?=$hpr;?>>
          <?if($category_id){
              foreach($category as $cat){
                if($cat['id'] == $category_id && !isset($_GET['search'])){
                  if(IS_MOBILE){
                    echo '<p><span>'.$cat['title'].'</span></p>';
                  } else {
                    echo '<p>'.$cat['title'].'</p>';
                  }
                }
              }
            } else {
              if(IS_MOBILE){
                echo '<p><span>Показать темы документов</span></p>';
              } else {
                echo '<p>Показать темы документов</p>';
              }
            }
          ?>
        </div>
        <ul class="docs_category__block_view">
          <div class="modal_close"></div>
          <? foreach($category as $cat) : ?>
            <? if($cat['id'] == $category_id && !isset($_GET['search'])) : ?>
              <li data-category="<?=$cat['id'];?>" class="active"><a href="../docs/<?=$cat['name'];?>" target="_self"><?=$cat['title'];?> (<?=$cat['count'];?>)</a></li>
            <? else : ?>
              <li data-category="<?=$cat['id'];?>"><a href="../docs/<?=$cat['name'];?>" target="_self"><?=$cat['title'];?> (<?=$cat['count'];?>)</a></li>
            <? endif; ?>
		      <? endforeach; ?>
        </ul>
      </div>
      <? if(IS_MOBILE) : ?>
        <label class="docs_type" for="docs_filter"><span>Фильтр по типу</span></label>
        <select id="docs_filter" class="ds_filter" name="filter-id">
          <option value="-1">Все типы</option>
          <? foreach($filters as $filter) : ?>
            <? if($filter['name'] != 'none') : ?>
              <option value="<?=$filter['id'];?>"><?=$filter['title'];?></option>
            <? endif; ?>
          <? endforeach; ?>
        </select>
      <? else : ?>
        <ul class="docs_type">
          <? foreach($filters as $filter) : ?>
            <? if($filter['name'] != 'none') : ?>
              <? if(!empty($filter_id) && $filter['id'] == $filter_id) : ?>
                <li class="active" data-filter-id="<?=$filter['id'];?>" data-btn-text="<?=$filter['title'];?>"><?=$filter['title'];?></li>
              <? else : ?>
                <li data-filter-id="<?=$filter['id'];?>" data-btn-text="<?=$filter['title'];?>"><?=$filter['title'];?></li>
              <? endif; ?>
            <? endif; ?>
          <? endforeach; ?>
        </ul>
      <? endif; ?>
      <div class="section_view clearfix">
        <div class="view_docs">
          <? foreach($contents as $docs) : ?>
            <? if(isset($docs['body']['path']) && $docs['body']['path'] != '') : ?>
            <? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$docs['cid'].', \'edit\');"></span>' : null; ?>
            <li class="view_docs__item">
              <?=$click;?>
              <i class="docs_icon <?=$docs['docs_icon_class'];?>"></i>
              <div class="docs_title">
                <a href="..<?=$docs['body']['path'];?>" download data-id="<?=$docs['cid'];?>"><?=$docs['title'];?></a>
                <time datetime="<?=$docs['view_date'];?>"><?=$docs['view_date'];?></time>
              </div>
            </li>
            <? endif; ?>
          <? endforeach; ?>
        </div>
        <?=$paginator;?>
      </div>
    </div>
  </div>
</section>
