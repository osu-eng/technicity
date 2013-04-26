/**
 * An Object Oriented handler for creating heatmaps.
 */

// Declare a ss (street seen) name space if it doesn't exist
var ss = ss || {};
ss.handler = ss.handler || {};

ss.handler.Heatmap = function(mapId, center, zoom, maxIntensity, locations) {
  // 'map' is the default id for a map.
  ss.handler.Polygon.mapId = typeof mapId !== 'undefined' ? mapId : 'map';

  // Center should default to users current location
  center = typeof center !== 'undefined' ? center : new google.maps.LatLng(39.9611, -82.9989);

  // Default zoom is 10 for a good city view
  zoom = typeof zoom !== 'undefined' ? zoom : 10;

  // locations is an array of WeightedLocation objects.
  zoom = typeof zoom !== 'undefined' ? zoom : 10;


}
