$(document).ready(function () {
    GetAllUsers()
});

function GetAllUsers() {
    $.ajax({
        url: "/Chat/GetAllUsers",
        success: function (resp) {
            var html = ""
            $(resp).each(function (indexInArray, item) {
                html += `<div class="d-flex align-items-center justify-content-between mb-5">
                 <div class="d-flex align-items-center">
                     <div class="symbol symbol-circle symbol-50 mr-3">
                         <img alt="Pic" src="`+ item.profile.picture + `" />
                     </div>
                     <div class="d-flex flex-column">
                         <a onClick="oPenChat(`+ item.user.userId + `)" style=" cursor: pointer;"
                             class="text-dark-75 text-hover-primary font-weight-bold font-size-lg">`+ item.user.userName + ` ` + item.profile.name + `</a>
                         <span class="text-muted font-weight-bold font-size-sm">`+ item.role.roleName + `</span>
                     </div>
                 </div>
                 <!--<div class="d-flex flex-column align-items-end">
                     <span class="text-muted font-weight-bold font-size-sm">35 mins</span>
                 </div> -->
             </div>`
            });
            $("#all_users").html(html);
        }
    });
}

function oPenChat(userId) {
    GetChat(userId)
}

function GetChat(userId) {
    $.ajax({
        url: "/Chat/SingleChat?UserId=" + userId,
        success: function (resp) {
            $("#chat_pic").html(`<img alt="Pic" src="` + resp.profile.picture + `">`);
            $("#chat_name").html(resp.profile.name);
        }
    });
}