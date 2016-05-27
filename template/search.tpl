<?php
  if (Post::getQuery('q') == true && Post::getQuery('q') != '1') {
    $query = Post::getQuery('q');
    $artists = Music::searchArtists($query);
    $tracks = Music::searchTracks($query);
    $albums = Music::searchAlbums($query);
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
  <div class="page-header">
    <h1><?php $t->t('Showing results for'); echo ': '.$query;?></h1>
  </div>
  <?php if (count($artists)>0 || count($tracks)>0 || count($artists)>0) {?>
    <div class="row">
      <?php if (count($artists)>0) {?>
        <div class="list artists col-xs-12 col-sm-12 col-md-6 col-lg-6">
          <h2><?php $t->t('Artists')?></h2>
          <ul>
            <?php foreach($artists as $artist) {?>
              <li>
                <a href="/?p=artist&id=<?php echo $artist->id?>" class="async"><?php echo $artist->name?></a>
              </li>
            <?php }?>
          </ul>
        </div>
      <?php }?>
      <?php if (count($albums)>0) {?>
        <div class="list albums col-xs-12 col-sm-12 col-md-6 col-lg-6">
          <h2><?php $t->t('Albums')?></h2>
          <ul>
            <?php foreach($albums as $album) {?>
              <li>
                <a href="/?p=album&id=<?php echo $album->id?>" class="async"><?php echo $album->name?></a>
              </li>
            <?php }?>
          </ul>
        </div>
      <?php }?>
    </div>
    <br />
    <hr />
    <?php if (count($tracks)>0) {?>
      <div class="list tracks">
        <ul>
          <li class="row">
            <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1"></div>
            <div class="col-xs-6 col-sm-6 col-md-3 col-lg-3">
              <?php $t->t('Song')?>
            </div>
            <div class="col-xs-6 col-sm-6 col-md-3 col-lg-3">
              <?php $t->t('Artist')?>
            </div>
            <div class="col-xs-6 col-sm-6 col-md-3 col-lg-3">
              <?php $t->t('Album')?>
            </div>
          </li>
          <?php foreach($tracks as $track) {?>
            <li class="row">
              <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1">
                <a href="/?p=addTrack&id=<?php echo $track->id?>" class="addTrack" title="<?php $t->t('Add to playlist')?>">
                  <i class="fa fa-plus-circle" aria-hidden="true"></i>
                </a>
              </div>
              <div class="col-xs-6 col-sm-6 col-md-3 col-lg-3">
                <?php echo $track->name?>
              </div>
              <div class="col-xs-6 col-sm-6 col-md-3 col-lg-3">
                <a href="/?p=artist&id=<?php echo $track->idArtist?>" class="async"><?php echo $track->artist?></a>
              </div>
              <div class="col-xs-6 col-sm-6 col-md-3 col-lg-3">
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
