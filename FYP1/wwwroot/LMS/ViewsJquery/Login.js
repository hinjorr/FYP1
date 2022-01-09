$("#kt_login_signin_submit").click(function (e) {
  var UserDTO = {
    UserName: $("#username").val(),
    Password: $("#password").val(),
  };

  if (UserDTO.UserName != "" && UserDTO.Password != "") {
    $.ajax({
      type: "Post",
      url: "/LoginPost",
      data: UserDTO,
      success: function (resp) {
        if (resp.icon == "error") {
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
        } else {
          if (resp.role.roleName == "Admin") {
            location.replace("/Home");
          } else {
            location.replace("/ViewAllClasses");
          }
        }
      },
    });
  }
});
