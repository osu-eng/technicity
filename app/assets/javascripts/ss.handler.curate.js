/**
 * An Object Oriented page handler for the curate process.
 */



// Declare a ss (street seen) name space if it doesn't exist
var ss = ss || {};
ss.handler = ss.handler || {};

ss.handler.Curate = function(editModalId, panoramaMapId, panoramaId, deleteModalId, locationIdPrefix) {

  // Ids for various modals and map elements.
  ss.handler.Curate.editModalId = editModalId;
  ss.handler.Curate.panoramaMapId = panoramaMapId;
  ss.handler.Curate.panoramaId = panoramaId;
  ss.handler.Curate.deleteModalId = deleteModalId;
  ss.handler.Curate.locationIdPrefix = locationIdPrefix;

  // We track the working location with this static variable
  // ss.handler.Curate.workingLocation = null;
}

/**
 * Works with a modal popup named #edit_street_view.
 * @param  {[type]} id      [description]
 * @param  {[type]} lat     [description]
 * @param  {[type]} lng     [description]
 * @param  {[type]} heading [description]
 * @param  {[type]} pitch   [description]
 * @return {[type]}         [description]
 */
ss.handler.Curate.prototype.editLocation = function(id, latitude, longitude, heading, pitch) {

  // Enable modal
  $('#' + ss.handler.Curate.editModalId).modal();

  // Set the working location to be this location.
  ss.handler.Curate.workingLocation = new ss.Location(id, latitude, longitude, heading, pitch);

  // Create a panorama and google map (required for panorama?)
  var position = new google.maps.LatLng(latitude,longitude);
  var panoramaOptions = {
    position: position,
    pov: {
      heading: heading,
      pitch: pitch,
    },

    addressControl: false,
    linksControl: false,
    disableDoubleClickZoom: true,
    zoomControl: false,
    navigationControl: false,
    enableCloseButton: false
  };
  var mapOptions = {
    center: position,
    zoom: 14,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  var map = new google.maps.Map(document.getElementById(ss.handler.Curate.panoramaMapId), mapOptions);
  var panorama = new google.maps.StreetViewPanorama(document.getElementById(ss.handler.Curate.panoramaId), panoramaOptions);
  map.setStreetView(panorama);

  // Add some handlers for position and pov
  $('#' + ss.handler.Curate.editModalId).on('shown', function () {
    google.maps.event.trigger(panorama, 'resize');
    google.maps.event.addListener(panorama, 'position_changed', function() {
      ss.handler.Curate.workingLocation.latitude = panorama.getPosition().lat();
      ss.handler.Curate.workingLocation.longitude = panorama.getPosition().lng();
    });

    google.maps.event.addListener(panorama, 'pov_changed', function() {
      ss.handler.Curate.workingLocation.heading = panorama.getPov().heading;
      ss.handler.Curate.workingLocation.pitch = panorama.getPov().pitch;
    });
  });
}

/**
 * Shows the confirm delete dialog.
 */
ss.handler.Curate.prototype.deleteLocation = function() {
  $('#' + ss.handler.Curate.editModalId).modal('toggle');
  $('#' + ss.handler.Curate.deleteModalId).modal('toggle');
}

/**
 * Actually deletes the location.
 */
ss.handler.Curate.prototype.deleteLocationConfirm = function() {
  $('#' + ss.handler.Curate.deleteModalId).modal('toggle');
  ss.handler.Curate.workingLocation.delete(function (location, status, xhr) {
    // delete the image
    $('#' + ss.handler.Curate.locationIdPrefix + location.id).remove();
  });
}

/**
 * Cancels deletion and returns to the edit modal.
 */
ss.handler.Curate.prototype.deleteLocationCancel = function() {
  $('#' + ss.handler.Curate.deleteModalId).modal('toggle');
  $('#' + ss.handler.Curate.editModalId).modal('toggle');
}

ss.handler.Curate.prototype.updateLocation = function() {
  ss.handler.Curate.workingLocation.update(function(location, status, xhr) {
    if (status == "success") {
      // update the onclick
      $('#' + ss.handler.Curate.locationIdPrefix + location.id).click(function(){
        page.editLocation(location.id, location.latitude, location.longitude, location.heading, location.pitch);
      });
      // update the image
      $('#' + ss.handler.Curate.locationIdPrefix + location.id).html(
        '<img class="img-polaroid" src="http://maps.googleapis.com/maps/api/streetview?size=200x150'
        + '&location=' + location.latitude + ',%20' + location.longitude
        + '&heading=' + location.heading + '&pitch=' + location.pitch + '&sensor=false" />'
        );
      $('#' + ss.handler.Curate.editModalId).modal('toggle');
    }
  });

}



