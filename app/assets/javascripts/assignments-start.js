var assignmentStartListener;
assignmentStartListener = function() {
  $("#start-assignment").on("click", function(event) {
    swal({
      title: "Are you sure?",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes!",
      closeOnConfirm: false },
      function(){ startAssignment(); }
    );
  });
}

function startAssignment() {
  assignment_id = $("#start-assignment").data("assignment-id");
  url = window.location.href + '/start';
  $.ajax({
    type: "POST",
    url: url,
    success: function() {
      swal("Success!", "", "success");
      window.location.reload();
    },
    error: function() {
      swal("Oops...", "Something went wrong!", "error");
    }
  })
}

$(document).ready(assignmentStartListener);
$(document).on("page:load", assignmentStartListener);
