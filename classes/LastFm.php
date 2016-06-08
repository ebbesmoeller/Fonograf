<?php
class LastFm {
  private static $lastFmArtistUrl = 'http://ws.audioscrobbler.com/2.0/';
  public static function getArtist($artistName) {
    if (_LASTFM_KEY_ != '') {
      $request = array(
        'method' => 'artist.getinfo',
        'artist' => urlencode(html_entity_decode($artistName)),
        'api_key' => _LASTFM_KEY_,
        'format' => json
      );
      $url = self::$lastFmArtistUrl.'?'.http_build_query($request);
      $result = file_get_contents($url);

      if ($lastFmArtist = Http::get(self::$lastFmArtistUrl,$request,false)) {
        $lastFmArtist = json_decode($lastFmArtist->data);
        if (!array_key_exists('error', $lastFmArtist))
          return $lastFmArtist->artist;
      }
    }
    return false;
  }
}
