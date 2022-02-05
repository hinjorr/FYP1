$(document).ready(function () {
  CommonFunctions.GetAllClasses("#dpDownClasses");
});

var dto = {};

$("#dpDownClasses").change(function (e) {
  dto.ClassId = $("#dpDownClasses").val();
  $.ajax({
    url: "/Marks/GetResults",
    data: dto,
    success: function (resp) {
      var html = "";
      $(resp).each(function (indexInArray, item) {
        html +=
          `<tr>
            <td>` +
          item.classId +
          `</td>
            <td>` +
          item.assesmentName +
          `</td>
            <td>` +
          item.totalMarks +
          `</td>
            <td>` +
          item.obtainedMakrs +
          `</td>
        </tr>`;
      });
      $("#tblResults").html(html);
    },
  });
});
