$(document).ready(function () {
    var code;
    $('.submit').click(function () {
        let inputcode = $('#input-code').val().trim();
        let pass = $('#input-pass').val();
        let passAgain = $('#input-passAgain').val();
        let phoneEmail = $('#phonemail').val().trim();


        $.ajax({
            url: "/forgotpass/checkPhoneEmail",
            type: "get", //send it through get method
            data: {
                phoneEmail: phoneEmail,
            },
            success: function (response) {
                code = response;

            },
            error: function (xhr) {
                //Do Something to handle error
            }
        });
        if (checkNull(inputcode)) {
            return $("#error").text("Bạn chưa nhập mã!");
        } else if (inputcode.trim() != code){
            return $('#error').text("Mã không đúng!");
        }
        else if (checkNull(pass) || checkNull(passAgain)) {
            return $("#error").text("Bạn điền chưa đầy đủ thông tin");
        } else if (pass != passAgain) {
            return $("#error").text("Mật khẩu không trùng khớp!");
        }
        $.ajax({
            url: "/forgotpass/changePass",
            type: "get", //send it through get method
            data: {
                pass: pass,
                phoneEmail: phoneEmail,
            },
            success: function (response) {
                 $("#error").text(response);
            },
            error: function (xhr) {
                //Do Something to handle error
            }
        });
    })


    $('.send-code').click(function () {
        let phoneEmail = $('#phonemail').val().trim();
        if (checkNull(phoneEmail)){
           return  $('#error').text("Bạn chưa nhập số điện thoại hoặc email!");
        }
        $.ajax({
            url: "/forgotpass/checkPhoneEmail",
            type: "get", //send it through get method
            data: {
                phoneEmail: phoneEmail,
            },

            success: function (response) {
                if (response == 0 ) {
                    $('#error').text("Số điện thoại hoặc email không tồn tại!");
                } else {
                    $('#code').text(response);
                    code = response.trim();
                }
            },
            error: function (xhr) {
                //Do Something to handle error
            }
        });

    })


    function checkNull(text) {
        return text.length == 0 || text == null;
    }


});