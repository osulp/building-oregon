$(document).ready(function() {
  var width = $(window).width();
  if(width < 1024 ){
    $("#facets").remove();
  }
});
