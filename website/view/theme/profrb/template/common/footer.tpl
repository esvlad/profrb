<? if(IS_MOBILE) : ?>
<footer class="sect footer">
  <div class="wrappall">
    <div class="content clearfix">
      <div class="foot_col">
        <div class="foot_contacts">
          <a class="fc_item fc_phone" href="tel:+7-347-2720484">
            <span>+7 347 272-04-84</span></a>
          <a class="fc_item fc_mail" href="mailto:eduprofrb@ufamail.ru">
            <span>eduprofrb@ufamail.ru</span>
          </a>
        </div>
      </div>
      <div class="foot_col">
        <ul class="foot_list_link foot_menu">
          <li><a href="../history" target="_self">О нас</a></li>
          <li><a href="../docs" target="_self">Документы</a></li>
          <li><a href="../faq" target="_self">Вопрос-ответ</a></li>
        </ul>
      </div>
      <div class="foot_col">
        <ul class="foot_list_link foot_page">
          <li><a href="../entry" target="_self">Вступить в профсоюз</a></li>
          <li><a href="../labor-inspection" target="_self">Инспекция труда</a></li>
          <li><a href="../obrazovanie" target="_self">КПК &laquo;Образование&raquo;</a></li>
          <li><a href="../burevestnik" target="_self">ПФСК &laquo;Буревестник&raquo;</a></li>
        </ul>
      </div>
      <div class="foot_col">
        <div class="foot_contacts">
          <div class="fc_social">
            <a class="fc_item" href="https://vk.com/eduprofrb" target="_blank"> <span>Сообщество ВКонтакте</span></a>
          </div>
          <?=$letter?>
        </div>
      </div>
      <div class="foot_col">
        <p class="copyright">© 2008—2012 Башкирский республиканский комитет Профсоюза</p>
        <div class="copyright_link">
        	<a href="../uploads/documents/Конфиденциальность_персональной_информации.pdf" target="_blank">Конфиденциальность персональной информации</span>
        </div>
        <div class="copyright_link">
        	<a href="../uploads/documents/Политика_в_отношении_обработки_персональных_данных.pdf" target="_blank">Политика в&nbsp;отношении обработки персональных данных</span>
        </div>
        <div class="copyright_link">
        	<a href="../uploads/documents/Правила_рассмотрения_вопросов_членов_Общероссийского_Профсоюза_образования.pdf" target="_blank">Правила рассмотрения вопросов членов Общероссийского Профсоюза образования</span>
        </div>
        
        <p class="foot_other_link"><a href="http://www.eseur.ru/" target="_blank">ЦС профсоюза</a></p>
        <p class="foot_other_link"><a href="http://www.fprb.ru/" target="_blank">Федерация профсоюзов РБ</a></p>
      </div>
      <div class="foot_col foot_old_web_link">
        <p>Сайт сделали в <a href="https://promolink.su/" target="_blank">Promolink</a></p>
      </div>
    </div>
  </div>
</footer>
<? else : ?>
<footer class="sect footer">
  <div class="wrappall">
    <div class="content clearfix">
      <?#=$block['footer'];?>
      <div class="foot_col">
        <ul class="foot_list_link foot_menu">
          <li><a href="../history" target="_self">О нас</a></li>
          <li><a href="../docs" target="_self">Документы</a></li>
          <li><a href="../faq" target="_self">Вопрос-ответ</a></li>
          <!--<li><a href="../links" target="_self">Полезные ссылки</a></li>
          <li><a href="../map_site" target="_self">Карта сайта</a></li>-->
        </ul>
      </div>
      <?#=$block['footer'];?>
      <div class="foot_col">
        <ul class="foot_list_link foot_page">
          <li><a href="../entry" target="_self">Вступить в профсоюз</a></li>
          <li><a href="../labor-inspection" target="_self">Инспекция труда</a></li>
          <li><a href="../obrazovanie" target="_self">КПК &laquo;Образование&raquo;</a></li>
          <li><a href="../burevestnik" target="_self">ПФСК &laquo;Буревестник&raquo;</a></li>
        </ul>
      </div>
      <?#=$block['footer'];?>
      <div class="foot_col">
        <div class="foot_contacts"><a class="fc_item fc_phone" href="tel:+7-347-272-04-84"> <span>+7 347 272-04-84</span></a><a class="fc_item fc_mail" href="mailto:eduprofrb@ufamail.ru"> <span>eduprofrb@ufamail.ru</span></a>
          <?=$letter?>
          <div class="fc_social"><a class="fc_item" href="https://vk.com/eduprofrb" target="_blank"> <span>Сообщество ВКонтакте</span></a></div>
        </div>
      </div>
      <?#=$block['footer'];?>
      <div class="foot_col">
        <p class="copyright">© 2008—2012 Башкирский республиканский комитет Профсоюза</p>
        <div class="copyright_link" id="footer_popup" data-modal-id="usematerials">
        	<a href="../uploads/documents/Конфиденциальность_персональной_информации.pdf" target="_blank">Конфиденциальность персональной информации</span>
        </div>
        <div class="copyright_link" id="footer_popup" data-modal-id="usematerials">
        	<a href="../uploads/documents/Политика_в_отношении_обработки_персональных_данных.pdf" target="_blank">Политика в&nbsp;отношении обработки персональных данных</span>
        </div>
        <div class="copyright_link" id="footer_popup" data-modal-id="protectioninformation">
        	<a href="../uploads/documents/Правила_рассмотрения_вопросов_членов_Общероссийского_Профсоюза_образования.pdf" target="_blank">Правила рассмотрения вопросов членов Общероссийского Профсоюза образования</span>
        </div>
        <p class="foot_other_link"><a href="http://www.eseur.ru/" target="_blank">ЦС профсоюза</a></p>
        <p class="foot_other_link"><a href="http://www.fprb.ru/" target="_blank">Федерация профсоюзов РБ</a></p>
      </div>
    </div>
    <div class="content clearfix">
      <div class="foot_col foot_old_web_link">
        <p>Сайт сделали в <a href="https://promolink.su/" target="_blank">Promolink</a></p>
      </div>
    </div>
  </div>
</footer>
<? endif; ?>

<div class="footer_message">
  <div class="wrappall">
    <p class="footer_message_text">Мы&nbsp;собираем метаданные пользователей (cookie, данные об&nbsp;IP-адресе и&nbsp;местоположении) для улучшения функционирования сайта.</p>
    <div class="footer_message_close"></div>
  </div>
</div>

<!--<script src="../verstka/js/jquery/owl.carousel/owl.carousel.min.js"></script>
<script src="../<?= TPL_PATH . THEME_NAME; ?>/js/search-address.js"></script>-->
<script src="../<?= TPL_PATH . THEME_NAME; ?>/js/jquery/slick/slick.min.js"></script>
<script src="../<?= TPL_PATH . THEME_NAME; ?>/js/snap.svg/snap.svg-min.js"></script>
<script src="../<?= TPL_PATH . THEME_NAME; ?>/js/packery.pkgd/packery.pkgd.min.js"></script>
<script src="https://api-maps.yandex.ru/2.1/?lang=ru_RU"></script>

<script src="../<?= TPL_PATH . THEME_NAME; ?>/js/jquery/esSlider/esSlider.jquery.js"></script>
<script src="../<?= TPL_PATH . THEME_NAME; ?>/js/myscript.js"></script>
<? if(!empty($is_admin)) : ?>
  <script src="../<?= TPL_PATH . THEME_NAME; ?>/js/ckeditor/ckeditor.js"></script>
  <script src="../<?= TPL_PATH . THEME_NAME; ?>/js/admin.js"></script>
<? endif; ?>

<? if($page['name'] = 'faq') : ?>
    <script src="//www.google.com/recaptcha/api.js?onload=CaptchaCallback&render=explicit" async defer></script>
  <? endif; ?>

<!-- Yandex.Metrika informer -->
<a href="http://metrika.yandex.ru/stat/?id=12597004&amp;from=informer"
target="_blank" rel="nofollow"><img src="//bs.yandex.ru/informer/12597004/3_1_FFFFFFFF_EFEFEFFF_0_pageviews"
style="width:1px; height:1px; border:0;" alt="Яндекс.Метрика" title="Яндекс.Метрика: данные за сегодня (просмотры, визиты и уникальные посетители)" onclick="try{Ya.Metrika.informer({i:this,id:12597004,type:0,lang:'ru'});return false}catch(e){}"/></a>
<!-- /Yandex.Metrika informer -->

<!-- Yandex.Metrika counter -->
<div style="display:none;"><script type="text/javascript">
(function(w, c) {
    (w[c] = w[c] || []).push(function() {
        try {
            w.yaCounter12597004 = new Ya.Metrika({id:12597004, enableAll: true, webvisor:true});
        }
        catch(e) { }
    });
})(window, "yandex_metrika_callbacks");
</script></div>
<script src="//mc.yandex.ru/metrika/watch.js" type="text/javascript" defer="defer"></script>
<noscript><div><img src="//mc.yandex.ru/watch/12597004" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->

</body>
</html>