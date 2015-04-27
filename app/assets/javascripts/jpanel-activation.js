$(document).ready(function() {
  var jPM = $.jPanelMenu({
    menu: '#facets',
    trigger: '#button',
    duration: 300,
    excludedPanelContent: "#ajax-modal"
  });
  jPM.on();
});

