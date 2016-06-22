<?php
class Render {
  public function renderPage($template = "index", $chrome = true) {
    header('Content-Type: text/html; charset=utf-8');
    $templateDir = "template";
    $translationDir = "translations";
    $t = new Translation;
    $content_only = $chrome;
    $javascripts=array();
    if (is_dir($templateDir)) {
      $thisController = $template;
      if (is_file($templateDir."/header.tpl") && $chrome) {
        include($templateDir."/header.tpl");
      }

      if (is_file($templateDir."/".$template.".tpl") && $template != 'header' && $template != 'footer') {
        include($templateDir."/".$template.".tpl");
        if (!$chrome) {
          foreach($javascripts as $javascript){
            echo $javascript;
          }
        }
      }
      else {
        echo '<p style="font-family: sans-serif;">Template Not Found!</p>';
      }

      if ($chrome) {
        include($translationDir."/jsTranslatables.php");
      }

      if (is_file($templateDir."/footer.tpl") && $chrome) {
        include($templateDir."/footer.tpl");
      }
    }
    else {
      die('<p style="font-family: sans-serif;">No template directory!</p>');
    }
  }
}
