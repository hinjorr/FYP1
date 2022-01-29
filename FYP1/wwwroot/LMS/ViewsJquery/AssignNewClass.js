$(document).ready(function () {
  CommonFunctions.GetPrograms("#dpPrograms");
  CommonFunctions.GetDays("#dpDownClassDay");
  CommonFunctions.GetTime("#dpDownClassTime");

  // $("#DpDownCourse").select2();
  GetAllClasses();
  CommonFunctions.GetCurrentSemester();
  ClassDTO.SemesterId = CommonFunctions.SemesterDTO.SemesterId;
});

$("#dpPrograms").change(function (e) {
  var id = $("#dpPrograms").val();
  CommonFunctions.GetCoursesbyPrograms("#DpDownCourse", id);
});

var ClassDTO = {};

$("#btnSubmit").click(function (e) {
  // debugger
  if (ClassDTO.SemesterId != 0) {
    if (ClassDTO.ClassId != undefined) {
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
  }
  else {
    swal
      .fire({
        text: "No Semester is running",
        icon: "error",
        buttonsStyling: false,
        confirmButtonText: "Ok, got it!",
        customClass: {
          confirmButton: "btn font-weight-bold btn-light-primary",
        },
      })
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
      {
        data: "course.fullName",
        render: function (data, type, row) {
          var id = row.classes.classId;
          return (
            '<a href="/Class/' + id + '" target="_blank">' + data + " </a>"
          );
        },
      },
      { data: "program.programShortName" },
      { data: "day.dayName" },
      { data: "time.timeName" },
      { data: "classes.classStrength" },
      {
        data: "classes.enrolledStd",
        render: function (data) {
          if (data != 0) {
            return "<span>" + data + "</span>";
          } else {
            return '<a class="label label-lg font-weight-bold label-light-danger label-inline">' + data + '</a>';
          }
        },
      },
      {
        data: "classes.faculty_Assigned",
        render: function (data) {
          if (data != 0) {
            return "<span>Yes</span>";
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
