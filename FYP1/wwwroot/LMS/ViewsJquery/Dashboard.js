$(document).ready(function () {
  CommonFunctions.GetCurrentSemester().done(function (resp) {
    $("#SemesterName").text(resp.semesterName);
  });
});

