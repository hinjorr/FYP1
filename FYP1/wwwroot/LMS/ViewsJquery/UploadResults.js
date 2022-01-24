$(document).ready(function () {
  var user_id = $("#GetUserName").html();
  CommonFunctions.GetAllClasses(user_id, "#dpDownClasses");
  $("#btnSubmit").hide();

});

var MarksDTO = [];

$("#dpDownClasses").change(function (e) {
  var classid = $("#dpDownClasses").val();
  if (classid != 0 && classid != undefined) {
    $("#GetStudents").DataTable().clear().destroy();
    GetUsers(classid);
  } else {
    $("#GetStudents").DataTable().clear().destroy();
  }
});

function GetUsers(classid) {
  $.ajax({
    url: "/Classes/ViewStudentbyClass?cid=" + classid,
    success: function (resp) {
      var data = resp.data[0];
      if (data.icon != null) {
        swal
          .fire({
            text: data.text,
            icon: data.icon,
            buttonsStyling: false,
            confirmButtonText: "Ok, got it!",
            customClass: {
              confirmButton: "btn font-weight-bold btn-light-primary",
            },
          })
          .then(function () {
            KTUtil.scrollTop();
          });
      } else {
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
                return (
                  '<input type="text" class="form-control" id="' +
                  id +
                  '" name="obtainedmarks" style="width: 50px;" > '
                );
              },
            },
          ],
        });
        $("#btnSubmit").show();
      }
    },
  });
}

$("#btnSubmit").click(function (e) {
  var ClassId = $("#dpDownClasses").val();
  var AssementName = $("#dpDownAssements").val();
  var TotalMarks = $("#totalMarks").val();
  if (ClassId != 0 && AssementName != "") {
    if (TotalMarks != "") {
      $("#GetStudents tr").each(function (indexInArray, tr) {
        var dto = {};
        if (indexInArray != 0) {
          dto.ClassId = ClassId;
          dto.AssementName = AssementName;
          dto.TotalMarks = TotalMarks;
          dto.UserName = $(this).find("td:eq(1) ").text();
          dto.ObtainedMakrs = $(this).find("td:eq(3) input[type='text']").val();
          MarksDTO.push(dto);
        }
      });
      SendData(MarksDTO);
    }
  }
});

function SendData(MarksDTO) {
  $.ajax({
    type: "Post",
    url: "/Marks/UploadMarks",
    data: { dto: MarksDTO },
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
          while (MarksDTO > 0) {
            MarksDTO.pop()
          }
        });
    },
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
