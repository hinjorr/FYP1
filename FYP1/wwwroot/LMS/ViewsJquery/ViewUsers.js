$(document).ready(function () {
  GetUsers();
});

function GetUsers() {
  $("#viewuser").DataTable({
    ajax: {
      url: "/User/GetUsers",
      type: "Get",
      datatype: "json",
    },
    columns: [
      { data: "user.userName" },
      { data: "name" },
      { data: "nic" },
      { data: "email" },
      { data: "user.role.roleName" },
      { data: "user.isActive" },
      { data: "user.userDate" },
      {
        render: function (data, row) {
          return (
            '<button class="btn btn-primary btn-xs" onclick="Update(this)"><i class="fa fa-pencil"></i>' +
            '</button><button class="btn btn-danger btn-xs" onclick="Delete(this)"><i class="fa fa-trash-o"></i></button>'
          );
        },
      },
    ],
  });
}

function Update(obj) {
  var userid = $(obj).closest("tr").find("td:first").html();
  console.log(userid);
}
function Delete(obj) {
  var username = $(obj).closest("tr").find("td:eq(0)").html();
  var status = $(obj).closest("tr").find("td:eq(5)").html();
  if (status == "true") {
    $.ajax({
      url: "/user/DeleteUser?username=" + username,
      success: function (resp) {
        if (resp == true) {
          $("#viewuser").DataTable().clear().destroy();
          cuteToast({
            type: "success",
            message: "User Deactivated!",
            timer: 3000,
          });
          GetUsers();
        } else {
          cuteToast({
            type: "error",
            message: resp,
            timer: 3000,
          });
        }
      },
    });
  } else {
    cuteToast({
      type: "error",
      message: "User already Deactivated!",
      timer: 3000,
    });
  }
}
