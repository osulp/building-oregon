$(document).ready(function() {
  var path = window.location.pathname;
  if(path.indexOf("oregondigital:") > -1){
    document.getElementById("button").style.visibility = "hidden";
  }
});
