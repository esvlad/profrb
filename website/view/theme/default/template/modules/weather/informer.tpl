<div class="weather">
	<h3><?=$www;?></h3>
	<h2><a class="weather_link link-duration" href="<?=$weather_link_href;?>" target="_blank">Погода в <span class="weather_city"><?=$weather_city_fname;?></span></a></h2>
	<img src="<?=$weather_images;?>" alt="">
	<p class="weather_now weather_temperature temperature"><?=$weather_temperature;?></p>
	<p class="weather_details"><?=$weather_type;?></p>
	<p class="weather_details">ветер: <?=$weather_wind_direction;?>, <?=$weather_wind_speed;?> м/с</p>
	<p class="weather_details" style="margin-bottom: 15px;">влажность: <?=$weather_humidity;?>%</p>
	<p class="weather_day_tommorow"><?=$weather_day_part;?> <span class="weather_temperature temperature"><?=$weather_part_temperature;?></span></p>
<script type="text/javascript" src="/modul/weather/js/weatively.js"></script>
</div>