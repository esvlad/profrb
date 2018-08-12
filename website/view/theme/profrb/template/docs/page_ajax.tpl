<? if(!empty($contents)) : ?>
	<div class="view_docs">
		<? foreach($contents as $docs) : ?>
			<? if(isset($docs['body']['path']) && $docs['body']['path'] != '') : ?>
			<? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$docs['cid'].', \'edit\');"></span>' : null; ?>
			<li class="view_docs__item">
				<?=$click;?>
				<i class="docs_icon <?=$docs['docs_icon_class'];?>"></i>
				<div class="docs_title">
					<a href="..<?=$docs['body']['path'];?>" download data-id="<?=$docs['cid'];?>"><?=$docs['title'];?></a>
					<time datetime="<?=$docs['view_date'];?>"><?=$docs['view_date'];?></time>
				</div>
			</li>
			<? endif; ?>
		<? endforeach; ?>
	</div>
	<?=$paginator;?>
<? endif; ?>