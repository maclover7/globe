var assignmentCreateListener;
assignmentCreateListener = function() {
  $('.new-assignment-btn').click(function(e) {
    e.preventDefault();

    if (!$('.new-assignment-name').val()) {
      swal({ title: "Name field can't be blank", type: "warning" });
    } else {
      if (!$('.new-assignment-description').val()) {
        swal({ title: "Description field can't be blank", type: "warning" });
      } else {
        $('.new-assignment-btn').prop('disabled', true);
        sendAssignment();
      }
    }
  });

  $('.new-assignment-close').click(function() {
    clearInput();
  })
};

function sendAssignment() {
  $.ajax({
    type: "POST",
    url: (window.location.href + '/assignments'),
    data: $('#new-assignment-form').serialize(),
    dataType: 'json',
    success: function() {
      $('#newAssignment').modal('hide');
      hideButton();
      clearInput();
      $('.new-assignment-btn').prop('disabled', false);
      swal("Assignment added successfully.", "", "success");
      window.location.reload();
    },
    error: function(jqXHR, textStatus, errorThrown) { dispatchError(jqXHR.status) }
  })
}

$(document).ready(assignmentCreateListener);
$(document).on("page:load", assignmentCreateListener);

// CREATE HELPER FUNCTIONS

function hideButton() {
  var button = $("#new-assignment-toggler");
  button.hide();
}

function clearInput() {
  $('.new-assignment-name').val("");
  $('.new-assignment-description').val("");
  $('.new-assignment-duedate').val("");
}

// ERROR HANDLING

function dispatchError(status) {
  if (status == 409) {
    handleAlgorithmCode2();
  } else if (status == 412) {
    handleAlgorithmCode3();
  } else {
    handleOtherError();
  }
}

function handleAlgorithmCode2() {
  swal("Hello! This is an alert from the Robots here at Globe.", "We are just letting you know " +
        "that more than half of your students have at least **2** projects, quizzes, or tests " +
        "due on " + $('.new-assignment-duedate').val() + "." +
        " Please consider moving this assignment's due date if at all possible.", "warning");
  $('.new-assignment-btn').prop('disabled', false);
}

function handleAlgorithmCode3() {
  swal("Hello! This is an alert from the Robots here at Globe.", "We are just letting you know " +
        "that more than half of your students have at least **3** projects, quizzes, or tests " +
        "due on " + $('.new-assignment-duedate').val() + "." +
        " Please move this assignment's due date to a different day.", "error");
  $('.new-assignment-btn').prop('disabled', false);
}

function handleOtherError() {
  swal("Error, please try again.", "", "error");
  $('.new-assignment-btn').prop('disabled', false);
}
