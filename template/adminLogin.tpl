<?php if (!Post::getQuery('content_only')) {?>
  <?php
    Authentication::authenticate();
    if (Authentication::isAuthenticated()) {
      header('Location: /?p=adminControls');
    }
  ?>

  <?php if(!Authentication::authenticate() && Post::getPost('loginUsername')) {?>
    <div class="alert alert-danger">
      <?php $t->t('Wrong username and/or password. Please try again.')?>
    </div>
  <?php }?>

  <div class="panel">
    <div class="panel-body">
      <div class="row">
        <form class="form-group text-center col-xs-12 col-sm-5 col-md-4 col-lg-3" method="post" name="loginForm" style="float: none; margin: auto;">
          <input type="text" class="form-control" name="loginUsername" placeholder="<?php $t->t('Username')?>"/>
          <br />
          <input type="password" class="form-control" name="loginPassword" placeholder="<?php $t->t('Password')?>"/>
          <br />
          <button type="submit" class="btn btn-primary"><i class="fa fa-sign-in" aria-hidden="true"></i>&nbsp;<?php $t->t('Login')?></button>
        </form>
      </div>
    </div>
  </div>
<?php } else {?>
  <script type="text/javascript">
    location.reload();
  </script>
<?php }?>
