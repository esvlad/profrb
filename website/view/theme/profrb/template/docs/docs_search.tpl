<? if(!empty($contents)) : ?>
	<div class="view_docs">
		<? foreach($contents as $docs) : ?>
			<? if(isset($docs['uri']) && $docs['uri'] != '') : ?>
			<? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$docs['id'].', \'edit\');"></span>' : null; ?>
			<li class="view_docs__item">
				<?=$click;?>
				<i class="docs_icon <?=$docs['type'];?>"></i>
				<div class="docs_title">
					<a href="..<?=$docs['uri'];?>" download data-id="<?=$docs['cid'];?>"><?=$docs['title'];?></a>
					<time datetime="<?=$docs['view_date'];?>"><?=$docs['view_date'];?></time>
				</div>
			</li>
			<? endif; ?>
		<? endforeach; ?>
	</div>
<? endif; ?>