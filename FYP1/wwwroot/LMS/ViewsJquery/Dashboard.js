$(document).ready(function () {
  CommonFunctions.GetCurrentSemester().success(function (resp) {
    $("#LogoSemester").text(resp.semesterName);
  });
});
