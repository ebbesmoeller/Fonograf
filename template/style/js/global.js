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
  if ($('#menu').hasClass('open')) {
    $('#menu').removeClass('open');
    $('#overlay').removeClass('display');
  }
});
// Menu controller end
