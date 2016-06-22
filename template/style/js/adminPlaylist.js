// EMPTY PLAYLIST
$('#emptyPlaylist').click(function(e) {
  e.preventDefault();
  var button = $(this);
  if (confirm(txtVar01)) {
    $.post(appendQueryString(button[0].href, {'content_only':''}), function() {
      $('#songList li').slideUp();
    });
  }
});
// EMPTY PLAYLIST END
// SKIP TO INDEX
$('.skipButton').click(function(e) {
  e.preventDefault();
  $.post(appendQueryString($(this)[0].href, {'content_only':''}));
  reloadPlaylist();
});
// SKIP TO INDEX END
// REMOVE INDEX
$('.removeButton').click(function(e) {
  e.preventDefault();
  var button = $(this);
  $.post(appendQueryString(button[0].href, {'content_only':''}), function() {
    button.parent().parent().slideUp(function(){
      reloadPlaylist();
    });
  });
});
// REMOVE INDEX END
