$(document).ready(function () {
  CommonFunctions.GetAllActiveCourses("#GetActiveCourse");
  GetAllStudents();
  GetStudentInfo();
});

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
      if (id != 0) {
        $.ajax({
          url: "/GetProfile?username=" + id,
          success: function (resp) {
            ShowStudent(id, resp.profile.name, resp.profile.picture);
            $("#StudentInfo").show();
          },
        });
      } else {
        $("#StudentInfo").hide();
      }
    });
}

$("#GetActiveCourse").on("change", function (e) {
  var id = $("#GetActiveCourse").val();
  if (id != 0) {
    $.ajax({
      url: "/Classes/GetClassesByCourse?id=" + id,
      success: function (resp) {
        var html = "";
        $(resp).each(function (indexInArray, item) {
          html += `<div class="frb frb-primary">
          <input type="radio" id="`+item.classes.classId+`" name="radio-button" value="`+item.classes.classId+`">
          <label for="`+item.classes.classId+`">
              <span class="frb-title">`+item.day.dayName+` `+item.time.timeName+`</span>
              <span class="frb-description">`+item.course.fullName+`</span>
              <span class="frb-description">ClassID: `+item.classes.classId+` -- CrHr: `+item.course.crHr+`</span>
          </label>
      </div>`;
        });
        $("#ShowClasses").html(html);
      },
    });
  }
});
