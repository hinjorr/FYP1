$(document).ready(function () {
  TotalUsers();
  TotalUsers();
  ToTalStudents();
  ToTalFaculty();
  ToTalAdmins();
  ToTalPrograms();
  ToTalCourses();
  ToTalActiveClasses();
  // swal
  //   .fire({
  //     text: "Login Succesfull!",
  //     icon: "success",
  //     buttonsStyling: false,
  //     confirmButtonText: "Ok, got it!",
  //     customClass: {
  //       confirmButton: "btn font-weight-bold btn-light-primary",
  //     },
  //   })
  //   .then(function () {
  //     KTUtil.scrollTop();
  //   });
});

function TotalUsers() {
  $.ajax({
    url: "/General/TotalUsers",
    success: function (resp) {
      $("#TotalUsers").text(resp);
    },
  });
}

function ToTalStudents() {
  $.ajax({
    url: "/General/ToTalStudents",
    success: function (resp) {
      $("#ToTalStudents").text(resp);
    },
  });
}
function ToTalFaculty() {
  $.ajax({
    url: "/General/ToTalFaculty",
    success: function (resp) {
      $("#ToTalFaculty").text(resp);
    },
  });
}
function ToTalAdmins() {
  $.ajax({
    url: "/General/ToTalAdmins",
    success: function (resp) {
      $("#ToTalAdmins").text(resp);
    },
  });
}
function ToTalPrograms() {
  $.ajax({
    url: "/General/ToTalPrograms",
    success: function (resp) {
      $("#ToTalPrograms").text(resp);
    },
  });
}
function ToTalCourses() {
  $.ajax({
    url: "/General/ToTalCourses",
    success: function (resp) {
      $("#ToTalCourses").text(resp);
    },
  });
}
function ToTalActiveClasses() {
  $.ajax({
    url: "/General/ToTalActiveClasses",
    success: function (resp) {
      $("#ToTalActiveClasses").text(resp);
    },
  });
}
