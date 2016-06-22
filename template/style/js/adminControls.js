// VOLUME KNOB
$(function() {
  $('#volume').knob({
    'min' : 1,
    'step' : 2,
    'width' : '200',

    'thickness' : .1,
    'fgColor' : '#ff1e53',
    'bgColor' : '#222222',
    'displayInput' : false,
    'displayPrevious' : true,
    'release' : function(v) {
      $.post(appendQueryString(window.location.href, {'setVolume':v}), function(data) {

      });
    },
  });
});
// VOLUME KNOB END

// MUTE BUTTON
var muteButtonClick = null;
if (!muteButtonClick) {
  muteButtonClick = $('#muteButton').click(function(e) {
    $.post(appendQueryString(window.location.href, {'setMute':''}));
  });
}
function setMuteButton(boolean) {
  var muteButton = $('#muteButton');
  if (boolean) {
    muteButton.addClass('muted');
    muteButton.html('<i class=\"fa fa-volume-off\" aria-hidden=\"true\"></i>');
  }
  else {
    muteButton.removeClass('muted');
    muteButton.html('<i class=\"fa fa-volume-up\" aria-hidden=\"true\"></i>');
  }
}
$('body').on('loadBegin', function() {
  muteButtonClick = null;
});
// MUTE BUTTON END

// PAUSE BUTTON
var pauseButtonClick = null;
if (!pauseButtonClick) {
  pauseButtonClick = $('#pauseButton').click(function(e) {
    $.post(appendQueryString(window.location.href, {'setPause':''}));
  });
}
function setPauseButton(boolean) {
  var pauseButton = $('#pauseButton');
  if (boolean) {
    pauseButton.addClass('paused');
    pauseButton.html('<i class=\"fa fa-play\" aria-hidden=\"true\"></i>');
  }
  else {
    pauseButton.removeClass('paused');
    pauseButton.html('<i class=\"fa fa-pause\" aria-hidden=\"true\"></i>');
  }
}
$('body').on('loadBegin', function() {
  pauseButtonClick = null;
});
// PAUSE BUTTON END

// PREVIOUS BUTTON
var prevButtonClick = null;
if (!prevButtonClick) {
  prevButtonClick = $('#prevButton').click(function(e) {
    $.post(appendQueryString(window.location.href, {'setPrevTrack':''}));
  });
}
$('body').on('loadBegin', function() {
  prevButtonClick = null;
});
// PREVIOUS BUTTON END

// NEXT BUTTON
var nextButtonClick = null;
if (!nextButtonClick) {
  nextButtonClick = $('#nextButton').click(function(e) {
    $.post(appendQueryString(window.location.href, {'setNextTrack':''}));
  });
}
$('body').on('loadBegin', function() {
  nextButtonClick = null;
});
// NEXT BUTTON END


// STATE UPDATER
var stateUpdater
function updateState() {
  if ($('#playerState').length) {
    $.get({
      url: '/download/playerState.php',
      cache: false
    }).done(function(data){

      // SONG NAME
      trackName = data.track;
      if (trackName == null)
        trackName = '&nbsp;';
      if ($('#songName').html() != trackName) {
        $('#songName').html(trackName);
      }

      // ARTIST NAME
      artistName = data.artist;
      if (artistName == null)
        artistName = '&nbsp;';
      if ($('#artistName').html() != artistName) {
        $('#artistName').html(artistName);
      }

      // MUTE STATE
      var buttonMuted = $('#muteButton').hasClass('muted');
      if (buttonMuted && !data.mute) {
        setMuteButton(false);
      }
      else if (!buttonMuted && data.mute) {
        setMuteButton(true);
      }

      // PAUSE STATE
      var buttonPaused = $('#pauseButton').hasClass('paused');
      if (buttonPaused && !data.pause) {
        setPauseButton(false);
      }
      else if (!buttonPaused && data.pause) {
        setPauseButton(true);
      }
    }).fail(function(){
      $('#songName').html('&nbsp;');
      $('#artistName').html('&nbsp;');
    });
  }
}
$('body').on('loadEnd', function() {
  if (!stateUpdater) {
    stateUpdater = setInterval(function(){updateState();}, 2000);
  }
});
$('body').on('loadBegin', function() {
  clearInterval(stateUpdater);
  stateUpdater = null;
});
updateState();
// STATE UPDATER END
// PLAYLIST UPDATER
function reloadPlaylist() {
  if ($('#adminPlaylistWrapper').length) {
    $.get('/?p=adminPlaylistAsync&content_only', function(data) {
      $('#adminPlaylistWrapper').html(data);
      $('#adminPlaylistWrapper').addClass('loaded');
    });
  }
}
var playlistUpdater = null;
$('body').on('loadEnd', function() {
  if (!playlistUpdater) {
    playlistUpdater = setInterval(function(){reloadPlaylist();}, 4500);
  }
});
$('body').on('loadBegin', function() {
  clearInterval(playlistUpdater);
  playlistUpdater = null;
});
reloadPlaylist();
// PLAYLIST UPDATER END
