<section class="sect second_menu">
  <div class="wrapper">
    <div class="content">
      <ul class="second_menu__list_view">
            <li>
              <a href="/history" target="_self">История</a>
            </li>
            <li>
              <a href="/geo" target="_self">География</a>
            </li>
            <li class="active">
              <a href="/workers" target="_self">Сотрудники</a>
            </li>
            <li>
              <a href="/structure" target="_self">Структура</a>
            </li>
      </ul>
      </div>
    </div>
</section>
<? $w_class = IS_MOBILE ? 'clearfix' : null; ?>
<? $w_placeholder = IS_MOBILE ? 'Имя, фамилия, должность, № кабинета' : 'Быстрый поиск по сотрудникам: введите имя, фамилию, должность или номер кабинета'; ?>
<section class="sect about_us workers">
  <div class="wrappall">
    <div class="content">
      <h1 class="section_title">Сотрудники</h1>
      <div class="workers_search">
        <form id="search_workers">
          <input class="search_workers__input brd" type="text" name="workers" value="" placeholder="<?=$w_placeholder;?>" autocomplete="off"/>
          <input class="display_none" type="submit" disabled />
        </form>
      </div>
      <div class="view_block workers_block admin_edit">
        <? foreach($contents as $content) : ?>
          <? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$content['id'].', \'edit\');"></span>' : null; ?>
          <div class="worker_block active <?=$w_class;?>" data-content="<?=$content['id'];?>">
            <?=$click;?>
            <img src="..<?=$content['fields']['workers_image']['path'];?>"/>
            <p class="worker_name"><?=$content['title'];?></p>
            <p class="worker_position"><?=$content['fields']['worker_position'];?></p>
            <?=$content['fields']['text'];?>
          </div>
        <? endforeach; ?>
      </div>
    </div>
  </div>
</section>