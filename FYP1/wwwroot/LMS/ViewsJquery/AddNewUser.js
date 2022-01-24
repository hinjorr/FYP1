$(document).ready(function () {
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
    var GeneralDTO = new FormData();
    GeneralDTO.append("Profile.ProfileImage", file[0]);
    GeneralDTO.append("Profile.Name", $("#txtName").val());
    GeneralDTO.append("Profile.FatherName", $("#txtFatherName").val());
    GeneralDTO.append("Profile.PhoneNumber", $("#txtNumber").val());
    GeneralDTO.append("Profile.Email", $("#txtEmail").val());
    GeneralDTO.append("Profile.Nic", $("#txtNic").val());
    GeneralDTO.append("Profile.Gender", $("input[name=gender]:checked").val());
    GeneralDTO.append("Profile.DoB", $("#timeDOB1").val());
    GeneralDTO.append("Profile.Address", $("#txtAddress").val());
    GeneralDTO.append("Profile.City", $("#txtCity").val());
    GeneralDTO.append("Profile.Country", $("#txtCountry").val());
    GeneralDTO.append("Role.RoleId", $("#dpdownRole option:selected").val());
    GeneralDTO.append("User.IsActive", 1);
    GeneralDTO.append("Student.ProgramId", $("#dpdownProgram option:selected").val());
    $.ajax({
      type: "Post",
      url: "/User/AddNewUser",
      data: GeneralDTO,
      dataType: "json",
      contentType: false,
      processData: false,
      success: function (resp) {
        swal
          .fire({
            text: resp.text,
            icon: resp.icon,
            buttonsStyling: false,
            confirmButtonText: "Ok, got it!",
            customClass: {
              confirmButton: "btn font-weight-bold btn-light-primary",
            },
          })
          .then(function () {
            KTUtil.scrollTop();
          });
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
  if (id == 3) {
    $("#dpdownProgram").attr("disabled", false);
  } else {
    $("#dpdownProgram").attr("disabled", true);
  }
}

//Role dp chnge
$("#dpdownRole").change(function (e) {
  var GeneralDTO = {
    "Profile.Nic": $("#txtNic").val(),
    "Role": {
      "RoleId": $("#dpdownRole option:selected").val(),
    },
  };
  RoleCheck(GeneralDTO);
});

//Role Check
function RoleCheck(GeneralDTO) {
  $.ajax({
    type: "Post",
    url: "/User/RoleCheck",
    data: GeneralDTO,
    success: function (resp) {
      if (resp.text != null) {
        swal
          .fire({
            text: resp.text,
            icon: resp.icon,
            buttonsStyling: false,
            confirmButtonText: "Ok, got it!",
            customClass: {
              confirmButton: "btn font-weight-bold btn-light-primary",
            },
          })
          .then(function () {
            KTUtil.scrollTop();
          });
      }

    },
  });
}

//NIC check ajax
$("#txtNic").change(function (e) {
  var GeneralDTO = {
    Profile: {
      Nic: $("#txtNic").val(),
    }
  };
  $.ajax({
    type: "Post",
    url: "/UserValidation/NICCheck",
    data: GeneralDTO,
    success: function (resp) {
      if (resp != null) {
        cuteToast({
          type: "info",
          message: "This NIC is already Registered!",
          timer: 3000,
        });
        $("#txtName").val(resp.profile.name).prop("disabled", true);
        $("#txtFatherName").val(resp.profile.fatherName).prop("disabled", true);
        $("#txtNumber").val(resp.profile.phoneNumber).prop("disabled", true);
        $("#txtEmail").val(resp.profile.email).prop("disabled", true);
        $("input[name=gender][value=" + resp.profile.gender + "]").prop("checked", true);
        // $("#dpdownRole").val(resp.role.roleId);
        $("#timeDOB1").val(resp.profile.doB).prop("disabled", true);
        $("#txtAddress").val(resp.profile.address).prop("disabled", true);
        $("#txtCity").val(resp.profile.city).prop("disabled", true);
        $("#txtCountry").val(resp.profile.country).prop("disabled", true);
        $(".GetImage").css("background-image", "url(" + resp.profile.picture + ")");
        ProgramHide(resp.role.roleId);
      }
    },
  });
});
