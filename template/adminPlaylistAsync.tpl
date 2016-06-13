<?php
  if (!Authentication::isAuthenticated()) {
    header('Location: /?p=adminLogin');
  }

  if (Post::getQuery('playIndex')) {
    MusicPlayer::skipToIndex((int)Post::getQuery('playIndex'));
  }
  if (Post::getQuery('removeIndex')) {
    MusicPlayer::removeIndex((int)Post::getQuery('removeIndex'));
  }

  $playerState = MusicPlayer::getInstance()->getPlayerState();
  $playlistIndex = (int)$playerState->index;
  $playlist = array();

  foreach (musicPlayer::getPlaylist() as $key => $file) {
    $playlist[] = Music::getTrackByFile($file);
  }
?>
<div class="list tracks noAdd">
  <ul>
    <li class="row">
      <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
        <?php $t->t('Song')?>
      </div>
      <div class="col-xs-6 col-sm-3 col-md-3 col-lg-3">
        <?php $t->t('Artist')?>
      </div>
      <div class="col-xs-6 col-sm-3 col-md-3 col-lg-3">
        <?php $t->t('Album')?>
      </div>
      <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2">
        <?php $t->t('Actions')?>
      </div>
    </li>
  </ul>
  <?php if (count($playlist)>0 && $playerState->playing) {?>
    <ul id="songList">
      <li class="hidden"></li>
      <?php foreach($playlist as $key => $track) {?>
        <?php if($key>=$playlistIndex) {?>
          <li class="row<?php if ($key==$playlistIndex){echo ' playing';}?>">
            <div></div>
            <div class="col-xs-11 col-sm-4 col-md-4 col-lg-4" data-title="<?php $t->t('Song')?>">
              <?php echo $track->name?>
            </div>
            <div class="col-xs-11 col-sm-3 col-md-3 col-lg-3" data-title="<?php $t->t('Artist')?>">
              <a href="/?p=artist&id=<?php echo $track->idArtist?>" class="async"><?php echo $track->artist?></a>
            </div>
            <div class="col-xs-11 col-sm-3 col-md-3 col-lg-3" data-title="<?php $t->t('Album')?>">
              <a href="/?p=album&id=<?php echo $track->idAlbum?>" class="async"><?php echo $track->album?></a>
            </div>
            <div class="col-xs-12 col-sm-0 col-md-0 col-lg-0">&nbsp;</div>
            <div class="actions col-xs-12 col-sm-2 col-md-2 col-lg-2">
              <a class="skipButton" href="/?p=adminPlaylistAsync&playIndex=<?php echo $key?>" title="<?php $t->t('Play')?>"><i class="fa fa-play-circle" aria-hidden="true"></i></a>
              <a class="skipButton" href="/?p=adminPlaylistAsync&removeIndex=<?php echo $key?>" title="<?php $t->t('Remove')?>"><i class="fa fa-trash" aria-hidden="true"></i></a>
            </div>
          </li>
        <?php }?>
      <?php }?>
    </ul>
  <?php }?>
</div>
