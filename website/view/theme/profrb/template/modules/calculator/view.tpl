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
		        <div class="row clearfix">
		        	<input class="mq_form__input _input_bilet" type="text" name="calc_bilet" value="" placeholder="Номер профсоюзного билета" id="bilet" />
		        </div>
		        <div class="row clearfix calc_jobs">
		        	<div class="calc_selected">
			            <input class="selected_checkbox" id="jobs" type="checkbox" name="not"/>
			            <label for="jobs">Выберите место работы</label>
			            <div class="calc_selected_group">
			              <? foreach($jobs as $job) : ?>
			                  <p data-value="<?=$job['id'];?>" onclick="calc_selected(<?=$job['id'];?>, 'calc_jobs')"><?=$job['name'];?></p>
			              <? endforeach; ?>
			            </div>
		        	</div>
		        	<input id="jobs" type="hidden" name="job_id" value=""/>
		        </div>
		        <div class="row clearfix calc_position hidden">
		        	<div class="calc_selected">
			            <input class="selected_checkbox" id="position" type="checkbox" name="not"/>
			            <label for="position">Выберите должность</label>
			            <div class="calc_selected_group"></div>
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
		        <div class="row calc_norm_hour clearfix">
		        	<h3 class="calc_title_form"></h3>
		          	<input class="mq_form__input" type="text" name="how_norm_hour" value="" placeholder="Сколько часов вы работаете?" />
		        </div>
		        <div class="row clearfix calc_result hidden">
		        	<p>За <span class="rh"></span> <span class="rh_text hht"></span> работы оплата составит <span class="rrub"></span> рублей. Ваш оклад <span class="okl"></span> рублей, а норма работы <span class="nh"></span> <span class="nh_text hht"></span>.</p>
		        </div>
		        <div class="row calc_buttons clearfix">
		          <input class="btn brd btn_submit" id="calculate" type="submit" value="Рассчитать"/>
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