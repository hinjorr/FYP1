$(document).ready(function () {
  CommonFunctions.GetAllActiveCourses("#GetActiveCourse");
  CommonFunctions.GetCurrentSemester();
  userName = $("#GetUserName").html();
  userRole = $("#GetUsersRole").html();
  if (userRole != "Student") {
    GetAllStudents();
  }
  else {
    RegisteredCourses(userName)
    DTO.Username = userName
    $("#txtStudent").remove();
    $("#admin_panel").remove();
  }
  DTO.SemesterId = CommonFunctions.SemesterDTO.SemesterId
  GetStudentInfo();
});
var userName;
var userRole;
function GetAllStudents() {
  var html = "<option value=0>Search Student</option>";
  $.ajax({
    url: "/General/GetStudents",
    success: function (resp) {
      $(resp).each(function (indexInArray, item) {
        html +=
          "<option value=" +
          item.user.userName +
          ">" +
          item.user.userName +
          " " +
          item.profile.name +
          "</option>";
      });
      $("#txtStudent").html(html);
    },
  });
}

function ShowStudent(id, name, img) {
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
      <img alt="Pic" src="` +
    img +
    `" />
  </span>
</div>
</a>`;
  $("#StudentInfo").html(html);
}

function GetStudentInfo() {
  $("#txtStudent")
    .select2()
    .on("change", function (e) {
      var id = $("#txtStudent").val();
      DTO.Username = id;
      if (id != 0) {
        $.ajax({
          url: "/GetProfile?username=" + id,
          success: function (resp) {
            ShowStudent(id, resp.profile.name, resp.profile.picture);
            $("#StudentInfo").show();
          },
        });
        RegisteredCourses(DTO.Username);
      } else {
        $("#StudentInfo").hide();
      }
    });
}

$("#GetActiveCourse").on("change", function (e) {
  var id = $("#GetActiveCourse").val();
  if (id != 0) {
    $("#ShowRegisteredCourses").show();
    $("#ShowClasses").show();
    $.ajax({
      url: "/RegisterCourses/GetClassesByCourse?id=" + id,
      success: function (resp) {
        var html = "";
        $(resp).each(function (indexInArray, item) {
          html +=
            `<div class="frb frb-primary">
          <input type="radio" id="` +
            item.classes.classId +
            `" name="radio-button" value="` +
            item.classes.classId +
            `">
          <label for="` +
            item.classes.classId +
            `">
              <span class="frb-title">` +
            item.day.dayName +
            ` ` +
            item.time.timeName +
            `</span>
              <span class="frb-description">` +
            item.course.fullName +
            `</span>
              <span class="frb-description">ClassID: ` +
            item.classes.classId +
            ` -- CrHr: ` +
            item.course.crHr +
            `</span>
          </label>
      </div>`;
        });
        $("#ShowClasses").html(html);
      },
    });
  } else {
    DTO.ClassId = undefined;
    $("#ShowClasses").hide();
    $("#ShowRegisteredCourses").hide();
  }
});

var DTO = {};

$("#btnAdd").click(function (e) {
  DTO.ClassId = $("input[name=radio-button]:checked").val();
  if (DTO.Username != 0 && DTO.ClassId != undefined) {
    $.ajax({
      type: "Post",
      url: "/RegisterCourses/ResgisterStudent",
      data: DTO,
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
          });
        RegisteredCourses(DTO.Username);
      },
    });
  }
});

function RegisteredCourses(username) {
  $.ajax({
    url: "/RegisterCourses/GetRegisteredCourses?username=" + username,
    type: "GET",
    success: function (resp) {
      var html = "";
      $(resp).each(function (indexInArray, item) {
        html +=
          `<div class="frb frb-primary">
        <input type="radio" id="12` +
          item.studentCourseRegistration.classId +
          `" name="radio-button12" value="` +
          item.studentCourseRegistration.classId +
          `">
        <label for="12` +
          item.studentCourseRegistration.classId +
          `">
            <span class="frb-title">` +
          item.day.dayName +
          ` ` +
          item.time.timeName +
          `</span>
            <span class="frb-description">` +
          item.course.fullName +
          `</span>
            <span class="frb-description">ClassID: ` +
          item.studentCourseRegistration.classId +
          ` -- CrHr: ` +
          item.course.crHr +
          `</span>
        </label>
    </div>`;
      });
      $("#ShowRegisteredCourses").html(html);
    },
  });
}
var model = {};

$("#btnDrop").click(function (e) {
  model.ClassId = $("input[name=radio-button12]:checked").val();
  // debugger
  if (userRole == "Student") {
    model.Username = userName
  }
  else {
    model.Username = $("#txtStudent").val();

  }
  if (model.ClassId != undefined && model.Username != 0) {
    $.ajax({
      url: "/RegisterCourses/DropCourse",
      data: model,
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
          });
        $("#ShowRegisteredCourses").show();
        RegisteredCourses(model.Username);
      },
    });
  }
});
