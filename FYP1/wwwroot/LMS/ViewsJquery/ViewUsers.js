$(document).ready(function () {
  $("#viewuser").DataTable({
    ajax: {
      url: "/User/ViewUser",
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
          return '<button class="btn btn-primary btn-xs" onclick="clicked(this)"><i class="fa fa-pencil"></i></button><button class="btn btn-danger btn-xs"><i class="fa fa-trash-o "></i></button>';
        },
      },
    ],
  });
});

function clicked(obj) {
  var userid = $(obj).closest("tr").find("td:first").html();
  console.log(userid);
}
