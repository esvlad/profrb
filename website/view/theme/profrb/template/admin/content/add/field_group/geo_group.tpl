<div id="geo_group" data-group="<?=$key_group;?>" class="admin_field_group">
  <p class="admin_field_group_title">Данные в модалке</p>
  <div class="admin_form_row">
    <label for="geo_modal">Название группы</label>
    <p class="admin_form_caption">Профсоюз трудящихся/учащихся</p>
    <select id="modal_title" name="modal_title[group][]" data-table="fields">
      <option value="0">Без названия</option>
      <option value="1">Профсоюз трудящихся</option>
      <option value="2">Профсоюз учащихся</option>
    </select>
  </div>
  <div class="admin_form_row">
    <label for="view_profile">Фото ответственного</label>
    <div id="fileUpload<?=++$key;?>" class="file_upload clearfix">
      <input id="view_profile<?=$key;?>" type="file" name="view_profile[]" data-table="fields" data-file-type="images" class="file_upload_input" onchange="getUploadFiles('view_profile<?=$key;?>');" value="">
      <div class="file_viewed clearfix"></div>
      <div id="fileUploaded" class="btn btn_admin" onclick="fileUploadBtn('view_profile<?=$key;?>');">Добавить файл</div>
      <input class="file_upload_filed" type="hidden" name="view_profile[group][]" value="">
    </div>
    <p class="admin_form_caption">Можно прикрепить лишь 1 фотографию</p>
  </div>
  <div class="admin_form_row">
    <label for="view_profile_title">ФИО</label>
    <p class="admin_form_caption">ФИО ответственного лица или руководителя</p>
    <input id="view_profile_title" name="view_profile_title[group][]" data-table="fields" value="">
  </div>
  <div class="admin_form_row">
    <label for="view_profile_phone">Телефон</label>
    <p class="admin_form_caption">Телефон ответственного лица или руководителя</p>
    <input id="view_profile_phone" name="view_profile_phone[group][]" data-table="fields" value="">
  </div>
  <div class="admin_form_row">
    <label for="view_profile_mail">E-mail</label>
    <p class="admin_form_caption">E-mail адрес ответственного лица или руководителя</p>
    <input id="view_profile_mail1" name="view_profile_mail[group][]" data-table="fields" value="">
  </div>
  <div class="admin_form_row">
    <label for="position">Должность</label>
    <p class="admin_form_caption">Описание должности ответственного лица или руководителя</p>
    <textarea id="position<?=++$key;?>" name="position[group][]" data-table="fields" style="visibility: hidden; display: none;"></textarea> 
    <? $position_key = 'position'.$key; ?>
  </div>
  <div class="admin_form_row">
    <label for="geo_profile">Описание</label>
    <p class="admin_form_caption">Описание организации</p>
    <textarea id="geo_profile<?=++$key;?>" name="geo_profile[group][]" data-table="fields" style="visibility: hidden; display: none;"></textarea> 
    <? $text_key = 'geo_profile'.$key; ?>
  </div>
  <div class="admin_form_row">
    <label for="geo_docs">Документ</label>
    <div id="fileUpload<?=++$key;?>" class="file_upload clearfix">
      <input id="geo_docs<?=$key;?>" type="file" name="geo_docs[]" data-table="fields" data-file-type="docs" class="file_upload_input" onchange="getUploadFiles('geo_docs<?=$key;?>');" value="">
      <div class="file_viewed clearfix"></div>
      <div id="fileUploaded" class="btn btn_admin" onclick="fileUploadBtn('geo_docs<?=$key;?>');">Добавить файл</div>
      <input class="file_upload_filed" type="hidden" name="geo_docs[group][]" value="">
    </div>
    <p class="admin_form_caption">Можно прикрепить лишь 1 документ</p>
  </div>
</div>
<script>
  CKEDITOR.replace(<?=$text_key;?>);
  CKEDITOR.replace(<?=$position_key;?>);

  $('#add_group').attr('disabled','disabled');
</script>