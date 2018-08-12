<div class="admin_form_row">
  <label for="text">Текст</label>
  <p class="admin_form_caption">Обычный текстовый блок</p>
  <textarea id="text<?=$key;?>" name="text[<?=$key;?>]" data-table="fields"></textarea>
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
</div>
<? $textkey = 'text' . $key; ?>
<script>
  CKEDITOR.replace(<?=$textkey;?>);
</script>