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
      {
        data: "picture",
        render: function (picture) {
          return (
            '<div class="symbol symbol-50 flex-shrink-0">' +
            '<img src="' +
            picture +
            '">' +
            "</div>"
          );
        },
      },
      { data: "user.userName" },
      { data: "name" },
      { data: "nic" },
      { data: "email" },
      {
        data: "user.role.roleId",
        render: function (role) {
          if (role == 1) {
            return '<a  class="label label-lg font-weight-bold label-light-primary label-inline"><i class="flaticon-user icon-nm"></i>Admin</a>';
          } else if (role == 2) {
            return '<a  class="label label-lg font-weight-bold label-light-success label-inline"><i class="flaticon-presentation icon-nm"></i> Faculty</a>';
          } else {
            return '<a  class="label label-lg font-weight-bold label-light-warning label-inline"><i class="flaticon2-pen icon-nm"></i> Student</a>';
          }
        },
      },
      {
        data: "user.isActive",
        render: function (isActive) {
          if (isActive == true) {
            return '<a  class="label label-lg font-weight-bold label-light-success label-inline">Active</a>';
          } else {
            return '<a class="label label-lg font-weight-bold label-light-danger label-inline">Inactive</a>';
          }
        },
      },
      { data: "user.userDate" },
      {
        render: function (data, row) {
          return (
            '<button class="btn btn-sm btn-clean btn-icon" title="Edit details" onclick="Update(this)"><i class="la la-edit"></i></button>' +
            '<button class="btn btn-sm btn-clean btn-icon" title="Delete" onclick="Delete(this)"><i class="la la-trash"></i></button>'
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
