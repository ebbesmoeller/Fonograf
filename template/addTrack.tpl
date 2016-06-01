<?php
  $track = Music::getTrack((int)Post::getQuery('id'));
  print_r($track);

  //extract data from the post
  //set POST variables
  $url = _PLAYER_SERVER_.':'._PLAYER_PORT_;
  $post = $track->path.'/'.$track->file;

  //open connection
  $ch = curl_init();

  //set the url, number of POST vars, POST data
  curl_setopt($ch,CURLOPT_URL, $url);
  curl_setopt($ch,CURLOPT_POST, strlen($post));
  curl_setopt($ch,CURLOPT_POSTFIELDS, $post);

  //execute post
  $result = curl_exec($ch);

  //close connection
  curl_close($ch);
?>
