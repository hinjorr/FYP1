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
  $(".trClone:first").clone().appendTo("#tblsyllabus");
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
  while (ProgramSyllabusDTO.length > 0) {
    ProgramSyllabusDTO.pop();
  }
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

$(document).on("change", ".Programs", function () {
  var id = $(".Programs").val();
  $("#tblsyllabus tr:gt(1)").remove();
  $.ajax({
    url: "GetProgramSyllabus/" + id,
    success: function (resp) {
      $.each(resp, function (index, item) {
        $(".btnadd").click();
        // $("#tblsyllabus tr").find("#dpCourse").val(31);
        // $("#tblsyllabus tr").find("#dpRequisete").val(32);
        $("#tblsyllabus tr:eq("+index+")").find("td:eq(3) input[type='text']").val(item.requiredCrHr);
        console.log(item.requiredCrHr)
      });
      // $("#tblsyllabus tr:eq(1)").remove();
    },
  });
});
