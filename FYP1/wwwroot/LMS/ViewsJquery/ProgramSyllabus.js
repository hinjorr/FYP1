$(document).ready(function () {
  CommonFunctions.GetPrograms("#dpPrograms");
  CommonFunctions.GetCoursesFullName(".dpCourse");
  CommonFunctions.GetCoursesFullName(".dpRequisete");
  $(".RowNumber").text(index);
  // Select();
});
var index = 1;
var totalCrHr = 0;
var ProgramSyllabusDTO = [];

$(document).on("click", ".btnadd", function () {
  $(this).closest(".trClone").clone().appendTo("#tblsyllabus");
  // Select();
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
  $.ajax({
    type: "Post",
    url: "/ProgramSyllabus/AddNewSyllabus",
    data: { dto: ProgramSyllabusDTO },
    success: function (resp) {
      cuteToast({
        type: resp.type,
        message: resp.msg,
        timer: 3000,
      });
    },
  });
}

function GetCrHr(obj) {
  var data = $(obj).closest(".dpCourse").val();
  var CourseDTO = {
    CourseId: data,
  };
  $.ajax({
    type: "Post",
    url: "/ProgramSyllabus/GetCrHr",
    data: CourseDTO,
    success: function (resp) {
      $(obj).closest("tr").find("td:eq(4)").html(resp);
      totalCrHr += resp;
      $(".ToTalCrHr").val(totalCrHr);
    },
  });
}

function GetIndex(obj) {
  $(obj)
    .closest("tr")
    .find("td:eq(0)")
    .text(++index);
}

// function Select() {
//   $(".dpCourse").select2();
//   $(".dpRequisete").select2();
// }

// $(".Programs").change(function (e) {
//   var id = $(".Programs").val();
//   $.ajax({
//     url: "GetProgramSyllabus/" + id,
//     success: function (resp) {
//       if (resp != null) {
//         var table = $("#tblsyllabus");
//         var html = "";
//         html += "<option value='0'>Select Course</option>";
//         $(resp).each(function (index, item) {
//           table.find("tr").each(function (indexInArray, valueOfElement) {
//             html += "<option value=1>Masod</option>";
//             $(this).find(".dpCourse").html(html);
//             //$(this).find("td:eq(1)").val(item.courseId);
//             // $(this).find("td:eq(2)").val(item.rqdCourseId);
//             // $(this).find("td:eq(3) input[type='text']").val(item.requiredCrHr);
//           });
//         });
//       }
//     },
//   });
// });
