$(document).ready(function () {
  $("#btnCreate").click(function () {
    var CourseDTO = {
      CourseName: $("#txtFullname").val(),
      CourseCrHr: $("#txtCoursecrhr").val(),
      RequiredCrHr: $("#txtRequired").val(),
      CourseShortName: $("#txtShrtname").val(),
    };
   console.log(CourseDTO)
    
  });
});
