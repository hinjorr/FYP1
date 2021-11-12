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

$(".tblsyllabus").on("click", ".btnadd", function () {
  $(".trClone:last").clone().appendTo(".tblsyllabus");
  // var ProgramSyllabusDTO = {
  //   ProgramId: $("#dpPrograms").val(),
  //   CourseId: $(this).closest("tr").find(".dpCourse").val(),
  //   RqdCourseId: $(this).closest("tr").find(".dpRequisete").val(),
  //   RequiredCrHr: $(this).closest("tr").find(".rqdCrHr").val(),
  // };
  // console.log(ProgramSyllabusDTO);

  var currentRow = $(this).closest("tr");
  var col1 = currentRow.find(".dpCourse").val(); // get current row 1st TD value
  var col2 = currentRow.find(".dpRequisete").val(); // get current row 2nd TD
  var col3 = currentRow.find(".rqdCrHr").val(); // get current row 3rd TD
  var data = col1 + "\n" + col2 + "\n" + col3;

  alert(data);
});

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

// var data = [[], [], []];
// $(document).ready(function () {
//   CommonFunctions.GetPrograms("#dpPrograms");
//   CommonFunctions.GetCoursesFullName(".dpCourse");
//   CommonFunctions.GetCoursesFullName(".dpRequisete");
// });

// $(".dpCourse").change(function (e) {
//   var CourseDTO = {
//     CourseId: $(".dpCourse").val(),
//   };
//   GetCrHr(CourseDTO);
// });

// $(".tblsyllabus").on("click", ".btnadd", function () {
//   $(".trClone:last").clone().appendTo(".tblsyllabus");
//   var ProgramSyllabusDTO = {
//     ProgramId: $("#dpPrograms").val(),
//     CourseId: $(this).closest("tr").find(".dpCourse").val(),
//     RqdCourseId: $(this).closest("tr").find(".dpRequisete").val(),
//     RequiredCrHr: $(this).closest("tr").find(".rqdCrHr").val(),
//   };

//   data.push([ProgramSyllabusDTO]);
// });
// $("#btnsubmit").click(function () {
//   //$.each(data, function (set, results) {
//   //    $.each(results, function (key, value) {
//   //        console.log("Set" + set + "Key" + key + "Value" + value);

//   //    })

//   //})
//   console.log(data);
//   $.ajax({
//     type: "Post",
//     url: "/AddNewSyllabus",
//     data: data,
//     success: function (response) {
//       console.log(response)
//     }
//   });
// });

// $(document).on("click", ".btnremove", function () {
//   $(this).closest(".trClone").remove();
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

