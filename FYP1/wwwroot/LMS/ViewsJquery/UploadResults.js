$.validator.addMethod("greaterThan",
    function (value, element, param) {
        var $otherElement = $(param);
        return parseInt(value, 10) >= parseInt($otherElement.val(), 10);
    });
$("#Upload").validate({
    rules: {
        totalMarks: {
            required: true,
            digits: true,
        },
        obtainedmarks: {
            required: true,
            digits: true,
            greaterThan: "#txtTotalMarks",
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
            greaterThan: 'Must be greater than or equal to Total Marks',
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