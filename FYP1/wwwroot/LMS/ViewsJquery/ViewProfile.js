$(document).ready(function () {
  var route = window.location.href;
  UserID = route.substring(route.lastIndexOf("/") + 1);
  alert(UserID);
});

