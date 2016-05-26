<?php
  if (Post::getQuery('q') == true && Post::getQuery('q') != '1') {
    $query = Post::getQuery('q');
    $tracks = Music::searchAllSongs($query);
  }
?>
<div class="searchArea">
  <form class="form-group">
    <input type="hidden" name="p" value="search" />
    <div class="input-group">
      <input type="search" class="form-control" name="q" placeholder="<?php $t->t('Search by artist, album, or song')?>" value="<?php echo $query?>"/>
      <div class="input-group-btn">
        <button type="submit" class="btn btn-primary"><i class="fa fa-search" aria-hidden="true"></i>&nbsp;<?php $t->t('Search')?></button>
      </div>
    </div>
  </form>
</div>
<pre>
  <?php print_r($tracks)?>
</pre>
