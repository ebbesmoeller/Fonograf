<?php
  $thisAlbum = Music::getAlbum((int)Post::getQuery('id'));
  $tracks = Music::getAlbumTracks($thisAlbum->id);
?>
<div class="row album">
  <div class="albumArt col-xs-12 col-sm-4 col-md-4 col-lg-3">
    <img src="/download/albumArt.php?id=<?php echo $thisAlbum->id?>" title="<?php echo $thisAlbum->name?>" />
  </div>
  <div class="albumInfo col-xs-12 col-sm-8 col-md-8 col-lg-9">
    <h1><?php echo $thisAlbum->name?></h1>
    <?php foreach(Music::getAlbumArtists($thisAlbum->id) as $artist) {?>
      <span class="albumArtist"><a href="/?p=artist&id=<?php echo $artist->id?>" class="async"><?php echo $artist->name?></a></span>
    <?php }?>
  </div>
</div>

<?php if (count($tracks)>0) {?>
  <div class="list tracks">
    <ul>
      <li class="row">
        <div class="col-xs-12 col-sm-5 col-md-5 col-lg-5">
          <?php $t->t('Song')?>
        </div>
        <div class="col-xs-6 col-sm-5 col-md-5 col-lg-5">
          <?php $t->t('Artist')?>
        </div>
        <div class="col-xs-6 col-sm-1 col-md-1 col-lg-1">
          <?php $t->t('Track')?>
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
          <div class="col-xs-11 col-sm-5 col-md-5 col-lg-5" data-title="<?php $t->t('Artist')?>">
            <a href="/?p=artist&id=<?php echo $track->idArtist?>" class="async"><?php echo $track->artist?></a>
          </div>
          <div class="col-xs-11 col-sm-1 col-md-1 col-lg-1" data-title="<?php $t->t('Track')?>">
            <?php echo $track->track?>
          </div>
        </li>
      <?php }?>
    </ul>
  </div>
<?php }?>
