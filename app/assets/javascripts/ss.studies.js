/**
 * JavaScript wrappers for Locations.
 */

// Declare a ss (street seen) name space if it doesn't exist
var ss = ss || {};

ss.Study = function () {
}
/**
 * Opens a study
 *
 * Used example here:
 * http://blog.project-sierra.de/archives/1788
 *
 * @param  {function} successHandler function to be called upon success.
 */
ss.Study.prototype.open = function(id, successHandler) {
  $.ajax({
    url:'/studies/' + id + '/open',
    // Expect JSON to be returned. This is also enforced on the server via mimetype.
    dataType: 'json',
    type: 'post',
    processData: false,
    contentType: "application/json",
    data: JSON.stringify({
      study: {
        id: id,
      }
    }),
    beforeSend: function(xhr) {
      xhr.setRequestHeader("X-Http-Method-Override", "PUT");
    },
    success: successHandler
    });
}

/**
 * Opens a study
 *
 * Used example here:
 * http://blog.project-sierra.de/archives/1788
 *
 * @param  {function} successHandler function to be called upon success.
 */
ss.Study.prototype.close = function(id, successHandler) {
  $.ajax({
    url:'/studies/' + id + '/close',
    // Expect JSON to be returned. This is also enforced on the server via mimetype.
    dataType: 'json',
    type: 'post',
    processData: false,
    contentType: "application/json",
    data: JSON.stringify({
      study: {
        id: id,
      }
    }),
    beforeSend: function(xhr) {
      xhr.setRequestHeader("X-Http-Method-Override", "PUT");
    },
    success: successHandler
    });
}

