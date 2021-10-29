jQuery('#addnewcourse').validate({
    rules: {
        coursefullname: "required",
        shortname: "required",
        crhr: "required"
    }, messages: {
        coursefullname: "Please enter course name",
        shortname: "Please enter short name",
        crhr: "Please enter credit hours"
    }

})

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
