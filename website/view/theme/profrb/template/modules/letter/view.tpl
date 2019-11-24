<? $placeholder = IS_MOBILE ? 'Впишите сюда адрес вашей почты' : 'Впишите сюда адрес вашей почты и нажмите Enter'; ?>
<div class="btn brd btn_letter" id="letter">Подписаться
  <div class="mini_modal footer_letter_modal">
    <div class="modal_close"></div>
    <p class="flm_title">Отметьте разделы, обновления которых вам интересны:</p>
    <form id="subscribe" class="mini_form clearfix">
      <div class="clearfix">
        <div class="mini_form_label__group_col_50">
          <input class="mini_form_checkbox" id="letter_news" type="checkbox" name="letter[]" value="news"/>
          <label class="mini_form_label" for="letter_news">Новости</label>
        </div>
        <div class="mini_form_label__group_col_50">
          <input class="mini_form_checkbox" id="letter_docs" type="checkbox" name="letter[]" value="docs"/>
          <label class="mini_form_label" for="letter_docs">Документы</label>
        </div>
        <div class="mini_form_label__group_col_50">
          <input class="mini_form_checkbox" id="letter_events" type="checkbox" name="letter[]" value="events"/>
          <label class="mini_form_label" for="letter_events">Мероприятия</label>
        </div>
      </div>
      <div class="_politics">
        <input class="pf_checkbox_input _is_politics_subs" id="_form_data_subs" type="checkbox" checked="checked"/>
        <label class="pf_checkbox_label mq_form__label _is_politics" for="_form_data_subs">Cогласен на <a href="../uploads/documents/Политика_в_отношении_обработки_персональных_данных.pdf" target="_blank">обработку персональных данных</a>.</label>
      </div>
      <div class="mini_form_label__group_row">
        <input class="mini_form_email required" type="email" name="mail" value="" placeholder="<?=$placeholder;?>" required/>
        <input class="mini_form_submit" type="submit" value="Отправить">
      </div>
    </form>
  </div>
</div>