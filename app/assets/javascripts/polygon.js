/**
 * This javascript file has some handy functions for working with maps
 * and polygons. It makes a few assumptions. Namely that the following
 * variables exist in a global scope.
 *
 * map
 * path
 * markers
 * polygon
 */


/**
 * Initializes a google map with a polygon.
 *
 * @return {[type]} [description]
 */
function initializeMap(id, center, zoom, ui) {
  var sv = new google.maps.StreetViewService();
  map = new google.maps.Map(document.getElementById(id), {
    zoom: zoom,
    center: center,
    disableDefaultUI: ui,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  polygon = new google.maps.Polygon({
    strokeWeight: 3,
    fillColor: '#5555FF'
  });
  polygon.setMap(map);
  polygon.setPaths(new google.maps.MVCArray([path]));

  return map;
}

/**
 * A problem with this function is that it really only
 * finds x possible points in the polygon and tries them
 * in street view. It's very possible for only a small
 * number of those to work in streetview.
 *
 * @param  {[type]} points The number of points you want
 * @return {[type]}        [description]
 */
function populatePoints(points) {

  // First lets lock the map
  map = initializeMap('map', map.getCenter(), map.zoom, true);
  polygon = new google.maps.Polygon({
    strokeWeight: 3,
    fillColor: '#5555FF'
  });
  polygon.setPaths(new google.maps.MVCArray([path]));

  // Next lets start finding points
  var sv = new google.maps.StreetViewService();
  var candidates = polygon.randomPoints(points);
  for (var i = 0; i<candidates.length; i++) {
    sv.getPanoramaByLocation(candidates.getAt(i), 50, processSVData);
  }
}

function addPoint(event) {
  path.insertAt(path.length, event.latLng);

  var marker = new google.maps.Marker({
    position: event.latLng,
    map: map,
    draggable: true
  });
  markers.push(marker);
  marker.setTitle("#" + path.length);

  google.maps.event.addListener(marker, 'click', function() {
    marker.setMap(null);
    for (var i = 0, I = markers.length; i < I && markers[i] != marker; ++i);
    markers.splice(i, 1);
    path.removeAt(i);
    }
  );

  google.maps.event.addListener(marker, 'dragend', function() {
    for (var i = 0, I = markers.length; i < I && markers[i] != marker; ++i);
    path.setAt(i, marker.getPosition());
    }
  );

}

function processSVData(data, status) {
  if (status == google.maps.StreetViewStatus.OK) {
    if (google.maps.geometry.poly.containsLocation(data.location.latLng, polygon)) {

      var marker = new google.maps.Marker({
        position: data.location.latLng,
        map: map,
        title: data.location.description
      });

      locations.push(marker);
    }
  }
}

/**
 * Adds a get bounds function to return the bounding box.
 * Note: This may be included in google geometry. Maybe we can remove this?
 */
if (!google.maps.Polygon.prototype.getBounds) {
  google.maps.Polygon.prototype.getBounds = function(latLng) {
    var bounds = new google.maps.LatLngBounds();
    var paths = this.getPaths();
    var path;
    for (var p = 0; p < paths.getLength(); p++) {
      path = paths.getAt(p);
      for (var i = 0; i < path.getLength(); i++) {
        bounds.extend(path.getAt(i));
      }
    }
     return bounds;
  }
}



/**
 * PHP-like print_r() & var_dump() equivalent for JavaScript Object
 *
 * @author Faisalman <movedpixel@gmail.com>
 * @license http://www.opensource.org/licenses/mit-license.php
 * @link http://gist.github.com/879208
 */
var print_r = function(obj,t){

    // define tab spacing
    var tab = t || '';

    // check if it's array
    var isArr = Object.prototype.toString.call(obj) === '[object Array]' ? true : false;

    // use {} for object, [] for array
    var str = isArr ? ('Array\n' + tab + '[\n') : ('Object\n' + tab + '{\n');

    // walk through it's properties
    for(var prop in obj){
        if (obj.hasOwnProperty(prop)) {
            var val1 = obj[prop];
            var val2 = '';
            var type = Object.prototype.toString.call(val1);
            switch(type){

                // recursive if object/array
                case '[object Array]':
                case '[object Object]':
                    val2 = print_r(val1, (tab + '\t'));
                    break;

                case '[object String]':
                    val2 = '\'' + val1 + '\'';
                    break;

                default:
                    val2 = val1;
            }
            str += tab + '\t' + prop + ' => ' + val2 + ',\n';
        }
    }

    // remove extra comma for last property
    str = str.substring(0, str.length-2) + '\n' + tab;

    return isArr ? (str + ']') : (str + '}');
};


