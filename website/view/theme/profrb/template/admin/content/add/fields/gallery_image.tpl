<div class="admin_form_row">
	<label for="gallery_image">Галерея изображений</label>
	<div id="fileUpload<?=$key;?>" class="file_upload clearfix">
		<input id="gallery_image<?=$key;?>" type="file" name="gallery_image[<?=$key;?>]" multiple data-table="fields" data-file-type="images" class="file_upload_input" onchange="getUploadFiles('gallery_image<?=$key;?>');" value="">
		<div class="file_viewed clearfix"></div>
		<div id="fileUploaded" class="btn btn_admin" onclick="fileUploadBtn('gallery_image<?=$key;?>');">Добавить файл</div>
		<input class="file_upload_filed" type="hidden" name="gallery_image[<?=$key;?>]" value="">
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
	<p class="admin_form_caption">Можно прикрепить много фотографий. Минимальный размер ширины 820px. Разрешены форматы: JPG, PNG, GIF</p>
</div>