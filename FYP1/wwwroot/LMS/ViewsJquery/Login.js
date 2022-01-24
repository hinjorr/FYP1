$("#kt_login_signin_submit").click(function (e) {
  $("#kt_login_signin_submit").addClass("spinner spinner-white spinner-right");
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
              $("#kt_login_signin_submit").removeClass("spinner spinner-white spinner-right");

            });
        } else {
          location.replace("/Home");
        }
      },
    });
  }
});
