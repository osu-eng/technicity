/**
 * An Object Oriented handler for working with polygons.
 */

// Declare a ss (street seen) name space if it doesn't exist
var ss = ss || {};
ss.handler = ss.handler || {};

/**
 * A class for handling polygon creation and point population.
 * @param {[type]} mapId     [description]
 * @param {[type]} center    [description]
 * @param {[type]} zoom      [description]
 * @param {[type]} editable  [description]
 * @param {[type]} path      [description]
 * @param {[type]} locations [description]
 */
ss.handler.Polygon = function(mapId, center, zoom, editable, path, locations) {

  // 'map' is the default id for a map.
  ss.handler.Polygon.mapId = typeof mapId !== 'undefined' ? mapId : 'map';

  // Center should default to users current location
  center = typeof center !== 'undefined' ? center : new google.maps.LatLng(39.9611, -82.9989);

  // Default zoom is 10 for a good city view
  zoom = typeof zoom !== 'undefined' ? zoom : 10;

  // Editable determines the initial state of the polygon
  editable = typeof editable !== 'undefined' ? editable : true;

  // path is an ordered list of points that make up our polygon.
  if (typeof path == 'undefined') {
    if (!ss.handler.Polygon.path) {
      ss.handler.Polygon.path = new google.maps.MVCArray;
    }
  }
  else {
    ss.handler.Polygon.path = path;
  }

  // locations are points inside of our polygon
  if (typeof locations == 'undefined') {
    if (!ss.handler.Polygon.locations) {
      ss.handler.Polygon.locations = new google.maps.MVCArray;
    }
  }
  else {
    ss.handler.Polygon.locations = locations;
  }

  // pathMarkers contains an array of markers corresponding to points on our path.
  // If we allow re-editing the polygon, this may need initialized.
  ss.handler.Polygon.pathMarkers = new google.maps.MVCArray;

  // map is the google map object
  ss.handler.Polygon.map = new google.maps.Map(
    document.getElementById(ss.handler.Polygon.mapId),
    {
      zoom: zoom,
      center: center,
      disableDefaultUI: !editable,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    });

  polygon = new google.maps.Polygon({
    strokeWeight: 3,
    fillColor: '#5555FF'
  });
  polygon.setMap(ss.handler.Polygon.map);
  polygon.setPaths(new google.maps.MVCArray([ss.handler.Polygon.path]));

  if (editable) {
    // Register a listener to add points to the polygon's path
    google.maps.event.addListener(ss.handler.Polygon.map, 'click', function (event) {

      // Add point to the path
      ss.handler.Polygon.path.insertAt(ss.handler.Polygon.path.length, event.latLng);

      // Create a marker for our path point
      var marker = new google.maps.Marker({
        position: event.latLng,
        map: ss.handler.Polygon.map,
        title: event.latLng.toString(),
        draggable: true
      });

      // Add the marker to our list of markers
      ss.handler.Polygon.pathMarkers.push(marker);

      /**
       * Register a callback to delete a marker/path entry
       */
      google.maps.event.addListener(marker, 'click', function() {

        // Remove the marker from our map
        marker.setMap(null);

        // Find the index of our marker
        i = 0;
        while (i < ss.handler.Polygon.pathMarkers.length && ss.handler.Polygon.pathMarkers.getAt(i) != marker) {
          i++;
        }
        // Remove the item from both the path and markerspath
        ss.handler.Polygon.path.removeAt(i);
        ss.handler.Polygon.pathMarkers.removeAt(i);

      }); // End add point listener

      /**
       * Add a listener to handle dragging markers to reshape the polygon
       */
      google.maps.event.addListener(marker, 'dragend', function() {

        // Find the index of our marker
        i = 0;
        while (i < ss.handler.Polygon.pathMarkers.length && ss.handler.Polygon.pathMarkers.getAt(i) != marker) {
          i++;
        }

        // Update the path point corresponding the the marker location
        ss.handler.Polygon.path.setAt(i, marker.getPosition());
      });

    });
  } // end is editable
}


ss.handler.Polygon.prototype.lock = function() {

  // Reinitialize our map as ineditable
  ss.handler.Polygon.map = new google.maps.Map(
    document.getElementById(ss.handler.Polygon.mapId),
    {
      zoom: ss.handler.Polygon.map.getZoom(),
      center: ss.handler.Polygon.map.getCenter(),
      disableDefaultUI: true,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    });
}

ss.handler.Polygon.prototype.tooClose = function (candidate, distance) {

  var closerThan = false;

  for (var i = 0; i < ss.handler.Polygon.locations.length; i++) {
    var tempDistance = google.maps.geometry.spherical.computeDistanceBetween(candidate, ss.handler.Polygon.locations.getAt(i));
    if (tempDistance < distance) {
      closerThan = true;
    }
  }
  return closerThan;

}

ss.handler.Polygon.prototype.addPoints = function(quantity, proximity, foundId) {

  ss.handler.Polygon.pointQuantity = quantity;
  ss.handler.Polygon.pointProximity = proximity;

  polygon = new google.maps.Polygon({
    strokeWeight: 3,
    fillColor: '#5555FF'
  });
  polygon.setMap(ss.handler.Polygon.map);
  polygon.setPaths(new google.maps.MVCArray([ss.handler.Polygon.path]));

  // Next lets start finding points
  var sv = new google.maps.StreetViewService();

  var tries = 0;
  var batch = 20;

  // We need to keep querying for points until we get the desired number or give up.
  var retry = setInterval(function() {

    // Generate some candidate points within our polygon
    var candidates = polygon.randomPoints(batch);

    // This loop should continue until we reach our quota or exhaust our current candidates
    i = 0;
    while ((i < candidates.length) && (ss.handler.Polygon.locations.length < quantity)) {

      // If the point isn't too close to existing points, look it up in street view
      if (!ss.handler.Polygon.prototype.tooClose(candidates.getAt(i), proximity)) {

        // Look it up in street view (requires a request)
        sv.getPanoramaByLocation(candidates.getAt(i), 50, function(data, status) {

          // Process results back from street view asynchronously
          if (status == google.maps.StreetViewStatus.OK) {

            // Check to make sure the new point is still in the bounding box
            // and still isn't too close to other points.
            if (google.maps.geometry.poly.containsLocation(data.location.latLng, polygon)
               && !ss.handler.Polygon.prototype.tooClose(data.location.latLng, proximity)) {

              // This should probably use semaphores
              if (ss.handler.Polygon.locations.length < quantity) {

                // Create a marker for the map
                var marker = new google.maps.Marker({
                  position: data.location.latLng,
                  map: ss.handler.Polygon.map,
                  title: data.location.description
                });

                // Add the marker's position to our locations
                ss.handler.Polygon.locations.push(marker.getPosition());
              }
            }
          }
        });
      }

      i++;
    }

    // Update setInterval information
    $('#' + foundId).html('Found <strong>' + ss.handler.Polygon.locations.length + '</strong> locations');
    tries++;

    // Check and see if it is time to clear the interval
    if ((ss.handler.Polygon.locations.length == quantity) || (tries > 4 * quantity / batch)) {
      clearInterval(retry);
    }
  }, 400); // 400ms is our interval

}




/**
 * Generates random points within a polygon.
 *
 * This algorithm works by constructing a bounding box for a polygon
 * and guessing points randomly within that box. These are then checked
 * to see if they inside the polygon. Note, this extends the polygon class.
 *
 * @param  {[integer]} desired   Desired number of points
 * @return {[MVCArray]}          Points in the polygon
 */
google.maps.Polygon.prototype.randomPoints = function(desired) {

  var maxTries = 1000;

  var points = new google.maps.MVCArray;
  var bounds = this.getBounds();

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
    if (google.maps.geometry.poly.containsLocation(candidate, this)) {
      points.push(candidate);
    }

    tries++;
  }

  return points;
}

