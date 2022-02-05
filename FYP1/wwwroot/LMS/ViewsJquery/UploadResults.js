$(document).ready(function () {
  CommonFunctions.GetAllClasses("#dpDownClasses");
  $("#btnSubmit").hide();

});

var MarksDTO = [];

function AssesmentsList(classId) {
  $.ajax({
    url: "/Marks/GetAssesmentsList?classId=" + classId,
    success: function (resp) {
      var html = ` <option value="0">Select Assesment</option>`
      $(resp).each(function (indexInArray, item) {
        html += "<option value=" + item.assesmentId + ">" + item.assesmentName + "</option>"
      });
      $("#dpDownAssements").html(html);
    }
  });
}

$("#dpDownClasses").change(function (e) {
  var classid = $("#dpDownClasses").val();
  if (classid != 0) {
    AssesmentsList(classid)
  }
  else {
    $("#GetStudents").DataTable().clear().destroy();
  }
});

$("#dpDownAssements").change(function (e) {
  var assesmentId = $("#dpDownAssements").val();
  var classid = $("#dpDownClasses").val();
  if (assesmentId != 0 && classid != 0) {
    $("#GetStudents").DataTable().clear().destroy();
    GetUsers(classid, assesmentId);
  }
  else {
    $("#GetStudents").DataTable().clear().destroy();
  }

});

function GetUsers(classId, assesmentId) {
  dto = {
    ClassId: classId,
    AssesmentId: assesmentId
  }
  $.ajax({
    url: "/Marks/GetTestResults",
    data: dto,
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
            url: "/Marks/GetTestResults",
            data: dto,
            type: "Get",
            datatype: "json",
          },
          columns: [
            {
              data: "profile.picture",
              render: function (picture) {
                return (
                  `<div class="symbol symbol-50 flex-shrink-0"><img src="` + picture + `" > </div>`
                );
              },
            },
            {
              data: "user.userName",
              render: function (data, type, row) {
                return `<div>` + data + `<label style="display:none" class="need">` + row.user.userId + `</label></div>`
              }
            },
            {
              data: "profile.name"
            },
            {
              data: "marks.obtainedMakrs",
              render: function (marks) {
                if (marks != null) {
                  return (
                    '<input type="text" class="form-control" value="' + marks + '"  style="width: 50px;" > '
                  );
                }
                else {
                  return (
                    '<input type="text" class="form-control" value=0 style="width: 50px;" > '
                  );
                }
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
  var AssesmentId = $("#dpDownAssements").val();
  var TotalMarks = $("#totalMarks").val();
  if (ClassId != 0 && AssesmentId != 0) {
    if (TotalMarks != "") {
      $("#GetStudents tr").each(function (indexInArray, tr) {
        var dto = {};
        if (indexInArray != 0) {
          dto.ClassId = ClassId;
          dto.AssesmentId = AssesmentId;
          dto.TotalMarks = TotalMarks;
          dto.UserId = $(this).find(".need").text();
          dto.ObtainedMakrs = $(this).find("td:eq(3) input[type='text']").val();
          MarksDTO.push(dto);
        }
      });
      SendData(MarksDTO);
    }
  }
});

function SendData() {
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
          while (MarksDTO.length > 0) {
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
