/**
 * JavaScript wrappers for Locations.
 */

// Declare a ss (street seen) name space if it doesn't exist
var ss = ss || {};

/**
 * Location class
 * @param {int}   id
 * @param {float} latitude
 * @param {float} longitude
 * @param {int}   heading
 * @param {int}   pitch
 */
ss.Location = function (id, latitude, longitude, heading, pitch) {
  this.id = id;
  this.latitude = latitude;
  this.longitude = longitude;
  this.heading = heading;
  this.pitch = pitch;
}

/**
 * Updates a location.
 *
 * Used example here:
 * http://blog.project-sierra.de/archives/1788
 *
 * @param  {function} successHandler function to be called upon success.
 */
ss.Location.prototype.update= function(successHandler) {
  $.ajax({
    url:'/locations/' + this.id,
    // Expect JSON to be returned. This is also enforced on the server via mimetype.
    dataType: 'json',
    type: 'post',
    processData: false,
    contentType: "application/json",
    data: JSON.stringify({
      location: {
        id: this.id,
        latitude: this.latitude,
        longitude: this.longitude,
        heading: this.heading,
        pitch: this.pitch,
      }
    }),
    beforeSend: function(xhr) {
      xhr.setRequestHeader("X-Http-Method-Override", "PUT");
    },
    success: successHandler
    });
}

/**
 * Deletes a location
 *
 * Used example here:
 * http://humanwebdevelopment.com/rails-jquery-ajax-delete-and-put-methods/
 *
 * @param   {function} successHandler function to be called upon successful felete.
 */
ss.Location.prototype.delete = function(successHandler) {
  $.ajax({
    url: "/locations/" + this.id,
    type: "post",
    dataType: "json",
    data: {"_method":"delete"},
    type: 'POST',
    success: successHandler
  });
}
