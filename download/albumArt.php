<?php
require_once('../config/settings.php');
foreach (glob("../classes/*.php") as $filename)
{
  require_once($filename);
}
$albumArt = Music::getAlbumArt(Post::getQuery('id'));
if (count($albumArt)>0) {
  $albumArt = $albumArt[0];
}
else {
  $albumArt = 'noAlbumArt.png';
}
$ext = pathinfo($albumArt, PATHINFO_EXTENSION);

if ($albumArt) {
  header('Content-Type: image/'.$ext);
  echo readfile($albumArt);
}
else {
  header("HTTP/1.0 404 Not Found");
}
