$(document).ready(function () {
  CommonFunctions.GetPrograms("#dpPrograms");
  CommonFunctions.GetDays("#dpDownClassDay");
  CommonFunctions.GetTime("#dpDownClassTime");
  // $("#DpDownCourse").select2();
  GetAllClasses();
  var semester = JSON.parse(localStorage.getItem("SemesterDetails"));
  ClassDTO.SemesterId = semester.semesterName;
});

$("#dpPrograms").change(function (e) {
  var id = $("#dpPrograms").val();
  CommonFunctions.GetCoursesbyPrograms("#DpDownCourse", id);
});

var ClassDTO = {
  ClassStrength: 0,
  CourseId: 0,
  SemesterId: 0,
  ProgramId: 0,
  DayId: 0,
  TimeId: 0,
  ClassId: 0,
};

$("#btnSubmit").click(function (e) {
  if (ClassDTO.ClassId != 0) {
    ClassDTO.ClassStrength = $("#txtClasStrength").val();
    CreateClass(ClassDTO);
  } else {
    ClassDTO.ProgramId = $("#dpPrograms").val();
    ClassDTO.CourseId = $("#DpDownCourse").val();
    ClassDTO.ClassStrength = $("#txtClasStrength").val();
    ClassDTO.DayId = $("#dpDownClassDay").val();
    ClassDTO.TimeId = $("#dpDownClassTime").val();
    CreateClass(ClassDTO);
  }
});

function CreateClass(ClassDTO) {
  $.ajax({
    type: "Post",
    url: "/Classes/AssignNewClass",
    data: ClassDTO,
    success: function (resp) {
      swal
        .fire({
          text: resp.text,
          icon: resp.icon,
          buttonsStyling: false,
          confirmButtonText: "Ok, got it!",
          customClass: {
            confirmButton: "btn font-weight-bold btn-light-primary",
          },
        })
        .then(function () {
          KTUtil.scrollTop();
          if (resp.icon != "error") {
            $("#classes").trigger("reset");
            $("#ViewClasses").DataTable().clear().destroy();
            GetAllClasses();
          }
        });
    },
  });
}

function GetAllClasses() {
  $("#ViewClasses").DataTable({
    ajax: {
      url: "/Classes/ViewAllClassesinJson",
      type: "Get",
      datatype: "json",
    },
    columns: [
      { data: "classes.classId" },
      { data: "course.fullName" },
      { data: "program.programShortName" },
      { data: "day.dayName" },
      { data: "time.timeName" },
      { data: "classes.classStrength" },
      { data: "classes.enrolledStd" },
      {
        data: "classes.faculty_Assigned",
        render: function (data) {
          if (data != 0) {
            return '<a  class="label label-lg font-weight-bold label-light-success label-inline">Yes</a>';
          } else {
            return '<a class="label label-lg font-weight-bold label-light-danger label-inline">No</a>';
          }
        },
      },
      {
        data: "classes.classId",
        render: function (id) {
          return (
            '<button class="btn btn-sm btn-clean btn-icon"  title="Edit details" onclick="btnupdate(this)"><i class="la la-edit"></i><button class="btn btn-sm btn-clean btn-icon" title="Delete" onclick="btndelete(' +
            id +
            ')"><i class="la la-trash"></i></button>'
          );
        },
      },
    ],
  });
}

function btnupdate(obj) {
  $("#dpPrograms")
    .html(
      "<option >" + $(obj).closest("tr").find("td:eq(2)").html() + "</option>"
    )
    .attr("disabled", true);
  $("#DpDownCourse")
    .html(
      "<option >" + $(obj).closest("tr").find("td:eq(1)").html() + "</option>"
    )
    .attr("disabled", true);
  $("#dpDownClassDay")
    .html(
      "<option >" + $(obj).closest("tr").find("td:eq(3)").html() + "</option>"
    )
    .attr("disabled", true);
  $("#dpDownClassTime")
    .html(
      "<option >" + $(obj).closest("tr").find("td:eq(4)").html() + "</option>"
    )
    .attr("disabled", true);
  $("#txtClasStrength").val($(obj).closest("tr").find("td:eq(5)").html());
  ClassDTO.ClassId = $(obj).closest("tr").find("td:eq(0)").html();
  KTUtil.scrollTop();
}

function btndelete(id) {
  $.ajax({
    url: "/DeleteClass/" + id,
    success: function (resp) {
      cuteToast({
        type: resp.type,
        message: resp.msg,
        timer: 3000,
      });
      $("#ViewClasses").DataTable().clear().destroy();
      GetAllClasses();
    },
  });
}
