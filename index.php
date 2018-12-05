<?php
session_start();
// Version
define('VERSION', '1.1.0');
date_default_timezone_set('Asia/Yekaterinburg');

// Configuration
if (is_file('config.php')) {
	require_once('config.php');
}

// MobileDetect
require_once(DIR_SYSTEM . 'plugins/MobileDetect.php');
$detect = new MobileDetect();
if($detect->isMobile() && !$detect->isTablet()){
	define('IS_MOBILE', true);
} else{
	define('IS_MOBILE', false);
}

require_once(DIR_SYSTEM . 'lib/Registry.php');
$registry = new Registry();

// DB
require_once(DIR_SYSTEM . 'lib/SafeMySQL.php');
$db = new \SafeMySQL();

//Document
require_once(DIR_SYSTEM . 'lib/Document.php');

require_once('system/lib/MVC.php');
require_once('system/lib/SystemAction.php');

require_once('system/lib/Action.php');
require_once('system/site/HtmlHelper.php');
require_once('system/site/Image.php');
include('system/site/Paginator.php');
include('system/site/EMT.php');
include('system/site/ClassMail.php');
include('system/site/Functions.php');
include('website/models/faq/recaptchalib.php');

if (isset($_GET['r'])) {
	$action = new Action(CONTROLLER, $_GET['r']);
	echo $action->loader();
} else {
	if(empty($_GET['_route_'])) $_GET['_route_'] = 'home';
	require_once('system/lib/Router.php');

	$route = new Router($_GET['_route_']);
	$router = $route->getRoute();

	$action = new Action(CONTROLLER, $router['type']);
	echo $action->loader('index', $router);
}

?>