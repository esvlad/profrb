<section class="sect second_menu">
	<div class="wrapper">
		<div class="content">
			<ul class="second_menu__list_view">
		        <li><a href="/history" target="_self">История</a></li>
		        <li class="active"><a href="/geo" target="_self">География</a></li>
		        <li><a href="/workers" target="_self">Сотрудники</a></li>
		        <li><a href="/structure" target="_self">Структура</a></li>
			</ul>
    	</div>
  	</div>
</section>
<section class="sect <?=$sect_class;?>">
	<div class="wrappall">
		<div class="content">
			<? foreach($area_city['category'] as $value) : ?>
				<? if($value['id'] == $category_id) : ?>
					<h1 class="section_title geografy_name"><span><i class="geo_pin_city"></i><?=$value['title'];?></span></h1>
				<? endif; ?>
			<? endforeach; ?>
			<div class="view_block geo_block geo_city_list admin_edit" data-block-name="geo_list">
        		<div class="geo_close"></div>
        		<? if(in_array('city', $area_city['areas'])) : ?>
	        		<div class="geo_list_block active geo_lict_city">
	          			<h4 class="geo_list_block__title">Города</h4>
	          			<ul class="geo_list_block__lists">
	          				<? foreach($area_city['category'] as $value) : ?>
								<? if($value['params'] == 'city') : ?>
			          				<li class="visible"><a href="./geo_city/<?=$value['id']?>"><?=mb_strtolower($value['title']);?></a></li>
								<? endif; ?>
							<? endforeach; ?>
	          			</ul>
	        		</div>
	        	<? endif; ?>
		        <? if(in_array('area', $area_city['areas'])) : ?>
		        	<div class="geo_list_block geo_lict_area">
						<h4 class="geo_list_block__title">Районы</h4>
						<ul class="geo_list_block__lists">
				            <? foreach($area_city['category'] as $value) : ?>
								<? if($value['params'] == 'area') : ?>
			          				<li class="visible"><a href="./geo_city/<?=$value['id']?>"><?=mb_strtolower($value['title']);?></a></li>
								<? endif; ?>
							<? endforeach; ?>
			          	</ul>
		        	</div>
		        <? endif; ?>
      		</div>
      		<form class="search_form">
		        <input class="search_form__input brd" type="text" name="search" value="" placeholder="Введите название населенного пункта" autocomplete="off"/>
		        <input class="search_form__submit" type="submit" value="" disabled="disabled" />
      		</form>
      		<div class="section_switch" id="switch" data-switch-count="<?=count($filters);?>">
      			<? foreach($filters as $filter) : ?>
      				<? if($filter['id'] == 1) : ?>
	        			<div class="switch_label active btn_dotted" data-switch="<?=$filter['id'];?>" data-btn-text="<?=$filter['title'];?>"><?=$filter['title'];?></div>
	        		<? else : ?>
	        			<div class="switch_label btn_dotted" data-switch="<?=$filter['id'];?>" data-btn-text="<?=$filter['title'];?>"><?=$filter['title'];?></div>
	        		<? endif; ?>
			      <? endforeach; ?>
      		</div>
      		
      		<div class="view_block geo_block active admin_edit" data-block-id="15" data-block-name="geo_area_list" data-switch="1">
		        <ul class="geo_block_list">
		        	<? foreach($content as $geo) : ?>
		        		<? if($geo['filter_id'] == 1) : ?>
			        		<? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$geo['id'].', \'edit\');"></span>' : null; ?>
							<li>
								<p id="btn_modal" data-modal-id="<?=$geo['id']?>" data-modal-block="geo"><?=$geo['title']?></p>
								<?=$click;?>
				          	</li>
			          	<? endif; ?>
			        <? endforeach; ?>
		        </ul>
			</div>
			<div class="view_block geo_block admin_edit" data-block-id="16" data-block-name="geo_colledge_list" data-switch="2">
		        <ul class="geo_block_list">
		        	<? foreach($content as $geo) : ?>
		        		<? if($geo['filter_id'] == 2) : ?>
			        		<? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$geo['id'].', \'edit\');"></span>' : null; ?>
							<li>
								<p id="btn_modal" data-modal-id="<?=$geo['id']?>" data-modal-block="geo"><?=$geo['title']?></p>
				            	<p><?=$geo['body']?></p>
								<?=$click;?>
				          	</li>
			          	<? endif; ?>
			        <? endforeach; ?>
		        </ul>
      		</div>
      		<div class="view_block geo_block admin_edit" data-block-id="17" data-block-name="geo_vvuz_list" data-switch="3">
		        <ul class="geo_block_list">
		          	<? foreach($content as $geo) : ?>
		        		<? if($geo['filter_id'] == 3) : ?>
			        		<? $click = !empty($is_admin) ? '<span class="admin_edit_content" onclick="content_event('.$geo['id'].', \'edit\');"></span>' : null; ?>
							<li>
								<p id="btn_modal" data-modal-id="<?=$geo['id']?>" data-modal-block="geo"><?=$geo['title']?></p>
				            	<p><?=$geo['body']?></p>
								<?=$click;?>
				          	</li>
			          	<? endif; ?>
			        <? endforeach; ?>
		        </ul>
      		</div>
    	</div>
  	</div>
</section>
<? foreach($modal as $key => $value) : ?>
	<? 
		if(count($value['docs']) > 0) $docs = $value['docs'];
		unset($value['docs']);

		if(count($value['news']) > 0){
			$news = $value['news'];
			$count_news = $value['count_news'];
		}
		unset($value['news']);
		unset($value['count_news']);

		if(!empty($value['coordinates'])) $coordinates = $value['coordinates'];
		$cord = explode(',',$coordinates);
		$cord_x = round($cord[0], 6);
		$cord_y = round($cord[1], 6);
		unset($value['coordinates']);
	?>
	<? $dogovor = 'Коллективный договор'; ?>
	<div class="modal modal_geo" data-modal-id="<?=$key;?>" data-modal-block="geo" data-modal-open="false">
		<div class="modal_close"></div>
		<? foreach($value as $geo) : ?>
			<div class="modal_view clearfix">
				<? if($geo['modal_title']['body'] == 'Без названия') {
						foreach($content as $v){
							if($v['id'] == $key){
								$geo['modal_title']['body'] = $v['title'];
								$dogovor = 'Отраслевое соглашение';
							}
						}
					} elseif($geo['modal_title']['body'] == 'Профсоюз трудящихся'){
						$geo['modal_title']['body'] = 'Профсоюзная организация работников';
					} elseif($geo['modal_title']['body'] == 'Профсоюз учащихся'){
						$geo['modal_title']['body'] = 'Профсоюзная организация студентов';
					}

					$geo_image_modal = ($geo['view_profile']['body']['path'] && file_exists($_SERVER['DOCUMENT_ROOT'] . $geo['view_profile']['body']['path'])) ? $geo['view_profile']['body']['path'] : '/uploads/images/geo/obrazec_110400.jpg';
				?>
				<h4 class="modal_title"><?=$geo['modal_title']['body'];?></h4>
				<div class="modal_view__profile clearfix"><img src="..<?=$geo_image_modal;?>"/>
					<p class="modal_view__profile_title"><?=$geo['view_profile_title']['body'];?></p>
					<? if($geo['view_profile_mail']['body']) : ?>
						<p class="modal_view__profile_title"><?=$geo['view_profile_phone']['body'];?></p>
						<p class="modal_view__profile_phone"><?=$geo['view_profile_mail']['body'];?></p>
					<? else : ?>
						<p class="modal_view__profile_phone"><?=$geo['view_profile_phone']['body'];?></p>
					<? endif; ?>
					<?=$geo['position']['body'];?>
				</div>
				<ul class="modal_view__docs view_docs">
					<? if($geo['modal_title']['body'] != 'Профсоюзная организация студентов') : ?>
						<li class="view_docs__item">
							<i class="docs_icon docs_icon__doc"></i>
							<div class="docs_title">
								<a href="..<?=$geo['geo_docs']['body']['path'];?>"><?=$dogovor;?></a>
							</div>
						</li>
					<? endif; ?>
				</ul>
				<div class="modal_view__caption clearfix">
					<?=$geo['geo_profile']['body'];?>
				</div>
			</div>
		<? endforeach; ?>
		<div class="modal_view maps clearfix">
			<div class="btn brd btn_geo_map" data-cords="<?=$coordinates;?>" data-cordx="<?=$cord_x;?>" data-cordy="<?=$cord_y;?>" data-open-map="false">Показать на карте</div>
			<div class="geo_map" data-map="false">
				<div id="GMap"></div>
			</div>
		</div>
		<? if(!empty($docs)) : ?>
			<div class="modal_view documents clearfix">
				<h4 class="modal_title">Документы</h4>
				<div class="view_docs clearfix">
					<? foreach($docs as $value) : ?>
						<? $doc = json_decode($value['body'], true); ?>
						<li class="view_docs__item">
							<i class="docs_icon docs_icon__pdf"></i>
							<div class="docs_title">
				                <a href="<?=$doc['path'];?>" download="" data-id="642"><?=$doc['title'];?></a>
				              </div>
						</li>
					<? endforeach; ?>
				</div>
			</div>
		<? endif; ?>
		<? if(!empty($news)) : ?>
			<div class="modal_view geo_news clearfix">
				<h4 class="modal_title">Новости</h4>
				<div class="geo_news_block clearfix">
					<? foreach($news as $value) : ?>
						<div class="geo_news__content">
							<time datetime="<?=$value['date_creat'];?>"><?=$value['date_creat'];?></time>
							<?=$value['body'];?>
						</div>
					<? endforeach; ?>
				</div>
				<? if($count_news > 10) : ?>
					<div id="more_geo_news" class="btn brd btn_submit btn_geo_news" data-page="2">Показать ещё</div>
				<? endif; ?>
			</div>
		<? endif; ?>
	</div>
<? endforeach; ?>