<?php
class Colors {
  private static $url = _COLOR_SERVER_.':'._COLOR_PORT_;
  public static function setColor($color='#000000') {
    $post = array(
      'secret' => _COLOR_SECRET_,
      'command' => 'setHexColor',
      'value' => $color
    );
    $http = Http::post(self::$url, $post);
    if ($http == 200) {
      return true;
    }
    return false;
  }
  public static function loadSetColor($color='#000000') {
    $post = array(
      'secret' => _COLOR_SECRET_,
      'command' => 'loadSetColor',
      'value' => $color
    );
    $http = Http::post(self::$url, $post);
    if ($http == 200) {
      return true;
    }
    return false;
  }
  public static function blinkLeds($interval=1.0,$fadeTime=0.5,$blinks=1,$on=false) {
    $values = array(
      "interval" => (float)$interval,
      "fadeTime" => (float)$fadeTime,
      "blinks" => (int)$blinks,
      "on" => (bool)$on
    );
    $post = array(
      'secret' => _COLOR_SECRET_,
      'command' => 'blinkLeds',
      'value' => json_encode($values)
    );
    $http = Http::post(self::$url, $post);
    if ($http == 200) {
      return true;
    }
    return false;
  }
  public static function rainbow() {
    $post = array(
      'secret' => _COLOR_SECRET_,
      'command' => 'rainbow'
    );
    $http = Http::post(self::$url, $post);
    if ($http == 200) {
      return true;
    }
    return false;
  }
}
