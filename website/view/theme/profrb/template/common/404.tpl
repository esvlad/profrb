<?=$header;?>
<section class="sect 404">
  <div class="wrapper">
    <div class="content clearfix">
    	<div class="page_404">
    		<h2>404</h2>
    		<h2>Такой страницы нет.</h2>
    		<p>Может быть, нужная страница найдется в&nbsp;меню?</p>
    	</div>
    </div>
  </div>
</section>
<nav class="sect menu not_found">
  <div class="wrapper">
    <div class="content clearfix">
        <div class="menu_row clearfix">
          <div class="menu_col">
            <p class="menu_first"><a href="../news" data-path="/news" target="_self">Новости</a></p>
          </div>
          <div class="menu_col">
            <p class="menu_first"><a href="../faq" data-path="/faq" target="_self">Вопроc-ответ</a></p>
          </div>
          <div class="menu_col">
            <p class="menu_first"><a href="../obrazovanie" data-path="/obrazovanie" target="_self">КПК &laquo;Образование&raquo;</a></p>
          </div>
          <div class="menu_col">
            <p class="menu_first"><a href="../contacts" data-path="/contacts" target="_self">Контакты</a></p>
          </div>
        </div>
        <div class="menu_row clearfix">
          <div class="menu_col">
            <p class="menu_first">
              <a href="../history" data-path="/history" target="_self">О нас</a>
              <span class="mb_sub_view"></span>
            </p>
            <ul class="menu_group">
              <li><a href="../history" data-path="/history" target="_self">История</a></li>
              <li><a href="../geo" data-path="/geo" target="_self">География</a></li>
              <li><a href="../workers" data-path="/workers" target="_self">Сотрудники</a></li>
              <li><a href="../structure" data-path="/structure" target="_self">Структура</a></li>
            </ul>
          </div>
          <div class="menu_col">
            <p class="menu_first">
            	<a href="../activity" data-path="/activity" target="_self">Деятельность</a>
            	<span class="mb_sub_view"></span>
            </p>
            <ul class="menu_group">
              <li><a href="../activity?a=128" data-path="/activity?a=128" target="_self">Правовая работа</a></li>
              <li><a href="../activity?a=132" data-path="/activity?a=132" target="_self">Охрана труда</a></li>
              <li><a href="../activity?a=134" data-path="/activity?a=134" target="_self">Социальные гарантии</a></li>
              <li><a href="../activity?a=136" data-path="/activity?a=136" target="_self">Социально-трудовые отношения</a></li>
              <li><a href="../activity?a=131" data-path="/activity?a=131" target="_self">Информационная работа</a></li>
              <li><a href="../activity?a=133" data-path="/activity?a=133" target="_self">Молодёжная политика</a></li>
              <li><a href="../activity?a=135" data-path="/activity?a=135" target="_self">Организационная работа</a></li>
              <li><a href="../activity?a=137" data-path="/activity?a=137" target="_self">Финансовая деятельность</a></li>
            </ul>
          </div>
          <div class="menu_col">
            <p class="menu_first">
              <a href="../docs" data-path="/docs" target="_self">Документы</a>
              <span class="mb_sub_view"></span>
            </p>
            <ul class="menu_group">
              <? foreach($c_docs as $docs) : ?>
                <li><a href="../docs/<?=$docs['name'];?>" data-path="/docs/<?=$docs['name'];?>" target="_self"><?=$docs['title'];?> (<?=$docs['count'];?>)</a></li>
              <? endforeach; ?>
            </ul>
          </div>
          <div class="menu_col">
            <p class="menu_first">
              <a href="../labor-inspection" data-path="/labor-inspection" target="_self">Внештатная инспекция труда</a>
            </p>
            <ul class="menu_group">
              <li><a href="../labor-inspection" target="_self">Правовая</a></li>
              <li><a href="../labor-inspection?ds=teh" target="_self">Техническая</a></li>
            </ul>
          </div>
        </div>
        <div class="menu_row clearfix">
          <div class="search_block">
            <form class="search_form" action="../search" method="get">
              <input class="search_form_input brd" type="text" name="search" value="" placeholder="Поиск"/>
              <input class="search_form_submit" type="submit" value=""/>
            </form>
          </div>
          <div class="btn brd btn_site_version" id="verius">Версия для слабовидящих</div>
        </div>
    </div>
  </div>
</nav>
<?=$footer;?>