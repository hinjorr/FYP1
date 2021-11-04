$(document).ready(function () {
  $("#btnSubmit").click(function () {
    var Classnew = {
      SelecCourses: $("#DpDownCourse").val(),
      Depart: $("#dpDownDepart").val(),
      ClassStrength: $("#txtClasStrength").val(),
      ClassDay: $("#dpDownClassDay").val(),
      ClassDay: $("#dpDownClassTime").val(),
    };
    console.log(Classnew);
  });
});
$(document).ready(function () {
  // $("#btnView").click(function () {
  //     var ViewClass = {
  //         ViewCourses: $("#dpDownViewClasses").val(),
  //         VCDepart: $("#dpDownVCDepart").val(),

  //     };
  //     console.log(ViewClass)
  // });
  CommonFunctions.GetPrograms(".dpPrograms");
  CommonFunctions.GetCourse(".DpDownCourse");
  CommonFunctions.GetDays("#dpDownClassDay");
  CommonFunctions.GetTime("#dpDownClassTime");
});
