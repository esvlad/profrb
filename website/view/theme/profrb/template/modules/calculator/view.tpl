<section class="sect calculator">
  <div class="wrapper">
    <div class="content">
      <h1 class="section_title"><?=$setting['title'];?></h1>
      <div class="view_block clearfix">
      	<?=Functions::f_typograf($setting['caption']);?>
      </div>
      <div id="calculator" class="view_block calculator_block">
      	<div class="modal_question">
      		<div class="mq_form_row clearfix">
		        <div class="row clearfix bilet_number bilet_disabled" style="display: table;">
		        	<input class="mq_form__input _input_bilet" type="text" name="calc_bilet" value="" placeholder="Номер профсоюзного билета" id="bilet" />
		        	<?=Functions::calc_prompt($setting['prompt']['bilet']);?>
		        </div>
		        <div class="row clearfix calc_jobs">
		        	<div class="calc_selected">
			            <input class="selected_checkbox" id="jobs" type="checkbox" name="not" disabled="disabled" />
			            <label for="jobs">Выберите место работы</label>
			            <div class="calc_selected_group">
			              <? foreach($jobs as $job) : ?>
			                  <p data-value="<?=$job['id'];?>" onclick="calc_selected(<?=$job['id'];?>, 'calc_jobs')"><?=$job['name'];?></p>
			              <? endforeach; ?>
			            </div>
			            <?=Functions::calc_prompt($setting['prompt']['jobs']);?>
		        	</div>
		        	<input id="jobs" type="hidden" name="job_id" value=""/>
		        </div>
		        <div class="row clearfix calc_position hidden">
		        	<div class="calc_selected">
			            <input class="selected_checkbox" id="position" type="checkbox" name="not"/>
			            <label for="position">Выберите должность</label>
			            <div class="calc_selected_group"></div>
			            <?=Functions::calc_prompt($setting['prompt']['position']);?>
		        	</div>
		        	<input type="hidden" name="position" value=""/>
		        </div>
		        <div class="row clearfix calc_position_info hidden">
		        	<div class="col oklad">
		        		<p>Ставка <span class="oklad_text"></span> рублей</p>
		        	</div>
		        	<div class="col norm_hour">
		        		<p>Норма <span class="norm_hour_text"></span> <span class="norm_hour_text_caption"></span></p>
		        	</div>
		        </div>
		        <div class="row calc_norm_hour clearfix" style="display: table;">
		        	<h3 class="calc_title_form"></h3>
		          	<input class="mq_form__input" type="text" name="how_norm_hour" value="" placeholder="Сколько часов вы работаете?" onkeyup="this.value = this.value.replace(/[^\d]/g,'');" disabled="disabled" />
		          	<?=Functions::calc_prompt($setting['prompt']['how_norm_hour']);?>
		        </div>
		        <div class="row clearfix calc_result hidden">
		        	<p>За <span class="rh"></span> <span class="rh_text hht"></span> работы оплата составит <span class="rrub"></span> рублей.</p>
		        </div>
		        <div class="row calc_buttons_submit clearfix">
		        	<input class="btn brd btn_submit" id="calculate" type="submit" value="Рассчитать"/>
		        </div>
		        <div class="row clearfix calc_compensation hidden">
		        	<div class="calc_selected">
			            <input class="selected_checkbox" id="compensation" type="checkbox" name="compensation"/>
			            <label for="compensation">Компенсационные выплаты</label>
			            <div class="calc_selected_group"><div class="calc_selected_group_list"></div></div>
			            <?=Functions::calc_prompt($setting['prompt']['compensation']);?>
		        	</div>
		        </div>
		        <div class="row clearfix calc_compensation_info hidden">
		        	<div class="calc_compensation_info_items"></div>
		        </div>
		        <div class="row clearfix calc_pays hidden">
		        	<div class="calc_selected">
			            <input class="selected_checkbox" id="pays" type="checkbox" name="pays"/>
			            <label for="pays">Стимулирующие выплаты</label>
			            <div class="calc_selected_group"><div class="calc_selected_group_list"></div></div>
			            <?=Functions::calc_prompt($setting['prompt']['pays']);?>
		        	</div>
		        </div>
		        <div class="row clearfix calc_pays_info hidden">
		        	<div class="calc_pays_info_items"></div>
		        </div>
		        <div class="row clearfix calc_dop_pays hidden">
		        	<div class="mq_form_group_private">
			            <input class="pf_checkbox_input" id="tr_dop_cpays" type="checkbox" name="tr_dop_cpays" value="">
			            <label class="pf_checkbox_label mq_form__label" for="tr_dop_cpays"><span>Республиканская выплата за осуществление функций классного руководителя</span></label>
			            <input class="mq_form__input disabled" type="text" name="dop_cpays" value="" placeholder="Количество учащихся" onkeyup="this.value = this.value.replace(/[^\d]/g,'');" disabled="disabled">
			            <?=Functions::calc_prompt($setting['prompt']['dop_cpays']);?>
			        </div>
		        </div>
		        <div class="row clearfix calc_result_summ hidden">
		        	<p>Начисленная заработная плата составит <b class="calc_result_summ_text"></b> рублей.</p>
		        </div>
		        <div class="row calc_buttons clearfix">
		          <input class="btn brd btn_submit hidden" id="reset_calc" type="reset" value="Сбросить данные"/>
		          <input class="btn brd btn_submit hidden" id="print_calc" type="submit" value="Распечатать"/>
		        </div>
		      </div>
      	</div>
      </div>
    </div>
  </div>
</section>
<script src="../<?= TPL_PATH . THEME_NAME; ?>/js/jquery.maskedinput.min.js"></script>