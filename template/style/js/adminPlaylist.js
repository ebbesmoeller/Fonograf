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
