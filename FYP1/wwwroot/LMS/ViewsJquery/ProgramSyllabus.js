
var data = [[],[],[]]
$(document).ready(function () {
  CommonFunctions.GetPrograms("#dpPrograms");
  CommonFunctions.GetCoursesFullName(".dpCourse");
    CommonFunctions.GetCoursesFullName(".dpRequisete");
    
});

$(".dpCourse").change(function (e) {
  var CourseDTO = {
    CourseId: $(".dpCourse").val(),
  };
  GetCrHr(CourseDTO);
});


$(".tblsyllabus").on("click", ".btnadd", function () {
  $(".trClone:last").clone().appendTo(".tblsyllabus");
   var ProgramSyllabusDTO = {
     ProgramId: $("#dpPrograms").val(),
     CourseId: $(this).closest("tr").find(".dpCourse").val(),
     RqdCourseId: $(this).closest("tr").find(".dpRequisete").val(),
     RequiredCrHr: $(this).closest("tr").find(".rqdCrHr").val(),
    };
    

    data.push([ProgramSyllabusDTO]);
    
    

    
});
$("#btnsubmit").click(function () {
    //$.each(data, function (set, results) {
    //    $.each(results, function (key, value) {
    //        console.log("Set" + set + "Key" + key + "Value" + value);

    //    })

    //})
    console.log(data)
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
