<?php
class PlayerState {
  public static $pause;
  public static $mute;
  public static $playing;
  public static $index;
  public static $loop;
  public static $volume;
}
class MusicPlayer {
  public static $instance = null;
  private static $playerState;
  private static $url = _PLAYER_SERVER_.':'._PLAYER_PORT_;
  public static function getInstance() {
      if (!self::$instance) {
          self::$instance = new MusicPlayer();
          self::populateState();
      }
      return self::$instance;
  }
  private static function populateState() {
    $post = array(
      'secret' => _PLAYER_SECRET_,
      'command' => 'playerState',
    );
    $http = Http::get(self::$url, $post);
    $playerState = new PlayerState();
    if ($http->status == 200) {
      $data = (array)json_decode($http->data);
      $playerState->pause = $data['pause'];
      $playerState->mute = $data['mute'];
      $playerState->playing = $data['playing'];
      $playerState->index = $data['index'];
      $playerState->loop = $data['loop'];
      $playerState->volume = $data['volume'];
    }
    self::$playerState = $playerState;
  }
  public static function isConnected() {
    if (!empty((array)self::getPlayerState()))
      return true;
    return false;
  }
  public static function getPlayerState() {
    self::populateState();
    if (self::$playerState)
      return self::$playerState;
    else
      return false;
  }
  public static function setVolume($percentage) {
    $post = array(
      'secret' => _PLAYER_SECRET_,
      'command' => 'setVolume',
      'value' => (int)$percentage,
    );
    $http = Http::post(self::$url, $post);
    if ($http == 200) {
      self::populateState();
      return true;
    }
    return false;
  }
  public static function setPause() {
    $post = array(
      'secret' => _PLAYER_SECRET_,
      'command' => 'setPause',
      'value' => '',
    );
    $http = Http::post(self::$url, $post);
    if ($http == 200) {
      self::populateState();
      return true;
    }
    return false;
  }
  public static function skipToIndex($index) {
    $post = array(
      'secret' => _PLAYER_SECRET_,
      'command' => 'skipToIndex',
      'value' => (int)$index,
    );
    $http = Http::post(self::$url, $post);
    if ($http == 200) {
      self::populateState();
      return true;
    }
    return false;
  }  public static function removeIndex($index) {
      $post = array(
        'secret' => _PLAYER_SECRET_,
        'command' => 'removeIndex',
        'value' => (int)$index,
      );
      $http = Http::post(self::$url, $post);
      if ($http == 200) {
        self::populateState();
        return true;
      }
      return false;
    }
  public static function setPrevTrack() {
    $post = array(
      'secret' => _PLAYER_SECRET_,
      'command' => 'setPrevTrack',
      'value' => '',
    );
    $http = Http::post(self::$url, $post);
    if ($http == 200) {
      self::populateState();
      return true;
    }
    return false;
  }
  public static function setNextTrack() {
    $post = array(
      'secret' => _PLAYER_SECRET_,
      'command' => 'setNextTrack',
      'value' => '',
    );
    $http = Http::post(self::$url, $post);
    if ($http == 200) {
      self::populateState();
      return true;
    }
    return false;
  }
  public static function setMute() {
    $post = array(
      'secret' => _PLAYER_SECRET_,
      'command' => 'setMute',
      'value' => '',
    );
    $http = Http::post(self::$url, $post);
    if ($http == 200) {
      self::populateState();
      return true;
    }
    return false;
  }
  public static function addToPlaylist($filePath) {
    $post = array(
      'secret' => _PLAYER_SECRET_,
      'command' => 'playlistAdd',
      'value' => $filePath,
    );
    $http = Http::post(self::$url, $post);
    if ($http == 200) {
      self::populateState();
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
}
