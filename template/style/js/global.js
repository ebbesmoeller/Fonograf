// Loader and state
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
  $('body').addClass('loaded');
  setTimeout(function(){
    $('#loader').hide();
  }, 400);
}
// Loader and state end
// Menu controller
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
// Menu controller end
// Async load of pages
$('a').click(function(e){
  if ($(this).hasClass('async')) {
    e.preventDefault();
    $('#loader').show();
    $('body').removeClass('ready').removeClass('loaded');
    var contentUrl = $(this)[0].href;
    $.get(appendQueryString(contentUrl, {'content_only':''}), function( data ) {
      $( "#mainContent" ).html( data );
      history.pushState('data', '', contentUrl);
      $('body').addClass('ready').addClass('loaded');
      setTimeout(function(){
        $('#loader').hide();
      }, 400);
    });
  }
});
$('#menu a').click(function(e){
  if ($(this).hasClass('async')) {
    e.preventDefault();
    $('#menu li.active').removeClass('active');
    $(this).parent().addClass('active');
  }
});
function appendQueryString(url, queryVars) {
    var firstSeperator = (url.indexOf('?')==-1 ? '?' : '&');
    var queryStringParts = new Array();
    for(var key in queryVars) {
        queryStringParts.push(key + '=' + queryVars[key]);
    }
    var queryString = queryStringParts.join('&');
    return url + firstSeperator + queryString;
}
// Async load of pages end
