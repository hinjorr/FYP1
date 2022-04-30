$(document).ready(function () {

    GetAllUsers()
    UnReadMessages()
    SentMessages()
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
                 <div class="d-flex flex-column align-items-end">
                 </div> 
             </div>`
            });
            $("#all_users").html(html);
        }
    });
}


var UserTo = 0;
var myInterval = null;
function oPenChat(userId) {
    $("#kt_chat_content").show();
    _chatContentEl = KTUtil.getById('kt_chat_content');
    KTLayoutChat.setup(KTUtil.getById('kt_chat_content'));
    UserTo = userId
    myInterval = setInterval(function () {
        GetChat(UserTo)
    }, 1000);
}
clearInterval(myInterval);


function GetChat(userId) {
    console.log(UserTo)
    $.ajax({
        url: "/Chat/OpenChat?UserId=" + userId,
        success: function (resp) {
            UnReadMessages()
            $("#chat_pic").html(`<img alt="Pic" src="` + resp.profile.picture + `">`);
            $("#chat_name").html(resp.profile.name);
            $.ajax({
                url: "/Chat/GetMessages?UserId=" + userId,
                success: function (resp) {
                    var html = ""
                    $(resp).each(function (indexInArray, item) {
                        if (item.mine == true) {
                            html += ` <div class="d-flex flex-column mb-5 align-items-end">
                            <div class="d-flex align-items-center">
                                <div>
                                    <span class="text-muted font-size-sm">`+ item.timespan + `</span>
                                   
                                </div>
                                <div class="symbol symbol-circle symbol-40 ml-3">
                                  
                                </div>
                            </div>
                            <div
                                class="mt-2 rounded p-5 bg-light-primary text-dark-50 font-weight-bold font-size-lg text-right max-w-400px">
                                `+ item.body + `</div>
                        </div>`
                        }
                        else {
                            html += `<div class="d-flex flex-column mb-5 align-items-start">
                            <div class="d-flex align-items-center">
                                <div class="symbol symbol-circle symbol-40 mr-3">
                                </div>
                                <div>
                                   
                                    <span class="text-muted font-size-sm">`+ item.timespan + `</span>
                                </div>
                            </div>
                            <div
                                class="mt-2 rounded p-5 bg-light-success text-dark-50 font-weight-bold font-size-lg text-left max-w-400px">
                               `+ item.body + `
                            </div>
                        </div>`
                        }
                    });
                    $("#_chating").html(html);
                }
            });
        }
    });
}

$("#btnSendMsg").click(function (e) {
    SendMessage()
});


function SendMessage() {
    var Message = {}
    Message.UserTo = UserTo
    Message.Body = $("#body_txt").val();
    $.ajax({
        type: "Post",
        url: "/Chat/SendMessage",
        data: Message,
        success: function (response) {
            SentMessages()
            UnReadMessages()
            $("#body_txt").val(" ");
        }
    });
}



function UnReadMessages() {
    $.ajax({
        url: "/Chat/UnReadMessages",
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
                 <div class="d-flex flex-column align-items-end">
                 <span class="text-muted font-weight-bold font-size-sm">`+ item._Message.timespan + `</span>`
                if (item._Message.totalUnread > 0) {
                    html += ` <span class="label label-sm label-success">` + item._Message.totalUnread + `</span>`
                }

                html += `</div>
             </div>`
            });
            $("#unReadsers").html(html);
        }
    });
}

function SentMessages() {
    $.ajax({
        url: "/Chat/Sent_Messages",
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
                 <div class="d-flex flex-column align-items-end">
                 <span class="text-muted font-weight-bold font-size-sm">`+ item._Message.timespan + `</span>
                 </div>
             </div>`
            });
            $("#msg_receivers").html(html);
        }
    });
}
