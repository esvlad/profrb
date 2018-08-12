<?php
if (version_compare(phpversion(), '5.3.0', '<') == true) {
	exit('PHP5.3+ Required');
}

// HTTP
define('HTTP_SERVER', '');

// HTTPS
define('HTTPS_SERVER', '');

//DIRECTORY
define('DYRR', '');

// DIR
define('DIR_APPLICATION', DYRR.'/website/');
define('DIR_SYSTEM', DYRR.'/system/');
define('DIR_LANGUAGE', DYRR.'/website/language/');
define('DIR_TEMPLATE', DYRR.'/website/view/theme/');
define('DIR_CONFIG', DYRR.'/system/config/');
define('DIR_CACHE', DYRR.'/cache/');
define('DIR_AUDIO', DYRR.'/uploads/audio/');
define('DIR_DOCUMENTS', DYRR.'/uploads/documents/');
define('DIR_FILES', DYRR.'/uploads/files/');
define('DIR_IMAGES', DYRR.'/uploads/images/');
define('DIR_VIDEO', DYRR.'/uploads/video/');
define('TPL_PATH', 'website/view/theme/');

// DB
#ip 37.140.192.170
define('DB_DRIVER', 'mysql');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', '');
define('DB_PASSWORD', '');
define('DB_DATABASE', '');
define('DB_PORT', '3306');
define('DB_PREFIX', '');

// LOADER
define('CONTROLLER', 'controller');
define('MODEL', 'model');

// THEME
define('THEME_NAME', '');
