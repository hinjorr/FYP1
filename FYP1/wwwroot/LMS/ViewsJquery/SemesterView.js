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
        alert.append("Semester didnt started");
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
  alert(semesterName + " is running");
}
function NoSemester() {
  $("#txtFullname").show();
  $("#lblname").show();
  $("#btnstart").show();
  $("#btnend").hide();
  alert("No semester is running");
}

//Get Currenlty running semester
function GetCurrentSemester() {
  $.ajax({
    url: "/Semester/GetCurrentSemester",
    success: function (resp) {
      // debugger;
      if (resp != null) {
        // debugger;
        (SemesterDTO.SemesterId = resp.semesterId),
          (SemesterDTO.SemesterName = resp.semesterName),
          (SemesterDTO.StartDate = resp.startDate),
          (SemesterDTO.IsActive = resp.isActive);
        YesSemester(resp.semesterName);
      } else {
        NoSemester();
      }
    },
  });
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

$(document).ready(function () {
  GetCurrentSemester();
});
