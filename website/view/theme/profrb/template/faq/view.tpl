<? $placeholder = IS_MOBILE ? 'Быстрый поиск по вопросам' : 'Быстрый поиск по вопросам: введите ключевые слова или № вопроса'; ?>
<section class="sect faq" data-category="<?=$category_id;?>">
  <div class="wrapper">
    <div class="content">
      <h1 class="section_title">Вопрос-ответ</h1>
      <div class="faq_search_category">
        <form class="faq_search__form" id="faq_search" action="../faq" method="get">
          <input class="faq_search__form_input" type="text" name="search" value="<?=isset($_GET['search']) ? $_GET['search'] : null;?>" placeholder="<?=$placeholder;?>" autocomplete="off"/>
          <div class="faq_search__form_submit"></div>
        </form>
        <? $hpr = null; $btt = null; if($category_id == 108 && IS_MOBILE) $hpr = 'style="height: 140px;"'; $btt = 'style="top:152px;"'; ?>
        <div class="btn brd btn_answer" id="btn_modal" data-modal-id="55" data-modal-block="answer" <?=$btt;?>>Задать вопрос</div>
        <div class="faq_category__block_preview" <?=$hpr;?>>
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
                echo '<p><span>Показать темы вопросов</span></p>';
              } else {
                echo '<p>Показать темы вопросов</p>';
              }
            }
          ?>
        </div>
        <ul class="faq_category__block_view">
          <div class="modal_close"></div>
          <? foreach($category as $cat) : ?>
            <? if($cat['id'] == $category_id) : ?>
              <li class="active"><a href="../faq/<?=$cat['name'];?>" target="_self"><?=$cat['title'];?> (<?=(!empty($category_count[$cat['id']])) ? $category_count[$cat['id']] : 0;?>)</a></li>
            <? else : ?>
              <li><a href="../faq/<?=$cat['name'];?>" target="_self"><?=$cat['title'];?> (<?=(!empty($category_count[$cat['id']])) ? $category_count[$cat['id']] : 0;?>)</a></li>
            <? endif; ?>
          <? endforeach; ?>
        </ul>
      </div>
      <div class="section_view clearfix admin_edit">
        <? foreach($contents as $content) : ?>
          <?
            if($content['question_author_private'] == 1){
              $author_faq = 'Анонимно';
            } else {
              $author_faq = $content['question_author_name'] .', '. $content['question_author_work'] .', '. $content['question_author_from'];
            }
          ?>
          <? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="faq_event('.$content['id'].', \'edit\');"></span>' : null; ?>
          <div class="view_block faq_block clearfix admin_edit" data-block-id="<?=$content['id'];?>">
            <?=$click;?>
            <? if(IS_MOBILE) : ?>
              <div class="faq_question">
                <p class="faq_question__id"><?=$content['id'];?></p>
                <div class="faq__question">
                  <h3 class="faq__question__subject"><?=$content['category_title'];?></h3>
                  <?=$content['question'];?>
                </div>
                <p class="faq_question__author"><?=$author_faq;?></p>
                <p class="faq_question__date"><?=$content['date_creat'];?></p>
              </div>
              <div class="faq_answer">
                <p class="faq_answer__title">Ответ</p>
                <div class="faq__answer">
                  <?=$content['answer'];?>
                </div>
                <p class="faq_answer__author"><?=$content['answer_caption'];?> <span class="admin_filter"><?=$content['answer_name'];?></span></p>
                <div class="faq_answer_cs">
                  <div class="social_icons faq_answer_cs__socials clearfix">
                    <span>Поделиться: </span>
                    <i class="social_icon" id="social_repost" data-social-type="vk" onclick="window.open('https://vk.com/share.php?url=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>&title=<?=mb_substr(strip_tags($content['question']), 0, 140);?>','sharer','toolbar=0,status=0,width=700,height=400');"></i>
                    <i class="social_icon" id="social_repost" data-social-type="tw" onclick="window.open('http://twitter.com/share?url=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>&text=<?=mb_substr(strip_tags($content['question']), 0, 120);?>','sharer','toolbar=0,status=0,width=700,height=400');"></i>
                    <i class="social_icon" id="social_repost" data-social-type="fb" onclick="window.open('https://www.facebook.com/sharer.php?u=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>&title=<?=mb_substr(strip_tags($content['question']), 0, 140);?>&description=<?=strip_tags($content['answer']);?>','sharer','toolbar=0,status=0,width=700,height=400');"></i>
                    <i class="social_icon" id="social_repost" data-social-type="ok" onclick="window.open('https://connect.ok.ru/dk?st.cmd=WidgetSharePreview&st.description=<?=strip_tags($content['answer']);?>&st.title=<?=mb_substr(strip_tags($content['question']), 0, 140);?>&st.shareUrl=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>','sharer','toolbar=0,status=0,width=700,height=400');"></i>
                  </div>
                  <? if($content['no_comment'] == 0) : ?>
                    <p class="faq_answer_cs__comments" id="faq_comments" data-faq-id="<?=$content['id'];?>">Комментарии: <span class="faq_answer_cs__comments_count"><?=count($comments[$content['id']]);?></span></p>
                  <? endif; ?>
                </div>
              </div>
            <? else : ?>
              <div class="faq_block_body clearfix">
                <div class="faq_question">
                  <p class="faq_question__id"><?=$content['id'];?></p>
                  <p class="faq_question__date"><?=$content['date_creat'];?></p>
                  <div class="faq__question">
                    <h3 class="faq__question__subject"><?=$content['category_title'];?></h3>
                    <?=$content['question'];?>
                  </div>
                </div>
                <div class="faq_answer">
                  <p class="faq_answer__title">Ответ</p>
                  <div class="faq__answer">
                  <? $content['answer'] = trim($content['answer']); ?>
                    <? if(isset($content['answer']) && $content['answer'] != '') : ?>
                      <?=$content['answer'];?>
                    <? else : ?>
                      <p>Вопрос находится на рассмотрении.</p>
                    <? endif; ?>
                  </div>
                  <div class="faq_answer_cs">
                    <? if($content['no_comment'] == 0) : ?>
                      <p class="faq_answer_cs__comments" id="faq_comments" data-faq-id="<?=$content['id'];?>">Комментарии: <span class="faq_answer_cs__comments_count"><?=count($comments[$content['id']]);?></span></p>
                    <? endif; ?>
                    <div class="social_icons faq_answer_cs__socials clearfix">
                      <span>Поделиться: </span>
                      <i class="social_icon" id="social_repost" data-social-type="vk" onclick="window.open('https://vk.com/share.php?url=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>&title=<?=mb_substr(strip_tags($content['question']), 0, 140);?>','sharer','toolbar=0,status=0,width=700,height=400,top='+((screen.height-600)/2)+',left='+((screen.width-700)/2)+'');"></i>
                      <i class="social_icon" id="social_repost" data-social-type="tw" onclick="window.open('http://twitter.com/share?url=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>&text=<?=mb_substr(strip_tags($content['question']), 0, 120);?>','sharer','toolbar=0,status=0,width=700,height=400,top='+((screen.height-600)/2)+',left='+((screen.width-700)/2)+'');"></i>
                      <i class="social_icon" id="social_repost" data-social-type="fb" onclick="window.open('https://www.facebook.com/sharer.php?u=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>&title=<?=mb_substr(strip_tags($content['question']), 0, 140);?>&description=<?=strip_tags($content['answer']);?>','sharer','toolbar=0,status=0,width=700,height=400,top='+((screen.height-600)/2)+',left='+((screen.width-700)/2)+'');"></i>
                      <i class="social_icon" id="social_repost" data-social-type="ok" onclick="window.open('https://connect.ok.ru/dk?st.cmd=WidgetSharePreview&st.description=<?=strip_tags($content['answer']);?>&st.title=<?=mb_substr(strip_tags($content['question']), 0, 140);?>&st.shareUrl=<?='http://'. $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];?>','sharer','toolbar=0,status=0,width=700,height=400,top='+((screen.height-600)/2)+',left='+((screen.width-700)/2)+'');"></i>
                    </div>
                  </div>
                </div>
              </div>
              <div class="faq_block_footer clearfix">
                <p><?=$author_faq;?></p>
                <p><?=$content['answer_caption'];?> <span class="admin_filter"><?=$content['answer_name'];?></span></p>
              </div>
            <? endif; ?>
            <div class="comments_block clearfix admin_edit" data-faq-id="<?=$content['id'];?>">
                <div class="modal_close"></div>
                  <ul class="comments_list clearfix">
                    <? if(count($comments[$content['id']]) >= 1) : ?>
                      <? foreach($comments[$content['id']] as $comment) : ?>
                        <li class="admin_edit" id="comments" data-comment-id="<?=$comment['id']?>">
                          <p><?=$comment['text']?></p>
                          <p class="comments_list__autor"><?=$comment['author']?></p>
                          <p class="comments_list__time"><?=$comment['view_date']?></p>
                        </li>
                      <? endforeach; ?>
                    <? else : ?>
                      <li class="admin_edit" id="comments" data-comment-id="0">
                        <? if($content['no_comment'] == 0) : ?>
                          <p style="text-align: center;">Пока нет ни одного комментария, будьте первым!</p>
                        <? else : ?>
                          <p style="text-align: center;">Комментарии к этому вопросу запрещены.</p>
                        <? endif; ?>
                      </li>
                    <? endif; ?>
                  </ul>
                <? if($content['no_comment'] == 0) : ?>
                      <form id="form_comments" class="comments_form clearfix">
                        <input type="hidden" name="faq_id" value="<?=$content['id'];?>" />
                        <input class="comments_form__input required" type="text" name="author" value="" placeholder="Как вас зовут?"/>
                          <textarea class="comments_form__textarea required" id="c_body" name="text" cols="30" rows="5" placeholder="Текст комментария. Комментарий будет опубликован после того, как пройдет проверку модератором."></textarea>
                        <div class="captcha">
                          <div class="g-recaptcha" data-sitekey="6Lf7LiYUAAAAAAp4px2co8wMvUHRDwFOQ023zBLw"></div>
                        </div>
                        <input class="btn brd btn_submit" id="comments_submit" type="submit" value="Отправить"/>
                      </form>
                <? endif; ?>
              </div>
          </div>
        <? endforeach; ?>
      </div>
      <? if(!empty($paginator)) echo $paginator;?>
    </div>
  </div>
</section>
<div class="modal modal_question" data-modal-id="55" data-modal-open="false">
  <div class="modal_close"></div>
  <form id="add_question" class="mq_form clearfix">
    <div class="mq_form_row clearfix">
      <div class="mq_form_select_group">
        <div class="selected_activ">
          <input class="selected_checkbox" id="mqf_s" type="checkbox" name="not"/>
          <label for="mqf_s">Трудовой договор</label>
          <div class="selected_group">
            <? foreach($category as $cat) : ?>
              <? if($cat['id'] != 113) : ?>
                <p id="mq_selected" data-value="<?=$cat['id'];?>"><?=$cat['title'];?></p>
              <? endif; ?>
            <? endforeach; ?>
          </div>
        </div>
        <input class="mq_form__select" id="mqf_subject" type="hidden" name="category_id" value="103"/>
        <div class="mq_form_select_label">
          <p>Пожалуйста, уточните тему вопроса, чтобы мы смогли быстрее переслать его нужному специалисту.</p>
        </div>
      </div>
      <div class="mq_form_row_inputs clearfix">
        <input class="mq_form__input required" type="text" name="question_author_name" value="" placeholder="Как вас зовут?"/>
        <input class="mq_form__input required" type="text" name="question_author_from" value="" placeholder="Где вы живете?"/>
        <input class="mq_form__input required" type="text" name="question_author_work" value="" placeholder="Место работы"/>
      </div>
      <div class="mq_form_row_textarea clearfix">
        <textarea class="mq_form__textarea required" id="mqf_text" name="question" cols="30" rows="5" placeholder="Введите в это поле ваш вопрос."></textarea>
      </div>
      <div class="mq_form_row clearfix">
        <div class="mq_form_froup_mail">
          <input class="pf_checkbox_input mq_form__checkbox" id="mq_form_tomail" type="checkbox" name="question_author_to_mail" value=""/>
          <label class="pf_checkbox_label mq_form__label" for="mq_form_tomail">Выслать ответ на мою электронную почту.</label>
          <input class="pf_input__bbottom" type="text" name="question_author_mail" value="" placeholder="Введите ваш e-mail"/>
        </div>
        <div class="mq_form_froup_file">
          <input class="mq_form__file" id="mq_upload_file" type="file" name="docs[]" multiple="multiple" value=""/>
          <label class="mq_form__file_label" for="mq_upload_file"><span>Вы можете приложить дополнительные материалы, более полно раскрывающие суть вопроса.</span></label>
          <div class="mq_form__file_view"></div>
          <p class="mq_form__caption_file">Размер файла не&nbsp;более 5&nbsp;МБ в&nbsp;форматах JPG, PNG, DOC, PDF.</p>
        </div>
      </div>
      <div class="mq_form_row clearfix">
        <div class="mq_form_group_private">
          <input class="pf_checkbox_input" id="mq_form_private" type="checkbox" name="question_author_private" value=""/>
          <label class="pf_checkbox_label mq_form__label mq_form__label__spec" for="mq_form_private">Я&nbsp;не&nbsp;хочу, чтобы мои персональные данные были видны на&nbsp;сайте.<br>Их&nbsp;увидит только специалист, отвечая на&nbsp;вопрос.</label>
        </div>
      </div>
      <div class="mq_form_row clearfix">
        <div class="mq_form_group_private">
          <input class="pf_checkbox_input" id="mq_form_data_personal" type="checkbox" checked="checked" name="question_data_personal" value=""/>
          <label class="pf_checkbox_label mq_form__label" for="mq_form_data_personal">Cогласен на обработку персональных данных.</label>
        </div>
      </div>
      <div class="mq_form_row clearfix">
        <div class="mq_form_group_private">
          <input class="pf_checkbox_input" id="mq_form_data_membership" type="checkbox" checked="checked" name="question_data_membership" value=""/>
          <label class="pf_checkbox_label mq_form__label" for="mq_form_data_membership">Я член Общероссийского Профсоюза образования.</label>
        </div>
      </div>
      <div class="mq_form_row_btn clearfix">
        <input class="btn brd btn_submit" id="question_add" type="submit" value="Отправить"/>
      </div>
    </div>
  </form>
</div>
<div class="modals_block"></div>
<div class="comment_modal"></div>