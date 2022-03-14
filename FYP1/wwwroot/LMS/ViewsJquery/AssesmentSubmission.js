$(document).ready(function () {
    var url = $(location).attr('href').split('/');
    var classId = url[url.length - 2]
    assesmentId = url[url.length - 1]
    GetAssesmentDeatils(assesmentId)
    role = $("#GetUsersRole").text();
    if (role == "Student") {
        _DropZone(assesmentId)
        GetUploadedAssesment(assesmentId)
    }
    else {
        $("#submission_area").remove();
        StudentsSubmissionListHTML(classId, assesmentId)
    }
});
var assesmentId;
var role;
var data = new FormData();

function GetAssesmentDeatils(id) {
    $.ajax({
        url: "/ClassContent/GetAssesmentDetail?id=" + id,
        success: function (resp) {
            var curenttime = Math.floor(Date.now() / 1000)
            if (curenttime > resp.assesment.unixTime) {
                console.log(curenttime)
                $("#due_date").text(resp.assesment.endString).css("color", "#ff001b")
                if (resp.assesment.lateSubmission == true) {
                    $("#assesment_submission").remove();
                    $("#resubmitBtn").remove();
                    $("#assesmentSubmitBtn").remove();
                }
            }
            else {
                $("#due_date").text(resp.assesment.endString)
            }
            $("#due_date").text(resp.assesment.endString)
            $("#assesment_name").text(resp.assesment.assesmentName);
            $(".assesment_description").text(resp.assesment.description);
            $("#course_header").text(resp.course.fullName + " " + resp.course.courseId);
            if (resp.assesmentAttachmentList[0] != null) {
                var html = `<br><br><h3 class="card-label">Attachment(s)</h3><ul>`
                $(resp.assesmentAttachmentList).each(function (indexInArray, item) {
                    html += `<li><a href="` + item.link + `" target="_blank">` + item.displayName + `</a></li>`
                });
                html += "</ul>"
                $(".assesment_description").append(html);
            }
        }
    });
}



function StudentsSubmissionListHTML(classId, AssesmentId) {
    var html = ` <div class="col-lg-12">
    <div class="card card-custom">
        <div class="card-header">
            <h3 class="card-title">Class Students</h3>
        </div>
        <div class="card-body">
            <!--begin: Datatable-->
            <table class="table table-bordered table-hover table-checkable mt-10" id="SubmisionStudents">
                <thead>
                    <tr>
                        <th>Picture</th>
                        <th>Username</th>
                        <th>Name</th>
                        <th>File</th>
                        <th>Submission Time</th>
                        <th>Marks</th>
                    </tr>
                </thead>
            </table>
            <!--end: Datatable-->
        </div>
    </div>
</div>`
    $("#submission_list").html(html);
    StudentsSubmissionList(classId, AssesmentId)
}

function StudentsSubmissionList(classId, AssesmentId) {
    $("#SubmisionStudents").DataTable({
        ajax: {
            url: "/ClassContent/AssesmentStudents?class_id=" + classId + "&assesment_id=" + AssesmentId,
            type: "Get",
            datatype: "json",
        },
        paging: false,
        columns: [
            {
                data: "profile.picture",
                render: function (picture) {
                    return (
                        '<div class="symbol symbol-50 flex-shrink-0">' +
                        '<img src="' +
                        picture +
                        '">' +
                        "</div>"
                    );
                },
            },
            { data: "user.userName" },
            { data: "profile.name" },
            {
                data: "assesmentSubmission.link", render: function (data, type, row) {
                    if (data != null) {
                        return `<a href="` + data + `" target="_blank">` + row.assesmentSubmission.displayName + `</a>`
                    }
                    else {
                        return `<a class="label label-lg font-weight-bold label-light-danger label-inline">Not Submitted</a>`
                    }
                }
            },
            {
                data: "assesmentSubmission.submissionTime", render: function (data, type, row) {
                    if (data == null) {
                        return ``
                    }
                    else {
                        var date = new Date(Date.parse(data))
                        date = date.toLocaleString('en-us', { weekday: 'long' }) + " , " + date.getDate() + " " + date.toLocaleString('default', { month: 'long' }) + " " + date.getFullYear() + " , " + date.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true })
                        if (row.assesmentSubmission.lateSubmit == true) {
                            return `<span style="color:#f71b1b">` + date + `</span>`
                        }
                        else {
                            return date;
                        }
                    }
                }
            },
            { data: "marks.obtainedMakrs" },


        ],
    });


}

function SubmitAssesment() {
    $("#UpladingProgress").show();
    $.ajax({
        type: "Post",
        url: "/ClassContent/AssesmentSubmission",
        data: data,
        contentType: false,
        processData: false,
        success: function (resp) {
            $("#UpladingProgress").hide();
            // GetUploadedAssesment(assesmentId)
            swal
                .fire({
                    text: resp.text,
                    icon: resp.icon,
                    buttonsStyling: false,
                    confirmButtonText: "Ok, got it!",
                    customClass: {
                        confirmButton: "btn font-weight-bold btn-light-primary",
                    },
                }).then(function () {
                    location.reload()
                });
        }
    });
}

function _DropZone(assesmentId) {
    $('#assesment_submission').dropzone({
        url: "#",
        paramName: "file",
        maxFiles: 1,
        maxFilesize: 200,
        addRemoveLinks: true,
        // acceptedFiles: "application/pdf,",
        accept: function (file, done) {
            data.append("Attachment", file)
            data.append("AssesmentId", assesmentId)
            done();
            //done("sakjdh")
        }

    });
}


function GetUploadedAssesment(assesmentId) {
    $.ajax({
        url: "/ClassContent/GetSingleAssesment?assesment_id=" + assesmentId,
        success: function (resp) {
            if (resp.text != null) {
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
            }
            else {
                if (resp.assesmentSubmission.filePath != null) {
                    $("#SubmittedFile").html(`<a href="` + resp.assesmentSubmission.link + `" target="_blank"><img src="https://img.icons8.com/color/50/4a90e2/check-file.png" style="height: 30px;"/>` + resp.assesmentSubmission.displayName + `</a>`);
                    $("#resubmitBtn").show();
                    $("#assesmentSubmitBtn").hide();
                    $("#assesment_submission").hide();
                }
            }
        }
    });
}

$("#resubmitBtn").click(function (e) {
    $("#assesmentSubmitBtn").show();
    $("#assesment_submission").show();
    $("#resubmitBtn").hide();
    $("#SubmittedFile").hide();
});
