$(document).ready(function () {
  CommonFunctions.GetPrograms("#dpPrograms");
  CommonFunctions.GetPrograms("#dpProgramsView");
  CommonFunctions.GetDays("#dpDownClassDay");
  CommonFunctions.GetTime("#dpDownClassTime");
  GetAllClasses();
  CommonFunctions.GetCurrentSemester().success(function (resp) {
    $("#txtSemesterName").val(resp.semesterName);
    ClassDTO.SemesterId = resp.semesterId;
  });
  $("#DpDownCourse").select2();
  $("#DpDownCourseView").select2();
});

var ClassDTO = {
  ClassStrength: 0,
  CourseId: 0,
  SemesterId: 0,
  ProgramId: 0,
  DayId: 0,
  TimeId: 0,
};

$("#btnSubmit").click(function (e) {
  ClassDTO.ProgramId = $("#dpPrograms").val();
  ClassDTO.CourseId = $("#DpDownCourse").val();
  ClassDTO.ClassStrength = $("#txtClasStrength").val();
  ClassDTO.DayId = $("#dpDownClassDay").val();
  ClassDTO.TimeId = $("#dpDownClassTime").val();
  CreateClass(ClassDTO);
});

function CreateClass(ClassDTO) {
  $.ajax({
    type: "Post",
    url: "/AdminClasses/AssignNewClass",
    data: ClassDTO,
    success: function (resp) {
      if (resp == true) {
        $("#ViewClasses").DataTable().clear().destroy();
        GetAllClasses();
        $("#classes").trigger("reset");
        cuteToast({
          type: "success",
          message: "Class Assigned!",
          timer: 3000,
        });
      } else {
        cuteToast({
          type: "error",
          message: "Class not Assigned!",
          timer: 3000,
        });
      }
    },
  });
}

function GetAllClasses() {
  $("#ViewClasses").DataTable({
    ajax: {
      url: "/AdminClasses/ViewAllClasses",
      type: "Get",
      datatype: "json",
    },
    columns: [
      { data: "classId" },
      { data: "course.shortName" },
      { data: "program.programShortName" },
      { data: "day.dayName" },
      { data: "time.timeName" },
      { data: "classStrength" },
      { data: "classStrength" },
      {
        render: function (data, row) {
          return '<button class="btn btn-primary btn-xs" onclick="clicked(this)"><i class="fa fa-pencil"></i></button><button class="btn btn-danger btn-xs"><i class="fa fa-trash-o "></i></button>';
        },
      },
    ],
  });
}

function clicked(obj) {
  var userid = $(obj).closest("tr").find("td:first").html();
  console.log(userid);
}

$("#dpPrograms").change(function (e) {
  var id = $("#dpPrograms").val();
  CommonFunctions.GetCoursesbyPrograms("#DpDownCourse", id);
});

$("#dpProgramsView").change(function (e) {
  var id = $("#dpProgramsView").val();
  CommonFunctions.GetCoursesbyPrograms("#DpDownCourseView", id);
});
