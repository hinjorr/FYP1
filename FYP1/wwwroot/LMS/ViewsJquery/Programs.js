$(document).ready(function () {
  $("#btnCreate").click(function () {
    var ProgramDTO = {
      ProgramFullName: $("#txtFullName").val(),
      ProgramShortName: $("#txtShortName").val(),
      IsActive: 1,
    };
    $.ajax({
      type: "Post",
      url: "/Programs/AddNewProgram",
      data: ProgramDTO,
      success: function (resp) {
        console.log(resp);
      },
      error: function (resp) {
        console.log(resp);
      },
    });
  });
});
