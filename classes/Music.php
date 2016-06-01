<?php
class Music {
  private static function queryForSongs($query) {
    $tracks = Database::getInstance()->executeS($query);
    $objectTracks = array();
    foreach ($tracks as $track) {
      $objectTrack = new Track();
      $objectTrack->id = (int)$track['id'];
      $objectTrack->name = $track['name'];
      $objectTrack->path = html_entity_decode($track['path']);
      $objectTrack->file = html_entity_decode($track['file']);
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
      $objectAlbum = new Album();
      $objectAlbum->name = $album['name'];
      $objectAlbum->id = $album['id'];
      $objectAlbums[] = $objectAlbum;
    }
    return $objectAlbums;
  }

// TRACK FUNCTIONS
  public static function getAllTracks() {
    $query = 'SELECT tr.`id`, tr.`name`, tr.`path`, tr.`file`, al.`name` AS \'album\', at.`name` AS \'artist\', tr.`id_album`, tr.`id_artist`, tr.`track`, tr.`genre`, tr.`year` FROM `tracks` AS tr JOIN `artists` AS at ON tr.`id_artist` = at.`id` JOIN `albums` AS al ON tr.`id_album` = al.`id` ORDER BY tr.`name`;';
    return self::queryForSongs($query);
  }
  public static function searchTracks($searchTerm) {
    $searchTerm = Database::cleanInput($searchTerm);
    $query = 'SELECT tr.`id`, tr.`name`, tr.`path`, tr.`file`, al.`name` AS \'album\', at.`name` AS \'artist\', tr.`id_album`, tr.`id_artist`, tr.`track`, tr.`genre`, tr.`year` FROM `tracks` AS tr JOIN `artists` AS at ON tr.`id_artist` = at.`id` JOIN `albums` AS al ON tr.`id_album` = al.`id` WHERE tr.`name` LIKE \'%'.$searchTerm.'%\' ORDER BY tr.`name`;';
    return self::queryForSongs($query);
  }
  public static function getArtistTracks($idArtist) {
    $idArtist = (int)Database::cleanInput($idArtist);
    $query = 'SELECT tr.`id`, tr.`name`, tr.`path`, tr.`file`, al.`name` AS \'album\', at.`name` AS \'artist\', tr.`id_album`, tr.`id_artist`, tr.`track`, tr.`genre`, tr.`year` FROM `tracks` AS tr JOIN `artists` AS at ON tr.`id_artist` = at.`id` JOIN `albums` AS al ON tr.`id_album` = al.`id` WHERE tr.`id_artist`='.$idArtist.' ORDER BY tr.`name`;';
    $results = self::queryForSongs($query);
    return $results;
  }
  public static function getAlbumTracks($idAlbum) {
    $idAlbum = (int)Database::cleanInput($idAlbum);
    $query = 'SELECT tr.`id`, tr.`name`, tr.`path`, tr.`file`, al.`name` AS \'album\', at.`name` AS \'artist\', tr.`id_album`, tr.`id_artist`, tr.`track`, tr.`genre`, tr.`year` FROM `tracks` AS tr JOIN `artists` AS at ON tr.`id_artist` = at.`id` JOIN `albums` AS al ON tr.`id_album` = al.`id` WHERE tr.`id_album`='.$idAlbum.' ORDER BY tr.`track`*1;';
    $results = self::queryForSongs($query);
    return $results;
  }
  public static function getTrack($idTrack) {
    $idTrack = (int)Database::cleanInput($idTrack);
    $query = 'SELECT tr.`id`, tr.`name`, tr.`path`, tr.`file`, al.`name` AS \'album\', at.`name` AS \'artist\', tr.`id_album`, tr.`id_artist`, tr.`track`, tr.`genre`, tr.`year` FROM `tracks` AS tr JOIN `artists` AS at ON tr.`id_artist` = at.`id` JOIN `albums` AS al ON tr.`id_album` = al.`id` WHERE tr.`id`='.$idTrack.' LIMIT 1;';
    $result = Database::getInstance()->getRow($query);
    $track = new Track();
    $track->id = (int)$result['id'];
    $track->name = $result['name'];
    $track->path = html_entity_decode($result['path']);
    $track->file = html_entity_decode($result['file']);
    $track->album = $result['album'];
    $track->artist = $result['artist'];
    $track->idAlbum = $result['id_album'];
    $track->idArtist = $result['id_artist'];
    $track->track = $result['track'];
    $track->genre = $result['genre'];
    $track->year = (int)$result['year'];
    return $track;
  }

// ARTIST FUNCTIONS
  public static function getAllArtists() {
    $query = 'SELECT `id`, `name` FROM `artists` ORDER BY `name`;';
    $results = self::queryForArtists($query);
    return $results;
  }
  public static function searchArtists($searchTerm) {
    $searchTerm = Database::cleanInput($searchTerm);
    $query = 'SELECT * FROM `artists` WHERE `name` LIKE \'%'.$searchTerm.'%\' ORDER BY `name`;';
    return self::queryForArtists($query);
  }
  public static function getAlbumArtists($idAlbum) {
    $idAlbum = (int)Database::cleanInput($idAlbum);
    $query = 'SELECT at.`id`, at.`name` FROM `artists` AS at WHERE EXISTS(SELECT * FROM `tracks` AS tr WHERE tr.`id_artist`=at.`id` AND tr.`id_album`='.$idAlbum.' LIMIT 1) ORDER BY at.`name`;';
    $results = self::queryForArtists($query);
    return $results;
  }
  public static function getArtist($idArtist) {
    $idArtist = (int)Database::cleanInput($idArtist);
    $query = 'SELECT `id`, `name` FROM `artists` WHERE `id`='.$idArtist.';';
    $result = Database::getRow($query);
    $artist = new Artist();
    $artist->id = $result['id'];
    $artist->name = $result['name'];
    return $artist;
  }

// ALBUM FUNCTIONS
  public static function getAllAlbums() {
    $query = 'SELECT `id`, `name` FROM `albums` ORDER BY `name`;';
    $results = self::queryForAlbums($query);
    return $results;
  }
  public static function searchAlbums($searchTerm) {
    $searchTerm = Database::cleanInput($searchTerm);
    $query = 'SELECT * FROM `albums` WHERE `name` LIKE \'%'.$searchTerm.'%\' ORDER BY `name`;';
    return self::queryForAlbums($query);
  }
  public static function getArtistAlbums($idArtist) {
    $idArtist = (int)Database::cleanInput($idArtist);
    $query = 'SELECT al.`id`, al.`name` FROM `albums` AS al WHERE EXISTS(SELECT * FROM `tracks` AS tr WHERE tr.`id_album`=al.`id` AND tr.`id_artist`='.$idArtist.' LIMIT 1) ORDER BY al.`name`;';
    $results = self::queryForAlbums($query);
    return $results;
  }
  public static function getAlbum($idAlbum) {
    $idAlbum = (int)Database::cleanInput($idAlbum);
    $query = 'SELECT `id`, `name` FROM `albums` WHERE `id`='.$idAlbum.';';
    $result = Database::getRow($query);
    $album = new Album();
    $album->id = $result['id'];
    $album->name = $result['name'];
    return $album;
  }
  public static function getAlbumArt($idAlbum) {
    $idAlbum = (int)Database::cleanInput($idAlbum);
    $albumPath = html_entity_decode(Database::getRow('SELECT `path` FROM `tracks` WHERE `id_album`='.$idAlbum.' LIMIT 1;')['path']);
    return glob($albumPath.'/*.{jpg,jpeg,png,gif}',GLOB_BRACE);
  }
}
