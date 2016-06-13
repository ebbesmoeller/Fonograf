<?php
  if (!Authentication::isAuthenticated()) {
    header('Location: /?p=adminLogin');
  }
  if (Post::getQuery('reindex')) {
    Indexation::indexMusic();
  }
?>
