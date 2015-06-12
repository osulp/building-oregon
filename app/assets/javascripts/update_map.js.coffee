jQuery ->
  if navigator.geolocation
    window.UserUpdater = new UserUpdater
    window.map?.on('moveend', window.UserUpdater.map_moved)
    window.map?.on('locationfound', window.UserUpdater.user_found)
    if window.location.search == ""
      setTimeout ->
        window.map?.locate(setView: true)
      , 50
    else
      window.map?.fitBounds(window.markers.getBounds())
  true
class UserUpdater
  constructor: ->
  user_found: =>
    @found = true
    self.map_moved
  map_moved: (e) =>
    return unless @found == true
    bounds = window.map.getBounds()
    south_west = bounds._southWest
    north_east = bounds._northEast
    if @frameRequest?
      @frameRequest.abort()
    @frameRequest = $.getJSON("/geo/frame", $.extend({}, {southwest: "#{south_west.lat},#{south_west.lng}", northeast: "#{north_east.lat},#{north_east.lng}"}, this.current_params()), this.update_frame)
  current_params: ->
    param_string = unescape(window.location.search.replace("?", "")).replace(/\+/g, " ")
    clean_string = decodeURI(param_string.replace(/&/g, "\",\"").replace(/\=/g,"\":\""))
    if clean_string != ""
      JSON.parse('{"' + clean_string + '"}')
    else
      {}
  set_coordinates: (coordinates) ->
    @latitude = this.round(coordinates.latitude)
    @longitude = this.round(coordinates.longitude)
  round: (num) ->
    Math.round(num*10000)/10000
  update_frame: (data) =>
    $('#blacklight-map').blacklight_leaflet_map(data)
