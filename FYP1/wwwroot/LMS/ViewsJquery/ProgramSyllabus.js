$(document).ready(function () {
  CommonFunctions.GetPrograms("#dpPrograms");
  CommonFunctions.GetCoursesFullName(".dpCourse");
  CommonFunctions.GetCoursesFullName(".dpRequisete");
  $(".dpCourse").select2();
  $(".dpRequisete").select2();
});

$(".dpCourse").change(function (e) {
  var CourseDTO = {
    CourseId: $(".dpCourse").val(),
  };
  GetCrHr(CourseDTO);
});

$("#tblsyllabus").on("click", ".btnadd", function () {
  $(".trClone:eq(0)").clone().appendTo("#tblsyllabus");
});

$("#btnsubmit").click(function (e) {});
function PassArray() {
  var tableData = document.getElementById("tblsyllabus");
  var numberOfRows = tableData.rows.length;
  for (var i = 1; i < numberOfRows; i += 1) {
    var row = tableData.rows[i];
    if (row.cells[3].innerText == "modified") {
      //Rows which have modified status
      console.log(row);
    }
  }
}

$(document).on("click", ".btnremove", function () {
  $(this).closest(".trClone").remove();
});

function GetCrHr(CourseDTO) {
  $.ajax({
    type: "Post",
    url: "/ProgramSyllabus/GetCrHr",
    data: CourseDTO,
    success: function (resp) {
      $("#CrHr").text(resp);
    },
  });
}
