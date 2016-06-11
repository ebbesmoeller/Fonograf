<?php
class Authentication {
  public function authenticate() {
    $username = Post::getPost('loginUsername');
    $password = Post::getPost('loginPassword');
    if ($username && $password) {
      if (sha1($username) == sha1(_ADMIN_USER_) && sha1($password) == sha1(_ADMIN_PASS_)) {
        $_SESSION['authenticated'] = true;
        return true;
      }
    }
    else if (self::isAuthenticated()) {
      return true;
    }
    else {
      return false;
    }
  }
  public static function unAuthenticate() {
    $_SESSION['authenticated'] = null;
  }
  public static function isAuthenticated() {
    if (array_key_exists('authenticated', $_SESSION) && $_SESSION['authenticated'] == true){
      return true;
    }
    else {
      return false;
    }
  }
}
