<?php
  $thisArtist = Music::getArtist((int)Post::getQuery('id'));
  $albums = Music::getArtistAlbums($thisArtist->id);
  $tracks = Music::getArtistTracks($thisArtist->id);
?>

<div class="artist">
  <h1><?php echo $thisArtist->name?></h1>
  <?php if (count($albums)>0) {?>
    <div class="grid albums">
      <ul class="row row-flex row-flex-wrap">
        <?php foreach($albums as $album) {?>
          <li class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
            <a href="/?p=album&id=<?php echo $album->id?>" class="albumArt async">
              <div class="albumArtContainer">
                <img class="albumArtImg" src="/download/albumArt.php?id=<?php echo $album->id?>" title="<?php echo $album->name?>"/>
              </div>
            </a>
            <div class="albumInfo">
              <a href="/?p=album&id=<?php echo $album->id?>" class="albumTitle async"><?php echo $album->name?></a>
            </div>
          </li>
        <?php }?>
      </ul>
    </div>
  <?php }?>
</div>
<?php if (count($tracks)>0) {?>
  <div class="list tracks">
    <ul>
      <li class="row">
        <div class="col-xs-12 col-sm-5 col-md-5 col-lg-5">
          <?php $t->t('Song')?>
        </div>
        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
          <?php $t->t('Album')?>
        </div>
      </li>
      <?php foreach($tracks as $track) {?>
        <li class="row">
          <a href="/?p=addTrack&id=<?php echo $track->id?>" class="addTrack" title="<?php $t->t('Add to playlist')?>">
            <i class="fa fa-plus-circle" aria-hidden="true"></i>
          </a>
          <div class="col-xs-11 col-sm-5 col-md-5 col-lg-5" data-title="<?php $t->t('Song')?>">
            <?php echo $track->name?>
          </div>
          <div class="col-xs-11 col-sm-6 col-md-6 col-lg-6" data-title="<?php $t->t('Album')?>">
            <a href="/?p=album&id=<?php echo $track->idAlbum?>" class="async"><?php echo $track->album?></a>
          </div>
        </li>
      <?php }?>
    </ul>
  </div>
<?php }?>
