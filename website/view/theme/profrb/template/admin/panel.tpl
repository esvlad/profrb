<section class="admin_section" data-user-org-id="<?=$user['org_id'];?>">
  <div class="wrapp100">
    <div class="content clearfix">
      <div class="admin_col">
        <div class="admin_first_menu_link"><a href="" data-post-attr="content" data-post-param="all" data-admin-role="81">Контент</a>
          <div class="admin_second_menu_block">
            <div class="admin_second_menu_list"><a href="" data-admin-role="81">Материалы</a>
              <div class="admin_second_children_menu_block">
                <? if($user['org_id'] == 0) : ?>
                  <div class="admin_second_children_menu_list">
                    <a href="admin/content/view" data-post-type="all" data-admin-role="81">Показать всё</a>
                  </div>
                <? endif; ?>
                <? foreach($content_type as $ctype) : ?>
                  <div class="admin_second_children_menu_list">
                    <a href="admin/content/view" data-post-type="<?=$ctype['name'];?>" data-admin-role="71"><?=$ctype['title'];?></a>
                  </div>
                <? endforeach; ?>
              </div>
            </div>
            <div class="admin_second_menu_list"><a href="" data-admin-role="81">Добавить материал</a>
              <div class="admin_second_children_menu_block">
                <? foreach($content_type as $ctype) : ?>
                  <? if($user['org_id'] == 0) : ?>
                    <div class="admin_second_children_menu_list">
                      <a class="admin_role" href="admin/content/add" data-post-type="<?=$ctype['name'];?>" data-admin-role="71"><?=$ctype['title'];?></a>
                    </div>
                  <? else : ?>
                    <? if($ctype['name'] != 'geo_page') : ?>
                      <div class="admin_second_children_menu_list">
                        <a class="admin_role" href="admin/content/add" data-post-type="<?=$ctype['name'];?>" data-admin-role="71"><?=$ctype['title'];?></a>
                      </div>
                    <? endif; ?>
                  <? endif; ?>
                <? endforeach; ?>
              </div>
            </div>
          </div>
        </div>
      </div>
      <? if($user['org_id'] == 0) : ?>
        <div class="admin_col">
          <div class="admin_first_menu_link"><a href="" data-admin-role="81">Вопросы и комментарии</a>
            <div class="admin_second_menu_block">
              <div class="admin_second_menu_list"><a href="admin/faq/view" data-admin-role="81">Вопросы</a>
                <div class="admin_second_children_menu_block">
                  <div class="admin_second_children_menu_list"><a href="admin/faq/view&sort=DESC" data-admin-role="81">Показать вопросы</a></div>
                  <div class="admin_second_children_menu_list"><a href="admin/faq/add" data-admin-role="81">Добавить вопрос</a></div>
                </div>
              </div>
              <div class="admin_second_menu_list"><a href="admin/comments/view" data-admin-role="81">Комментарии</a>
                <!--<div class="admin_second_children_menu_block">
                  <div class="admin_second_children_menu_list"><a href="admin/faq/comments&sort=ASC" data-admin-role="81">Все комментарии</a></div>
                  <div class="admin_second_children_menu_list"><a href="admin/faq/comments&sort=DESC" data-admin-role="81">Новые комментарии</a></div>
                </div>-->
              </div>
              <div class="admin_second_menu_list"><a href="admin/letters/view" data-admin-role="81">Подписчики</a></div>
              <!--<div class="admin_second_menu_list"><a href="" data-admin-role="91">Авторы ответов</a>
                <div class="admin_second_children_menu_block">
                  <div class="admin_second_children_menu_list"><a href="admin/faq/authors_add" data-admin-role="91">Добавить автора</a></div>
                  <div class="admin_second_children_menu_list"><a href="admin/faq/authors" data-admin-role="91">Все авторы</a></div>
                  <div class="admin_second_children_menu_list"><a href="admin/faq/authors&id=1" data-admin-role="91">Администратор</a></div>
                  <div class="admin_second_children_menu_list"><a href="admin/faq/authors&id=2" data-admin-role="91">Имя и фамилия автора</a></div>
                </div>
              </div>-->
            </div>
          </div>
        </div>
        <!--<div class="admin_col admin_administrator">
          <div class="admin_first_menu_link">
            <a href="" data-admin-role="99">Структура</a>
            <div class="admin_second_menu_block">
              <div class="admin_second_menu_list">
                <a href="" data-admin-role="99">Страницы</a>
                <div class="admin_second_children_menu_block">
                  <div class="admin_second_children_menu_list">
                    <a href="admin/panel/structure" data-post-type="page" data-post-events="add" data-admin-role="99">Добавить страницу</a>
                  </div>
                  <? foreach($pages as $page) : ?>
                    <div class="admin_second_children_menu_list">
                      <a href="admin/panel/structure" data-post-type="page" data-post-events="update" data-post-params="<?=$page['id'];?>" data-admin-role="99"><?=$page['title'];?></a>
                    </div>
                  <? endforeach; ?>
                </div>
              </div>
              <div class="admin_second_menu_list">
                <a href="" data-admin-role="99">Секции</a>
                <div class="admin_second_children_menu_block">
                  <div class="admin_second_children_menu_list">
                    <a href="admin/panel/structure" data-post-type="section" data-post-events="add" data-admin-role="99">Добавить секцию</a>
                  </div>
                  <? foreach($sections as $section) : ?>
                    <div class="admin_second_children_menu_list">
                      <a href="admin/panel/structure" data-post-type="section" data-post-events="update" data-post-params="<?=$section['id'];?>" data-admin-role="99"><?=$section['title'];?></a>
                    </div>
                  <? endforeach; ?>
                </div>
              </div>
              <div class="admin_second_menu_list">
                <a href="" data-admin-role="99">Блоки</a>
              </div>
              <div class="admin_second_menu_list">
                <a href="" data-admin-role="99">Меню</a>
              </div>
              <div class="admin_second_menu_list">
                <a href="" data-admin-role="99">Поля</a>
                <div class="admin_second_children_menu_block">
                  <div class="admin_second_children_menu_list">
                    <a href="admin/panel/structure" data-post-type="field_type" data-post-events="add" data-admin-role="99">Добавить поле</a>
                  </div>
                </div>
              </div>
              <div class="admin_second_menu_list"><a href="" data-admin-role="81">Материалы</a>
                <div class="admin_second_children_menu_block">
                  <div class="admin_second_children_menu_list">
                    <a href="admin/panel/structure" data-post-type="content" data-post-events="add" data-admin-role="99">Добавить тип материала</a>
                  </div>
                  <? foreach($content_type as $ctype) : ?>
                    <div class="admin_second_children_menu_list">
                      <a href="admin/panel/structure" data-post-type="content_type" data-post-events="update" data-post-params="<?=$ctype['id'];?>" data-admin-role="99"><?=$ctype['title'];?></a>
                    </div>
                  <? endforeach; ?>
                </div>
              </div>
            </div>
          </div>
        </div>-->
        <div class="admin_col admin_administrator">
          <div class="admin_first_menu_link"><a href="" data-admin-role="99">Пользователи</a>
            <div class="admin_second_menu_block">
              <div class="admin_second_menu_list"><a href="admin/user/view" data-admin-role="81">Показать</a></div>
              <div class="admin_second_menu_list"><a href="admin/user/add" data-admin-role="81">Добавить</a></div>
            </div>
          </div>
        </div>
        <!--<div class="admin_col admin_administrator">
          <div class="admin_first_menu_link"><a href="" data-admin-role="99">Настройки</a>
            <div class="admin_second_menu_block">
              <div class="admin_second_menu_list"><a href="" data-admin-role="81">Сайт</a></div>
              <div class="admin_second_menu_list"><a href="" data-admin-role="81">Тема</a></div>
              <div class="admin_second_menu_list"><a href="" data-admin-role="81">Мультимедиа</a></div>
              <div class="admin_second_menu_list"><a href="" data-admin-role="81">Файл-менеджер</a></div>
              <div class="admin_second_menu_list"><a href="" data-admin-role="81">Пользователи</a></div>
            </div>
          </div>
        </div>-->
        <div class="admin_col admin_notification">
          <? if($notification) : ?>
            <div class="admin_first_menu_link">
              <a class="icon_notification icon_notification_true"><span class="notification_count"><?=$notification['count'];?></span></a>
              <div class="admin_second_menu_block notification_true">
                <? foreach($notification['content'] as $notifi) : ?>
                  <div class="admin_second_menu_list"><a id="notification" class="notise_icon" href="<?=$notifi['href'];?>" data-notise="<?=$notifi['type'];?>"><b class="red"><?=$notifi['count'];?></b> <?=$notifi['type_text'];?></a></div>
                <? endforeach; ?>
                <!--<div class="admin_second_menu_list"><a class="notise_icon" href="" data-notise="letter" data-notise-count="5" data-admin-role="81">2 новых подписчика на рассылки</a></div>-->
              </div>
            </div>
          <? else : ?>
            <div class="admin_first_menu_link">
              <a class="icon_notification icon_notification_false"></a>
            </div>
          <? endif; ?>
        </div>
      <? endif; ?>
      <div class="admin_col right">
        <div class="admin_first_menu_link">
          <a href="" onclick="logout()">Выйти</a>
        </div>
      </div>
    </div>
  </div>
</section>
<div class="modal admin_modal" data-modal-id="999" data-modal-open="false">
  <div class="modal_close"></div>
  <div class="admin_modal_view"></div>
</div>