$(document).ready(function () {
  GetCurrentSemester();
  GetSessions();
  $(".SemesterName").text();
});

//Get Currenlty running semester
function GetCurrentSemester() {
  var semester = JSON.parse(localStorage.getItem("SemesterDetails"));
  if (semester != undefined) {
    (SemesterDTO.SemesterId = semester.semesterId),
      (SemesterDTO.SemesterName = semester.semesterName),
      (SemesterDTO.StartDate = semester.startDate),
      (SemesterDTO.IsActive = semester.isActive);
    YesSemester(semester.semesterName);
  } else {
    NoSemester();
  }
}

var SemesterDTO = {
  SemesterId: 0,
  SemesterName: "",
  StartDate: "",
  EndDate: "",
  IsActive: "",
};

//Close the semeter
$("#btnend").click(function (e) {
  // debugger;
  if (SemesterDTO.SemesterId != 0) {
    $.ajax({
      type: "Post",
      url: "/Semester/EndSemester",
      data: SemesterDTO,
      success: function (resp) {
        if (resp == true) {
          localStorage.removeItem("SemesterDetails");
          CheckSemester();
          NoSemester();
        } else {
          alert("Cant close semester");
        }
      },
    });
  } else {
    alert("Cant close semester");
  }
});

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
        var rows = $("#tblSessions tr").length;
        console.log(rows - 1);
      }
    },
  });
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
  var SemesterID = SemesterDTO.SemesterId;
  if (SemesterID != 0) {
    $("#tblSessions tr").each(function (indexInArray, tr) {
      var dto = {};
      if (indexInArray != 0) {
        dto.SemesterID = SemesterID;
        dto.SessionName = $(this).find("td:eq(0) input[type='text']").val();
        ClassSessionDTO.push(dto);
      }
    });

    SendData();
  } else {
    cuteToast({
      type: "error",
      message: "Register a new Semester First",
      timer: 3000,
    });
  }
});
function SendData() {
  $.ajax({
    type: "Post",
    url: "/Semester/AddClassSessions",
    data: { dto: ClassSessionDTO },
    success: function (resp) {
      cuteToast({
        type: resp.type,
        message: resp.msg,
        timer: 3000,
      });
    },
  });
  while (ClassSessionDTO.length > 0) {
    ClassSessionDTO.pop();
  }
}

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
    var SemesterDTO = {
      SemesterName: $("#txtFullname").val(),
    };
    AddSemester(SemesterDTO);
  },
});

function AddSemester(SemesterDTO) {
  $.ajax({
    type: "Post",
    url: "/Semester/StartSemester",
    data: SemesterDTO,
    success: function (resp) {
      // debugger;
      if (resp == true) {
        GetCurrentSemester();
      } else {
        cuteToast({
          type: "error",
          message: "Semester didnt started",
          timer: 3000,
        });
      }
      // $('#newsemster').trigger("reset");
    },
  });
}

function YesSemester(semesterName) {
  // debugger;
  $("#txtFullname").hide();
  $("#lblname").hide();
  $("#btnstart").hide();
  $("#btnend").show();
  cuteToast({
    type: "error",
    message: semesterName + " is running",
    timer: 5000,
  });
}
function NoSemester() {
  $("#txtFullname").show();
  $("#lblname").show();
  $("#btnstart").show();
  $("#btnend").hide();
  cuteToast({
    type: "error",
    message: "No semester is running",
    timer: 5000,
  });
}
