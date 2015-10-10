$(document).ready(function() {
  $('.new-enrollment-btn').click(function(e) {
    e.preventDefault();

    if (!$('.new-enrollment-code').val()) {
      alert("Course code field can't be blank");
    } else {
      $('.new-enrollment-btn').prop('disabled', true);
      sendEnrollment();
    }
  });

  $('.new-enrollment-close').click(function() {
    clearInput();
  })
});

function hideButton() {
  var button = $("#new-enrollment-toggler");
  button.hide();
}

function clearInput() {
  $('.new-enrollment-code').val("");
}

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
      alert("Course added successfully.");
      window.location.reload();
    },
    error: function() {
      alert("Error, please try again. It is possible that you may already be registered for this course.");
      $('.new-enrollment-btn').prop('disabled', false);
    }
  })
}
