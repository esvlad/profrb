<div class="admin_form_row">
  <label for="stage<?=$key;?>">Этап</label>
  <p class="admin_form_caption">Описание этапов вступления в профсоюз</p>
  <textarea id="stage<?=$key;?>" name="stage[<?=$key;?>]" data-table="fields"></textarea> 
</div>
<? $textkey = 'stage' . $key; ?>
<script>
  CKEDITOR.replace(<?=$textkey;?>);
</script>