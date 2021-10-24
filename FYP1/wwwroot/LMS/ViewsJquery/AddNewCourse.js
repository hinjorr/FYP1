$(document).ready(function () {
  $("#btnCreate").click(function () {
    var CourseDTO = {
      CourseName: $("#txtFullname").val(),
      CourseCrHr: $("#txtCoursecrhr").val(),
      RequiredCrHr: $("#txtRequired").val(),
      CourseShortName: $("#txtShrtname").val(),
    };
    if (CourseDTO.CourseName==null) {
        $("#lblFullname")
    }
    
  });
});
