var courseNotificationCreateListener;
courseNotificationCreateListener = function() {
  $('.new-course-notification-btn').click(function(e) {
    e.preventDefault();

    if (!$('.new-course-notification-subject').val()) {
      swal({ title: "Subject field can't be blank", type: "warning" });
    } else {
      if (!$('.new-course-notification-body').val()) {
        swal({ title: "Body field can't be blank", type: "warning" });
      } else {
        $('.new-course-notification-btn').prop('disabled', true);
        sendCourseNotification();
      }
    }
  });

  $('.new-course-notification-close').click(function() {
    clearInput();
  })
};

function sendCourseNotification() {
  $.ajax({
    type: "POST",
    url: (window.location.href + '/course_notifications'),
    data: $('#new-course-notification-form').serialize(),
    dataType: 'json',
    success: function() {
      $('#newCourseNotification').modal('hide');
      hideButton();
      clearInput();
      $('.new-course-notification-btn').prop('disabled', false);
      swal("Course Notification sent successfully.", "", "success");
      window.location.reload();
    },
     error: function() {
      swal("Error, please try again.", "", "error");
      $('.new-course-notification-btn').prop('disabled', false);
    }
  })
}

$(document).ready(courseNotificationCreateListener);
$(document).on("page:load", courseNotificationCreateListener);

// CREATE HELPER FUNCTIONS

function hideButton() {
  var button = $("#new-course-notification-toggler");
  button.hide();
}

function clearInput() {
  $('.new-course-notification-body').val("");
  $('.new-course-notification-subject').val("");
}
