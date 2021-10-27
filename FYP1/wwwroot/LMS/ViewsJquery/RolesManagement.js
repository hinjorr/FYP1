$(document).ready(function () {
    $("#btnSubmit").click(function () {
        var RoleManagement = {
            DropDownRoles: $("#dpdownRoles").val(),
            NewUser: $("#cbNewUser").val(),
            ViewAllUsers: $("#cbViewAllUsers").val(),
            BulkUsers: $("#cbBulkUsers").val(),
            AssignNewCourse: $("#cbAssignNewCourse").val(),
            AddNewCourse: $("#cbAddNewCourse").val(),
            EnrollUser: $("#cbEnrollUser").val(),
            Roles: $("#cbRoles").val(),
            Program: $("#cbProgram").val(),
            CurrentClasses: $("#cbCurrentClasses").val(),
            RegisteredCourses: $("#cbRegisteredCourses").val(),
            TestResults: $("#cbTestResults").val(),
            UploadResults: $("#cbUploadResults").val(),
            
        };
        console.log(RoleManagement)

    });
});