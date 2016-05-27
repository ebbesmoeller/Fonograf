<?php
class Music {
  private static function queryForSongs($query) {
    $tracks = Database::getInstance()->executeS($query);
    $objectTracks = array();
    foreach ($tracks as $track) {
      $objectTrack = new Track();
      $objectTrack->id = (int)$track['id'];
      $objectTrack->name = $track['name'];
      $objectTrack->path = $track['path'];
      $objectTrack->file = $track['file'];
      $objectTrack->album = $track['album'];
      $objectTrack->artist = $track['artist'];
      $objectTrack->idAlbum = $track['id_album'];
      $objectTrack->idArtist = $track['id_artist'];
      $objectTrack->track = $track['track'];
      $objectTrack->genre = $track['genre'];
      $objectTrack->year = (int)$track['year'];
      $objectTracks[] = $objectTrack;
    }
    return $objectTracks;
  }
  private static function queryForArtists($query) {
    $artists = Database::getInstance()->executeS($query);
    $objectArtists = array();
    foreach ($artists as $artist) {
      $objectArtist = new Artist();
      $objectArtist->name = $artist['name'];
      $objectArtist->id = $artist['id'];
      $objectArtists[] = $objectArtist;
    }
    return $objectArtists;
  }
  private static function queryForAlbums($query) {
    $albums = Database::getInstance()->executeS($query);
    $objectAlbums = array();
    foreach ($albums as $album) {
      $objectAlbum = new Artist();
      $objectAlbum->name = $album['name'];
      $objectAlbum->id = $album['id'];
      $objectAlbums[] = $objectAlbum;
    }
    return $objectAlbums;
  }

  public static function getAllTracks() {
    $query = 'SELECT tr.`id`, tr.`name`, tr.`path`, tr.`file`, al.`name` AS \'album\', at.`name` AS \'artist\', tr.`id_album`, tr.`id_artist`, tr.`track`, tr.`genre`, tr.`year` FROM `tracks` AS tr JOIN `artists` AS at ON tr.`id_artist` = at.`id` JOIN `albums` AS al ON tr.`id_album` = al.`id`;';
    return self::queryForSongs($query);
  }
  public static function searchTracks($searchTerm) {
    $searchTerm = Database::cleanInput($searchTerm);
    $query = 'SELECT tr.`id`, tr.`name`, tr.`path`, tr.`file`, al.`name` AS \'album\', at.`name` AS \'artist\', tr.`id_album`, tr.`id_artist`, tr.`track`, tr.`genre`, tr.`year` FROM `tracks` AS tr JOIN `artists` AS at ON tr.`id_artist` = at.`id` JOIN `albums` AS al ON tr.`id_album` = al.`id` WHERE tr.`name` LIKE \'%'.$searchTerm.'%\' ORDER BY tr.`name`;';
    return self::queryForSongs($query);
  }

  public static function searchArtists($searchTerm) {
    $searchTerm = Database::cleanInput($searchTerm);
    $query = 'SELECT * FROM `artists` WHERE `name` LIKE \'%'.$searchTerm.'%\' ORDER BY `name`;';
    return self::queryForArtists($query);
  }

  public static function searchAlbums($searchTerm) {
    $searchTerm = Database::cleanInput($searchTerm);
    $query = 'SELECT * FROM `albums` WHERE `name` LIKE \'%'.$searchTerm.'%\' ORDER BY `name`;';
    return self::queryForAlbums($query);
  }
}
