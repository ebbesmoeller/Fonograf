<?php
  $menu = array();

  $menu['search'] = [$t->r('Search'),'fa-search'];
  $menu['music'] = [$t->r('Music'),'fa-music'];
  $menu['playlist'] = [$t->r('Playlist'),'fa-list-ol'];

  if (Authentication::isAuthenticated()) {
    $menu['adminControls'] = [$t->r('Player controls'),'fa-play-circle'];
    $menu['adminSettings'] = [$t->r('Settings'),'fa-cogs'];
    $menu['adminLogout'] = [$t->r('Logout'),'fa-sign-out'];
  }
?>
<div id="menu">
  <ul>
    <li class="home<?php if($thisController == 'index'){?> active<?php }?>">
      <a href="/" class="async">
        <i class="fa fa-home" aria-hidden="true"></i>&nbsp;<?php $t->t('Home')?>
      </a>
    </li>
    <?php foreach($menu as $key => $value) {?>
      <li class="<?php echo $key?><?php if($thisController == $key){?> active<?php }?>">
        <a href="/?p=<?php echo $key?>" class="async">
          <i class="fa <?php echo $value[1]?>" aria-hidden="true"></i>&nbsp;<?php echo $value[0]?>
        </a>
      </li>
    <?php }?>
  </ul>
</div>
