<?php
  $playerState = MusicPlayer::getInstance()->getPlayerState();
  if (Post::getQuery('setPause')) {
    MusicPlayer::setPause();
  }
  if (Post::getQuery('setPrevTrack')) {
    MusicPlayer::setPrevTrack();
  }
  if (Post::getQuery('setNextTrack')) {
    MusicPlayer::setNextTrack();
  }
  if (Post::getQuery('setMute')) {
    MusicPlayer::setMute();
  }
  if (Post::getQuery('skipToIndex')) {
    $index = (int)Post::getQuery('skipToIndex');
    MusicPlayer::skipToIndex($index);
  }
  if (Post::getQuery('setVolume')) {
    $percentage = (int)Post::getQuery('setVolume');
    MusicPlayer::setVolume($percentage);
  }

  $currentlyPlaying = Music::getTrackByFile($playerState->playing);
?>
<div id="playerState" class="controls panel">
  <div class="panel-body">
    <div class="row">
      <div id="volumeDial" class="text-center col-xs-12 col-sm-4 col-md-4 col-lg-3">
        <input id="volume" type="text" value="<?php echo $playerState->volume?>">
        <a id="muteButton" <?php if($playerState->mute) {echo 'class="muted"';}?>>
          <?php if($playerState->mute) {?>
            <i class="fa fa-volume-off" aria-hidden="true"></i>
          <?php } else {?>
            <i class="fa fa-volume-up" aria-hidden="true"></i>
          <?php }?>
        </a>
        <br />
      </div>
      <div class="text-center col-xs-12 col-sm-8 col-md-8 col-lg-9">
        <h2 id="songName"><?php if ($currentlyPlaying->name != '') {echo $currentlyPlaying->name;} else {echo '&nbsp;';}?></h2>
        <h5 id="artistName"><em><?php if ($currentlyPlaying != '') {echo $currentlyPlaying->artist;} else {echo '&nbsp;';}?></em></h5>
        <hr />

        <a id="prevButton" class="btn btn-default"><i class="fa fa-step-backward" aria-hidden="true"></i></a>
        &nbsp;
        <?php if($playerState->pause) {?>
          <a id="pauseButton" class="btn btn-primary paused"><i class="fa fa-play" aria-hidden="true"></i></a>
        <?php } else {?>
          <a id="pauseButton" class="btn btn-primary"><i class="fa fa-pause" aria-hidden="true"></i></a>
        <?php }?>
        &nbsp;
        <a id="nextButton" class="btn btn-default"><i class="fa fa-step-forward" aria-hidden="true"></i></a>
      </div>
    </div>
  </div>
</div>

<div id="playlistWrapper"></div>
<?php
$javascripts[] = "
  <script src=\"/template/style/js/adminControls.js\"></script>
  <script src=\"/template/style/js/adminPlaylist.js\"></script>
";
?>
