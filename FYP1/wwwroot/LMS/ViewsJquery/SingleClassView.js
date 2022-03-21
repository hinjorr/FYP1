
$(document).ready(function () {
  var route = window.location.href;
  ClassId = route.substring(route.lastIndexOf("/") + 1);
  GetCourseName(ClassId);
  $('.start_date').datetimepicker();
  $('.end_date').datetimepicker();
  CommonFunctions.GetSessions("#attachment_sessions");
  CommonFunctions.GetSessions("#assesment_sessions");
  CommonFunctions.GetSessions("#url_sessions");
  CommonFunctions.GetSessions("#docs_sessions");
  role = $("#GetUsersRole").text();
  Assesment_Attachments()
  VideosUpload()
  Docs_Upload()
  if (role == "Student") {
    $("#ActivityBtn").remove();
  }
});

var role;
var ClassId;



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
          <div id="docs`+ item.sessionId + `"></div>
          <div id="videos`+ item.sessionId + `"></div>
        </div>`
        GetUrls(item.sessionId)
        GetAssesments(item.sessionId)
        GetVideos(item.sessionId)
        GetDocs(item.sessionId)
        html += `</div><hr>`;
      });
      html += "</div>";
      $("#data").html(html);
    },
  });
}

//<--------Docs Modal working Start------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
{
  function GetDocs(session_id) {
    $.ajax({
      url: "/ClassContent/GetDocFiles?class_id=" + ClassId + "&sessionId=" + session_id,
      success: function (resp) {
        var html = `<details style="margin-left:40px;font-size:15px"><summary>Files</summary>`
        if (resp[0] != null) {
          $(resp).each(function (index, item) {
            html += `<img src="https://img.icons8.com/color/48/4a90e2/attach.png" style="height: 20px;"><a href="` + item.link + `" target="_blank">` + item.displayName + `</a>`
            if (role == "Faculty") {
              html += `&nbsp&nbsp<button type="button" class="btn btn-sm btn-icon btn-hover-light-danger"><i class="fas fa-trash" title="Delete" onclick="DeleteDoc(` + item.docId + `,` + session_id + `)"></i></button><br>`
            }
          });
          html += "</details>"
          $("#docs" + session_id).html(html);
        }
        else {
          $("#docs" + session_id).html("");
        }
      }
    });
  }
  function DeleteDoc(id, sessionId) {
    $.ajax({
      url: "/ClassContent/DeleteDocFile?doc_id=" + id,
      success: function (resp) {
        if (resp == true) {
          GetDocs(sessionId)
        }
      }
    });
  }

  var DocDTO = new FormData()
  function UploadDocs() {
    var docs_session = $("#docs_sessions").val()
    DocDTO.append("SessionId", docs_session)
    DocDTO.append("ClassId", ClassId)
    $("#Docsbar").show();
    $.ajax({
      type: "Post",
      url: "/ClassContent/UploadDocFiles",
      data: DocDTO,
      contentType: false,
      processData: false,
      success: function (resp) {
        $("#Docsbar").hide();
        cuteToast({
          type: resp.type,
          message: resp.message,
          timer: 3000,
        })
        if (resp.type != "error") {
          GetDocs(docs_session)
          $('#DocsModal').modal('hide');
          $('#exampleModal_').modal('hide');
        }
      }
    });
  }

  function Docs_Upload() {
    $('#docs_upload').dropzone({
      url: "#",
      paramName: "file",
      addRemoveLinks: true,
      // removedfile: function (file) {
      //   AssesmentDTO.delete("")
      //   return (_ref = file.previewElement) != null ? _ref.parentNode.removeChild(file.previewElement) : void 0;
      // },
      accept: function (file, done) {
        DocDTO.append("Attachments", file)
        done();
      }
    });
  }

}
//<--------Docs Modal working End------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->


//<--------Video Modal working Start------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
{
  var VideosDTO = new FormData()
  function UploadFiles() {
    var sessionId = $("#attachment_sessions").val();
    VideosDTO.append("ClassId", ClassId)
    VideosDTO.append("SessionId", sessionId)
    console.log(VideosDTO.get("Attachment"))

    $("#VideosBar").show();
    $.ajax({
      type: "Post",
      url: "/ClassContent/UploadVideos",
      data: VideosDTO,
      contentType: false,
      processData: false,
      success: function (resp) {
        $("#VideosBar").hide();
        cuteToast({
          type: resp.type,
          message: resp.message,
          timer: 3000,
        })
        if (resp.type != "error") {
          GetVideos(sessionId)
          $('#VideosModal').modal('hide');
          $('#exampleModal_').modal('hide');
        }
      }
    });
  }

  function VideosUpload() {
    $('#files_upload').dropzone({
      url: "#",
      paramName: "file",
      addRemoveLinks: true,
      acceptedFiles: "video/*",
      // removedfile: function (file) {
      //   AssesmentDTO.delete("")
      //   return (_ref = file.previewElement) != null ? _ref.parentNode.removeChild(file.previewElement) : void 0;
      // },
      accept: function (file, done) {
        VideosDTO.append("Attachment", file)
        done();
      }
    });
  }


  function GetVideos(sessionId) {
    $.ajax({
      url: "/ClassContent/GetVideos?sessionId=" + sessionId + "&classId=" + ClassId,
      success: function (resp) {
        var html = `<details style="margin-left:40px;font-size:15px"><summary>Videos</summary>`
        if (resp[0] != null) {
          $(resp).each(function (index, item) {
            html += `<iframe src="https://www.youtube.com/embed/` + item.ytubeVideoId + `" allow="accelerometer;  allowfullscreen="" width="400" height="250" frameborder="0"></iframe>`
            html += `<button type="button" class="btn btn-sm btn-icon btn-hover-light-danger"><i class="fas fa-trash" title="Delete" onclick="DeleteVideo(` + item.videoId + `,` + sessionId + `)"></i></button>`
          });
          html += "</details>"
          $("#videos" + sessionId).html(html);
        }
        else {
          $("#videos" + sessionId).html("");
        }
      }
    });
  }

  function DeleteVideo(id, sessionId) {
    $.ajax({
      url: "/ClassContent/DeleteVideo?id=" + id,
      success: function (resp) {
        if (resp == true) {
          GetVideos(sessionId)
        }
      }
    });
  }

}
//<--------Video Modal working End------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->


//<--------Assesment Modal working Start------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
{
  var AssesmentDTO = new FormData()

  function Assesment_Attachments() {
    $('#assesment_attachments').dropzone({
      url: "#",
      paramName: "file",
      addRemoveLinks: true,
      maxFilesize: 150,
      // removedfile: function (file) {
      //   AssesmentDTO.delete("")
      //   return (_ref = file.previewElement) != null ? _ref.parentNode.removeChild(file.previewElement) : void 0;
      // },
      accept: function (file, done) {
        AssesmentDTO.append("Attachments", file)
        done();
        //done("sakjdh")
      }
    });
  }


  $("#btnAssesmentSubmit").click(function (e) {
    var session_id = $("#assesment_sessions").val()
    AssesmentDTO.append("ClassId", ClassId)
    AssesmentDTO.append("SessionId", session_id)
    AssesmentDTO.append("AssesmentName", $("#txtName").val())
    AssesmentDTO.append("Description", $("#txtDescription").val())
    AssesmentDTO.append("Start", $("#assesmentStart").val())
    AssesmentDTO.append("End", $("#assesmentEnd").val())
    AssesmentDTO.append("LateSubmission", $('#LateSubmit').prop('checked'))
    $("#assesmentBar").show();
    $.ajax({
      type: "Post",
      url: "/ClassContent/UploadAssesment",
      data: AssesmentDTO,
      contentType: false,
      processData: false,
      success: function (resp) {
        $("#assesmentBar").hide();
        cuteToast({
          type: resp.type,
          message: resp.message,
          timer: 3000,
        })
        if (resp.type != "error") {
          AssesmentDTO.delete("AssesmentId")
          GetAssesments(session_id)
          $('#AssignmentModal').modal('hide');
          $('#exampleModal_').modal('hide');
        }
      }
    });
  });


  function GetAssesments(SessionId) {
    $.ajax({
      url: "/ClassContent/GetAssesment?_sessionId=" + SessionId + "&_classId=" + ClassId,
      success: function (resp) {
        var html = ""
        $(resp).each(function (indexInArray, item) {
          html += `<a href="/ViewAssesment/` + ClassId + `/` + item.assesmentId + `" target="_blank" style="margin-left: 20px;"> <img src="https://img.icons8.com/color/48/4a90e2/task--v1.png" style="height: 20px;">` + item.assesmentName + `</a>&nbsp&nbsp&nbsp&nbsp`
          if (role == "Faculty") {
            html += `<button type="button" class="btn btn-sm btn-icon  btn-hover-light-primary "><i class="fas fa-edit" title="Edit" onClick="OpenAssesmentModal(` + item.assesmentId + `)"></i></button>`
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

  function OpenAssesmentModal(assesmentId) {
    $.ajax({
      url: "/ClassContent/GetAssesmentDetail?id=" + assesmentId,
      success: function (resp) {
        AssesmentDTO.set("AssesmentId", assesmentId)
        console.log("Get", AssesmentDTO.get("AssesmentId"))
        $("#assesment_sessions").val(resp.assesment.sessionId);
        $("#txtName").val(resp.assesment.assesmentName);
        $("#txtDescription").val(resp.assesment.description);
        $("#assesmentStart").val(resp.assesment.start);
        $("#assesmentEnd").val(resp.assesment.end);
        $('#LateSubmit').prop('checked', resp.assesment.lateSubmission);
        if (resp.assesmentAttachmentList[0] != null) {
          ShowAttachments(resp.assesmentAttachmentList, assesmentId)
          $("#assesment_attachments").hide();
        }
        else {
          $("#assesment_attachments").show();
          $("#SubmittedFile").html("");
        }
        $("#AssignmentModal").modal("show")
      }
    });
  }
  function ShowAttachments(list, assesmentId) {
    var html = ""
    $(list).each(function (indexInArray, item) {
      html += `<a href="` + item.link + `" target="_blank">` + item.displayName + `</a> &nbsp &nbsp<i onmouseover="this.style.cursor='pointer'" class="fas fa-trash" title="Delete" onClick="DeleteAttachments(` + item.fileId + `,` + assesmentId + `)"></i>`
      html += "<br>"
    });
    html += `<br><button class="btn btn-light-primary font-weight-bold btn-sm btn-block" onClick="DropZoneBtn(this)">Upload More</button><br>`
    $("#SubmittedFile").html(html);
  }

  function DeleteAttachments(id, assesmentId) {
    $.ajax({
      url: "/ClassContent/DeleteAssesmentAttachment?fileId=" + id,
      success: function () {
        $.ajax({
          url: "/ClassContent/GetAssesmentDetail?id=" + assesmentId,
          success: function (resp) {
            ShowAttachments(resp.assesmentAttachmentList, assesmentId)
          }
        });
      }
    });
  }

  function DropZoneBtn(obj) {
    $(obj).hide();
    $("#assesment_attachments").show();
  }
}
//<--------Assesment Modal working End------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------>



//<--------Url Modal working Start------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
{


  var UrlDTO = {}

  $("#btnUrlSumit").click(function (e) {
    UrlDTO.SessionId = $("#url_sessions").val();
    UrlDTO.ClassId = ClassId
    UrlDTO.DisplayName = $("#link_name").val();
    UrlDTO.Link = $("#link_url").val();
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
          UrlDTO.UrlId = 0
          GetUrls(UrlDTO.SessionId)
          $('#UrlModal').modal('hide');
          $('#exampleModal_').modal('hide');

        }
      }
    });

  });



  function GetUrls(SessionId) {
    var html = ""
    $.ajax({
      url: "/ClassContent/GetUrls?sessionId=" + SessionId + "&classId=" + ClassId,
      success: function (resp) {
        $(resp).each(function (indexInArray, item) {
          html += `<a href="` + item.link + `" target="_blank" style="margin-left: 20px;"> <img src="https://img.icons8.com/fluency/48/4a90e2/chain.png" style="height: 20px;">` + item.displayName + `</a>&nbsp&nbsp&nbsp&nbsp`
          if (role == "Faculty") {
            html += `<button type="button" class="btn btn-sm btn-icon  btn-hover-light-primary "><i class="fas fa-edit" title="Edit" onClick="openUrlModal(` + item.urlId + `)"></i></button>`
            html += `<button type="button" class="btn btn-sm btn-icon btn-hover-light-danger"><i class="fas fa-trash" title="Delete" onClick="DeleteUrl(` + SessionId + `,` + item.urlId + `)"></i></button>`
          }
          html += "<br>"
        });
        $("#urls" + SessionId).html(html);


      }
    });
  }

  function openUrlModal(id) {
    $.ajax({
      url: "/ClassContent/GetSingleUrl?id=" + id,
      success: function (resp) {
        UrlDTO.UrlId = resp.urlId
        $("#url_sessions").val(resp.sessionId);
        $("#link_name").val(resp.displayName);
        $("#link_url").val(resp.link);
        $('#UrlModal').modal('show');
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
}

//<--------Url Modal working End------------------------------------------------------------------------------------------------------------------------------------------>
