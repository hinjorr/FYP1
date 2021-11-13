$(document).ready(function () {
  GetCourses();
});

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
      CourseId: CID,
    };
    AddNewCourse(CourseDTO);
  },
});
var CID = 0;
function AddNewCourse(CourseDTO) {
  $.ajax({
    type: "Post",
    url: "/AdminCourses/AddNewCourse",
    data: CourseDTO,
    success: function (resp) {
      if (resp == true) {
        $("#ViewCourses").DataTable().clear().destroy();
        GetCourses();
        $("#addnewcourse").trigger("reset");
        cuteToast({
          type: "success",
          message: "Class Assigned!",
          timer: 3000,
        });
      } else {
        cuteToast({
          type: "error",
          message: "Failed",
          timer: 3000,
        });
      }
    },
  });
}

function GetCourses() {
  $("#ViewCourses").DataTable({
    ajax: {
      url: "/AdminCourses/GetCourses",
      type: "Get",
      datatype: "json",
    },
    columns: [
      { data: "courseId" },
      { data: "fullName" },
      { data: "isActive" },
      { data: "isActive" },
      { data: "crHr" },
      {
        render: function (data, row) {
          return '<button class="btn btn-primary btn-xs" onclick="FillForm(this)"><i class="fa fa-pencil"></i></button><button class="btn btn-danger btn-xs"><i class="fa fa-trash-o "></i></button>';
        },
      },
    ],
  });
}

function FillForm(obj) {
  var id = $(obj).closest("tr").find("td:first").html();
  $.ajax({
    url: "/AdminCourses/GetCoursebyID?id=" + id,
    success: function (resp) {
      $("#txtfullName").val(resp.fullName);
      $("#txtshortName").val(resp.shortName);
      $("#txtcourseCrHr").val(resp.crHr);
      CID = id;
    },
  });
}
