/**
 * An Object Oriented handler for creating heatmaps.
 */

// Declare a ss (street seen) name space if it doesn't exist
var ss = ss || {};
ss.handler = ss.handler || {};

ss.handler.Heatmap = function(mapId, center, zoom, intensity, locations, path) {
  // 'map' is the default id for a map.
  ss.handler.Heatmap.mapId = typeof mapId !== 'undefined' ? mapId : 'map';

  // Center should default to users current location
  center = typeof center !== 'undefined' ? center : new google.maps.LatLng(39.9611, -82.9989);

  // Default zoom is 10 for a good city view
  zoom = typeof zoom !== 'undefined' ? zoom : 10;

  // locations is an array of WeightedLocation objects.
  locations = typeof locations !== 'undefined' ? locations : Array();

  // path is an ordered list of points that make up our polygon.
  if (typeof path == 'undefined') {
    if (!ss.handler.Heatmap.path) {
      ss.handler.Heatmap.path = new google.maps.MVCArray;
    }
  }
  else {
    ss.handler.Heatmap.path = path;
  }

  // map is the google map object
  ss.handler.Heatmap.map = new google.maps.Map(
    document.getElementById(ss.handler.Heatmap.mapId),
    {
      zoom: zoom,
      center: center,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
  );

  var heatmap = new google.maps.visualization.HeatmapLayer({
    data: locations,
    maxIntensity: intensity,
    radius: 15,
    dissipating: true
  });
  heatmap.setMap(ss.handler.Heatmap.map);

  polygon = new google.maps.Polygon({
    strokeWeight: 3,
    fillOpacity: 0
  });
  polygon.setMap(ss.handler.Heatmap.map);
  polygon.setPaths(new google.maps.MVCArray([ss.handler.Heatmap.path]));
}
