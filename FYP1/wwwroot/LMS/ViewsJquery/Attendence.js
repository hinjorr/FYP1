$(document).ready(function () {
  var user_id = $("#GetUserName").html();
  CommonFunctions.GetAllClasses(user_id, "#dpDownClasses");
  GetSessions();
  $("#SubmitButton").hide();
});

function GetSessions() {
  $.ajax({
    url: "/Semester/GetAlllSessions",
    success: function (resp) {
      var html = `<option value="0">Select Week</option>`;
      $(resp).each(function (indexInArray, item) {
        html +=
          `<option value="` +
          item.sessionId +
          `">` +
          item.sessionName +
          `</option>`;
      });
      $("#dpdownSelectWeek").html(html);
    },
  });
}

dto = {};
$("#btnView").click(function (e) {
  dto.ClassId = $("#dpDownClasses").val();
  dto.SessionId = $("#dpdownSelectWeek").val();
  if (dto.ClassId != 0 && dto.SessionId != 0) {
    $.ajax({
      url: "/Attendence/GetAttendenceStudents",
      data: dto,
      success: function (resp) {
        var html = "";
        var data = resp[0];
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
        }
        $(resp).each(function (indexInArray, item) {
            html += `<tr>
          <td>`+item.user.userName+`</td>
          <td>`+item.profile.name+`</td>`
          if (item.attendence._1st==1) {
            html+= `<td><input type="radio" name="1st`+item.user.userName+`"  value="1 " checked></td>
                    <td><input type="radio" name="1st`+item.user.userName+`"  value="0"></td>`
          } else {
            html+=   `<td><input type="radio" name="1st`+item.user.userName+`"  value="1" ></td>
                      <td><input type="radio" name="1st`+item.user.userName+`"  value="0" checked></td>`
          }
         if (item.attendence._2nd==1) {
          html+=  `<td><input type="radio" name="2nd`+item.user.userName+`"  value="1" checked></td>
          <td><input type="radio" name="2nd`+item.user.userName+`"  value="0"></td>`
         }
         else{
          html+=   `<td><input type="radio" name="2nd`+item.user.userName+`"  value="1" ></td>
          <td><input type="radio" name="2nd`+item.user.userName+`"  value="0" checked></td>`
         }
         html+=`
         <td>`+item.totalSessions+`</td>
         <td>`+item.attendence.totalMarkedSesion+`</td>
         <td>`+item.attendence.totalPresent+`</td>
         <td>`+item.attendence.totalAbsent+`</td> 
          </tr>`;
       
              });
        $("#tblAttedence").html(html);
        $("#SubmitButton").show();
      },
    });
  }
});

var AttendenceDTO = [];
$("#btnSubmit").click(function (e) {
  $("#tblAttedence tr").each(function (indexInArray, tr) {
    var dto = {};
    var ClassId = $("#dpDownClasses").val();
    var SessionId = $("#dpdownSelectWeek").val();
    dto.ClassId = ClassId;
    dto.SessionId = SessionId;
    dto.UserName = $(this).find("td:eq(0)").text();
    dto._1st = $(this)
      .find("input[name=1st" + dto.UserName + "]:checked")
      .val();
    dto._2nd = $(this)
      .find("input[name=2nd" + dto.UserName + "]:checked")
      .val();
    AttendenceDTO.push(dto);
  });
  SendData(AttendenceDTO);
});

function SendData(AttendenceDTO) {
  $.ajax({
    type: "Post",
    url: "/Attendence/MarkAttendence",
    data: { dto: AttendenceDTO },
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
          window.location.replace("/MarkAttendence");
        });
    },
  });
}

 