<?php
  if (Authentication::isAuthenticated()) {
    Authentication::unAuthenticate();
  }
  $javascripts[] = '
    <script type="text/javascript">
      setTimeout(function(){
        window.location = "/";
      }, 100);
    </script>
  ';
?>
