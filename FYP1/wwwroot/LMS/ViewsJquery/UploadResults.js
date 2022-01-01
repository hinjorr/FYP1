$(document).ready(function () {
  var user_id = $("#GetUserName").html();
  GetAllClasses(user_id);
});

function GetAllClasses(id) {
  $.ajax({
    url: "/Classes/ViewClassesbyId?username=" + id,
    success: function (resp) {
      var html = "";
      $(resp).each(function (indexInArray, item) {
        html +=
          `<option value="` +
          item.classes.classId +
          `">` +
          item.classes.classId +
          ` ` +
          item.course.fullName +
          `</option>`;
      });
      $("#dpDownClasses").append(html);
    },
  });
}

$("#dpDownClasses").change(function (e) {
  var classid = $("#dpDownClasses").val();
  if (classid != 0 && classid != undefined) {
    console.log(classid);
    $("#GetStudents").DataTable().clear().destroy();
    GetUsers(classid);
  } else {
    $("#GetStudents").DataTable().clear().destroy();
  }
});

function GetUsers(classid) {
  $("#GetStudents").DataTable({
    ajax: {
      url: "/Classes/ViewStudentbyClass?cid=" + classid,
      type: "Get",
      datatype: "json",
    },
    columns: [
      {
        data: "profile.picture",
        render: function (picture) {
          return (
            '<div class="symbol symbol-50 flex-shrink-0">' +
            '<img src="' +
            picture +
            '">' +
            "</div>"
          );
        },
      },
      { data: "user.userName" },
      { data: "profile.name" },
      {
        data: "user.userName",
        render: function (id) {
          return '<input type="text" class="form-control" id="totalmarks" name="totalMarks">';
        },
      },
      {
        data: "user.userName",
        render: function (id) {
          return (
            '<input type="text" class="form-control" id="' +
            id +
            '" name="obtainedmarks">'
          );
        },
      },
    ],
  });
}

// $.validator.addMethod("greaterThan",
//     function (value, element, param) {
//         var $otherElement = $(param);
//         return parseInt(value, 10) >= parseInt($otherElement.val(), 10);
//     });
// $("#Upload").validate({
//     rules: {
//         totalMarks: {
//             required: true,
//             digits: true,
//         },
//         obtainedmarks: {
//             required: true,
//             digits: true,
//             greaterThan: "#txtTotalMarks",
//         },

//     },
//     messages: {
//         totalMarks: {
//             required: "Please enter Total Marks",
//             digits: "Please enter Digits",
//         },
//         obtainedmarks: {
//             required: "Please enter Obtained Marks",
//             digits: "Please enter Digits",
//             greaterThan: 'Must be greater than or equal to Total Marks',
//         },
//     },
//     submitHandler: function (form) {

//         var UploadRes = {
//                 TotalMarks : $("#txtTotalMarks").val,
//                 ObtainedMarks : $("#txtObtainedMarks").val,
//         };
//         console.log(UploadRes);

//     }

// })
