/**
 * An Object Oriented handler for working with polygons.
 */

// Declare a ss (street seen) name space if it doesn't exist
var ss = ss || {};

/**
 * A class for handling polygon creation and point population.
 */
ss.Polygon = function(path, googlePolygon) {

  // Path is a sequence of LatLng that define a polygon
  if (typeof path == 'undefined') {
    this.path = new google.maps.MVCArray;
  }
  else {
    this.path = path;
  }

  // Define a base polygon
  if (typeof googlePolygon == 'undefined') {
    this.googlePolygon = new google.maps.Polygon({
      strokeWeight: 3,
      fillColor: '#5555FF'
    });
  }
  else {
    this.googlePolygon = googlePolygon;
  }

  // Set the path for the polygon
  this.googlePolygon.setPaths(new google.maps.MVCArray([this.path]));

}

/**
 * Generate specified number of random points within a polygon.
 * @param  {[type]} desired [description]
 * @return {[type]}         [description]
 */
ss.Polygon.prototype.randomPoints = function(desired) {

  var maxTries = desired * 10;

  var points = new google.maps.MVCArray;
  var bounds = this.googlePolygon.getBounds();

  var lowerLat = bounds.getSouthWest().lat();
  var lowerLng = bounds.getSouthWest().lng();

  // There is a concern here about crossing the international date line
  var latRange = bounds.getNorthEast().lat() - lowerLat;
  var lngRange = bounds.getNorthEast().lng() - lowerLng;

  // Iterate until we reach the desired number of points
  var tries = 0;
  while ((points.length < desired) && (tries < maxTries)) {

    // Guess a point in the bounding box.
    var candidate = new google.maps.LatLng(lowerLat + latRange * Math.random(), lowerLng + lngRange * Math.random());

    // Test to see if it is in our polygon.
    if (google.maps.geometry.poly.containsLocation(candidate, this.googlePolygon)) {
      points.push(candidate);
    }

    tries++;
  }

  return points;
}

