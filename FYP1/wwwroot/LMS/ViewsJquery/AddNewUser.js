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
      PhoneNumber: $("#txtNumber").val(),
      Email: $("#txtEmail").val(),
      Nic: $("#txtNic").val(),
      Gender: $("input[name=gender]:checked").val(),
      DoB: $("#timeDOB1").val(),
      Address: $("#txtAddress").val(),
      City: $("#txtCity").val(),
      Country: $("#txtCountry").val(),
      Picture: $("#Image1").val(),
      IsActive: 1,
      User: {
        RoleId: $("#dpdownRole option:selected").val(),
        Password: $("#txtPassword").val(),
        IsActive: 1,
      },
      Student: {
        ProgramId: $("#dpdownProgram option:selected").val(),
        IsActive: 1,
      },
    };
    console.log(ProfileDTO);
    $.ajax({
      type: "Post",
      url: "/User/AddNewUser",
      data: ProfileDTO,
      success: function (resp) {
        console.log(resp);
      },
    });
  },
});

$(document).ready(function () {
  // //NIC ajax
  $("#txtNic").change(function (e) {
    var ProfileDTO = {
      Nic: $("#txtNic").val(),
    };
    $.ajax({
      url: "/UserValidation/NICCheck",
      data: ProfileDTO,
      success: function (resp) {
        console.log(resp);

        $("#txtName").val(resp.name);
        $("#txtFatherName").val(resp.fatherName);
        $("#txtNumber").val(resp.phoneNumber);
        $("#txtEmail").val(resp.email);
        // $("#txtNic").val();  
        // $("input[name=gender]:checked").val();
        $("#timeDOB1").val(resp.doB);
        $("#txtAddress").val(resp.address);
        $("#txtCity").val(resp.city);
        $("#txtCountry").val(resp.country);
        // $("#Image1").val();
        // $("#dpdownRole option:selected").val();
        $("#txtPassword").val();
        // $("#dpdownProgram option:selected").val();
      },
      error: function (resp) {
        console.log(resp);
      },
    });
  });
  //faculty role condition
  $("#dpdownRole").change(function (e) {
    if ($("#dpdownRole").val() == 2) {
      $("#lblprogram").hide();
      $("#dpdownProgram").hide();
    } else {
      $("#lblprogram").show();
      $("#dpdownProgram").show();
    }
  });

  //Roles List
  $.ajax({
    async: true,
    type: "Get",
    url: "/DropDown/GetRoles",
    success: function (resp) {
      var html = "";
      html += "<option value='0'>Select Role</option>";
      $(resp).each(function (index, item) {
        html +=
          "<option value=" + item.roleId + ">" + item.roleName + "</option>";
      });
      $("#dpdownRole").append(html);
    },
  });

  //Programs List
  $.ajax({
    async: true,
    type: "Get",
    url: "/DropDown/GetPrograms",
    success: function (resp) {
      var html = "";
      html += "<option value='0'>Select Program</option>";
      $(resp).each(function (indexInArray, items) {
        html +=
          "<option value=" +
          items.programId +
          ">" +
          items.programShortName +
          "</option>";
      });
      $("#dpdownProgram").append(html);
    },
  });
});
