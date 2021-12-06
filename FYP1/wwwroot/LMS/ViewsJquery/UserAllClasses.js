$(document).ready(function () {
    GetAllClasses()
});

function GetAllClasses() {
  $.ajax({
    url: "/AdminClasses/ViewAllClassesinAdmin",
    success: function (resp) {
      var html = "";
      html+='<div class="row">'
      $(resp).each(function (indexInArray, item) {         
        html+='<div class="col-md-4">'
        html+='<div class="card card-custom gutter-b card-stretch">'
        html+='<div class="card-body text-center pt-4">'
        html+='<div class="my-4">'
        html+='<span class="text-dark font-weight-bold  font-size-h5">'+item.program.programShortName+'</span>'
        html+='</div>'
        html+=' <div class="mt-7">'
        html+=' <div class="symbol symbol-circle symbol-lg-90">'
        html+='<img src="/wwwroot/UserImages/1234567800000" alt="image" />'
        html+='</div>'
        html+='</div>'
        html+='<div class="my-4">'
        html+=' <span class="text-dark font-weight-bold  font-size-h3">'+item.course.shortName+'&nbsp;'+item.classId+'</span>'
        html+='</div>'
        html+='<h4 class="my-4">'
        html+='<span class="text-dark font-weight-bold  font-size-h6">'+item.day.dayName+'&nbsp;'+item.time.timeName+'</span>'
        html+='</h4>'
        html+=' <span class="btn btn-text btn-light-success btn-sm font-weight-bold">'+item.isActive+'</span>'
        html+='<div class="mt-9">'
        html+=' <span class="btn btn-light-primary font-weight-bolder btn-sm py-3 px-6 text-uppercase">viewClass</span>'
        html+='</div>'
        html+='</div>'
        html+='</div>'
        html+='</div>'
        html+='</div>'
        html+='</div>'
        html+='</div>'
        
      });
      html+='</div>'
      $("#ClassesCard").append(html);

    },
  });
}
