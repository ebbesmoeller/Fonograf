<?php
class Translation {
  public function t ($string) {
    self::translate($string,true);
  }
  public function r ($string) {
    return self::translate($string,false);
  }
  public function translate($string,$print) {
    $languageFile = 'translations/'._LANGUAGE_ISO_.'.php';
    if (is_file($languageFile)) {
      include($languageFile);
      if (array_key_exists($string, $translations)) {
        $string = $translations[$string];
        if ($print) {
          echo $string;
          return;
        }
      }
    }
    if ($print) {
      echo $string;
      return;
    }
    return $string;
  }
}
