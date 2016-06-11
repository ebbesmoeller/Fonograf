<?php
  $thisArtist = Music::getArtist((int)Post::getQuery('id'));
  $albums = Music::getArtistAlbums($thisArtist->id);
  $tracks = Music::getArtistTracks($thisArtist->id);
  $lastFmArtist = LastFm::getArtist($thisArtist->name);
  $lastFmArtistBio = strip_tags($lastFmArtist->bio->summary);
  $lastFmArtistBio = str_replace('Read more on Last.fm','',$lastFmArtistBio);
  $lastFmArtistImage = (array)$lastFmArtist->image[3];
  $lastFmArtistImage = $lastFmArtistImage['#text']
?>

<div class="artist row">
  <?php if($lastFmArtist){?>
    <div class="artistArt col-xs-12 col-sm-3 col-md-3 col-lg-2">
      <img class="lazy" src="/download/noAlbumArt.jpg" title="<?php echo $thisArtist->name?>" data-original="<?php echo $lastFmArtistImage?>"/>
    </div>
    <div class="col-xs-12 col-sm-9 col-md-9 col-lg-10">
      <h1><?php echo $thisArtist->name?></h1>
      <div class="artistBio">
        <?php if($lastFmArtistBio != ' '){?>
          <?php echo $lastFmArtistBio?>
          <br />
          <br />
          <small><em><a href="<?php echo $lastFmArtist->url?>" target="_blank"><?php $t->t('Powered by Last.fm')?></a></em></small>
        <?php }?>
      </div>
    </div>
    <div class="artistArt col-xs-12 col-sm-12 col-md-12 col-lg-12"><hr /></div>
  <?php } else {?>
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <h1><?php echo $thisArtist->name?></h1>
    </div>
  <?php }?>
  <?php if (count($albums)>0) {?>
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <div class="grid albums lazy">
        <ul class="row row-flex row-flex-wrap">
          <?php foreach($albums as $album) {?>
            <li class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
              <a href="/?p=album&id=<?php echo $album->id?>" class="albumArt async">
                <div class="albumArtContainer">
                  <img class="albumArtImg lazy" src="/download/noAlbumArt.jpg" title="<?php echo $album->name?>" data-original="/download/albumArt.php?id=<?php echo $album->id?>&name=<?php echo urlencode($album->name)?>"/>
                </div>
              </a>
              <div class="albumInfo">
                <a href="/?p=album&id=<?php echo $album->id?>" class="albumTitle async"><?php echo $album->name?></a>
              </div>
            </li>
          <?php }?>
        </ul>
      </div>
    </div>
  <?php }?>
</div>
<?php if (count($tracks)>0) {?>
  <div class="list tracks artist">
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
<?php
  $javascripts[] = "
  <script type='text/javascript'>
    $('body').on('loadEnd', function() {
      $('.grid.albums.lazy img.lazy').lazyload({
        load : function()
        {
          $(this).closest('.albumArt').addClass('loaded')
        }
      });
      $('.artist .artistArt .lazy').lazyload({
        load : function()
        {
          $(this).addClass('loaded')
        }
      });
    });
  </script>";
?>
