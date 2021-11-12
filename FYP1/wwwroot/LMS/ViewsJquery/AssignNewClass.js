////$(document).ready(function () {
////  $("#btnSubmit").click(function () {
    
////  });
////});
$("#assignnewclass").validate({
    rules: {
        selectcourse: {
            required: true,
        },
        program: {
            required: true,
        },
        classstrength: {
            required: true,
        },
        classday: {
            required: true,
        },
        classtime: {
            required: true,
        },
    },
    messages: {
        selectcourse: {
            required: "Please select Course",
        },
        program: {
            required: "Please select Program",
        },
        classstrength: {
            required: "Please select Class Strength",
        },
        classday: {
            required: "Please select Class Day",
        },
        classtime: {
            required: "Please select Class Time",
        },
    },
    submitHandler: function (form) {
        var Classnew = {
            SelecCourses: $("#DpDownCourse").val(),
            Depart: $("#dpDownDepart").val(),
            ClassStrength: $("#txtClasStrength").val(),
            ClassDay: $("#dpDownClassDay").val(),
            ClassDay: $("#dpDownClassTime").val(),
        };
        console.log(Classnew);


    },
});
$(document).ready(function () {
  // $("#btnView").click(function () {
  //     var ViewClass = {
  //         ViewCourses: $("#dpDownViewClasses").val(),
  //         VCDepart: $("#dpDownVCDepart").val(),

  //     };
  //     console.log(ViewClass)
  // });
  CommonFunctions.GetPrograms(".dpPrograms");
  CommonFunctions.GetCourse(".DpDownCourse");
  CommonFunctions.GetDays("#dpDownClassDay");
  CommonFunctions.GetTime("#dpDownClassTime");
});

