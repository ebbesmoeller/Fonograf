<?php
class Http {
  public static $status;
  public static $data;

  public static function get($url, $request) {
    $query = '';
    if (is_array($request))
      $query = http_build_query($request);
    $ch = curl_init();
    curl_setopt($ch,CURLOPT_URL, $url.'?'.$query);
    curl_setopt($ch,CURLOPT_HTTPGET, 1);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
    $result = curl_exec($ch);
    $information = curl_getinfo($ch);
    curl_close($ch);

    $http = new Http();
    $http->status = (int)$information['http_code'];
    $http->data = $result;
    return $http;
  }
  public static function post($url, $request) {
    $query = '';
    if (is_array($request))
      $query = http_build_query($request);
    $ch = curl_init();
    curl_setopt($ch,CURLOPT_URL, $url.'?'.$query);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
    curl_setopt($ch,CURLOPT_POST, 1);
    $result = curl_exec($ch);
    $information = curl_getinfo($ch);
    curl_close($ch);

    $status = (int)$information['http_code'];
    $data = $result;
  }
}
