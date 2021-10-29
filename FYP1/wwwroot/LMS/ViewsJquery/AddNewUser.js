$("#newuser").validate({
  rules: {
    name: "required",
    number: {
      required: true,
      digits: true,
      minlength: 10,
      maxlength: 11,
    },
    email: {
      required: true,
      email: true,
    },
    password: {
      required: true,
      minlength: 5,
    },
    nic: {
      required: true,
      number: true,
      minlength: 13,
      maxlength: 13,
    },
  },
  messages: {
    password: {
      required: "Please enter password",
      minlength: "Minimum 5 characters",
    },
    number: {
      required: "Please enter  Phone Number",
      minlength: "Please enter valid phone number",
      maxlength: "Please enter valid phone number",
    },
    email: {
      required: "Please enter email",
      email: "Please enter valid email",
    },
    nic: {
      required: "Please enter NIC number",
      minlength: "Please enter valid 13 NIC digits",
      maxlength: "Please enter valid 13 NIC digits",
    },
  },
  submitHandler: function (form) {
    var ProfileDTO = {
      Name: $("#txtName").val(),
      FatherName: $("#txtFatherName").val(),
      Number: $("#txtNumber").val(),
      RoleId: $("#dpdownRole").val(),
      ProgramId: $("#dpdownProgram").val(),
      Email: $("#txtEmail").val(),
      Password: $("#txtPassword").val(),
      Nic: $("#txtNic").val(),
      Gender: $("input[name=optionsRadios]:checked").val(),
      DateOfBirth: $("#timeDOB1").val(),
      Address: $("#txtAddress").val(),
      City: $("#txtCity").val(),
      Country: $("#txtCountry").val(),
      Image: $("#Image1").val(),
    };
    $.ajax({
      type: "Post",
      url: "/User/AddNewUser",
      data: ProfileDTO,
      success: function (resp) {
        console.log(resp)
      }
    });
  },
});

