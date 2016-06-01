<?php
require_once('settings.php');
foreach (glob("classes/*.php") as $filename)
{
  require_once($filename);
}

// 3rd party library by shubhamjain
// https://github.com/shubhamjain/PHP-ID3
foreach (glob("classes/phpId3/PhpId3/*.php") as $filename)
{
  require_once($filename);
}
