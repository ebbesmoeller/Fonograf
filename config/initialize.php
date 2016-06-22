<?php
ini_set("session.cookie_lifetime", 86400);

require_once('settings.php');
foreach (glob("classes/*.php") as $filename)
{
  require_once($filename);
}
