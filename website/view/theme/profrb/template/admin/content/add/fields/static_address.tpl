<div class="admin_form_row">
  <label for="static_address<?=$key;?>">Адресный блок</label>
  <p class="admin_form_caption">Обычный адресный блок справа. П.С.: не забудьте написать заголовок и выделить его жирным</p>
  <textarea id="static_address<?=$key;?>" name="static_address[<?=$key;?>]" data-table="fields"></textarea> 
</div>
<? $textkey = 'static_address' . $key; ?>
<script>
  CKEDITOR.replace(<?=$textkey;?>);
</script>