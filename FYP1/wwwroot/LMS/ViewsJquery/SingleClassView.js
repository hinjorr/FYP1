$(document).ready(function () {
  var route = window.location.href;
  ClassId = route.substring(route.lastIndexOf("/") + 1);
  GetCourseName(ClassId);
});

var ClassId;

function GetCourseName(id) {
  $.ajax({
    url: "/GetClass/" + id,
    success: function (resp) {
      $("#ShowCourse").text(resp.course.fullName + " " + id);
      GetSessions();
    },
  });
}
function Quiz(CID, SessionID, ContentName, ContentLink) {
  console.log(CID, SessionID, ContentName, ContentLink);
}

function GetSessions() {
  $.ajax({
    url: "/Semester/GetAlllSessions",
    async: false,
    success: function (resp) {
      var html = "";
      html += '<div class="card-body">';
      $(resp).each(function (indexInArray, item) {
        html +=
          `<div class="row">
        <div class="col-lg-9">
            <h4><i class="fa fa-angle-right"></i>
                ` +
          item.sessionName +
          `
            </h4>
        </div>
        <div class="col-lg-3">
            <button type="button" class="btn btn-primary" data-toggle="modal"
                data-target="#exampleModal_` +
          item.sessionId +
          `">Add an Activity or resource</button>
            <div class="modal fade" id="exampleModal_` +
          item.sessionId +
          `" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
                aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">All Activities</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                        <button type="button" class="btn btn-default col-lg-3" data-toggle="modal" data-target="#AssignmentModal">
                        <i class="fa fa-book"></i><br />Assesment
                        </button>
                        <button type="button" class="btn btn-default col-lg-3" data-toggle="modal" data-target="#URLModal">
                        <i class="fa fa-desktop"></i><br />Url
                        </button>
                        <button type="button" class="btn btn-default col-lg-3">
                        <i class="fa fa-folder-open"></i><br />Upload Files
                        </button><br><br>
                        <button type="button" class="btn btn-default col-lg-3" >
                        <i class="fa fa-upload"></i><br />Online Quiz
                        </button>
                        </div>
                        <div class="modal-footer mt">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <hr>`;
      });
      html += "</div>";
      $("#data").append(html);
    },
  });
}

// onclick="Quiz(`+ClassId+`,`+item.sessionId+`,'Quiz1','google.com')" data-toggle="modal" data-target="#AssignmentModal"
