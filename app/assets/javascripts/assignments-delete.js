var assignmentDeleteListener;
assignmentDeleteListener = function() {
  $("#delete-assignment").on("click", function(event) {
    swal({
      title: "Are you sure?",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes!",
      closeOnConfirm: false },
      function(){ deleteAssignment(); }
    );
  });
}

function deleteAssignment() {
  assignment_id = $("#delete-assignment").data("assignment-id");
  url = window.location.href + '/assignments/' + assignment_id;
  $.ajax({
    type: "DELETE",
    url: url,
    success: function() {
      swal("Deleted!", "", "success");
      window.location.reload();
    },
    error: function() {
      swal("Oops...", "Something went wrong!", "error");
    }
  })
}

$(document).ready(assignmentDeleteListener);
$(document).on("page:load", assignmentDeleteListener);
