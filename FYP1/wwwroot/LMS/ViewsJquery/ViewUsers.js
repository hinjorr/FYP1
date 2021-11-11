$(document).ready(function () {
  $.ajax({
    async: true,
    type: "Get",
    url: "/User/ViewUser",
    success: function (resp) {
      var html = "";
      html += " ";
      $(resp).each(function (index, items) {
        html +='<tr><td>'+items.user.userName+'</td>'
        +'<td>'+items.name+'</td>'
        +'<td>'+items.nic+'</td>'
        +'<td>'+items.email+'</td>'
        +'<td>'+items.user.role.roleName+'</td>'
        +'<td>'+items.user.isActive+'</td>'
        +'<td>'+items.user.userDate+'</td>'
        +'<td>'+items.user.userDate+'</td></tr>'
      });
      // alert($("#tblusers").html());
      $("#tblusers").html(html);
    },
  });
});
