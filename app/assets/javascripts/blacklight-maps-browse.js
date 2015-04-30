;(function( $ ) {

  $.fn.blacklight_leaflet_map = function(geojson_docs, arg_opts) {
    var map, sidebar, markers, geoJsonLayer, currentLayer;

    // Configure default options and those passed via the constructor options
    var options = $.extend({
      tileurl : 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      mapattribution : 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
      sidebar: 'blacklight-map-sidebar'
    }, arg_opts );

    // Extend options from data-attributes
    $.extend(options, this.data());

    // Display the map
    this.each(function() {
      options.id = this.id;

      if(!window.map || typeof window.map === 'undefined') {
      // Setup Leaflet map
        if(L.Browser.mobile){
          var map_opts = {dragging: false, tap: false, minZoom: 8}
        }else{
          var map_opts = { minZoom: 4}
        }
        map = L.map(this.id, map_opts).setView([44.5620,-123.02], 2);
        window.map = map
        L.tileLayer(options.tileurl, {
          attribution: options.mapattribution,
          maxZoom: options.maxzoom,
        }).addTo(map);
        // Initialize sidebar
        sidebar = L.control.sidebar(options.sidebar, {
          position: 'right',
          autoPan: false
        });

        // Adds leaflet-sidebar control to map
        map.addControl(sidebar);

        // Create location marker icon
        var locationIcon = L.icon({
          iconUrl: 'http://www.lscarolinas.net/assets/leaflet/images/marker-icon-blue.png',
          iconAnchor: [13, 12]
        });
        // Sets the options for the getCurrentLocation function
        var opts = {
          enableHighAccuracy: true,
          timeout: 5000,
          maximumAge: 0
        };

        // Creates the marker at the default location
        if(navigator.geolocation) {
          var  locationMarker = new L.Marker([44.5649730045019, -123.275924921036], {icon: locationIcon}).addTo(map)
        }
        // Puts the marker on the map if the get location was successful
        var success = function (position) {
          locationMarker.setLatLng([position.coords.latitude, position.coords.longitude]);
        }
       // Gets the current location on map load
       document.onload = getLocation();
        function getLocation() {
          if(navigator.geolocation) {
            navigator.geolocation.watchPosition(success, function () {}, opts);
          }
        }
        //Add click listener to map
        map.on('click drag', hideSidebar);
      }
      map = window.map
      if(typeof window.markers !== 'undefined') {
        map.removeLayer(window.markers)
      }
      // Create a marker cluster object and set options
      window.markers = new L.MarkerClusterGroup({
        showCoverageOnHover: false,
        spiderfyOnMaxZoom: false,
        maxClusterRadius: 10,
        singleMarkerMode: true,
        animateAddingMarkers: true
      });
      markers = window.markers;
      if(window.reset_button) {
        window.map.removeControl(window.reset_button);
      }
      if(markers.count > 0) {
        var myButton = L.easyButton('glyphicon glyphicon-screenshot',function(){map.fitBounds(window.markers.getBounds())},'Reset Map')
      } else {
        var myButton = L.easyButton('glyphicon glyphicon-screenshot',function(){map.setView([44.5620, -123.02], 2)},'Reset Map')
      }
      window.reset_button = myButton

      // Creates the geoJsonLayer
      geoJsonLayer = L.geoJson(geojson_docs, {
        onEachFeature: function(feature, layer){
          layer.defaultOptions.title = getMapTitle(options.type, feature.properties.name);
          layer.on('click', function(e){
            var placenames = {};
            placenames[layer.defaultOptions.title] = [feature.properties.html];
            setupSidebarDisplay(e,placenames);
          });
        }
      });

      // Add GeoJSON layer to marker cluster object
      markers.addLayer(geoJsonLayer);


      // Add marker cluster object to map
      map.addLayer(markers);

      // Zooms to show all points on map
      if((geojson_docs.features.length > 0)) {
        map.fitBounds(markers.getBounds());
      } else {
        map.setView([44.5620, -123.02], 2);
      }

      // Listeners for marker cluster clicks
      markers.on('clusterclick', function(e){
        hideSidebar();

        //if map is at the lowest zoom level
        if (map.getZoom() === options.maxzoom){

          var placenames = generatePlacenamesObject(e.layer.getAllChildMarkers());
          setupSidebarDisplay(e,placenames);
        }
      });


    });

    function setupSidebarDisplay(e, placenames){
      hideSidebar();
      offsetMap(e);
      if (currentLayer !== e.layer || !("layer" in e)){
        // Update sidebar div with new html
        $('#' + options.sidebar).html(buildList(placenames));

        // Scroll sidebar div to top
        $('#' + options.sidebar).scrollTop(0);
        currentLayer = e.layer;
      }

      // Show the sidebar
      sidebar.show();

    }

    // Hides sidebar if it is visible
    function hideSidebar(){
      if (sidebar.isVisible()){
        sidebar.hide();
      }
    }

    // Build the list
    function buildList(placenames){
      var html = "";
      var href = "";
      $.each(placenames, function(i,val){
        html += "<ul class='sidebar-list'>";
        html += val;
        html += "</ul>";
      });
      return html;
    }

    // Generates placenames object
    function generatePlacenamesObject(markers){
      var placenames = {};
      $.each(markers, function(i,val){
        if (!(val.defaultOptions.title in placenames)){
          placenames[val.defaultOptions.title] = [];
        }
        placenames[val.defaultOptions.title].push(val.feature.properties.html);
      });
      return placenames;
    }

    // Move the map so that it centers the clicked cluster TODO account for various size screens
    function offsetMap(e){
      var mapWidth = $('#' + options.id).width();
      var mapHeight = $('#' + options.id).height();
      if (!e.latlng.equals(map.getCenter())){
        map.panBy([(e.originalEvent.layerX - (mapWidth/4)), (e.originalEvent.layerY - (mapHeight/2))]);
      }else{
        map.panBy([(mapWidth/4), 0]);
      }
    }

  };

  function getMapTitle(type, featureName){
    switch(type){
    case 'bbox':
      return 'Results';
    case 'placename_coord':
      return featureName;
    default:
      return 'Results';
    }
  }

}( jQuery ));
