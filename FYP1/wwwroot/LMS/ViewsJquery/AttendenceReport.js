$(document).ready(function () {
    $("#btnView").click(function () {
        var AttendenceReport = {
            SelectClass: $("#dpdownSelectClass").val(),
            SelectWeek: $("#dpdownSelectWeek").val(),

        };
        console.log(AttendenceReport)

    });
});