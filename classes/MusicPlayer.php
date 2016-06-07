<?php
class MusicPlayer {
  private static $url = _PLAYER_SERVER_.':'._PLAYER_PORT_;
  public static function addToPlaylist($filePath) {
    $post = array(
      'secret' => _PLAYER_SECRET_,
      'command' => 'playlistAdd',
      'value' => $filePath,
    );
    $http = Http::get(self::$url, $post);
    if ($http->status == 200) {
      return true;
    }
    return false;
  }
  public static function getPlaylist() {
    $post = array(
      'secret' => _PLAYER_SECRET_,
      'command' => 'playlist',
    );
    $http = Http::get(self::$url, $post);
    if ($http->status == 200) {
      return json_decode($http->data);
    }
    return false;
  }
  public static function getState() {
    $post = array(
      'secret' => _PLAYER_SECRET_,
      'command' => 'playerState',
    );
    $http = Http::get(self::$url, $post);
    if ($http->status == 200) {
      return (array)json_decode($http->data);
    }
    return false;
  }
}
