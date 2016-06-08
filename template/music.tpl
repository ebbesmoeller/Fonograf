<?php
  $artists = Music::getAllArtists();
  $albums = Music::getAllAlbums();
  $tracks = Music::getAllTracks();
?>
<ul class="nav nav-tabs" role="tablist">
  <li role="presentation" class="active"><a href="#albums" aria-controls="albums" role="tab" data-toggle="tab"><?php $t->t('Albums')?></a></li>
  <li role="presentation"><a href="#artists" aria-controls="artists" role="tab" data-toggle="tab"><?php $t->t('Artists')?></a></li>
  <li role="presentation"><a href="#songs" aria-controls="songs" role="tab" data-toggle="tab"><?php $t->t('Songs')?></a></li>
</ul>
<br />
<div class="tab-content">
  <div role="tabpanel" class="tab-pane fade in active" id="albums">
    <?php if (count($albums)>0) {?>
      <div class="grid albums lazy">
        <ul class="row row-flex row-flex-wrap" id="albumList">
          <?php foreach($albums as $album) {?>
            <li class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
              <a href="/?p=album&id=<?php echo $album->id?>" class="albumArt async">
                <div class="albumArtContainer">
                  <img class="albumArtImg lazy" src="/download/noAlbumArt.jpg" title="<?php echo $album->name?>" data-original="/download/albumArt.php?id=<?php echo $album->id?>&name=<?php echo urlencode($album->name)?>"/>
                </div>
              </a>
              <div class="albumInfo">
                <a href="/?p=album&id=<?php echo $album->id?>" class="albumTitle async"><?php echo $album->name?></a>
                <?php foreach(Music::getAlbumArtists($album->id) as $key => $artist) {?>
                  <span class="albumArtist"><?php if($key>0){?>&nbsp;-&nbsp;<?php }?><a href="/?p=artist&id=<?php echo $artist->id?>" class="async"><?php echo $artist->name?></a></span>
                <?php }?>
              </div>
            </li>
          <?php }?>
        </ul>
      </div>
      <nav>
        <ul class="pager" id="albumList-pagination" style="display: none;">
          <li class="previous"><a id="albumList-previous" class="btn btn-default disabled" onclick="scrollToTop();"><i class="fa fa-chevron-left" aria-hidden="true" style="font-size: 13px;"></i>&nbsp;<?php $t->t('Previous')?></a></li>
          <li class="next"><a id="albumList-next" class="btn btn-default" onclick="scrollToTop();"><?php $t->t('Next')?>&nbsp;<i class="fa fa-chevron-right" aria-hidden="true" style="font-size: 13px;"></i></a></li>
        </ul>
      </nav>
    <?php }?>
  </div>

  <div role="tabpanel" class="tab-pane fade" id="artists">
    <?php if (count($artists)>0) {?>
      <div class="list artists">
        <ul id="artistList">
          <?php foreach($artists as $artist) {?>
            <li>
              <a href="/?p=artist&id=<?php echo $artist->id?>" class="async"><?php echo $artist->name?></a>
            </li>
          <?php }?>
        </ul>
      </div>
      <nav>
        <ul class="pager" id="artistList-pagination" style="display: none;">
          <li class="previous"><a id="artistList-previous" class="btn btn-default disabled" onclick="scrollToTop();"><i class="fa fa-chevron-left" aria-hidden="true" style="font-size: 13px;"></i>&nbsp;<?php $t->t('Previous')?></a></li>
          <li class="next"><a id="artistList-next" class="btn btn-default" onclick="scrollToTop();"><?php $t->t('Next')?>&nbsp;<i class="fa fa-chevron-right" aria-hidden="true" style="font-size: 13px;"></i></a></li>
        </ul>
      </nav>
    <?php }?>
  </div>

  <div role="tabpanel" class="tab-pane fade" id="songs">
    <?php if (count($tracks)>0) {?>
      <div class="list tracks">
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
        <ul id="songList">
          <li class="hidden"></li>
          <?php foreach($tracks as $track) {?>
            <li class="row">
              <a href="/?p=addTrack&id=<?php echo $track->id?>" class="addTrack" title="<?php $t->t('Add to playlist')?>">
                <i class="fa fa-plus-circle" aria-hidden="true"></i>
              </a>
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
        <nav>
          <ul class="pager" id="songList-pagination" style="display: none;">
            <li class="previous"><a id="songList-previous" class="btn btn-default disabled" onclick="scrollToTop();"><i class="fa fa-chevron-left" aria-hidden="true" style="font-size: 13px;"></i>&nbsp;<?php $t->t('Previous')?></a></li>
            <li class="next"><a id="songList-next" class="btn btn-default" onclick="scrollToTop();"><?php $t->t('Next')?>&nbsp;<i class="fa fa-chevron-right" aria-hidden="true" style="font-size: 13px;"></i></a></li>
          </ul>
        </nav>
      </div>
    <?php }?>
  </div>
</div>

<?php
  $javascripts[] = "<script src=\"/template/style/js/jquery.paginate.min.js\"></script>";
  $javascripts[] = "
  <script type='text/javascript'>
    $('body').on('loaded', function() {
      $('.grid.albums.lazy img.lazy').lazyload({
        load : function()
        {
          $(this).closest('.albumArt').addClass('loaded')
        }
      });
    });
    $(document).ready(function() {
      $('#artistList').paginate({itemsPerPage: 15});
    });
    $(document).ready(function() {
      $('#albumList').paginate({itemsPerPage: 18});
    });
    $(document).ready(function() {
      $('#songList').paginate({itemsPerPage: 15});
    });
  </script>";
?>
