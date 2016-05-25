<?php
class Controller {
  public static $instance = null;
  public static function getInstance() {
      if (!self::$instance) {
          self::$instance = new Controller();
      }
      return self::$instance;
  }
  public static function fetchController($controllerName = 'index') {
    $render = new Render();
    $page = Post::getQuery('p');
    if ($page != '') {
      switch ($page) {
        case 'connectionState':
          if(ActiveDirectory::getInstance()->connectionState())
            echo 'connected';
          die();
        break;
        case 'logOut':
          Authentication::unAuthenticate();
          header("Location: /");
          die();
        break;
        default:
          $render->renderPage($page);
        break;
      }
    }
    else {
      $render->renderPage();
    }
  }
}
