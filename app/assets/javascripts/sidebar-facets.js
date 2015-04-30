$(document).ready(function() {
  var width = $(window).width();
  if(width < 992 ){
    $("#facets").remove();
  }
});
