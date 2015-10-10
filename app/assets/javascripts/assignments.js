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
}

function sendAssignment() {
  $.ajax({
    type: "POST",
    url: (window.location.href + '/assignments'),
    data: $('#new-assignment-form').serialize(),
    dataType: 'json',
    success: function() {
      console.log('success');
      $('#newAssignment').modal('hide');
      hideButton();
      clearInput();
      $('.new-assignment-btn').prop('disabled', false);
      alert("Assignment added successfully.");
      window.location.reload();
    },
    error: function() {
      alert("Error, please try again.");
      $('.new-assignment-btn').prop('disabled', false);
    }
  })
}
