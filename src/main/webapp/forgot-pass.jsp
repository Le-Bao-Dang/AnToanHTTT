<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" href="css/forgot-pass.css">
</head>

<body>
<div class="content">
    <div class="background"></div>

    <div class="main">

        <div id="title"><img src="images/logo/logo-rmbg1.png" alt="">
            <h2> Quên mật khẩu</h2>
        </div>

        <div class="form-input">
            <p id="error"></p>
            <div class="input-uname">
                <input type="text" id="phonemail" class="input phone" placeholder="Số điện thoại hoặc email">
                <button class="uppercase send-code">Gửi mã</button>
            </div>

            <input type="text" id="input-code" class="input" placeholder="Nhập mã xác nhận">
            <input type="password" id="input-pass" class="input" placeholder="Mật khẩu mới">
            <input type="password" id="input-passAgain" class="input" placeholder="Nhập lại mật khẩu mới">
            <%--            <i class="fa-solid fa-check"></i>--%>
            <!-- <i class="fa-solid fa-xmark"></i> -->

            <input type="submit" class="submit" value="Đổi mật khẩu">

        </div>
        <a href="<%=request.getContextPath()%>/doLogin">Quay lại</a>
    </div>
</div>
</body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<%--<script src="js/forgot-pass.js"></script>--%>

<script>
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
</script>
</html>