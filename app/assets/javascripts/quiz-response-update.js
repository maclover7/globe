var studentAssignmentUpdateListener;
studentAssignmentUpdateListener = function() {
  $('.update-student-assignment-btn').click(function(e) {
    e.preventDefault();

    if (!$('.update-student-assignment-response').val()) {
      swal({ title: "Response field can't be blank", type: "warning" });
    } else {
      sendStudentAssignment();
    }
  });
};

function sendStudentAssignment() {
  $.ajax({
    type: "POST",
    url: (window.location.href + '/response'),
    data: $('#update-student-assignment-form').serialize(),
    dataType: 'json',
    success: function() {
      swal("Response saved successfully.", "", "success");
    },
    error: function() {
      swal("Oops...", "Something went wrong!", "error");
    }
  })
}

$(document).ready(studentAssignmentUpdateListener);
$(document).on("page:load", studentAssignmentUpdateListener);
