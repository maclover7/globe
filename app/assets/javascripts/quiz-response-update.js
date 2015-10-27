var studentAssignmentUpdateListener;
studentAssignmentUpdateListener = function() {
  $('.update-student-assignment-btn').click(function(e) {
    e.preventDefault();

    if (!$('.update-student-assignment-response').val()) {
      swal({ title: "Response field can't be blank", type: "warning" });
    } else {
      sendStudentAssignment({bot: false});
    }
  });
};

function sendStudentAssignment(data) {
  $.ajax({
    type: "POST",
    url: (window.location.href + '/response'),
    data: $('#update-student-assignment-form').serialize(),
    dataType: 'json',
    success: function() {
      if (data.bot != true) {
        swal("Response saved successfully.", "", "success");
      }
      updateLastSaved();
    },
    error: function() {
      if (data.bot != true) {
        swal("Oops...", "Something went wrong!", "error");
      } else {
        swal("Oops...", "While trying to autosave your work, something went wrong.", "error");
      }
    }
  })
}

function updateLastSaved(){
  lastSavedContainer = $("#response-last-saved");
  date = jQuery.timeago(new Date());
  lastSavedContainer.text(date);
}

$(document).ready(studentAssignmentUpdateListener);
$(document).on("page:load", studentAssignmentUpdateListener);
