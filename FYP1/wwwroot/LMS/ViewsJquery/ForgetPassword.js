var _handleForgotForm = function (e) {
    var validation;

    // Init form validation rules. For more info check the FormValidation plugin's official documentation:https://formvalidation.io/
    validation = FormValidation.formValidation(
        KTUtil.getById("kt_login_forgot_form"),
        {
            fields: {
                fg_email: {
                    validators: {
                        notEmpty: {
                            message: "Email address is required",
                        },
                        emailAddress: {
                            message: "The value is not a valid email address",
                        },
                    },
                },
                fg_username: {
                    validators: {
                        notEmpty: {
                            message: "Username is required",
                        }
                    },
                },
            },
            plugins: {
                trigger: new FormValidation.plugins.Trigger(),
                bootstrap: new FormValidation.plugins.Bootstrap(),
            },
        }
    );

    // Handle submit button
    $("#forget_btn").on("click", function (e) {
        e.preventDefault();

        validation.validate().then(function (status) {
            if (status == "Valid") {
                var email = $("input[name=fg_email]").val();
                var username = $("input[name=fg_username]").val();
                SendEmail(email, username);
                KTUtil.scrollTop();
            }
        });
    });
};

function SendEmail(email, username) {
    $.ajax({
        url: "/Authentication/ForgetPassword?username=" + username + "&email=" + email,
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
                .then(function () {
                    // $("#btnmodal_").click();
                     $('#AssignmentModal').modal('show');
                    // $("#kt_login_signin_submit").removeClass("spinner spinner-white spinner-right");
                });
        }
    });
}