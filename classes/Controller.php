<?php
class Controller {
  public static $instance = null;
  public static function getInstance() {
      if (!self::$instance) {
          self::$instance = new Controller();
      }
      return self::$instance;
  }
  public static function fetchController() {
    $render = new Render();

    $contentOnly = true;
    if (Post::getQuery('content_only'))
      $contentOnly = false;

    $page = Post::getQuery('p');
    if ($page != '') {
      switch ($page) {
        default:
          $render->renderPage($page, $contentOnly);
        break;
      }
    }
    else {
      $render->renderPage('index',$contentOnly);
    }
  }
}
