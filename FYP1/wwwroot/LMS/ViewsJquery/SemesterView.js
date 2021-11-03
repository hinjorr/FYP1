$("#newsemster").validate({
  rules: {
    Fullname: "required",
  },
  messages: {
    Fullname: {
      required: "Please enter Semester number",
    },
  },
  submitHandler: function (form) {
    var SemesterDTO = {
      SemesterName: $("#txtFullname").val(),
    };
    $.ajax({
      type: "Post",
      url: "/Semester/StartSemester",
      data: SemesterDTO,
      success: function (resp) {
        console.log(resp);
        // $('#newsemster').trigger("reset");
      },
    });
  },
});
$(document).ready(function () {
  var SemesterDTO = {
    SemesterId: 0,
    SemesterName: "",
    StartDate: "",
    EndDate: "",
    IsActive: "",
  };
  $.ajax({
    url: "/Semester/GetCurrentSemester",
    success: function (resp) {
      (SemesterDTO.SemesterId = resp.semesterId),
        (SemesterDTO.SemesterName = resp.semesterName),
        (SemesterDTO.StartDate = resp.startDate),
        (SemesterDTO.IsActive = resp.isActive);
    },
  });
  $("#btnend").click(function (e) {
    console.log(SemesterDTO);
    $.ajax({
      type: "Post",
      url: "/Semester/EndSemester",
      data: "SemesterDTO",
      success: function (resp) {
        console.log(resp);
      },
    });
  });
});
