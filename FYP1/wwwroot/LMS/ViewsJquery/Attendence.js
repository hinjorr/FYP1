$(document).ready(function () {
  var user_id = $("#GetUserName").html();
  GetAllClasses(user_id);
  GetSessions();
});

function GetAllClasses(id) {
  $.ajax({
    url: "/Classes/ViewClassesbyId?username=" + id,
    success: function (resp) {
      var html = `<option value="0">Select Class</option>`;
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
