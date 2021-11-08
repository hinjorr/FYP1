$.validator.addMethod('le', function (value, element, param) {
    return this.optional(element) || value <= $(param).val();
}, 'Invalid value');

$("#Upload").validate({
    rules: {

        obtainedmarks: {
            required: true,
            digits: true,
            le: '#txtTotalMarks',
        },
        totalMarks: {
            required: true,
            digits: true,
        },
        //
    },
    messages: {
        totalMarks: {
            required: "Please enter Total Marks",
            digits: "Please enter Digits",

        },
        obtainedmarks: {
            required: "Please enter Obtained Marks",
            digits: "Please enter Digits",
            le: 'Must be less than or equal to Total Marks',
        },
    },
    submitHandler: function (form) {

        var UploadRes = {
            TotalMarks: $("#txtTotalMarks").val,
            ObtainedMarks: $("#txtObtainedMarks").val,
        };
        console.log(UploadRes);

    }

})