<?php
class Music {
  private static function makeStringSearchable($string) {
    $string = mb_strtolower($string);
    $charactersToReplace = array('a','á','à','â','å','ã','ä','æ','ç','e','é','è','ê','ë','i','í','ì','î','ï','ñ','o','ó','ò','ô','ø','õ','ö','ß','u','ú','ù','û','ü','ÿ','\'','"','@');
    $string = str_replace($charactersToReplace,'_',$string);
    return $string;
  }
  private static function buildTrack($rawData) {
    $objectTrack = new Track();
    $objectTrack->id = (int)$rawData['id'];
    $objectTrack->name = $rawData['name'];
    $objectTrack->path = html_entity_decode($rawData['path']);
    $objectTrack->file = html_entity_decode($rawData['file']);
    $objectTrack->album = $rawData['album'];
    $objectTrack->artist = $rawData['artist'];
    $objectTrack->idAlbum = $rawData['id_album'];
    $objectTrack->idArtist = $rawData['id_artist'];
    $objectTrack->track = $rawData['track'];
    $objectTrack->genre = $rawData['genre'];
    $objectTrack->year = (int)$rawData['year'];
    return $objectTrack;
  }
  private static function queryForTracks($query) {
    $tracks = Database::getInstance()->executeS($query);
    $objectTracks = array();
    foreach ($tracks as $track) {
      $objectTracks[] = self::buildTrack($track);
    }
    return $objectTracks;
  }

  private static function buildArtist($rawData) {
    $objectArtist = new Artist();
    $objectArtist->name = $rawData['name'];
    $objectArtist->id = $rawData['id'];
    return $objectArtist;
  }
  private static function queryForArtists($query) {
    $artists = Database::getInstance()->executeS($query);
    $objectArtists = array();
    foreach ($artists as $artist) {
      $objectArtists[] = self::buildArtist($artist);
    }
    return $objectArtists;
  }

  private static function buildAlbum($rawData) {
    $objectAlbum = new Album();
    $objectAlbum->name = $rawData['name'];
    $objectAlbum->id = $rawData['id'];
    return $objectAlbum;
  }
  private static function queryForAlbums($query) {
    $albums = Database::getInstance()->executeS($query);
    $objectAlbums = array();
    foreach ($albums as $album) {
      $objectAlbums[] = self::buildAlbum($album);
    }
    return $objectAlbums;
  }

// TRACK FUNCTIONS
  public static function getAllTracks() {
    $query = 'SELECT tr.`id`, tr.`name`, tr.`path`, tr.`file`, al.`name` AS \'album\', at.`name` AS \'artist\', tr.`id_album`, tr.`id_artist`, tr.`track`, tr.`genre`, tr.`year` FROM `tracks` AS tr JOIN `artists` AS at ON tr.`id_artist` = at.`id` JOIN `albums` AS al ON tr.`id_album` = al.`id` ORDER BY tr.`name`;';
    return self::queryForTracks($query);
  }
  public static function searchTracks($searchTerm) {
    $searchTerm = Database::cleanInput($searchTerm,false);
    $query = 'SELECT tr.`id`, tr.`name`, tr.`path`, tr.`file`, al.`name` AS \'album\', at.`name` AS \'artist\', tr.`id_album`, tr.`id_artist`, tr.`track`, tr.`genre`, tr.`year` FROM `tracks` AS tr JOIN `artists` AS at ON tr.`id_artist` = at.`id` JOIN `albums` AS al ON tr.`id_album` = al.`id` WHERE tr.`name` LIKE \'%'.$searchTerm.'%\' ORDER BY tr.`name`;';
    return self::queryForTracks($query);
  }
  public static function getArtistTracks($idArtist) {
    $idArtist = (int)Database::cleanInput($idArtist);
    $query = 'SELECT tr.`id`, tr.`name`, tr.`path`, tr.`file`, al.`name` AS \'album\', at.`name` AS \'artist\', tr.`id_album`, tr.`id_artist`, tr.`track`, tr.`genre`, tr.`year` FROM `tracks` AS tr JOIN `artists` AS at ON tr.`id_artist` = at.`id` JOIN `albums` AS al ON tr.`id_album` = al.`id` WHERE tr.`id_artist`='.$idArtist.' ORDER BY tr.`name`;';
    $results = self::queryForTracks($query);
    return $results;
  }
  public static function getAlbumTracks($idAlbum) {
    $idAlbum = (int)Database::cleanInput($idAlbum);
    $query = 'SELECT tr.`id`, tr.`name`, tr.`path`, tr.`file`, al.`name` AS \'album\', at.`name` AS \'artist\', tr.`id_album`, tr.`id_artist`, tr.`track`, tr.`genre`, tr.`year` FROM `tracks` AS tr JOIN `artists` AS at ON tr.`id_artist` = at.`id` JOIN `albums` AS al ON tr.`id_album` = al.`id` WHERE tr.`id_album`='.$idAlbum.' ORDER BY tr.`track`*1;';
    $results = self::queryForTracks($query);
    return $results;
  }
  public static function getTrack($idTrack) {
    $idTrack = (int)Database::cleanInput($idTrack);
    $query = 'SELECT tr.`id`, tr.`name`, tr.`path`, tr.`file`, al.`name` AS \'album\', at.`name` AS \'artist\', tr.`id_album`, tr.`id_artist`, tr.`track`, tr.`genre`, tr.`year` FROM `tracks` AS tr JOIN `artists` AS at ON tr.`id_artist` = at.`id` JOIN `albums` AS al ON tr.`id_album` = al.`id` WHERE tr.`id`='.$idTrack.' LIMIT 1;';
    $result = Database::getInstance()->getRow($query);
    return self::buildTrack($result);
  }
  public static function getTrackByFile($trackUri) {
    $file = Database::cleanInput(basename($trackUri));
    $path = Database::cleanInput(str_replace('/'.basename($trackUri),'',$trackUri));
    $query = 'SELECT tr.`id`, tr.`name`, tr.`path`, tr.`file`, al.`name` AS \'album\', at.`name` AS \'artist\', tr.`id_album`, tr.`id_artist`, tr.`track`, tr.`genre`, tr.`year` FROM `tracks` AS tr JOIN `artists` AS at ON tr.`id_artist` = at.`id` JOIN `albums` AS al ON tr.`id_album` = al.`id` WHERE tr.`path`=\''.$path.'\' AND tr.`file`=\''.$file.'\' LIMIT 1;';
    $result = Database::getInstance()->getRow($query);
    return self::buildTrack($result);
  }

// ARTIST FUNCTIONS
  public static function getAllArtists() {
    $query = 'SELECT `id`, `name` FROM `artists` ORDER BY `name`;';
    $results = self::queryForArtists($query);
    return $results;
  }
  public static function searchArtists($searchTerm) {
    $searchTerm = Database::cleanInput(self::makeStringSearchable($searchTerm),false);
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
    return self::buildArtist($result);
  }

// ALBUM FUNCTIONS
  public static function getAllAlbums() {
    $query = 'SELECT `id`, `name` FROM `albums` ORDER BY `name`;';
    $results = self::queryForAlbums($query);
    return $results;
  }
  public static function searchAlbums($searchTerm) {
    $searchTerm = Database::cleanInput(self::makeStringSearchable($searchTerm),false);
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
    return self::buildAlbum($result);
  }
  public static function getAlbumArt($idAlbum) {
    $idAlbum = (int)Database::cleanInput($idAlbum);
    $albumPath = html_entity_decode(Database::getRow('SELECT `path` FROM `tracks` WHERE `id_album`='.$idAlbum.' LIMIT 1;')['path']);
    return glob($albumPath.'/*.{jpg,jpeg,png,gif}',GLOB_BRACE);
  }
}
