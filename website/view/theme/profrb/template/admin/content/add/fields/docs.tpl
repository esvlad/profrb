<div class="admin_form_row">
  <label for="docs_title">Введите название документа</label>
  <input id="docs_title" class="docs_title" type="text" name="docs_title[<?=$key;?>]" value="">
  <label for="docs">Документ</label>
  <div id="fileUpload<?=$key;?>" class="file_upload clearfix">
    <input id="docs<?=$key;?>" type="file" name="docs[<?=$key;?>]" data-table="fields" data-file-type="docs" class="file_upload_input" onchange="getUploadFiles('docs<?=$key;?>');" value="">
    <div class="file_viewed clearfix"></div>
    <div id="fileUploaded" class="btn btn_admin" onclick="fileUploadBtn('docs<?=$key;?>');">Добавить файл</div>
    <input class="file_upload_filed" type="hidden" name="docs[<?=$key;?>]" value="">
  </div>
  <label class="sortered">Порядок отображения: 
    <select name="order[<?=$key;?>]">
      <? for($o = -20; $o <= 20; $o++) : ?>
        <? if($o == $key) : ?>
          <option value="<?=$o;?>" selected><?=$o;?></option>
        <? else : ?>
          <option value="<?=$o;?>"><?=$o;?></option>
        <? endif; ?>
      <? endfor; ?>
      <? if($key > $o) : ?>
        <option value="21" selected>21</option>
      <? endif; ?>
    </select>
  </label>
  <p class="admin_form_caption">Можно прикрепить лишь 1 документ. Разрешены форматы: DOC, DOCX, PDF, RAR, ZIP</p>
</div>