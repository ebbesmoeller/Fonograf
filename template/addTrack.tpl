<?php
  $track = Music::getTrack((int)Post::getQuery('id'));
  if (musicPlayer::addToPlaylist($track->path.'/'.$track->file)) {
    header("HTTP/1.1 200 OK"); die();
  }
  else {
    header("HTTP/1.1 404 Not Found"); die();
  }

  $thisPage = $_SERVER[HTTP_HOST].$_SERVER[REQUEST_URI];
  $refererPage =  str_replace('http://', '', str_replace('https://', '', $_SERVER['HTTP_REFERER']));

  if ($thisPage != $refererPage) {
    $javascripts[] = '
      <script type="text/javascript">
        setTimeout(function(){
          window.location = "'.$_SERVER['HTTP_REFERER'].'";
        }, 100);
      </script>
    ';
  }
  else {
    header('Location: /');
  }
?>
