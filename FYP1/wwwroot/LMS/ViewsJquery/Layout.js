$(document).ready(function () {
  CommonFunctions.GetCurrentSemester();
  // Notifications()
  setInterval(Notifications, 5000)
});


function Notifications() {

  $.ajax({
    url: "/Notfication/ReceiveNotifications",
    success: function (resp) {
      if (resp[0] != null) {
        for (let index = 0; index < resp.length; index++) {
          if (resp[index].notificationTo.isSeen == false) {
            $("#_pulses").show();
            break;
          }
          else {
            $("#_pulses").hide();
            break;
          }
        }

        var html = ""
        $(resp).each(function (indexInArray, item) {
          html += `<a href="/viewclass/` + item.notification.classId + `" class="navi-item">
        <div class="navi-link">
          <div class="navi-icon mr-2">
          <img src="`+ item.notificationType.icon + `"/>
          </div>
          <div class="navi-text">`
          if (item.notificationTo.isSeen == false) {
            html += ` <div class="font-weight-bold font-size-lg">` + item.notification.from + `</div>
                     <div class="font-weight-bold">`+ item.notification.message + `</div>`
          }
          else {
            html += ` <div class="text-muted font-size-lg">` + item.notification.from + `</div>
          <div class="text-muted">`+ item.notification.message + `</div>`
          }

          html += ` <div class="text-muted">` + item.notification.timespan + `</div>
          </div >
        </div >
      </a > `
        });
        $("#server_notfications").html(html);
      }
      else {
        $("#emtpyRead").click();
      }

    }
  });
}

$("#mark_read").click(function (e) {
  $.ajax({
    url: "/Notfication/MarkAsReadNotifications",
    success: function (resp) {
      Notifications()
    }
  });
});