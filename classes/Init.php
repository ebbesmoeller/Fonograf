<?php
class Init {
  public static $instance = null;
  public static function getInstance() {
      if (!self::$instance) {
          self::$instance = new Init();
      }
      return self::$instance;
  }
  public function init() {
    if (!_DEBUG_) {
      error_reporting(E_ERROR | E_PARSE);
    }
    session_start();
    ini_set('session.save_path',$_SERVER['DOCUMENT_ROOT'] . "/sessions");
    if (!Database::getInstance()->isConnected()) {
      $render = new Render();
      $render->renderPage('dbNoConnection', false);
    }
    else if (!MusicPlayer::getInstance()->isConnected()) {
      $render = new Render();
      $render->renderPage('mpNoConnection', false);
    }
    else {
      Controller::getInstance()->fetchController();
    }
    exit();
  }
}
