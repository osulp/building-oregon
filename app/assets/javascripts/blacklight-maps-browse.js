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
      firstInitialization = false

      if(!window.map || typeof window.map === 'undefined') {
      // Setup Leaflet map
        firstInitialization = true
        if(L.Browser.mobile){
          var map_opts = {}
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

        // Puts the marker on the map if the get location was successful
        var success = function (position) {
          locationMarker.setLatLng([position.coords.latitude, position.coords.longitude]);
        }
        function onLocationFound(e) {
          L.marker(e.latlng).addTo(map);
        }
 
        map.on('locationfound', onLocationFound);
 
        //Add click listener to map
        map.on('click drag', hideSidebar);
        window.sidebar = sidebar
          var myButton = L.easyButton('glyphicon glyphicon-screenshot',function(){
            if(window.markers) {
              map.locate({setView: true, maxZoom: 16}); 
            } else {
              window.map.setView([44.5620, -123.02], 2)
            }
      },'Reset Map')
      }
      map = window.map

      sidebar = window.sidebar
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
      if(typeof window.all_geojson === 'undefined') {
        window.all_geojson = geojson_docs;
      } else {
        features = window.all_geojson.features;
        new_features = geojson_docs.features;
        string_features = $.map(features, JSON.stringify)
        $.each(new_features, function(index, value) {
          if ($.inArray(JSON.stringify(value), string_features)==-1) {
            features.push(value)
          }
        });
        window.all_geojson.features = features
      }

      // Creates the geoJsonLayer
      geoJsonLayer = L.geoJson(window.all_geojson, {
        onEachFeature: function(feature, layer){
          layer.defaultOptions.title = getMapTitle(options.type, feature.properties.name);
          layer.on('click', function(e){
            var placenames = {};
            placenames[layer.defaultOptions.title] = [feature.properties.html];
            setupSidebarDisplay(e,placenames);
          });
        }
      });

      window.layer = geoJsonLayer

      // Add GeoJSON layer to marker cluster object
      markers.addLayer(geoJsonLayer);


      // Add marker cluster object to map
      map.addLayer(markers);

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
      $.each(placenames, function(key, array){
        $.each(array, function(index, value){
          html += value;
        });
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
