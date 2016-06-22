<!DOCTYPE html>
<html lang="<?php echo _LANGUAGE_ISO_?>">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title><?php $t->t('Fonograf')?></title>
    <link rel="stylesheet" href="/template/style/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/template/style/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="/template/style/css/animate.css">
    <link rel="stylesheet" href="/template/style/css/global.css">

    <link rel="icon" type="image/png" href="/template/style/graphics/favicon.png">
    <meta name="application-name" content="Fonograf"/>
    <meta name="msapplication-square70x70logo" content="/template/style/graphics/favicon.png"/>
    <meta name="msapplication-square150x150logo" content="/template/style/graphics/favicon.png"/>
    <meta name="msapplication-wide310x150logo" content="/template/style/graphics/faviconBig.png"/>
    <meta name="msapplication-square310x310logo" content="/template/style/graphics/faviconBig.png"/>
    <meta name="msapplication-TileColor" content="#222222"/>
    <link rel="apple-touch-icon" sizes="57x57" href="/template/style/graphics/favicon.png">
    <link rel="apple-touch-icon" sizes="60x60" href="/template/style/graphics/favicon.png">
    <link rel="apple-touch-icon" sizes="72x72" href="/template/style/graphics/favicon.png">
    <link rel="apple-touch-icon" sizes="76x76" href="/template/style/graphics/favicon.png">
    <link rel="icon" type="image/png" href="/template/style/graphics/favicon.png" sizes="32x32">
    <link rel="icon" type="image/png" href="/template/style/graphics/favicon.png" sizes="96x96">
    <link rel="icon" type="image/png" href="/template/style/graphics/favicon.png" sizes="16x16">
    <meta name="theme-color" content="#222222">
  </head>
  <body>
    <?php include('template/menu.cl') ?>
    <div id="header">
      <a class="menuBtn">
        <i class="fa fa-bars" aria-hidden="true"></i>
      </a>
      <div class="logo">
        <?php if(Authentication::isAuthenticated()) {?>
          <img src="/template/style/graphics/logoRed.png" />
        <?php } else {?>
          <img src="/template/style/graphics/logoWhite.png" />
        <?php }?>
      </div>
      <a id="toTop" title="<?php $t->t('To the top')?>">
        <i class="fa fa-chevron-up" aria-hidden="true"></i>
      </a>
    </div>
    <div id="mainContent">
