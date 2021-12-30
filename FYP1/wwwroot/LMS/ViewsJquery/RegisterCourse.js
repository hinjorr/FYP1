$(document).ready(function () {
  GetFaculty();
  GetStudent();
  $("#txtFaculty")
    .select2()
    .on("change", function (e) {
      $("#CrHrSummary").hide();
    });

  $("#txtStudent")
    .select2()
    .on("change", function (e) {
      $("#CrHrSummary").show();
    });
});

function GetFaculty() {
  var html = "";
  $.ajax({
    url: "/General/Getfaculty",
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
      $("#txtFaculty").html(html);
    },
  });
}
function GetStudent() {
  var html = "";
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
