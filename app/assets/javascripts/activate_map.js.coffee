jQuery ->
  $("a[data-toggle='tab']").on('shown.bs.tab', (e) ->
    if $(e.target).attr("href") == "#map-pane"
      window.map?.invalidateSize()
      if $(".leaflet-map-pane").length < 1
        $('#blacklight-map').blacklight_leaflet_map(window.map_data)
  )
  if $("#documents.map").length > 0 && $(".leaflet-map-pane").length < 1
    $("#blacklight-map").blacklight_leaflet_map(window.map_data)
  $("#blacklight-map-sidebar").on('click', 'a[data-context-href]', Blacklight.handleSearchContextMethod)
