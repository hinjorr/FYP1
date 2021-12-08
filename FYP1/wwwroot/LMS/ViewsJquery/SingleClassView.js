$(document).ready(function () {
  GetSessions();
  $("#getid").text("masood");
});

function GetCourseName(id) {
    
}

function GetSessions() { 
  $.ajax({
    url: "/Semester/GetAlllSessions",
    async:false,
    success: function (resp) {
       var  html = "";
        html +=
    '<div class="card card-custom gutter-b example example-compact">' +
    '<div class="card-header">' +
    '<h3 class="card-title" id="getid">DCN</h3>' +
    '</div>'+
    '<div class="card-body">';
      $(resp).each(function (indexInArray, item) {
          html+=
          '<div class="row">'+
              '<div class="col-lg-9">'+
                 ' <h4><i class="fa fa-angle-right"></i>'+item.sessionName+'</h4>'+
             ' </div>'+
              '<div class="col-lg-3">'+
                  '<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Add an Activity or resource</button>'+
                  '<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">'+
                      '<div class="modal-dialog" role="document">'+
                          '<div class="modal-content">'+
                              '<div class="modal-header">'+
                                  '<h5 class="modal-title" id="exampleModalLabel">All Activities</h5>'+
                                  '<button type="button" class="close" data-dismiss="modal" aria-label="Close">'+
                                      '<span aria-hidden="true">&times;</span>'+
                                  '</button>'+
                              '</div>'+
                              '<div class="modal-body">'+
                                  '<button type="button" class="btn btn-default col-lg-3">'+
                                      '<i class="fa fa-user"></i><br />Attendence'+
                                  '</button>'+
                                  '<button type="button" class="btn btn-default col-lg-3">'+
                                      '<i class="fa fa-comments"></i><br />Chat'+
                                  '</button>'+
                                  '<button type="button" class="btn btn-default col-lg-3">'+
                                      '<i class="fa fa-book"></i><br />Assignment'+
                                  '</button>'+
                                  '<button type="button" class="btn btn-default col-lg-3">'+
                                      '<i class="fa fa-check"></i><br />Checklist'+
                                  '</button>'+
                                  '<button type="button" class="btn btn-default col-lg-3">'+
                                      '<i class="fa fa-bullhorn"></i><br />Quiz'+
                                  '</button>'+
                                  '<button type="button" class="btn btn-default col-lg-3">'+
                                      '<i class="fa fa-folder-open"></i><br />Folder'+
                                  '</button>'+
                                  '<button type="button" class="btn btn-default col-lg-3">'+
                                      '<i class="fa fa-desktop"></i><br />Url'+
                                  '</button>'+
                                 ' <button type="button" class="btn btn-default col-lg-3">'+
                                      '<i class="fa fa-book"></i><br />Lesson'+
                                 ' </button>'+
                                  '<button type="button" class="btn btn-default col-lg-3">'+
                                      '<i class="fa fa-upload"></i><br />Quiz'+
                                  '</button>'+
                              '</div>'+
                              '<div class="modal-footer mt">'+
                                  '<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>'+
                              '</div>'+
                          '</div>'+
                      '</div>'+
                  '</div>'+
              '</div>'+
          '</div>'+
          '<hr>'
      });
      html += '</div></div>'
      
    $("#data").append(html);
    },
  });
  
}
