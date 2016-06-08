<?php
  if (Post::getQuery('q') == true && Post::getQuery('q') != '1') {
    $query = Post::getQuery('q');
    if (strlen($query)>=3) {
      $artists = Music::searchArtists($query);
      $albums = Music::searchAlbums($query);
      $tracks = Music::searchTracks($query);
    }
  }
?>
<div class="searchArea">
  <form class="form-group">
    <input type="hidden" name="p" value="search" />
    <div class="input-group">
      <input type="search" class="form-control" name="q" placeholder="<?php $t->t('Search by artist, album, or song')?>" value="<?php echo $query?>" autocomplete="off"/>
      <div class="input-group-btn">
        <button type="submit" class="btn btn-primary"><i class="fa fa-search" aria-hidden="true"></i>&nbsp;<?php $t->t('Search')?></button>
      </div>
    </div>
  </form>
</div>
<?php if ($query) {?>
  <div class="page-header mobileHidden">
    <h1><?php $t->t('Showing results for'); echo ': '.$query;?></h1>
  </div>
  <?php if (count($artists)>0 || count($tracks)>0 || count($albums)>0) {?>
    <?php if (count($artists)>0 || count($albums)>0) {?>
      <div class="row row-flex row-flex-wrap">
        <?php if (count($artists)>0) {?>
          <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
            <div class="panel">
              <div class="panel-body list artists">
                <h3><?php $t->t('Artists')?></h3>
                <ul>
                  <?php foreach($artists as $artist) {?>
                    <li>
                      <a href="/?p=artist&id=<?php echo $artist->id?>" class="async"><?php echo $artist->name?></a>
                    </li>
                  <?php }?>
                </ul>
              </div>
            </div>
          </div>
        <?php }?>
        <?php if (count($albums)>0) {?>
          <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
            <div class="panel">
              <div class="panel-body list albums search">
                <h3><?php $t->t('Albums')?></h3>
                <ul>
                  <?php foreach($albums as $album) {?>
                    <li>
                      <a href="/?p=album&id=<?php echo $album->id?>" class="async"><img class="albumArt" src="/download/albumArt.php?id=<?php echo $album->id?>&name=<?php echo urlencode($album->name)?>" title="<?php echo $album->name?>" /></a>
                      <a href="/?p=album&id=<?php echo $album->id?>" class="async"><?php echo $album->name?></a>
                      <?php foreach(Music::getAlbumArtists($album->id) as $artist) {?>
                        <span class="albumArtist">&nbsp;-&nbsp;<a href="/?p=artist&id=<?php echo $artist->id?>" class="async"><?php echo $artist->name?></a></span>
                      <?php }?>
                    </li>
                  <?php }?>
                </ul>
              </div>
            </div>
          </div>
        <?php }?>
      </div>
    <?php }?>
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
      </div>
    <?php }?>
  <?php } else {?>
    <?php $t->t('No results found')?>
  <?php }?>
<?php }?>
