// PLAYLIST UPDATER
function reloadPlaylist() {
  if ($('#playlistWrapper').length) {
    $.get('/?p=playlistAsync&content_only', function(data) {
      $('#playlistWrapper').html(data);
      $('#playlistWrapper').addClass('loaded');
    });
  }
}
var playlistUpdater = null;
$('body').on('loadEnd', function() {
  if (!playlistUpdater) {
    playlistUpdater = setInterval(function(){reloadPlaylist();}, 4000);
  }
});
$('body').on('loadBegin', function() {
  clearInterval(playlistUpdater);
  playlistUpdater = null;
});
reloadPlaylist();
// PLAYLIST UPDATER END
