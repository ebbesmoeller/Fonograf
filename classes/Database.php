<?php
class Database {
  public static $instance = null;
  public static $dbConnection;
  public static function getInstance() {
      if (!self::$instance) {
          self::$instance = new Database();
      }
      return self::$instance;
  }
  private function query($query = "") {
    $dbConnection = new mysqli(_SQL_SERVER_, _SQL_USER_, _SQL_PASS_,_SQL_DB_,_SQL_PORT_);
    if (!$dbConnection->connect_errno > 0) {
      if ($query != '') {
        if($result = $dbConnection->query($query)){
          if ($result->num_rows) {
            $resultsArr = array();
            while($row = $result->fetch_assoc()) {
              $resultsArr[] = $row;
            }
            return $resultsArr;
          }
        }
      }
      return true;
    }
    return false;
  }

  public function isConnected() {
    return self::query();
  }

  public function getRow($query) {
    return self::query($query)[0];
  }
  public function executeS($query) {
    return self::query($query);
  }
  public function execute($query) {
    self::query($query);
  }

  public static function cleanInput($input) {
    $toRemove = [';'];
    $input = str_replace($toRemove,'',$input);
    $input = str_replace('\'','\'\'',$input);
    $input = str_replace('"','""',$input);
    $input = htmlentities($input);
    return $input;
  }
}
