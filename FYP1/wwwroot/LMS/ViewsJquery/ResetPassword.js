$(document).ready(function () {
    CheckStamp()
    _handleSignUpForm()
});

var _handleSignUpForm = function (e) {
    var validation;
    var form = KTUtil.getById("kt_login_signup_form");

    // Init form validation rules. For more info check the FormValidation plugin's official documentation:https://formvalidation.io/
    validation = FormValidation.formValidation(form, {
        fields: {
            password: {
                validators: {
                    notEmpty: {
                        message: "Password is required",
                    },
                },
            },
            cpassword: {
                validators: {
                    notEmpty: {
                        message: "Password confirmation is required",
                    },
                    identical: {
                        compare: function () {
                            return form.querySelector('[name="password"]').value;
                        },
                        message: "Password is not same",
                    },
                },
            }
        },
        plugins: {
            trigger: new FormValidation.plugins.Trigger(),
            bootstrap: new FormValidation.plugins.Bootstrap(),
        },
    });

    $("#kt_login_signup_submit").on("click", function (e) {
        e.preventDefault();

        validation.validate().then(function (status) {
            if (status == "Valid") {
                SendData()
            }
        });
    });

};


function CheckStamp() {
    var route = window.location.href;
    var code = route.substring(route.lastIndexOf("/") + 1);
    code = code.split("-")
    var timestamp = code[0]
    var curenttime = Math.floor(Date.now() / 1000)
    console.log(curenttime)
    if (curenttime > timestamp) {
        swal
            .fire({
                text: "Link Expired",
                icon: "error",
                buttonsStyling: false,
                confirmButtonText: "Ok, got it!",
                customClass: {
                    confirmButton: "btn font-weight-bold btn-light-primary",
                },
            })
            .then(function () {
                location.replace("/Home")
            });
    }
    else {
        dto.UserId = code[1]
    }
}
var dto = {}

function SendData() {
    dto.Password = $("input[name=password]").val();
    $.ajax({
        url: "/Authentication/ResetPassword",
        data: dto,
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
                    location.replace("/Home")
                });
        }
    });
}
