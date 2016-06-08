<?php
require_once('../config/settings.php');
foreach (glob("../classes/*.php") as $filename)
{
  require_once($filename);
}
$albumId = Post::getQuery('id');
$albumArt = Music::getAlbumArt($albumId);
if (count($albumArt)>0 && $albumId !== true) {
  $albumArt = $albumArt[0];
}
else {
  $albumArt = 'noAlbumArt.jpg';
}
$ext = pathinfo($albumArt, PATHINFO_EXTENSION);

if ($albumArt) {
  header('Content-Type: image/'.$ext);
  echo readfile($albumArt);
}
else {
  header("HTTP/1.0 404 Not Found");
}
