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
    paging: false,
    columns: [
      {
        data: "profile.picture",
        render: function (picture) {
          return (
            '<div class="symbol symbol-50 flex-shrink-0">' +
            '<img src="data:image/png;base64,' +
            picture +
            '">' +
            "</div>"
          );
        },
      },
      { data: "user.userName" },
      { data: "profile.name" },
      { data: "profile.nic" },
      { data: "profile.email" },
      {
        data: "role.roleName",
        render: function (role) {
          return '<a  class="label label-lg font-weight-bold label-light-warning label-inline"><i class="flaticon-user icon-nm"></i>' + role + '</a>';

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
        data: "user.userName",
        render: function (userName) {
          return (
            `<button class="btn btn-sm btn-clean btn-icon" title="Edit details" onclick="Update('`+userName+`')"><i class="la la-edit"></i></button> 
            <button class="btn btn-sm btn-clean btn-icon" title="Change Status" onclick="Delete('`+userName+`')"><i class="la la-trash"></i></button>`
          );
        },
      },
    ],
  });
}

function Update(userName) {
  // window.location.replace("/profile/" + userName);
  window.open("profile/" + userName, "_blank");
}
function Delete(userName) {
  // var username = $(userName).closest("tr").find("td:eq(1)").html();
  $.ajax({
    url: "/user/DeleteUser?username=" + userName,
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
          $("#viewuser").DataTable().clear().destroy();
          GetUsers();
        });

    },
  });
}
