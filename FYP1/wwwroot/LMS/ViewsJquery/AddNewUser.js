$('#newuser').validate({
    rules: {
        name: "required",
        fathername: "required",
        number: {
            required: true,
        },
        email: {
            required: true,
            email: true
        },
        password: "required",
        nic: {
            required: true,
            minlength: 13
        },
        address: "required",
        city: "required",
        country: "required"
    }, messages: {
        password: "Please enter password",
        name: "Please enter your name",
        fathername: "Please enter father name",
        number: {
            required: "Please enter a Phone Number",
        },
        email: {
            required: "Please enter email",
            email: "Please enter valid email"
        },
        nic: "Please enter 13 digit number",
        address: "Please enter address",
        city: "Please enter city",
        country: "Please entry country"
    },
    submitHandler: function (form) {

        var UserDetails = {
            'Name': $("#txtName").val(),
            'FatherName': $("#txtFatherName").val(),
            'Number': $("#txtNumber").val(),
            'Role': $("#dpdownRole").val(),
            'Email': $("#txtEmail").val(),
            'Password': $("#txtPassword").val(),
            'Nic': $("#txtNic").val(),
            'MaleRadio': $("#rad1").val(),
            'WomenRadio': $("#rad2").val(),
            'DateOfBirth': $("#timeDOB").val(),
            'Address': $("#txtAddress").val(),
            'City': $("#txtCity").val(),
            'Country': $("#txtCountry").val(),
            'Image': $("#Image").val(),
        };
        console.log(UserDetails)
    }
})