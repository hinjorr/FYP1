$(document).ready(function () {
  CommonFunctions.GetCurrentSemester();
  CheckSemester();
});

function CheckSemester() {
  var semester = JSON.parse(localStorage.getItem("SemesterDetails"));
  if (semester != undefined) {
    $("#SemesterName").text(semester.semesterName);
  } else {
    $("#SemesterName").text("No Semester is Running");
  }
}

function Logout() {
  localStorage.clear();
}
