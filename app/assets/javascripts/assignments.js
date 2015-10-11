$(document).ready(function() {
  $('.new-assignment-btn').click(function(e) {
    e.preventDefault();

    if (!$('.new-assignment-name').val()) {
      alert("Name field can't be blank");
    } else {
      if (!$('.new-assignment-description').val()) {
        alert("Description field can't be blank");
      } else {
        $('.new-assignment-btn').prop('disabled', true);
        sendAssignment();
      }
    }
  });

  $('.new-assignment-close').click(function() {
    clearInput();
  })
});

function hideButton() {
  var button = $("#new-assignment-toggler");
  button.hide();
}

function clearInput() {
  $('.new-assignment-name').val("");
  $('.new-assignment-description').val("");
  $('.new-assignment-duedate').val("");
}

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
      alert("Assignment added successfully.");
      window.location.reload();
    },
    error: function(jqXHR, textStatus, errorThrown) { dispatchError(jqXHR.status) }
  })
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
  alert("Hello! This is an alert from the Robots here at Globe. We are just letting you know " +
        "that more than half of your students have at least **2** projects, quizzes, or tests " +
        "due on " + $('.new-assignment-duedate').val() + "." +
        " Please consider moving this assignment's due date if at all possible.");
  $('.new-assignment-btn').prop('disabled', false);
}

function handleAlgorithmCode3() {
  alert("Hello! This is an alert from the Robots here at Globe. We are just letting you know " +
        "that more than half of your students have at least **3** projects, quizzes, or tests " +
        "due on " + $('.new-assignment-duedate').val() + "." +
        " Please move this assignment's due date to a different day.");
  $('.new-assignment-btn').prop('disabled', false);
}

function handleOtherError() {
  alert("Error, please try again.");
  $('.new-assignment-btn').prop('disabled', false);
}
