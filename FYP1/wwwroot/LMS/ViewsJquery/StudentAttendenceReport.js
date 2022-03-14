$(document).ready(function () {
  GetAttendence();
});

function GetAttendence() {
  $.ajax({
    url: "/Attendence/StudentAttendenceReport",
    success: function (resp) {
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
      } else {
        var html = "";
        $(resp).each(function (indexInArray, item) {
          html += `<tr>
            <td>`+ item.course.courseId + ` </td>
            <td>`+ item.course.fullName + ` </td>
            <td>`+ item.profile.name + ` </td>
            <td>`+ item.attendence.totalMarkedSesion + ` </td>
            <td>`+ item.attendence.totalPresent + ` </td>
            <td>`+ item.attendence.totalAbsent + ` </td>
            </tr>`;
        });
        $("#tblAttendence").html(html);
      }
    },
  });
}
