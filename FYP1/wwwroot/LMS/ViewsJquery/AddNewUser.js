$(document).ready(function () {
    $("#btnSubmit").click(function () {
        var UserDetails = {
            Name: $("#txtName").val(),
            FatherName: $("#txtFatherName").val(),
            Number: $("#txtNumber").val(),
            Role: $("#dpdownRole").val(),
            Email: $("#txtEmail").val(),
            Password: $("#txtPassword").val(),
            Nic: $("#txtNic").val(),
            MaleRadio: $("#rad1").val(),
            WomenRadio: $("#rad2").val(),
            DateOfBirth: $("#timeDOB").val(),
            Address: $("#txtAddress").val(),
            City: $("#txtCity").val(),
            Country: $("#txtCountry").val(),
            Image: $("#Image").val(),
        };
        console.log(UserDetails)

    });
});