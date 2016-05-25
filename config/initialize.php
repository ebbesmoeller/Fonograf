<?php
require_once('settings.php');
foreach (glob("classes/*.php") as $filename)
{
    require_once($filename);
}
