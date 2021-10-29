$(document).ready(function () {
  $("#btnSubmit").click(function () {
    var ProfileDTO = {
      Name: $("#txtName").val(),
      FatherName: $("#txtFatherName").val(),
      Number: $("#txtNumber").val(),
      Role: $("#dpdownRole").val(),
      Email: $("#txtEmail").val(),
      Password: $("#txtPassword").val(),
      Nic: $("#txtNic").val(),
      Gender: $("#rad1").val(),
      DateOfBirth: $("#timeDOB").val(),
      Address: $("#txtAddress").val(),
      City: $("#txtCity").val(),
      Country: $("#txtCountry").val(),
      Image: $("#Image").val(),
    };
    console.log(ProfileDTO)
    $.ajax({
      url: "/User/AddNewUser",
      method: "POST",
      data: ProfileDTO,
      success: function (resp) {
        console.log(resp);
      },
      error: function (resp) {
        console.console.log(resp);
      },
    });
  });
});
