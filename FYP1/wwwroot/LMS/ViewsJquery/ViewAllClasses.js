$(document).ready(function () {
  var user_id = $("#GetUserName").html();
  GetAllClasses(user_id);
});

function GetAllClasses(id) {
  $.ajax({
    url: "/Classes/ViewClassesbyId?username=" + id,
    success: function (resp) {
      var html = "";
      $(resp).each(function (indexInArray, item) {
        html += '<div class="col-md-4">';
        html += '<div class="card card-custom gutter-b card-stretch">';
        html += '<div class="card-body text-center pt-4">';
        html += '<div class="my-4">';
        html += "</div>";
        html += '<div class="mt-7">';
        html += '<div class="symbol symbol-circle symbol-lg-90">';
        if (item.classImage != null) {
          html += "<img src=" + item.classImage + ">";
        } else {
          html += "<img src=/LMS/assets/media/project-logos/noimage.svg.png>";
        }
        html += "</div>";
        html += "</div>";
        html += '<div class="my-4">';
        html +=
          '<span class="text-dark font-weight-bold text-hover-primary font-size-h4">' +
          item.course.shortName +
          "&nbsp;" +
          item.classes.classId +
          "</span>";
        html += "</div>";
        html += '<div class="my-4">';
        html +=
          '<span class="text-dark font-weight-bold  font-size-h5">' +
          item.day.dayName +
          "&nbsp;" +
          item.time.timeName +
          "</span>";
        html += "</div>";

        html += '<div class="mt-9">';
        if (item.classes.isActive != null) {
          if (item.classes.isActive == 1) {
            html += `<a class="label label-lg font-weight-bold label-light-success label-inline">Active</a><br><br>`
          }
          else {
            html += `<a class="label label-lg font-weight-bold label-light-danger label-inline">Inactive</a><br><br>`
          }
        }
        html +=
          '<a href="/ViewClass/' +
          item.classes.classId +
          '" class="btn btn-light-primary font-weight-bolder btn-sm py-3 px-6 text-uppercase">View Class</a>';
        html += "</div>";
        html += "</div>";
        html += "</div>";
        html += "</div>";
      });
      $("#ClassesCard").append(html);
    },
  });
}
