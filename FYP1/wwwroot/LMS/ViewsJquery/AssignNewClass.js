$(document).ready(function () {
  CommonFunctions.GetPrograms(".dpPrograms");
  CommonFunctions.GetDays("#dpDownClassDay");
  CommonFunctions.GetTime("#dpDownClassTime");
});

$(".dpPrograms").change(function (e) {
  var id = $(".dpPrograms").val();
  CommonFunctions.GetCoursesbyPrograms(".DpDownCourse", id);
});
$(".DpDownCourse").change(function (e) {
  var id = $(".DpDownCourse").val();
  console.log(id)
});

// var ClassDTO = {
//   CourseId: $("#DpDownCourse").val(),
//   ClassStrength: $("#txtClasStrength").val(),
//   ClassDay: $("#dpDownClassDay").val(),
//   ClassTime: $("#dpDownClassTime").val(),
//   SemesterId:
// };
