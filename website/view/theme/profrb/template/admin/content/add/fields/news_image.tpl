<div class="admin_form_row">
	<label for="news_image_title">Введите описание изображения (не обязательно)</label>
  	<input id="news_image_title" class="docs_title" type="text" name="news_image_title[<?=$key;?>]" value="">
	<label for="news_image">Большая картинка</label>
	<div id="fileUpload<?=$key;?>" class="file_upload clearfix">
		<input id="news_image<?=$key;?>" type="file" name="news_image[<?=$key;?>]" data-table="fields" data-file-type="images" class="file_upload_input" onchange="getUploadFiles('news_image<?=$key;?>');" value="">
		<div class="file_viewed clearfix"></div>
		<div id="fileUploaded" class="btn btn_admin" onclick="fileUploadBtn('news_image<?=$key;?>');">Добавить файл</div>
		<input class="file_upload_filed" type="hidden" name="news_image[<?=$key;?>]" value="">
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
	<p class="admin_form_caption">Можно прикрепить лишь 1 фотографию. Минимальный размер ширины 1100px. Разрешены форматы: JPG, PNG, GIF</p>
</div>