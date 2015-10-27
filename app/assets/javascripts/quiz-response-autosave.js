var studentAssignmentAutosaver;
studentAssignmentAutosaver = function() {
  setInterval(function(){
    if ($('.update-student-assignment-response').val()) {
      sendStudentAssignment({bot: true});
    }
  },10000); // 10 seconds
}

$(document).ready(studentAssignmentAutosaver);
$(document).on("page:load", studentAssignmentAutosaver);
