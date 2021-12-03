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
      console.log(resp);
    },
    error: function (resp) {
      console.log(resp);
    },
  });
});
function ProgamDetails() {
  $("#ProgramTable").DataTable({
    ajax: {
      url: "/AdminClasses/ViewAllClasses",
      type: "Get",
      datatype: "json",
    },
    columns: [
      { data: "classId" },
      { data: "course.shortName" },
      { data: "course.shortName" },
      { data: "program.programShortName" },
      {
        render: function (data, row) {
          return '<button class="btn btn-sm btn-clean btn-icon" title="Edit details" onclick="clicked(this)"><i class="la la-edit"></i></button>';
        },
      },
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
