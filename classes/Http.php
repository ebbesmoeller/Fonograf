<?php
class Http {
  public static $status;
  public static $data;

  public static function get($url, $request, $urlEncode = true) {
    $query = '';
    if (is_array($request))
      $query = http_build_query($request);
    $curlUrl = $url.'?'.$query;
    $ch = curl_init();
    if (!$urlEncode)
      $curlUrl = urldecode($curlUrl);
    curl_setopt($ch,CURLOPT_URL, $curlUrl);
    curl_setopt($ch,CURLOPT_HTTPGET, 1);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT,4000);
    curl_setopt($ch, CURLOPT_TIMEOUT, 6000);
    $result = curl_exec($ch);
    $information = curl_getinfo($ch);
    curl_close($ch);
    $http = new Http();
    $http->status = (int)$information['http_code'];
    $http->data = $result;
    return $http;
  }
  public static function post($url, $request, $urlEncode = true) {
    $query = '';
    if (is_array($request))
      $query = http_build_query($request);
    $curlUrl = $url.'?'.$query;
    $ch = curl_init();
    if (!$urlEncode)
      $curlUrl = curl_unescape($ch, $curlUrl);
    curl_setopt($ch,CURLOPT_URL, $curlUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
    curl_setopt($ch,CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT,4000);
    curl_setopt($ch, CURLOPT_TIMEOUT, 6000);
    $result = curl_exec($ch);
    $information = curl_getinfo($ch);
    curl_close($ch);
    $status = (int)$information['http_code'];
    $data = $result;
    return $status;
  }
}
