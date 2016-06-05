<?php
  $track = Music::getTrack((int)Post::getQuery('id'));

  $url = _PLAYER_SERVER_.':'._PLAYER_PORT_;
  $post = json_encode(
    array(
      'command' => 'playlistAdd',
      'parameter' => $track->path.'/'.$track->file,
      'secret' => _PLAYER_SECRET_
    )
  );

  $ch = curl_init();
  curl_setopt($ch,CURLOPT_URL, $url);
  curl_setopt($ch,CURLOPT_POST, strlen($post));
  curl_setopt($ch,CURLOPT_POSTFIELDS, $post);
  curl_exec($ch);
  $information = curl_getinfo($ch);
  curl_close($ch);

  $responseCode = (int)$information['http_code'];
  if ($responseCode == 200) {
    header("HTTP/1.1 200 OK");
  }
  else if ($responseCode == 401) {
    header("HTTP/1.1 401 Unauthorized Access");
  }
  else {
    header("HTTP/1.1 404 Not Found");
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
