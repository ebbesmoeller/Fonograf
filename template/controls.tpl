<?php
  $playerState = musicPlayer::getInstance()->getPlayerState();
  if (Post::getQuery('setVolume')) {
    $percentage = (int)Post::getQuery('setVolume');
    MusicPlayer::setVolume($percentage);
  }
  if (Post::getQuery('pause')) {
    $percentage = (int)Post::getQuery('setVolume');
    MusicPlayer::setVolume($percentage);
  }
?>
<h1><?php $t->t('Player controls')?></h1>
<div class="controls panel">
  <div class="panel-body">
    <div class="row">
      <div id="volumeDial" class="text-center col-xs-12 col-sm-4 col-md-4 col-lg-3">
        <input id="volume" type="text" value="<?php echo $playerState->volume?>">
        <a id="muteButton"><i class="fa fa-<?php if($playerState->mute) {?>volume-off<?php } else {?>volume-up<?php }?>" aria-hidden="true"></i></a>
        <br />
      </div>
      <div class="text-center col-xs-12 col-sm-8 col-md-8 col-lg-9">
        <h2><?php echo Music::getTrackByFile($playerState->playing)->name?></h2>
        <h5><em><?php echo Music::getTrackByFile($playerState->playing)->artist?></em></h5>
        <hr />
        <a class="btn btn-default"><i class="fa fa-step-backward" aria-hidden="true"></i></a>
        &nbsp;
        <a class="btn btn-primary"><i class="fa fa-<?php if($playerState->pause) {?>play<?php } else {?>pause<?php }?>" aria-hidden="true"></i></a>
        &nbsp;
        <a class="btn btn-default"><i class="fa fa-step-forward" aria-hidden="true"></i></a>
      </div>
  </div>
</div>
<?php
$javascripts[] = '
<script>
  $(function() {
    $("#volume").knob({
      "min" : 1,
      "step" : 2,
      "width" : "200",

      "thickness" : .1,
      "fgColor" : "#ff1e53",
      "bgColor" : "#222222",
      "displayInput" : false,
      "displayPrevious" : true,
      "release" : function(v) {
        $.post(appendQueryString(window.location.href, {\'setVolume\':v}), function(data) {

        });
      },
    });
  });
</script>
';
?>
