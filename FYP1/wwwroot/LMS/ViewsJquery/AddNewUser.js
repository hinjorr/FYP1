$(document).ready(function () {
  $("#roleinfo").hide();
  var Rolevariable = 0;

  CommonFunctions.GetPrograms("#dpdownProgram");
  CommonFunctions.GetRoles("#dpdownRole");
});

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
    var input = document.getElementById("profile_avatar");
    var file = input.files;
    var ProfileDTO = new FormData();
    ProfileDTO.append("ProfileImage", file[0]);
    ProfileDTO.append("Name", $("#txtName").val());
    ProfileDTO.append("FatherName", $("#txtFatherName").val());
    ProfileDTO.append("PhoneNumber", $("#txtNumber").val());
    ProfileDTO.append("Email", $("#txtEmail").val());
    ProfileDTO.append("Nic", $("#txtNic").val());
    ProfileDTO.append("Gender", $("input[name=gender]:checked").val());
    ProfileDTO.append("DoB", $("#timeDOB1").val());
    ProfileDTO.append("Address", $("#txtAddress").val());
    ProfileDTO.append("City", $("#txtCity").val());
    ProfileDTO.append("Country", $("#txtCountry").val());
    ProfileDTO.append("IsActive", 1);
    ProfileDTO.append("User.RoleId", $("#dpdownRole option:selected").val());
    ProfileDTO.append("User.IsActive", 1);
    ProfileDTO.append(
      "Student.ProgramId",
      $("#dpdownProgram option:selected").val()
    );
    ProfileDTO.append("Student.IsActive", 1);
    $.ajax({
      type: "Post",
      url: "/User/AddNewUser",
      data: ProfileDTO,
      dataType: "json",
      contentType: false,
      processData: false,
      success: function (resp) {
        cuteToast({
          type: resp.type,
          message: resp.msg,
          timer: 3000,
        });
        $("#newuser").trigger("reset");
      },
    });
  },
});

$("#dpdownRole").click(function (e) {
  RoleId = $("#dpdownRole option:selected").val();
  ProgramHide(RoleId);
});

//faculty and admin role condition
function ProgramHide(id) {
  if (id == 2 || id == 1) {
    $("#dpdownProgram").attr("disabled", true);
  } else {
    $("#dpdownProgram").attr("disabled", false);
  }
}

//Role dp chnge
$("#dpdownRole").change(function (e) {
  var ProfileDTO = {
    Nic: $("#txtNic").val(),
    User: {
      RoleId: $("#dpdownRole option:selected").val(),
    },
  };
  RoleCheck(ProfileDTO);
});

//Role Check
function RoleCheck(ProfileDTO) {
  $.ajax({
    type: "Post",
    url: "/User/RoleCheck",
    data: ProfileDTO,
    success: function (resp) {
      if (resp != null) {
        cuteToast({
          type: "warning",
          message: resp,
          timer: 3000,
        });
      }
    },
  });
}



//NIC check ajax
$("#txtNic").change(function (e) {
  var ProfileDTO = {
    Nic: $("#txtNic").val(),
    User: {
      IsActive: 1,
    },
    Student: {
      IsActive: 1,
    },
  };
  $.ajax({
    type: "Post",
    url: "/UserValidation/NICCheck",
    data: ProfileDTO,
    success: function (resp) {
      if (resp != null) {
        cuteToast({
          type: "info",
          message: "This NIC is already Registered!",
          timer: 3000,
        });
        $("#txtName").val(resp.name);
        $("#txtFatherName").val(resp.fatherName);
        $("#txtNumber").val(resp.phoneNumber);
        $("#txtEmail").val(resp.email);
        $("input[name=gender][value=" + resp.gender + "]").prop(
          "checked",
          true
        );
        $("#timeDOB1").val(resp.doB);
        $("#txtAddress").val(resp.address);
        $("#txtCity").val(resp.city);
        $("#txtCountry").val(resp.country);
        // $("#Image1").val();
        ProgramHide(resp.user.roleId);
      }
    },
  });
});
