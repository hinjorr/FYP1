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
    (CourseDTO.FullName = $("#txtfullName").val()),
      (CourseDTO.ShortName = $("#txtshortName").val()),
      (CourseDTO.CrHr = $("#txtcourseCrHr").val()),
      AddNewCourse(CourseDTO);
    $("#addnewcourse").trigger("reset");
  },
});

var CourseDTO = {
  FullName: "",
  ShortName: "",
  CrHr: 0,
  CourseId: 0,
};

function AddNewCourse(CourseDTO) {
  $.ajax({
    type: "Post",
    url: "/AdminCourses/AddNewCourse",
    data: CourseDTO,
    success: function (resp) {
      $("#ViewCourses").DataTable().clear().destroy();
      GetCourses();
      $("#addnewcourse").trigger("reset");
      cuteToast({
        type: resp.type,
        message: resp.msg,
        timer: 3000,
      });
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
      { data: "total_Classes" },
      { data: "crHr" },
      {
        data: "courseId",
        render: function (data) {
          return (
            '<button class="btn btn-sm btn-clean btn-icon" title="Edit details" onclick="FillForm(this)"><i class="la la-edit"></i></button><button class="btn btn-sm btn-clean btn-icon" title="Delete" onClick="btnDelete(' +
            data +
            ')"><i class="la la-trash"></i></button>'
          );
        },
      },
    ],
  });
}

function FillForm(obj) {
  var id = $(obj).closest("tr").find("td:eq(0)").html();
  $.ajax({
    url: "/AdminCourses/GetCoursebyID?id=" + id,
    success: function (resp) {
      $("#txtfullName").val(resp.fullName);
      $("#txtshortName").val(resp.shortName);
      $("#txtcourseCrHr").val(resp.crHr);
      CourseDTO.CourseId = resp.courseId;
      KTUtil.scrollTop();
    },
  });
}

function btnDelete(data) {
  $.ajax({
    url: "/AdminCourses/DeleteCourse?id=" + data,
    success: function (resp) {
      cuteToast({
        type: resp.type,
        message: resp.msg,
        timer: 3000,
      });
      $("#ViewCourses").DataTable().clear().destroy();
      GetCourses();
    },
  });
}
