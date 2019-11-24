<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="utf-8" />
  <? if(IS_MOBILE) : ?>
    <meta name="viewport" content="width=640px">
  <? else : ?>
    <meta name="viewport" content="width=device-width">
  <? endif; ?>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Башкирская республиканская организация Профсоюза работников народного образования и науки Российской Федерации</title>
  <link rel="shortcut icon" href="../<?=$theme['favicon'];?>" type="image/png" />
  <link href="../<?= TPL_PATH . THEME_NAME; ?>/js/jquery/owl.carousel/owl.carousel.css" rel="stylesheet" type="text/css" />
  <link href="../<?= TPL_PATH . THEME_NAME; ?>/css/style.css" rel="stylesheet" type="text/css" />
  <? if(!empty($is_admin)) : ?>
    <link href="../<?= TPL_PATH . THEME_NAME; ?>/css/admin.css" rel="stylesheet" type="text/css" />
  <? endif; ?>
  <? $basehref = isset($basehref) ? $basehref : 'https://eduprofrb.ru/'; ?>
  <base href="<?= $basehref; ?>" />
  <meta property="og:title" content="Башкирская республиканская организация Профсоюза работников народного образования и науки Российской Федерации" />
  <meta property="og:type" content="website" />
  <meta property="og:url" content="" />
  <? $site_name = isset($site_name) ? $site_name : 'My Site'; ?>
  <meta property="og:site_name" content="<?=$site_name;?>" />
  <script src="../<?= TPL_PATH . THEME_NAME; ?>/js/jquery/jquery.min.js"></script>
</head>
<body>
<div class="modal_bg"></div>
<nav class="sect menu" data-open="false">
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
              <a href="../labor-inspection" data-path="/labor-inspection" target="_self">Инспекция труда</a>
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
      <? # endif; ?>
    </div>
  </div>
</nav>
<? if(!empty($is_admin)) : ?>
  <?=$admin_panel;?>
<? endif; ?>

<header class="sect header <?=$page_class;?>">
  <div class="wrappall">
    <div class="content clearfix">
      <div class="logo">
        <a href="../">
          <img src="<?=$theme['logotype'];?>"/>
          <? if(IS_MOBILE) : ?>
            <span>Башкирская республиканская организация <br>Профсоюза работников народного образования и науки РФ</span>
          <? else : ?>
            <span>Башкирская республиканская организация <br>Профсоюза работников народного образования и науки Российской Федерации</span>
          <? endif; ?>
        </a>
      </div>
      <div class="site_menu" id="menu">
        <span>Меню</span>
        <div class="hamburglar is-closed opened" id="hamburger">
          <div class="burger-icon">
            <div class="burger-container">
            	<span class="burger-bun-top"></span>
            	<span class="burger-filling"></span>
            	<span class="burger-bun-bot"></span>
            </div>
          </div>
          <div class="burger-ring">
            <svg class="svg-ring">
              <path class="path" fill="none" stroke="#fff" stroke-miterlimit="10" stroke-width="4" d="M 34 2 C 16.3 2 2 16.3 2 34 s 14.3 32 32 32 s 32 -14.3 32 -32 S 51.7 2 34 2"></path>
            </svg>
          </div>
          <svg width="0" height="0">
            <mask id="mask">
              <path xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#2b2b66" stroke-miterlimit="10" stroke-width="4" d="M 34 2 c 11.6 0 21.8 6.2 27.4 15.5 c 2.9 4.8 5 16.5 -9.4 16.5 h -4"></path>
            </mask>
          </svg>
          <div class="path-burger">
            <div class="animate-path">
              <div class="path-rotation"></div>
            </div>
          </div>
        </div>
      </div>
      <div class="phone_block">
        <a class="main_phone" href="tel: <?#=$site_phone;?>"><?#=$site_phone;?></a>
      </div>
      <div class="search_miniform">
        <div class="search">
          <svg class="search-svg" viewBox="0 0 320 70" data-init="M160,3 L160,3 a27,27 0 0,1 0,54 L160,57 a27,27 0 0,1 0,-54 M197,67 181.21,51.21" data-mid="M160,3 L160,3 a27,27 0 0,1 0,54 L160,57 a27,27 0 0,1 0,-54 M179.5,49.5 179.5,49.5" data-active="M27,3 L293,3 a27,27 0 0,1 0,54 L27,57 a27,27 0 0,1 0,-54 M179.5,49.5 179.5,49.5">
            <path class="search-svg__path" d="M160,3 L160,3 a27,27 0 0,1 0,54 L160,57 a27,27 0 0,1 0,-54 M197,67 181.21,51.21"></path>
          </svg>
          <form action="/search" method="get">
            <input class="search-input" type="text" name="search" autocomplete="off"/>
          </form>
          <div class="search-close"></div>
        </div>
      </div>
    </div>
  </div>
</header>