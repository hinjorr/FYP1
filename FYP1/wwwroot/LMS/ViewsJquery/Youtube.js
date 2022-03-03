
var access_token = localStorage.getItem("AccessToken")
var _data = {
    "snippet": {
        "title": "",
        "description": "No Description",
        "categoryId": 27
    },
    "status": {
        "privacyStatus": "public",
        "embeddable": "True",
    }
}
function UploadVideo(file) {
    var file_name = file.name.split(".")
    _data.snippet.title = file_name[0];
    $.ajax({
        type: "POST",
        url: "https://www.googleapis.com/upload/youtube/v3/videos?uploadType=resumable&part=snippet,status",
        data: _data,    
        contentType: "application/json; charset=UTF-8",
        headers: {
            "Authorization": "Bearer " + access_token,
            "x-upload-content-type": "video/*",
            "X-Upload-Content-Length": file.size,
        },
        success: function (resp, status, xhr) {
            console.log(status)
            console.log(xhr.status)
            console.log(xhr.getResponseHeader("Location"))
            console.log(xhr.getAllResponseHeaders())
        }
    });
}
