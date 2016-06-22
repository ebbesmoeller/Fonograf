<?php
  Authentication::lockedDownPage();
  if (Post::getQuery('reindex')) {
    Indexation::indexMusic();
  }
?>
