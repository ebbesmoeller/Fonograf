<?php
class Render {
  public function renderPage($template = "index", $chrome = true) {
    $templateDir = "template";
    $t = new Translation;
    if (is_dir($templateDir)) {
      $thisController = $template;    
      if (is_file($templateDir."/header.tpl") && $chrome) {
        include($templateDir."/header.tpl");
      }

      if (is_file($templateDir."/".$template.".tpl") && $template != 'header' && $template != 'footer') {
        include($templateDir."/".$template.".tpl");
      }
      else {
        echo '<p style="font-family: sans-serif;">Template Not Found!</p>';
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
