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
    Controller::getInstance()->fetchController();
    exit();
  }
}
