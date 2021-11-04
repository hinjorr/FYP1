var CommonFunctions = {
  GetPrograms: function (id) {
    //display Programs List
    $.ajax({
      type: "Get",
      url: "/DropDown/GetPrograms",
      success: function (resp) {
        var html = "";
        html += "<option value='0'>Select Program</option>";
        $(resp).each(function (indexInArray, items) {
          html +=
            "<option value=" +
            items.programId +
            ">" +
            items.programShortName +
            "</option>";
        });
        $(id).append(html);
      },
    });
  },
  GetRoles: function (id) {
    $.ajax({
      type: "Get",
      url: "/DropDown/GetRoles",
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
      url: "/DropDown/GetDays",
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
      url: "/DropDown/GetTime",
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
};
