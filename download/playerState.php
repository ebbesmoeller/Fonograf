<?php
require_once('../config/settings.php');
foreach (glob("../classes/*.php") as $filename)
{
  require_once($filename);
}

if ($playerState = MusicPlayer::getInstance()->getPlayerState()) {
  if (!empty((array)$playerState)) {
    header('Content-Type: application/json');
    $currentlyPlaying = Music::getTrackByFile($playerState->playing);
    $extended = array(
      "track" => $currentlyPlaying->name,
      "artist" => $currentlyPlaying->artist,
    );
    $playerState = array_merge((array)$playerState, $extended);
    echo json_encode($playerState);
    die();
  }
}
header("HTTP/1.0 404 Not Found");
