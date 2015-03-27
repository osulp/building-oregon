jQuery(resizeMain);
$(window).resize(resizeMain);
function resizeMain(){
  var windowHeight = $(window).height();
  var footerHeight = $('#dynamicFooter').outerHeight(true);
  var containerPos = $('#main-container').offset().top;
  var total = windowHeight-containerPos-footerHeight;
  console.log(footerHeight)
  $('#main-container').css('min-height', total);
}
