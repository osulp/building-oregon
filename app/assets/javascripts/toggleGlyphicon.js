function toggleGlyphicon(){
  if($('.glyphicon-chevron-right').length > 0){
    $('.glyphicon-chevron-right').toggleClass("glyphicon-chevron-right glyphicon-chevron-left");
  } else if($('.glyphicon-chevron-left').length > 0){
    $('.glyphicon-chevron-left').toggleClass("glyphicon-chevron-right glyphicon-chevron-left"); 
  }
}
