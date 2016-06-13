// PLAYLIST UPDATER
var playlistUpdater
function reloadPlaylist() {
  if ($('#playlistWrapper').length) {
    $.get('/?p=adminPlaylistAsync&content_only', function(data) {
      $('#playlistWrapper').html(data);
      $('#playlistWrapper').addClass('loaded');
    });
  }
}
$('body').on('loadEnd', function() {
  if (playlistUpdater == null) {
    playlistUpdater = setInterval(function(){reloadPlaylist();}, 4500);
  }
});
reloadPlaylist();
// PLAYLIST UPDATER END
// SKIP TO INDEX
  var skipButtonClick = $(document).on('click', '.skipButton', function(e) {
    e.preventDefault();
    $.post(appendQueryString($(this)[0].href, {'content_only':''}));
    skipButtonClick = null;
  });
// SKIP TO INDEX END
