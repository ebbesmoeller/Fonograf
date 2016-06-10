<?php
  $playerState = MusicPlayer::getInstance()->getPlayerState();
  $playlistIndex = (int)$playerState->index;
  $playlist = array();

  foreach (musicPlayer::getPlaylist() as $key => $file) {
    if ($key>=$playlistIndex)
      $playlist[] = Music::getTrackByFile($file);
  }
?>
<div class="list tracks noAdd">
  <ul>
    <li class="row">
      <div class="col-xs-12 col-sm-5 col-md-5 col-lg-5">
        <?php $t->t('Song')?>
      </div>
      <div class="col-xs-6 col-sm-3 col-md-3 col-lg-3">
        <?php $t->t('Artist')?>
      </div>
      <div class="col-xs-6 col-sm-3 col-md-3 col-lg-3">
        <?php $t->t('Album')?>
      </div>
    </li>
  </ul>
  <?php if (count($playlist)>0 && $playerState->playing) {?>
    <ul id="songList">
      <li class="hidden"></li>
      <?php foreach($playlist as $key => $track) {?>
        <li class="row<?php if ($key==0){echo ' playing';}?>">
          <div></div>
          <div class="col-xs-11 col-sm-5 col-md-5 col-lg-5" data-title="<?php $t->t('Song')?>">
            <?php echo $track->name?>
          </div>
          <div class="col-xs-11 col-sm-3 col-md-3 col-lg-3" data-title="<?php $t->t('Artist')?>">
            <a href="/?p=artist&id=<?php echo $track->idArtist?>" class="async"><?php echo $track->artist?></a>
          </div>
          <div class="col-xs-11 col-sm-3 col-md-3 col-lg-3" data-title="<?php $t->t('Album')?>">
            <a href="/?p=album&id=<?php echo $track->idAlbum?>" class="async"><?php echo $track->album?></a>
          </div>
        </li>
      <?php }?>
    </ul>
  <?php }?>
</div>
