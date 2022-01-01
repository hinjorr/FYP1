var CommonFunctions = {
  GetPrograms: function (id) {
    //display Programs List
    $.ajax({
      type: "Get",
      url: "/General/GetPrograms",
      success: function (resp) {
        var html = "";
        html += "<option value='0'>Select Program</option>";
        $(resp).each(function (indexInArray, item) {
          html +=
            "<option value=" +
            item.programId +
            ">" +
            item.programShortName +
            "</option>";
        });
        $(id).append(html);
      },
    });
  },
  GetRoles: function (id) {
    $.ajax({
      type: "Get",
      url: "/General/GetRoles",
      success: function (resp) {
        var html = "";
        html += "<option value='0'>Select Role</option>";
        $(resp).each(function (index, item) {
          html +=
            "<option value=" + item.roleId + ">" + item.roleName + "</option>";
        });
        $(id).append(html);
      },
    });
  },
  GetDays: function (id) {
    $.ajax({
      url: "/General/GetDays",
      success: function (resp) {
        var html = "";
        html += "<option value='0'>Select Day</option>";
        $(resp).each(function (index, item) {
          html +=
            "<option value=" + item.dayId + ">" + item.dayName + "</option>";
        });
        $(id).append(html);
      },
    });
  },
  GetTime: function (id) {
    $.ajax({
      url: "/General/GetTime",
      success: function (resp) {
        var html = "";
        html += "<option value='0'>Select Time</option>";
        $(resp).each(function (index, item) {
          html +=
            "<option value=" + item.timeId + ">" + item.timeName + "</option>";
        });
        $(id).append(html);
      },
    });
  },
  GetCourse: function (id) {
    $.ajax({
      url: "/General/GetCourses",
      success: function (resp) {
        var html = "";

        $(resp).each(function (index, item) {
          html +=
            "<option value=" +
            item.courseId +
            ">" +
            item.shortName +
            "</option>";
        });
        $(id).append(html);
      },
    });
  },
  GetCoursesFullName: function (id) {
    $.ajax({
      url: "/General/GetCoursesFullName",
      success: function (resp) {
        var html = "";

        $(resp).each(function (index, item) {
          html +=
            "<option value=" +
            item.courseId +
            ">" +
            item.fullName +
            "</option>";
        });
        $(id).append(html);
      },
    });
  },
  GetCoursesbyPrograms: function (dpid, pid) {
    $.ajax({
      url: "/GetCoursesbyPrograms?id=" + pid,
      success: function (resp) {
        var html = "";
        html += "<option value='0'>Select Course</option>";
        $(resp).each(function (index, item) {
          html +=
            "<option value=" +
            item.courseId +
            ">" +
            item.courses.fullName +
            "</option>";
        });
        $(dpid).html(html);
      },
    });
  },
  GetCurrentSemester: function () {
    return $.ajax({
      async:false,
      url: "/Semester/GetCurrentSemester",
      success: function (resp) {
        var data = JSON.stringify(resp);
        localStorage.setItem("SemesterDetails", data);
      },
    });
  },
  GetAllActiveCourses: function (id) {
    $.ajax({
      url: "/Classes/ViewAllActiveCourses",
      success: function (resp) {
        var html = "<option value=0>Select Course</option>";
        $(resp).each(function (indexInArray, item) {
          html +=
            "<option value=" +
            item.courseId +
            ">" +
            item.fullName +
            "</option>";
        });
        $(id).append(html);
      },
    });
  },
};
