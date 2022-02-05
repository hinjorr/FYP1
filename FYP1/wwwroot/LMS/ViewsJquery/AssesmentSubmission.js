$(document).ready(function () {
    var url = $(location).attr('href').split('/');
    var classId = url[url.length - 2]
    var assesmentId = url[url.length - 1]
    GetAssesmentDeatils(assesmentId)
    role = $("#GetUsersRole").text();
    if (role == "Student") {
        SubmissionAreaHTML()
        _DropZone(assesmentId)
        GetUploadedAssesment(assesmentId)
    }
    else {
        StudentsSubmissionListHTML(classId, assesmentId)
    }
});

var role;
var data = new FormData();

function GetAssesmentDeatils(id) {
    $.ajax({
        url: "/ClassContent/GetAssesmentDetail?id=" + id,
        success: function (resp) {
            var date = new Date(Date.parse(resp.assesment.end))
            date = date.toLocaleString('en-us', { weekday: 'long' }) + " , " + date.getDate() + " " + date.toLocaleString('default', { month: 'long' }) + " " + date.getFullYear() + " , " + date.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true })
            $("#due_date").text(date);
            $("#assesment_name").text(resp.assesment.assesmentName);
            $(".assesment_description").text(resp.assesment.description);
            $("#course_header").text(resp.course.fullName + " " + resp.course.courseId);
            if (resp.assesmentAttachmentList[0] != null) {
                var html = `<br><br><h3 class="card-label">Attachment(s)</h3><ul>`
                $(resp.assesmentAttachmentList).each(function (indexInArray, item) {
                    html += `<li><a href="` + item.path + `" target="_blank">` + item.displayName + `</a></li>`
                });
                html += "</ul>"
                $(".assesment_description").append(html);
            }
        }
    });
}

function SubmissionAreaHTML() {
    var html = `  <div class="card card-custom">
    <div class="card-header">
        <div class="card-title">
            <!-- <span class="card-icon">
                <i class="flaticon2-chat-1 text-primary"></i>
            </span> -->
            <h3 class="card-label">Your Work
            </h3>
        </div>
        <!-- <div class="card-toolbar">
            <a href="#" class="btn btn-sm btn-success font-weight-bold">
                <i class="flaticon2-cube"></i>Reports</a>
        </div> -->
    </div>
    <div class="card-body" >
    <div id="SubmittedFile"></div>
    <div class="dropzone dropzone-default dropzone-success" id="assesment_submission">
    <div class="dropzone-msg dz-message needsclick">
        <h3 class="dropzone-msg-title" >Drop file here or click to upload.</h3>
        <span class="dropzone-msg-desc" style="color:#d30b2f">Only pdf and single file is allowed for upload</span>
    </div>
</div>
    </div>
    <div class="card-footer d-flex justify-content-between" id="submitBtnDiv">
        <button class="btn btn-light-primary font-weight-bold btn-lg btn-block" id="assesmentSubmitBtn" onClick="SubmitAssesment()">Submit</button>
    </div>
</div>`
    $("#submission_area").html(html);

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
                data: "assesmentSubmission.filePath", render: function (data, type, row) {
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
                        return `Not available`
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
    $.ajax({
        type: "Post",
        url: "/ClassContent/AssesmentSubmission",
        data: data,
        contentType: false,
        processData: false,
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
        }
    });
}

function _DropZone(assesmentId) {
    $('#assesment_submission').dropzone({
        url: "#",
        paramName: "file",
        maxFiles: 1,
        maxFilesize: 10,
        addRemoveLinks: true,
        acceptedFiles: "application/pdf,",
        accept: function (file, done) {
            data.append("Attachment", file)
            data.append("AssesmentId", assesmentId)
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
                $("#SubmittedFile").html(`<a href="` + resp.assesmentSubmission.filePath + `" target="_blank"><img src="https://img.icons8.com/color/50/4a90e2/check-file.png" style="height: 30px;"/>` + resp.assesmentSubmission.displayName + `</a>`);
                $("#submitBtnDiv").append(`<button class="btn btn-light-danger font-weight-bold btn-lg btn-block" onClick="resubmitBtnfn()" id="resubmitBtn">Resubmit</button>`);
                $("#assesmentSubmitBtn").hide();
                $("#assesment_submission").hide();
            }
        }
    });
}

function resubmitBtnfn() {
    $("#assesmentSubmitBtn").show();
    $("#assesment_submission").show();
    $("#resubmitBtn").hide();
    $("#SubmittedFile").hide();
}