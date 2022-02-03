$(document).ready(function () {
  var route = window.location.href;
  ClassId = route.substring(route.lastIndexOf("/") + 1);
  GetCourseName(ClassId);
  role = $("#GetUsersRole").text();
  // $("#data").html(`<input type="text" class="form-control form-control-solid datetimepicker-input kt_datetimepicker_5" placeholder="Select date &amp; time" data-toggle="datetimepicker" data-target=".kt_datetimepicker_5" />
  // `);
});

var role;
var ClassId;
var UrlDTO = {}

function GetCourseName(id) {
  $.ajax({
    url: "/GetClass/" + id,
    success: function (resp) {
      if (resp.icon == null) {
        $("#ShowCourse").text(id + " " + resp.course.fullName);
        GetSessions(id);
      } else {
        swal.fire({
          text: resp.text,
          icon: resp.icon,
          buttonsStyling: false,
          confirmButtonText: "Ok, got it!",
          customClass: {
            confirmButton: "btn font-weight-bold btn-light-primary",
          },
        });
      }
    },
  });
}

function GetSessions(Cid) {
  $.ajax({
    url: "/Classes/GetSessionsForClass?Cid=" + Cid,
    async: false,
    success: function (resp) {
      var html = "";
      html += '<div class="card-body">';
      $(resp).each(function (indexInArray, item) {
        html +=
          `<div class="row">
        <div class="col-lg-9">
            <h4 style="font-family: Georgia, serif;font-size: x-large;color:#036f7a"><i class="fa fa-angle-right"></i>` + item.sessionName + `</h4>
          <div id="urls`+ item.sessionId + `"></div>
          <div id="assements`+ item.sessionId + `"></div>
        </div>`
        GetUrls(item.sessionId)
        GetAssesments(item.sessionId)
        //anything
        if (role == "Faculty") {
          html += ActivityButton(item.sessionId)
          html += UrlModal(item.sessionId)
          html += AttachmentModal(item.sessionId)
          html += AssesmentModal(item.sessionId)
        }
        html += `</div><hr>`;
      });
      html += "</div>";
      $("#data").html(html);
      $('.start_date').datetimepicker();
      $('.end_date').datetimepicker();

    },
  });
}


function ActivityButton(sessionId) {
  return `<div class="col-lg-3">
  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal_` + sessionId + `">Add an Activity or resource</button>
    <div class="modal fade" id="exampleModal_` + sessionId + `" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title">All Activities `+ sessionId + `</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                  </button>
              </div>
             <div class="modal-body">
                  <button type="button" class="btn btn-default col-lg-3 " data-toggle="modal" data-target="#AssignmentModal`+ sessionId + `">
                      <i class="fas fa-file-signature"></i><br />Assesment
                  </button>
                  <button type="button" class="btn btn-default col-lg-3" data-toggle="modal" data-target="#UrlModal` + sessionId + `">
                      <i class="fas fa-link"></i><br />Url
                  </button>
                  <button type="button" class="btn btn-default col-lg-3" data-toggle="modal" data-target="#AttachmentModal`+ sessionId + `">
                      <i class="fa fa-folder-open"></i><br />Upload Files
                  </button><br><br>
                  <button type="button" class="btn btn-default col-lg-3" >
                      <i class="fas fa-laptop-code"></i><br />Embed Video
                  </button>
                  <button type="button" class="btn btn-default col-lg-3">
                      <i class="fas fa-question-circle"></i><br />Online Quiz
                  </button>
              </div>
              <div class="modal-footer mt">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              </div>
          </div>
      </div>
  </div>
</div>`
}

//<--------Assesment Modal working Start------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

function AssesmentModal(sessionId) {
  return `<div class="modal fade" id="AssignmentModal` + sessionId + `" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
  aria-hidden="true">
  <div class="modal-dialog" role="document">
      <div class="modal-content">
          <div class="modal-header">
              <h5 class="modal-title">Assesment</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
              </button>
          </div>
          <div class="modal-body">
              <div class="form-group">
                  <label>
                      Assesment Name
                      <span class="error">*</span>
                  </label>
                  <input type="text" class="form-control" placeholder="" id="txtName`+ sessionId + `" autocomplete="off">
              </div>
              <div class="form-group">
                  <label>
                      Description
                  </label>
                  <textarea type="text" class="form-control" placeholder="" id="txtDescription`+ sessionId + `"
                      name="txtDescription"></textarea>
              </div>
              <div class="form-group">
                  <input type="file" class="form-control" placeholder="" id="upload_files`+ sessionId + `" name="upload_files" multiple>
              </div>
             
              <div class="row">
              <div class="form-group col-lg-6">
                  <label>Start</label>
                  <span class="error">*</span>
                  <input type="text" class="start_date form-control form-control-solid datetimepicker-input" id="assesmentStart`+ sessionId + `" placeholder="Select date &amp; time" data-toggle="datetimepicker" data-target=".start_date" />
              </div>
              <div class="form-group col-lg-6">
                  <label>End</label>
                  <span class="error">*</span>
                  <input type="text" class="end_date  form-control form-control-solid datetimepicker-input" id="assesmentEnd`+ sessionId + `" placeholder="Select date &amp; time" data-toggle="datetimepicker" data-target=".end_date" />
              </div>
              </div>
                <div class="form-group ">
                  <label class="checkbox">
                      <input type="checkbox"  name="LateSubmit`+ sessionId + `" />
                      <span></span>&nbsp; No late Submission</label>
              </div>
          </div>
          <div class="modal-footer mt">
              <button type="button" class="btn btn-primary" onClick="UploadAssesment(`+ sessionId + `)" >Submit</button>
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          </div>
      </div>
  </div>
</div>`
}


function UploadAssesment(sessionId) {
  var dto = new FormData()
  dto.append("ClassId", ClassId)
  dto.append("SessionId", sessionId)
  dto.append("AssesmentName", $("#txtName" + sessionId).val())
  dto.append("Description", $("#txtDescription" + sessionId).val())
  dto.append("Start", $("#assesmentStart" + sessionId).val())
  dto.append("End", $("#assesmentEnd" + sessionId).val())
  dto.append("LateSubmission", $('input[name="LateSubmit' + sessionId + '"]').prop('checked'))
  // dto.append("LateSubmission", $(('input[name="LateSubmit' + sessionId + '"]').is(":checked")))
  var input = document.getElementById("upload_files" + sessionId)
  images = input.files;
  $.each(images, function (indexInArray, valueOfElement) {
    dto.append("Attachments", images[indexInArray])
  });

  $.ajax({
    type: "Post",
    url: "/ClassContent/UploadAssesment",
    data: dto,
    contentType: false,
    processData: false,
    success: function (resp) {
      cuteToast({
        type: resp.type,
        message: resp.message,
        timer: 3000,
      })
      if (resp.type != "error") {
        GetAssesments(sessionId)
        $('#AssignmentModal' + sessionId).modal('hide');
        $('#exampleModal_' + sessionId).modal('hide');

      }
    }
  });
}

function GetAssesments(SessionId) {
  $.ajax({
    url: "/ClassContent/GetAssesment?_sessionId=" + SessionId + "&_classId=" + ClassId,
    success: function (resp) {
      var html = ""
      $(resp).each(function (indexInArray, item) {
        html += `<a href="/ViewAssesment/` + ClassId + `/` + item.assesmentId + `" target="_blank" style="margin-left: 20px;"> <img src="https://img.icons8.com/color/48/4a90e2/task--v1.png" style="height: 20px;">` + item.assesmentName + `</a>&nbsp&nbsp&nbsp&nbsp`
        if (role == "Faculty") {
          html += `<button type="button" class="btn btn-sm btn-icon  btn-hover-light-primary "><i class="fas fa-edit" title="Edit" onClick="OpenAssesmentModal(` + SessionId + `,` + item.assesmentId + `)"></i></button>`
          html += `<button type="button" class="btn btn-sm btn-icon btn-hover-light-danger"><i class="fas fa-trash" title="Delete" onClick="DeleteAssesment(` + SessionId + `,` + item.assesmentId + `)"></i></button>`
        }
        html += "<br>"
      });
      $("#assements" + SessionId).html(html);

    }
  });
}

function DeleteAssesment(sessionId, id) {
  $.ajax({
    url: "/ClassContent/DeleteAssesment?id=" + id,
    success: function (resp) {
      GetAssesments(sessionId)
    }
  });
}

function OpenAssesmentModal(sessionId, classId) {
  $("#AssignmentModal" + sessionId).modal("show")
}
//<--------Assesment Modal working End------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------>

//<--------Attachment Modal working Start-------------------------------------------------------------------------------------------------------------------->

function AttachmentModal(sessionId) {
  return `<div class="modal fade" id="AttachmentModal` + sessionId + `" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
      <div class="modal-content">
          <div class="modal-header">
              <h5 class="modal-title">URL </h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
              </button>
          </div>
          <div class="modal-body">
             
              <div class="form-group">
              <div class="dropzone dropzone-default dropzone-success">
              <div class="dropzone-msg dz-message needsclick">
                  <h3 class="dropzone-msg-title">Drop files here or click to upload.</h3>
                  <input type="file" class="kt_dropzone_3">
                  <span class="dropzone-msg-desc">Only image, pdf and psd files are allowed for upload</span>
              </div>
          </div>
              </div>
          </div>
          <div class="modal-footer mt">
          <button type="button" class="btn btn-primary">Submit</button>
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          </div>
      </div>
  </div>
</div>`
}

//<--------Attachment Modal working End------------------------------------------------------------------------------------------------------------------------>


//<--------Url Modal working Start------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
function UrlModal(sessionId) {
  return `<div class="modal fade" id="UrlModal` + sessionId + `" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
      <div class="modal-content">
          <div class="modal-header">
              <h5 class="modal-title">URL </h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
              </button>
          </div>
          <div class="modal-body">
              <div class="form-group">
                  <label>
                      Link Name
                      <span class="error">*</span>
                  </label>
                  <input type="text" class="form-control" id="link_id`+ sessionId + `" autocomplete="off" >
                  <input type="text" class="form-control" placeholder="" id="link_name`+ sessionId + `" autocomplete="off">
              </div>
              <div class="form-group">
                  <label>
                      URL
                      <span class="error">*</span>
                  </label>
                  <input type="text" class="form-control" placeholder="" id="link_url`+ sessionId + `" autocomplete="off">
              </div>
          </div>
          <div class="modal-footer mt">
          <button type="button" class="btn btn-primary" onClick="UploadUrl('` + sessionId + `')">Submit</button>
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          </div>
      </div>
  </div>
</div>`
}

function UploadUrl(sessionId) {
  UrlDTO.ClassId = ClassId
  UrlDTO.SessionId = sessionId
  UrlDTO.DisplayName = $("#link_id" + sessionId).val();
  UrlDTO.DisplayName = $("#link_name" + sessionId).val();
  UrlDTO.Link = $("#link_url" + sessionId).val();
  console.log(UrlDTO)
  $.ajax({
    url: "/ClassContent/AddUrl",
    data: UrlDTO,
    success: function (resp) {
      cuteToast({
        type: resp.type,
        message: resp.message,
        timer: 3000,
      })
      if (resp.type != "error") {
        GetUrls(sessionId)
        $('#UrlModal' + sessionId).modal('hide');
        $('#exampleModal_' + sessionId).modal('hide');

      }
    }
  });
}

function GetUrls(SessionId) {
  var html = ""
  $.ajax({
    url: "/ClassContent/GetUrls?sessionId=" + SessionId + "&classId=" + ClassId,
    success: function (resp) {
      $(resp).each(function (indexInArray, item) {
        html += `<a href="` + item.link + `" target="_blank" style="margin-left: 20px;"> <img src="https://img.icons8.com/fluency/48/4a90e2/chain.png" style="height: 20px;">` + item.displayName + `</a>&nbsp&nbsp&nbsp&nbsp`
        if (role == "Faculty") {
          html += `<button type="button" class="btn btn-sm btn-icon  btn-hover-light-primary "><i class="fas fa-edit" title="Edit" onClick="openUrlModal(` + SessionId + `,` + item.urlId + `)"></i></button>`
          html += `<button type="button" class="btn btn-sm btn-icon btn-hover-light-danger"><i class="fas fa-trash" title="Delete" onClick="DeleteUrl(` + SessionId + `,` + item.urlId + `)"></i></button>`
        }
        html += "<br>"
      });
      $("#urls" + SessionId).html(html);


    }
  });
}

function openUrlModal(sessionId, id) {
  $.ajax({
    url: "/ClassContent/GetSingleUrl?id=" + id,
    success: function (resp) {
      UrlDTO.UrlId = resp.urlId
      $("#link_id" + sessionId).val(id);
      $("#link_name" + sessionId).val(resp.displayName);
      $("#link_url" + sessionId).val(resp.link);
      $('#UrlModal' + sessionId).modal('show');
    }
  });
}

function DeleteUrl(sessionId, id) {
  $.ajax({
    url: "/ClassContent/DeleteUrl?id=" + id,
    success: function (resp) {
      GetUrls(sessionId, ClassId)
    }
  });
}


//<--------Url Modal working End------------------------------------------------------------------------------------------------------------------------------------------>
