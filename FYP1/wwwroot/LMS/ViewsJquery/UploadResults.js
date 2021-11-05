
$.validator.addMethod('ge', function (value, element, param) {
    return this.optional(element) || value >= $(param).val();
}, 'Invalid value');

$("#Upload").validate({
    rules: {
        totalMarks: {
            required: true,
            digits: true,
        },
        obtainedmarks: {
            required: true,
            digits: true,
            ge: '#totalMarks',
        },

    },
    messages: {
        totalMarks: {
            required: "Please enter Total Marks",
            digits: "Please enter Digits",
        },
        obtainedmarks: {
            required: "Please enter Obtained Marks",
            digits: "Please enter Digits",
            ge: 'Must be greater than or equal to Total Marks',
        },
    },
    submitHandler: function (form) {
        
        var UploadRes = {
                TotalMarks : $("#txtTotalMarks").val,
                ObtainedMarks : $("#txtObtainedMarks").val,
        };
        console.log(UploadRes);

    }

})