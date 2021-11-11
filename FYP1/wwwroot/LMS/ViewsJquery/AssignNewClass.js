$(document).ready(function () {
  CommonFunctions.GetPrograms("#dpPrograms");
  CommonFunctions.GetPrograms("#dpProgramsView");
  CommonFunctions.GetDays("#dpDownClassDay");
  CommonFunctions.GetTime("#dpDownClassTime");
  CommonFunctions.GetCurrentSemester().success(function (resp) {
    $("#txtSemesterName").val(resp.semesterName);
    ClassDTO.SemesterId = resp.semesterId;
  });
});

$("#dpPrograms").change(function (e) {
  var id = $("#dpPrograms").val();
  CommonFunctions.GetCoursesbyPrograms("#DpDownCourse", id);
});

$("#dpProgramsView").change(function (e) {
  var id = $("#dpProgramsView").val();
  CommonFunctions.GetCoursesbyPrograms("#DpDownCourseView", id);
});

var ClassDTO = {
  CourseId: 0,
  ClassStrength: 0,
  ClassDay: 0,
  ClassTime: 0,
  SemesterId: 0,
  ProgramId:0
};

$("#btnSubmit").click(function (e) {
  ClassDTO.ProgramId = $("#dpPrograms").val();
  ClassDTO.CourseId = $("#DpDownCourse").val();
  ClassDTO.ClassStrength = $("#txtClasStrength").val();
  ClassDTO.ClassDay = $("#dpDownClassDay").val();
  ClassDTO.ClassTime = $("#dpDownClassTime").val();
  CreateClass(ClassDTO);
});

function CreateClass(ClassDTO) {
  $.ajax({
    type: "Post",
    url: "/AssignClass",
    data: ClassDTO,
    success: function (resp) {
      console.log(resp);
    },
  });
}
