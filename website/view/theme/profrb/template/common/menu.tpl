<nav class="sect menu" data-open="false">
  <div class="wrapper">
    <div class="content clearfix">
      <? if(!empty($menu_first_not_children)) : ?>
        <div class="menu_row clearfix">
          <? foreach($menu_first_not_children as $mfnc) : ?>
            <div class="menu_col">
              <p class="<?=$mfnc['setting']['class'];?>">
                <a href="<?=$mfnc['href'];?>" target="_self"><?=$mfnc['name'];?></a>
              </p>
            </div>
          <? endforeach; ?>
        </div>
      <? endif; ?>
      <? if(!empty($menu_children)) ?>
        <div class="menu_row clearfix">
          <? $data_menu_block = 1; ?>
          <? foreach($menu_children as $menu) : ?>
            <? if($data_menu_block == 2) : ?>
              <div class="menu_col_2">
            <? else : ?>
              <div class="menu_col">
            <? endif; ?>
              <p class="menu_first">
                <a href="<?=$menu['first']['href'];?>" target="_self"><?=$menu['first']['name'];?></a>
              </p>
              <ul class="menu_group">
                <? foreach($menu['children'] as $children_menu) : ?>
                  <li>
                    <a href="<?=$children_menu['href']?>" target="_self"><?=$children_menu['name']?></a>
                  </li>
                <? endforeach; ?>
              </ul>
            </div>
            <? $data_menu_block++; ?>
          <? endforeach; ?>
        </div>
      <? endif; ?>
      <div class="menu_row clearfix">
        <?=$search_menu_block;?>
        <div class="btn btn_site_version" id="versius">Версия для слабовидящих</div>
      </div>
    </div>
  </div>
</nav>