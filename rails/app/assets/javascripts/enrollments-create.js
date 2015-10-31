var enrollmentCreateListener;
enrollmentCreateListener = function() {
  $('.new-enrollment-btn').click(function(e) {
    e.preventDefault();

    if (!$('.new-enrollment-code').val()) {
      swal({ title: "Course code field can't be blank", type: "warning" });
    } else {
      $('.new-enrollment-btn').prop('disabled', true);
      sendEnrollment();
    }
  });

  $('.new-enrollment-close').click(function() {
    clearInput();
  })
};

function sendEnrollment() {
  $.ajax({
    type: "POST",
    url: '/enrollments',
    data: $('#new-enrollment-form').serialize(),
    dataType: 'json',
    success: function() {
      $('#newEnrollment').modal('hide');
      hideButton();
      clearInput();
      $('.new-enrollment-btn').prop('disabled', false);
      swal("Course added successfully.", "", "success");
      window.location.reload();
    },
    error: function() {
      swal("Error, please try again.", "It is possible that you may already be registered for this course.", "error");
      $('.new-enrollment-btn').prop('disabled', false);
    }
  })
}

$(document).ready(enrollmentCreateListener);
$(document).on("page:load", enrollmentCreateListener);

// CREATE HELPER FUNCTIONS

function hideButton() {
  var button = $("#new-enrollment-toggler");
  button.hide();
}

function clearInput() {
  $('.new-enrollment-code').val("");
}
