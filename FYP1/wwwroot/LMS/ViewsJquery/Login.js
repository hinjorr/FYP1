$("#btnlogin").click(function (e) {
    var UserDTO = {
      UserName: $("#username").val(),
      Password: $("#password").val(),
    };
    $.ajax({
      type: "Post",
      url: "/LoginPost",
      data: UserDTO,
      success: function (resp) {
        if (resp == true) {
          // window.location.replace("/Home");
          alert(resp)
        } else {
          // alert("Username/Password invalid");
          alert(resp)
        }
      },
    });
  });
  