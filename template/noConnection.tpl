<html>
  <head>
    <title><?php $t->t('Fonograf')?></title>
    <link rel="stylesheet" href="/template/style/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/template/style/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="/template/style/css/animate.css">
    <link rel="stylesheet" href="/template/style/css/global.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="/template/style/graphics/favicon.png?1">
  </head>
  <body id="<?php echo $thisController?>">
    <div id="mainContent">
      <img src="/template/style/graphics/logoWhite.png"/>
      <h2><?php $t->t('No connection to database!')?></h2>
      <br />
      <br />
      <a href="javascript:history.go(0);" class="btn btn-primary"><i class="fa fa-refresh fa-spin fa-fw" aria-hidden="true"></i>&nbsp;<?php $t->t('Reload page')?></a>

    </div><!-- Main content end -->
    <script src="/template/style/js/jquery-2.2.3.min.js"></script>
    <script src="/template/style/bootstrap/js/bootstrap.min.js"></script>
    <script src="/template/style/js/global.js"></script>
    <script>
      $(document).ready(function(){
        $('body').addClass('ready');
        setTimeout(function(){
          triggerLoaded();
        }, 2000);
      });
      $(window).bind("load", function() {
        triggerLoaded();
      });
      function triggerLoaded() {
        $('body').addClass('loaded');
      }
    </script>
  </body>
</html>
