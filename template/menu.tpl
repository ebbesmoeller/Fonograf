<?php
  $menu = array();

  $menu['search'] = [$t->r('Search'),'fa-search'];
  $menu['music'] = [$t->r('Music'),'fa-music'];
  $menu['playlist'] = [$t->r('Playlist'),'fa-list-ol'];
?>
<div id="menu">
  <ul>
    <li<?php if($thisController == 'index'){?> class="active"<?php }?>>
      <a href="/">
        <i class="fa fa-home" aria-hidden="true"></i>&nbsp;<?php $t->t('Home')?>
      </a>
    </li>
    <?php foreach($menu as $key => $value) {?>
      <li<?php if($thisController == $key){?> class="active"<?php }?>>
        <a href="/?p=<?php echo $key?>">
          <i class="fa <?php echo $value[1]?>" aria-hidden="true"></i>&nbsp;<?php echo $value[0]?>
        </a>
      </li>
    <?php }?>
  </ul>
</div>
