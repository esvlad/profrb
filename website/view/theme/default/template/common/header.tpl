<!DOCTYPE html>
<html lang="ru">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title><?= $title; ?></title>
	<link rel="shortcut icon" href="img/favicon_ico.png" type="image/png" />
	<link href="<?= TPL_PATH . $theme_name; ?>/js/jquery/owl.carousel/owl.carousel.css" rel="stylesheet" type="text/css" />
	<link href="<?= TPL_PATH . $theme_name; ?>/css/style.css" rel="stylesheet" type="text/css" />
	<? $basehref = isset($basehref) ? $basehref : 'http://profrb/verstka/'; ?>
	<base href="<?= $basehref; ?>" />
	<meta property="og:title" content="<?= $title; ?>" />
	<meta property="og:type" content="website" />
	<meta property="og:url" content="" />
	<? $site_name = isset($site_name) ? $site_name : 'My Site'; ?>
	<meta property="og:site_name" content="<?=$site_name;?>" />
</head>
<body>
