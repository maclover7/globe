var courseDeleteListener;
courseDeleteListener = function() {
  $("#delete-course").on("click", function(event) {
    swal({
      title: "Are you sure?",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes!",
      closeOnConfirm: false },
      function(){ deleteCourse(); }
    );
  });
}

function deleteCourse() {
  course_id = $("#delete-course").data("course-id");
  url = window.location.href + '/' + course_id;
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

$(document).ready(courseDeleteListener);
$(document).on("page:load", courseDeleteListener);
