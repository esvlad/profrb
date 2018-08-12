<section class="sect docs" data-category="<?=$category_id;?>" data-page="1">
  <div class="wrapper">
    <div class="content">
      <h1 class="section_title">Документы</h1>
      <div class="docs_search_category">
        <form class="docs_search__form" id="docs_search" action="../docs" method="get">
          <input class="docs_search__form_input" type="text" name="search" value="<?=$_GET['search'];?>" placeholder="Быстрый поиск по документам: введите ключевые слова, № постановления" autocomplete="off"/>
          <input class="docs_search__form_submit" type="submit" value=""/>
        </form>
        <div class="docs_category__block_preview">
          <p>Показать темы документов</p>
        </div>
        <ul class="docs_category__block_view">
          <div class="modal_close"></div>
          <? foreach($category as $cat) : ?>
              <li><a href="../docs/<?=$cat['name'];?>" target="_self"><?=$cat['title'];?> (<?=$cat['count'];?>)</a></li>
		      <? endforeach; ?>
        </ul>
      </div>
      <ul class="docs_type">
        <? foreach($filters as $filter) : ?>
          <? if($filter['name'] != 'none') : ?>
            <li data-filter-id="<?=$filter['id'];?>"><?=$filter['title'];?></li>
          <? endif; ?>
        <? endforeach; ?>
      </ul>
      <div class="section_view clearfix">
        <? if(!empty($contents)) : ?>
          <div class="view_docs">
            <? foreach($contents as $docs) : ?>
              <? if(isset($docs['uri']) && $docs['uri'] != '') : ?>
              <? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$docs['id'].', \'edit\');"></span>' : null; ?>
              <li class="view_docs__item">
                <?=$click;?>
                <i class="docs_icon <?=$docs['type'];?>"></i>
                <div class="docs_title">
                  <a href="..<?=$docs['uri'];?>" download data-id="<?=$docs['cid'];?>"><?=$docs['title'];?></a>
                  <time datetime="<?=$docs['view_date'];?>"><?=$docs['view_date'];?></time>
                </div>
              </li>
              <? endif; ?>
            <? endforeach; ?>
          </div>
          <?=$paginator;?>
        <? endif; ?>
      </div>
      <?#=$paginator;?>
    </div>
  </div>
</section>
