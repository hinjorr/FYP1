$(document).ready(function () {
  CommonFunctions.GetPrograms("#dpPrograms");
  CommonFunctions.GetCoursesFullName(".dpCourse");
  CommonFunctions.GetCoursesFullName(".dpRequisete");
  $(".RowNumber").text(index);
});
var index = 1;
var totalCrHr = 0;
var ProgramSyllabusDTO = [];

$(document).on("click", ".btnadd", function () {
  $(".trClone:first").clone().appendTo("#tblsyllabus");
  index++;
  $(".trClone:last").find(".RowNumber").text(index);
});

$(document).on("click", ".btnremove", function () {
  if (index != 1) {
    $(this).closest(".trClone").remove();
    var txt = $(this).parents("tr").find("td:eq(4)").text();
    totalCrHr = totalCrHr - txt;
    $(".ToTalCrHr").val(totalCrHr);
    index--;
  }
});
$("#btnsubmit").click(function (e) {
  var ProgramId = $("#dpPrograms").val();
  if (ProgramId != 0) {
    var rows = $(".trClone");
    $.each(rows, function (index, item) {
      var dto = {};
      dto.ProgramId = ProgramId;
      dto.CourseId = $(this).find(".dpCourse").val();
      dto.RqdCourseId = $(this).find(".dpRequisete").val();
      dto.RequiredCrHr = $(this).find(".txtRqdCrhr").val();
      ProgramSyllabusDTO.push(dto);
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
          while (ProgramSyllabusDTO.length > 0) {
            ProgramSyllabusDTO.pop();
          }
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

$(document).on("change", ".Programs", function () {
  totalCrHr = 0;
  index = 1;
  var id = $(".Programs").val();
  $("#tblsyllabus tr:gt(1)").remove();
  $.ajax({
    url: "GetProgramSyllabus/" + id,
    success: function (resp) {
      if (resp != null) {
        $.each(resp, function (index, item) {
          if (index == 0) {
          } else {
            $(".btnadd").click();
          }
        });
        var rows = $(".trClone");
        $.each(rows, function (index, item) {
          $(this).find(".dpCourse").val(resp[index].courseId).trigger("change");
          $(this)
            .find(".dpRequisete")
            .val(resp[index].rqdCourseId)
            .trigger("change");
          $(this).find(".txtRqdCrhr").val(resp[index].requiredCrHr);
        });
      }
    },
  });
});
