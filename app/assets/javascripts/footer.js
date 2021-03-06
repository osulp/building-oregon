jQuery(resizeMain);
$(window).resize(resizeMain);
function resizeMain(){
  $("#blacklight-map").css("height", 0)
  $("#main-container").css("min-height",0)
  var windowHeight = $(window).height();
  var navbarHeight = $('#header-navbar').outerHeight(true);
  var footerHeight = $('#dynamicFooter').outerHeight(true);
  var links_footer = $("#dynamicFooter .links").outerHeight(true)
  var logoHeight = 45
  if(footerHeight < links_footer+logoHeight) {
    footerHeight = links_footer+logoHeight;
  }
  var containerHeight = $('#main-container').outerHeight(true);
  var sidebarHeight = $('#sidebar').outerHeight(true);
  var contentHeight = $('#content').outerHeight(true);
  if(sidebarHeight > contentHeight) {
    containerHeight = contentHeight
  }
  var total = windowHeight-footerHeight-navbarHeight;
  if(total > 0) {
    $('#main-container').css('min-height', total);
  }
  if($("#theMap").length > 0){
    $('#blacklight-map').css('height', total);
  }else{
    $('#blacklight-map').css('height', total-containerHeight);
  } 
}
