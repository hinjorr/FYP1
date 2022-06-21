$(document).ready(function () {
  var route = window.location.href;
  ClassId = route.substring(route.lastIndexOf("/") + 1);
  GetClassInfo(ClassId);
  GetStudents(ClassId);

});

function GetClassInfo(id) {
  $.ajax({
    url: "/GetClass/" + id,
    success: function (resp) {
      if (resp.icon == null) {
        $("#program").text(resp.program.programShortName);
        $("#class_name").text(
          resp.classes.classId + " " + resp.course.fullName
        );
        $("#strength").text(resp.classes.classStrength);
        $("#enrooled_std").text(resp.classes.enrolledStd);
        $("#day_time").text(resp.day.dayName + " " + resp.time.timeName);
        if (resp.profile == null) {
          $("#faculty").html(
            '<a class="label label-lg font-weight-bold label-light-danger label-inline">Faculty not assigned</a>'
          );
        } else {
          ShowFacultyInfo(
            resp.user.userName,
            resp.profile.name,
            resp.profile.picture
          );
        }
      } else {
        swal.fire({
          text: resp.text,
          icon: resp.icon,
          buttonsStyling: false,
          confirmButtonText: "Ok, got it!",
          customClass: {
            confirmButton: "btn font-weight-bold btn-light-primary",
          },
        });
      }
    },
  });
}

function ShowFacultyInfo(id, name, img) {
  var html =
    `<a href=profile/` +
    id +
    ` target="_blank" > <div class="btn btn-light-success d-inline-flex align-items-center btn-lg mr-5">
    <div class="d-flex flex-column text-right pr-3">
        <span class="text-dark-75 font-weight-bold font-size-sm">` +
    id +
    `</span>
        <span class="font-weight-bolder font-size-sm">` +
    name +
    `</span>
    </div>
    <span class="symbol symbol-40">
        <img src="data:image/png;base64,` +
    img +
    `" />
    </span>
  </div>
  </a>`;
  $("#faculty").html(html);
}

function GetStudents(id) {
  $.ajax({
    url: "/Classes/ViewStudentbyClass?cid=" + id,
    success: function (resp) { },
  });
}

function GetStudents(classid) {
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
        $("#ViewStudents").DataTable({
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
                  '<img src="data:image/png;base64,' +
                  picture +
                  '">' +
                  "</div>"
                );
              },
            },
            { data: "user.userName" },
            { data: "profile.name" },

          ],
        });
        $("#btnSubmit").show();
      }
    },
  });
}
