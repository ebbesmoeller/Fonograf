// LOADER AND STATE
$(document).ready(function(){
  $('body').addClass('ready');
  setTimeout(function(){
    triggerLoaded();
  }, 2000);
});

$(window).bind("load", function() {
  triggerLoaded();
});

function triggerLoaded() {
  $('body').trigger('loadEnd');
  $('body').addClass('loaded');
  setTimeout(function(){
    $('#loader').hide();
  }, 400);
}
// LOADER AND STATE END
// MENU CONTROLLER
$('.menuBtn').click(function(){
  $('#menu').toggleClass('open');
  if ($('#menu').hasClass('open')) {
    $('#overlay').addClass('display');
  }
  else {
    $('#overlay').removeClass('display');
  }
});

$('#overlay').click(function(){
  hideMenu();
});

$('#menu a').click(function(){
  hideMenu();
});
function hideMenu() {
  if ($('#menu').hasClass('open')) {
    $('#menu').removeClass('open');
    $('#overlay').removeClass('display');
  }
}
// MENU CONTROLLER END
// ASYNC LOAD OF PAGES
$(document).on('click', '#menu a.async', function(e) {
  e.preventDefault();
  $('#menu li.active').removeClass('active');
  $(this).parent().addClass('active');
  reloadAsync($(this)[0].href);
});

$(document).on('click', '#mainContent a.async', function(e) {
  e.preventDefault();
  $('#menu li.active').removeClass('active');
  reloadAsync($(this)[0].href);
});

window.addEventListener("popstate", function(e) {
  var currentPage = getParameterByName('p');
  $('#menu li.active').removeClass('active');
  if (currentPage == null) {
    $('#menu li.home').addClass('active');
  }
  else {
    $('#menu li.'+currentPage).addClass('active');
  }
  reloadAsync(window.location.href);
});

function reloadAsync(url) {
  $('body').trigger('loadBegin');
  scrollToTop();
  $('#loader').show();
  $('body').removeClass('ready').removeClass('loaded');
  console.log(appendQueryString(url, {'content_only':''}));
  $.get(appendQueryString(url, {'content_only':''}), function(data) {
    $( "#mainContent" ).html( data );
    history.pushState('data', '', url);
    setTimeout(function(){
      $('body').addClass('ready').addClass('loaded');
      $('body').trigger('loadEnd');
      setTimeout(function(){
        $('#loader').hide();
      }, 400);
    }, 200);
  });
}

function appendQueryString(url, queryVars) {
    var firstSeperator = (url.indexOf('?')==-1 ? '?' : '&');
    var queryStringParts = new Array();
    for(var key in queryVars) {
        queryStringParts.push(key + '=' + queryVars[key]);
    }
    var queryString = queryStringParts.join('&');
    return url + firstSeperator + queryString;
}

function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}
// ASYNC LOAD OF PAGES END
// ASYNC ADD TO PLAYLIST
$(document).on('click', 'a.addTrack', function(e) {
  e.preventDefault();
  var link = $(this);
  if (!link.hasClass('pressed') && !link.hasClass('getting')) {
    link.addClass('getting');
    $.post(link[0].href, function() {
      link.removeClass('getting');
      link.removeClass('error');
      link.addClass('pressed');
    })
    .fail(function() {
      link.removeClass('getting');
      link.removeClass('pressed');
      link.addClass('error');
    });
  }
});
// ASYNC ADD TO PLAYLIST END
// TO TOP BUTTON
$(window).scroll(function() {
  if($(window).scrollTop()>(window.innerHeight/2)&&$('#toTop').is(":hidden")) {
    $('#toTop').show();
    $('#toTop').addClass('display');
  }
  else if($(window).scrollTop()<=(window.innerHeight/2)&&$('#toTop').is(":visible")) {
    $('#toTop').removeClass('display');
    setTimeout(function(){
      $('#toTop').hide();
    }, 400);
  }
});
$('#toTop').on("click",function() {
  scrollToTop();
});
function scrollToTop() {
  $('html,body').animate({scrollTop:0},'medium',function(){});
}
// TO TOP BUTTON
