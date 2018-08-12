<?=$header;?>
<section class="sect 404">
  <div class="wrapper">
    <div class="content clearfix">
    	<div class="page_404">
        <pre><?print_r($unletter);?></pre>
    		<? if($unletter === true) : ?>
    			<h2>Успех!</h2><br/>
    			<p>Вы отписались от рассылки.</p>
    		<? else : ?>
    			<h2>Произошла неизвестная ошибка</h2><br/>
    			<p>Напишите об этом администратору сайта на <a href="mailto:eduprofrb@ufamail.ru">eduprofrb@ufamail.ru</a>.</p>
    		<? endif; ?>
    	</div>
    </div>
  </div>
</section>
<?=$footer;?>