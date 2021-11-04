$("#addnewcourse").validate({
  rules: {
    fullname: "required",
    shortname: "required",
    courseCrHr: {
      digits: true,
      min: 1,
      max: 4,
    },
  },
  messages: {
    fullname: {
      required: "This field is required",
    },
    courseCrHr: {
      min: "Minimum 1 CrHr",
      max: "Maximum 4 CrHr",
    },
  },
  submitHandler: function (form) {
    var CourseDTO = {
      FullName: $("#txtfullName").val(),
      ShortName: $("#txtshortName").val(),
      CrHr: $("#txtcourseCrHr").val(),
    };
    AddNewCourse(CourseDTO);
    console.log(CourseDTO);
  },
});

function AddNewCourse(CourseDTO) {
  $.ajax({
    type: "Post",
    url: "/AdminCourses/AddNewCourse",
    data: CourseDTO,
    success: function (resp) {
      console.log(resp);
    },
  });
}
$(document).ready(function () {
  // alert("s");
});
