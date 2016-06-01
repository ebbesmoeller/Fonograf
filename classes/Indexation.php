<?php
use PhpId3\Id3TagsReader;
class Indexation {
  private static $tracks = array();
  public static function indexMusic() {
    self::recursiveIndexation(_MUSIC_FOLDER_);

    Database::getInstance()->execute('TRUNCATE TABLE `tracks`;');
    Database::getInstance()->execute('TRUNCATE TABLE `artists`;');
    Database::getInstance()->execute('TRUNCATE TABLE `albums`;');

    $sql = '';
    foreach(self::$tracks as $track) {
      $artist = Database::getInstance()->getRow('SELECT * FROM `artists` WHERE `name`=\''.$track->artist.'\';');
      if ($artist == null) {
        Database::getInstance()->execute('INSERT INTO `artists`(`name`) VALUES(\''.$track->artist.'\');');
        $artist = Database::getInstance()->getRow('SELECT * FROM `artists` WHERE `name`=\''.$track->artist.'\';');
      }

      $album = Database::getInstance()->getRow('SELECT * FROM `albums` WHERE `name`=\''.$track->album.'\';');
      if ($album == null) {
        Database::getInstance()->execute('INSERT INTO `albums`(`name`) VALUES(\''.$track->album.'\');');
        $album = Database::getInstance()->getRow('SELECT * FROM `albums` WHERE `name`=\''.$track->album.'\';');
      }

      Database::getInstance()->execute('INSERT INTO `tracks`(`name`,`path`,`file`,`id_album`,`id_artist`,`track`,`genre`,`year`) VALUES(\''.$track->name.'\',\''.$track->path.'\',\''.$track->file.'\','.$album['id'].','.$artist['id'].','.$track->track.',\''.$track->genre.'\','.$track->year.');');
    }
  }

  private static function recursiveIndexation($folder) {
    foreach (glob($folder.'/*') as $item)
    {
      if (is_dir($item)) {
        self::recursiveIndexation($item);
      }
      else if (is_file($item)) {
        $ext = pathinfo($item, PATHINFO_EXTENSION);
        if (in_array($ext, json_decode(_MUSIC_TYPES_))) {
          try {
            $id3 = new Id3TagsReader(fopen($item, "rb"));
            $id3 = $id3->readAllTags()->getId3Array();
          }
          catch (Exception $e) {}
          $track = new Track();
          $track->name = Database::cleanInput($id3['TIT2']['body']);
          $track->album = Database::cleanInput($id3['TALB']['body']);
          if ($id3['TPE2'])
            $track->artist = Database::cleanInput($id3['TPE2']['body']);
          else
            $track->artist = Database::cleanInput($id3['TPE1']['body']);
          $track->track = (int)explode('/',Database::cleanInput($id3['TRCK']['body']))[0];
          $track->genre = Database::cleanInput($id3['TCON']['body']);
          $track->year = (int)$id3['TYER']['body'];
          $track->path = Database::cleanInput($folder);
          $track->file = Database::cleanInput(str_replace($folder.'/', '', $item));
          self::$tracks[] = $track;

          echo 'memory usage: '.((int)memory_get_usage()/1000000.0).' MB <br />';
          print_r($track);

          unset($track);
          unset($id3);
        }
      }
    }
  }
}
