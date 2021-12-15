$(document).ready(function () {
  CommonFunctions.GetPrograms("#dpPrograms");
  CommonFunctions.GetCoursesFullName(".dpCourse");
  CommonFunctions.GetCoursesFullName(".dpRequisete");
  $(".RowNumber").text(index); // $(".dpCourse").select2();
  // $(".dpRequisete").select2();
});
var index = 1;

var ProgramSyllabusDTO = [];
$("#tblsyllabus").on("click", ".btnadd", function () {
  console.log("before ", index);
  index++;
  console.log("after ", index);
  $(this).closest(".RowNumber").text(index);
  $(".trClone").clone().appendTo("#tblsyllabus");
});

$(document).on("click", ".btnremove", function () {
  $(this).closest(".trClone").remove();
});
$("#btnsubmit").click(function (e) {
  var ProgramId = $("#dpPrograms").val();
  if (ProgramId != 0) {
    $("#tblsyllabus tr").each(function (indexInArray, tr) {
      var dto = {};
      if (indexInArray != 0) {
        dto.ProgramId = ProgramId;
        dto.CourseId = $(this).find("td:eq(1) option:selected").val();
        dto.RqdCourseId = $(this).find("td:eq(2) option:selected").val();
        dto.RequiredCrHr = $(this).find("td:eq(3) input[type='text']").val();
        ProgramSyllabusDTO.push(dto);
      }
    });
    SendData();
  } else {
    cuteToast({
      type: "warning",
      message: "Please Select Program",
      timer: 3000,
    });
  }
});

function SendData() {
  console.log(ProgramSyllabusDTO);
  // $.ajax({
  //   type: "Post",
  //   url: "/ProgramSyllabus/AddNewSyllabus",
  //   data: { dto: ProgramSyllabusDTO },
  //   success: function (response) {
  //     console.log("Response ", response);
  //   },
  // });
}

// $(".dpCourse").change(function (e) {
//   var CourseDTO = {
//     CourseId: $(".dpCourse").val(),
//   };
//   GetCrHr(CourseDTO);
// });

// function GetCrHr(CourseDTO) {
//   $.ajax({
//     type: "Post",
//     url: "/ProgramSyllabus/GetCrHr",
//     data: CourseDTO,
//     success: function (resp) {
//       $("#CrHr").text(resp);
//     },
//   });
// }
