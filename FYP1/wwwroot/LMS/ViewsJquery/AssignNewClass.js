$(document).ready(function () {
  CommonFunctions.GetPrograms(".dpPrograms");
  CommonFunctions.GetCourse(".DpDownCourse");
  CommonFunctions.GetDays("#dpDownClassDay");
  CommonFunctions.GetTime("#dpDownClassTime");

});

var ClassDTO = {
  CourseId: $("#DpDownCourse").val(),
  ClassStrength: $("#txtClasStrength").val(),
  ClassDay: $("#dpDownClassDay").val(),
  ClassTime: $("#dpDownClassTime").val(),
  SemesterId:
};
$(document).ready(function () {
  // $("#btnView").click(function () {
  //     var ViewClass = {
  //         ViewCourses: $("#dpDownViewClasses").val(),
  //         VCDepart: $("#dpDownVCDepart").val(),

  //     };
  //     console.log(ViewClass)
  // });
 
});
