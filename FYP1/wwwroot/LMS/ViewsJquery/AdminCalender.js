$(document).ready(function () {
    GetCalender()
});

function GetCalender() {
    $("#_schedule").DataTable({
        ajax: {
            url: "/User/GetCalender",
            dataType: "json",
            type: "Get"
        },
        paging: false,
        columns: [
            { data: "day.dayName" },
            { data: "time.timeName" },
            { data: "course.fullName" },
            { data: "classes.classId" },
        ],
    })
}