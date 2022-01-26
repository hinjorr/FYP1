$(document).ready(function () {
  GetSessions()
  CommonFunctions.GetCurrentSemester();
  if (CommonFunctions.SemesterDTO.SemesterId != null) {
    SemesterDTO.SemesterId = CommonFunctions.SemesterDTO.SemesterId
    IsSemester()
  }
  else {
    NotSemester()
  }
});
SemesterDTO = {}


$("#newsemster").validate({
  rules: {
    Fullname: "required",
  },
  messages: {
    Fullname: {
      required: "Please enter Semester name",
    },
  },
  submitHandler: function (form) {
    SemesterDTO.SemesterName = $("#txtFullname").val(),
      AddSemester(SemesterDTO);
  },
});

function AddSemester(SemesterDTO) {
  $.ajax({
    type: "Post",
    url: "/Semester/StartSemester",
    data: SemesterDTO,
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
          if (resp.icon != "error") {
            IsSemester()
            CommonFunctions.GetCurrentSemester();
            SemesterDTO.SemesterId = CommonFunctions.SemesterDTO.SemesterId

          }
        });
    },
  });
}

//Close the semeter
$("#btnend").click(function (e) {
  $.ajax({
    type: "Post",
    url: "/Semester/EndSemester",
    data: SemesterDTO,
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
          if (resp.icon != "error") {
            NotSemester()
            CommonFunctions.GetCurrentSemester();
          }
        });
    },
  });

});

function IsSemester() {
  $("#txtFullname").hide();
  $("#lblname").hide();
  $("#btnstart").hide();
  $("#btnend").show();
}

function NotSemester() {
  $("#txtFullname").show();
  $("#lblname").show();
  $("#btnstart").show();
  $("#btnend").hide();
}


var ClassSessionDTO = [];

$(document).on("click", ".btnadd", function () {
  $(".trClone:first").clone().appendTo("#tblSessions");
  // Select();  
});
$(document).on("click", ".btnremove", function () {
  $(this).closest(".trClone").remove();
});
$("#btnsubmit").click(function (e) {
  var SemesterId = SemesterDTO.SemesterId;
  $("#tblSessions tr").each(function (indexInArray, tr) {
    var dto = {};
    if (indexInArray != 0) {
      dto.SemesterID = SemesterId;
      dto.SessionName = $(this).find("td:eq(0) input[type='text']").val();
      ClassSessionDTO.push(dto);
    }
  });
  SendData();
});
function SendData() {
  $.ajax({
    type: "Post",
    url: "/Semester/AddClassSessions",
    data: { dto: ClassSessionDTO },
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
          if (resp.icon != "error") {
            GetSessions()
            while (ClassSessionDTO.length > 0) {
              ClassSessionDTO.pop();
            }
          }
        });
    },
  });
}


function GetSessions() {
  var html = "";
  html += `<thead>
           <tr>
           <th>Session Name</th>
           </tr>
           </thead>`;
  $.ajax({
    url: "/Semester/GetAlllSessions",
    success: function (resp) {
      if (resp != null) {
        $(resp).each(function (indexInArray, item) {
          html += `<tr class="trClone">`;
          html +=
            `<td><input type="text" class="form-control SessionName" value="` +
            item.sessionName +
            `"></td>`;
          html += `<td> <button
          class="btn btn-danger btn-sm btnremove">-</i></button></td>`;
          html += `</tr>`;
        });
        $("#tblSessions").html(html);

      }
    },
  });
}
