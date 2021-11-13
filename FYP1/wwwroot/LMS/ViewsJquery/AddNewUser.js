
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
            dpRole: {
                required: true,
            },
            program: {
                required: true,
            },
            fathername: {
                required: true,
            },
            country: {
                required: true,
            },
            city: {
                required: true,
            },
            address: {
                required: true,
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
            dpRole: {
                required: "Please Enter Role",
            },
            program: {
                required: "Please enter Program",
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
                    IsActive: 1,
                },
                Student: {
                    ProgramId: $("#dpdownProgram option:selected").val(),
                    IsActive: 1,
                },
            };
            $.ajax({
                type: "Post",
                url: "/User/AddNewUser",
                data: ProfileDTO,
                success: function (resp) {
                    console.log(resp);
                    // $('#newuser').trigger("reset");
                },
            });
        },
    });


$(document).ready(function () {
    $("#newuser").valid();
    $("#roleinfo").hide();
  var Rolevariable = 0;

  //faculty and admin role condition
  function ProgramHide(id) {
    if (id == 2 || id == 1) {
      $("#lblprogram").attr("disabled", true);
      $("#dpdownProgram").attr("disabled", true);
    } else {
      $("#lblprogram").attr("disabled", false);
      $("#dpdownProgram").attr("disabled", false);
    }
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
          Rolevariable = resp.user.roleId;
          // if (resp.user.roleId == 1) {
          //   $("#roleinfo").text("User already registered as Admin").show();
          // } else if (resp.user.roleId == 2) {
          //   $("#roleinfo").text("User already registered as Faculty").show();
          // } else if (resp.user.roleId == 3) {
          //   $("#roleinfo").text("User already registered as Student").show();
          // }
        }
      },
    });
  });

  //user already registerd with same role
  $("#dpdownRole").change(function (e) {
    var local = $("#dpdownRole").val();
    ProgramHide(local);
    if (local == Rolevariable) {
      $("#roleinfo").text("This User already registered with this Role").show();
      $("#btnSubmit").attr("disabled", true);
    } else {
      $("#roleinfo").hide();
      $("#btnSubmit").attr("disabled", false);
    }
  });


  CommonFunctions.GetPrograms("#dpdownProgram");
  CommonFunctions.GetRoles("#dpdownRole");
});
