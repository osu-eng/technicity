/**
 * JavaScript wrappers for Locations.
 */

// Declare a ss (street seen) name space if it doesn't exist
var ss = ss || {};

/**
 * Region class
 */
ss.Study = function (id, name, description, question) {
  this.id = id;
  this.name = name;
  this.description = description;
  this.question = question;
}

/**
 * Updates a region.
 *
 * Used example here:
 * http://blog.project-sierra.de/archives/1788
 *
 * @param  {function} successHandler function to be called upon success.
 */
ss.Study.prototype.update = function(successHandler) {
  $.ajax({
    url:'/regions/' + this.id,
    // Expect JSON to be returned. This is also enforced on the server via mimetype.
    dataType: 'json',
    type: 'post',
    processData: false,
    contentType: "application/json",
    data: JSON.stringify({
      region: {
        id: this.id,
        name: this.name,
        description: this.description,
        question: this.question
      }
    }),
    beforeSend: function(xhr) {
      xhr.setRequestHeader("X-Http-Method-Override", "PUT");
    },
    success: successHandler
    });
}

/**
 * Updates a region.
 *
 * Used example here:
 * http://blog.project-sierra.de/archives/1788
 *
 * @param  {function} successHandler function to be called upon success.
 */
ss.Study.prototype.open = function(id, successHandler, errorHandler) {
  $.ajax({
    url:'/studies/' + id + '/open',
    // Expect JSON to be returned. This is also enforced on the server via mimetype.
    dataType: 'json',
    type: 'post',
    processData: false,
    contentType: "application/json",
    data: JSON.stringify({
      id: id,
      "_method":"open"
    }),
    beforeSend: function(xhr) {
      xhr.setRequestHeader("X-Http-Method-Override", "PUT");
    },
    success: successHandler,
    error: errorHandler
    });
}
ss.Study.prototype.close = function(id, successHandler, errorHandler) {
  $.ajax({
    url:'/studies/' + id + '/close',
    // Expect JSON to be returned. This is also enforced on the server via mimetype.
    dataType: 'json',
    type: 'post',
    processData: false,
    contentType: "application/json",
    data: JSON.stringify({
      id: id,
      "_method":"close"
    }),
    beforeSend: function(xhr) {
      xhr.setRequestHeader("X-Http-Method-Override", "PUT");
    },
    success: successHandler,
    error: errorHandler
    });
}

/**
 * Deletes a region
 *
 * Used example here:
 * http://humanwebdevelopment.com/rails-jquery-ajax-delete-and-put-methods/
 *
 * @param   {function} successHandler function to be called upon successful felete.
 */
ss.Study.prototype.delete = function(successHandler) {
  $.ajax({
    url: "/studies/" + this.id,
    type: "post",
    dataType: "json",
    data: {"_method":"delete"},
    type: 'POST',
    success: successHandler
  });
}
