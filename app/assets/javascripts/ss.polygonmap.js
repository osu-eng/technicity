/**
 * An Object Oriented handler for working with maps.
 */

// Declare a ss (street seen) name space if it doesn't exist
var ss = ss || {};

/**
 * A class for handling basic map operations in consort with polygons
 */
ss.PolygonMap = function(polygon, mapId, center, zoom, editable) {

  /**
   * Recognized default callbacks
   *
   * this.markerClickCb - what happens after you click on a marker
   * this.markerPersistCb - after finding an SV point, this is called before adding to markers, should return id
   */

  // Polygon is required
  this.polygon = polygon;

  // 'map' is the default id for a map.
  this.mapId = typeof mapId !== 'undefined' ? mapId : 'map';

  // Center should default to users current location
  this.center = typeof center !== 'undefined' ? center : new google.maps.LatLng(39.9611, -82.9989);

  // Default zoom is 10 for a good city view
  this.zoom = typeof zoom !== 'undefined' ? zoom : 10;

  // Editable determines the initial state of the polygon
  this.editable = typeof editable !== 'undefined' ? editable : true;

  // Initialize markers
  this.markers = new google.maps.MVCArray;

  // LatLng's that have not yet become markers
  this.pendingPoints = new google.maps.MVCArray;

  // map is the google map object
  this.googleMap = new google.maps.Map(
    document.getElementById(this.mapId),
    {
      zoom: this.zoom,
      center: this.center,
      disableDefaultUI: !this.editable,
      scrollwheel: this.editable,
      navigationControl: this.editable,
      scaleControl: this.editable,
      draggable: this.editable,
      mapTypeControl: this.editable,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    });

  // Add polygon to this map
  this.polygon.googlePolygon.setMap(this.googleMap);
}

/**
 * Adds a marker to our map and this.markers.
 * @param {[type]} id        a unique numeric identifier, will be in title, becomes z-index
 * @param {[type]} latitude
 * @param {[type]} longitude
 */
ss.PolygonMap.prototype.addMarker = function(id, point) {

  // Create a marker
  marker = new google.maps.Marker({
    position: point,
    map: this.googleMap,
    title: 'Location Id:\n  '+ id + '\n\nCoordinates:\n  ' + point.lat() + ', ' + point.lng(),
    draggable: false,
    zIndex: id,
    });

  // Add it to our list of markers
  this.markers.push(marker);
  this.totalMarkers++;

  // Add an event handler for clicking if one is provided
  if (this.markerClick) {
    clickCb = this.markerClick;
  }
  else {
    clickCb = ss.PolygonMap.markerClick;
  }
  google.maps.event.addListener(marker, 'click', clickCb);

  return marker;
}

/**
 * Removals are done using zIndex as long as id is an integer.
 * @param  {[type]} id [description]
 * @return {[type]}    [description]
 */
ss.PolygonMap.prototype.removeMarker = function (id) {
  for (i=0; i<this.markers.getLength(); i++) {
    if (this.markers.getAt(i).getZIndex() == id) {
      this.markers.removeAt(i);
    }
  }
}

/**
 * Returns true if candidate is closerThan distance to another point.
 * @param  {[type]} candidate [description]
 * @param  {[type]} distance  [description]
 * @return {[type]}           [description]
 */
ss.PolygonMap.prototype.closerThan = function (candidate, distance) {

  var closerThan = false;

  // Check all markers
  for (var i = 0; i < this.markers.length; i++) {
    var tempDistance = google.maps.geometry.spherical.computeDistanceBetween(candidate, this.markers.getAt(i).getPosition());
    if (tempDistance < distance) {
      closerThan = true;
    }
  }

  // Check all pending points
  for (var i = 0; i < this.pendingPoints.length; i++) {
    var tempDistance = google.maps.geometry.spherical.computeDistanceBetween(candidate, this.pendingPoints.getAt(i));
    if (tempDistance < distance) {
      closerThan = true;
    }
  }
  return closerThan;

}

/**
 * This function does a lot of asynchronous stuff.
 * I suspect it needs better concurrency handling
 * although what's here will rarely have issues.
 *
 * @param {[type]} quantity  [description]
 * @param {[type]} proximity [description]
 */
ss.PolygonMap.prototype.addPoints = function(quantity, proximity) {

  // Next lets start finding points
  var sv = new google.maps.StreetViewService();

  var tries = 0;
  var batch = 20;

  var $this = this;

  // We need to keep querying for points until we get the desired number or give up.
  var retry = setInterval(function() {

    // Generate some candidate points within our polygon
    var candidates = this.polygon.randomPoints(batch);

    // This loop should continue until we reach our quota or exhaust our current candidates
    i = 0;
    while ((i < candidates.length) && ($this.markers.length + $this.pendingPoints.length < quantity)) {

      // If the point isn't too close to existing points, look it up in street view
      if (!$this.closerThan(candidates.getAt(i), proximity)) {

        // Look it up in street view (requires a request) - finds closes point within 1000 meters
        sv.getPanoramaByLocation(candidates.getAt(i), 1000, function(data, status) {

          // Process results back from street view asynchronously
          if (status == google.maps.StreetViewStatus.OK) {

            // Check to make sure the new point is still in the bounding box
            // and still isn't too close to other points.
            if (google.maps.geometry.poly.containsLocation(data.location.latLng, $this.polygon.googlePolygon)
               && !$this.closerThan(data.location.latLng, proximity)) {

              if ($this.markers.length + $this.pendingPoints.length < quantity) {

                // Add to our list of pending points
                maxIndex = $this.pendingPoints.push(data.location.latLng) - 1;

                // Trigger a callback to get an id for our point, database update may happen here.
                if (typeof $this.markerPersistCb !== 'undefined') {
                  $this.markerPersistCb(data.location.latLng);
                }
                else {
                  // We should probably do max zindex + 1, but this is fairly safe for mapping
                  id = Math.random() * 9007199254740992;

                  // Add our new marker
                  $this.addMarker(id, data.location.latLng);

                  // Remove from pending points - Don't assume index <= value at start
                  start = maxIndex > $this.pendingPoints.length ? $this.pendingPoints.length : maxIndex;
                  for (i=start; i>-1; i--) {
                    if (data.location.latLng.lat() == $this.pendingPoints.getAt(i)) {
                      $this.pendingPoints.removeAt(i);
                    }
                  }
                }


              }
            }
          }
        });
      }

      i++;
    }

    // Update setInterval information
    tries++;

    // Check and see if it is time to clear the interval
    if (($this.markers.length + $this.pendingPoints.length == quantity) || (tries > 10 * quantity / batch)) {
      clearInterval(retry);
    }
  }, 400); // 400ms is our interval

}

/**
 * Removes an item from pending points and adds it to the marker list.
 * You might fire this callback after persisting a point to a database.
 *
 * @param  {[type]} id       [description]
 * @param  {[type]} position [description]
 * @return {[type]}          [description]
 */
ss.PolygonMap.prototype.promotePendingToMarker = function(id, position) {

  for (i=this.pendingPoints.length-1; i>-1; i--) {

    item = this.pendingPoints.getAt(i);
    if ((position.lat() == item.lat()) && (position.lng() == item.lng())) {
      this.pendingPoints.removeAt(i);
      this.addMarker(id, position);
    }
  }
}

ss.PolygonMap.markerClick = function() {

}
