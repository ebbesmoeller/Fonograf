<?php
class Music {
  private static function queryForSongs($query) {
    $tracks = Database::getInstance()->executeS($query);
    $objectTracks = array();
    foreach ($tracks as $track) {
      $objectTrack = new Track();
      $objectTrack->name = $track['name'];
      $objectTrack->path = $track['path'];
      $objectTrack->file = $track['file'];
      $objectTrack->album = $track['album'];
      $objectTrack->artist = $track['artist'];
      $objectTrack->track = $track['track'];
      $objectTrack->genre = $track['genre'];
      $objectTrack->year = $track['year'];
      $objectTracks[] = $objectTrack;
    }
    return $objectTracks;
  }

  public static function getAllSongs() {
    $sql = 'SELECT tr.`name`, tr.`path`, tr.`file`, al.`name` AS \'album\', at.`name` AS \'artist\', tr.`track`, tr.`genre`, tr.`year` FROM `tracks` AS tr JOIN `artists` AS at ON tr.`id_artist` = at.`id` JOIN `albums` AS al ON tr.`id_album` = al.`id`;';
    return self::queryForSongs($sql);
  }

  public static function searchAllSongs($searchTerm) {
    $searchTerm = Database::cleanInput($searchTerm);
    $sql = 'SELECT tr.`name`, tr.`path`, tr.`file`, al.`name` AS \'album\', at.`name` AS \'artist\', tr.`track`, tr.`genre`, tr.`year` FROM `tracks` AS tr JOIN `artists` AS at ON tr.`id_artist` = at.`id` JOIN `albums` AS al ON tr.`id_album` = al.`id` WHERE tr.`name` LIKE \'%'.$searchTerm.'%\' OR al.`name` LIKE \'%'.$searchTerm.'%\' OR at.`name` LIKE \'%'.$searchTerm.'%\';';
    return self::queryForSongs($sql);
  }
}
