$(document).ready(function () {
  ProgamDetails();
});
$("#btnCreate").click(function () {
  var ProgramDTO = {
    ProgramFullName: $("#txtFullName").val(),
    ProgramShortName: $("#txtShortName").val(),
    IsActive: 1,
  };
  $.ajax({
    type: "Post",
    url: "/Programs/AddNewProgram",
    data: ProgramDTO,
    success: function (resp) {
      cuteToast({
        type: resp.type,
        message: resp.msg,
        timer: 3000,
      });
      $("#ProgramTable").DataTable().clear().destroy();
      ProgamDetails();
    },
  });
});
function ProgamDetails() {
  $("#ProgramTable").DataTable({
    ajax: {
      url: "/Programs/GetPrograms",
      type: "Get",
      datatype: "json",
    },
    columns: [
      { data: "programId" },
      { data: "programShortName" },
      { data: "enrolled_Courses" },
      { data: "enrolled_Classes" },
      { data: "enrolled_Students" },
    ],
  });
}

// function clicked(obj) {
//   var userid = $(obj).closest("tr").find("td:first").html();
//   console.log(userid);
// }

// $("#dpPrograms").change(function (e) {
//   var id = $("#dpPrograms").val();
//   CommonFunctions.GetCoursesbyPrograms("#DpDownCourse", id);
// });

// $("#dpProgramsView").change(function (e) {
//   var id = $("#dpProgramsView").val();
//   CommonFunctions.GetCoursesbyPrograms("#DpDownCourseView", id);
// });
