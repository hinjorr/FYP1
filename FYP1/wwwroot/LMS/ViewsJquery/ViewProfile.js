$(document).ready(function () {
  var route = window.location.href;
  UserID = route.substring(route.lastIndexOf("/") + 1);
  GetProfile(UserID);

  var role = $("#GetUsersRole").text();
});

function GetProfile(username) {
  $.ajax({
    url: "/GetProfile?username=" + username,
    success: function (resp) {
      $(".GetImage").css(
        "background-image",
        "url(" + resp.profile.picture + ")"
      );
      $("#txtName").val(resp.profile.name);
      $("#txtFatherName").val(resp.profile.fatherName);
      $("#txtNic").val(resp.profile.nic);
      $("#txtRole").val(resp.role.roleName);
      $("#txtDOB").val(resp.profile.doB);
      $("input[name=gender][value=" + resp.profile.gender + "]").prop(
        "checked",
        true
      );
      $("#txtAddress").val(resp.profile.address);
      $("#txtCity").val(resp.profile.city);
      $("#txtCountry").val(resp.profile.country);
      $("#txtUsername").val(resp.user.userName);
      $("#txtEmail").val(resp.profile.email);
      $("#txtPhone").val(resp.profile.phoneNumber);
    },
  });
}

$("#btnSubmitProfile").click(function (e) {
  var input = document.getElementById("profile_avatar");
  var file = input.files;
  var ProfileDTO = new FormData();
  ProfileDTO.append("ProfileImage", file[0]);
  ProfileDTO.append("Name", $("#txtName").val());
  ProfileDTO.append("FatherName", $("#txtFatherName").val());
  ProfileDTO.append("Gender", $("input[name=gender]:checked").val());
  ProfileDTO.append("DoB", $("#txtDOB").val());
  ProfileDTO.append("Address", $("#txtAddress").val());
  ProfileDTO.append("City", $("#txtCity").val());
  ProfileDTO.append("Country", $("#txtCountry").val());
  ProfileDTO.append("IsActive", 1);
  $.ajax({
    type: "Post",
    url: "/UpdateProfile",
    data: ProfileDTO,
    dataType: "json",
    contentType: false,
    processData: false,
    success: function (resp) {
      // cuteToast({
      //   type: resp.type,
      //   message: resp.msg,
      //   timer: 3000,
      // });
      // if (resp.msg == "success") {
      //   $("#newuser").trigger("reset");
      // }
    },
  });
});

function UpdatePassword() { }

// ProfileDTO.append(
//   "Student.ProgramId",
//   $("#dpdownProgram option:selected").val()
// );
