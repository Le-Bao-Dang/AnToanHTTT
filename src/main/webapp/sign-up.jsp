<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" href="css/sign-up.css">
</head>

<body>
<% String error = (String) request.getAttribute("error");
    error = (error == null ? "" : error);

    String fullName = (String) request.getAttribute("fullName");
    fullName = (fullName == null ? "" : fullName);

    String phone = (String) request.getAttribute("phone");
    phone = (phone == null ? "" : phone);

    String email = (String) request.getAttribute("email");
    email = (email == null ? "" : email);

    String pass = (String) request.getAttribute("pass");
    pass = (pass == null ? "" : pass);

    String passAgain = (String) request.getAttribute("passAgain");
    passAgain = (passAgain == null ? "" : passAgain);




%>
<div class="content">
    <div class="background"></div>

    <div class="main">

        <div id="title"><img src="images/logo/logo-rmbg1.png" alt="">
            <h2> Đăng ký</h2>
        </div>

        <form class="form-input" action="/doSignUp" method="post">
            <p class="error"><%= error%>
            </p>

            <input type="text" name="fullName" class="input name" placeholder="Họ tên" value="<%=fullName%>">
            <input type="text" name="phone" class="input phone" placeholder="Số điện thoại" value="<%=phone%>">
            <input type="email" name="email" class="input mail" placeholder="Email" value="<%=email%>">
            <input type="password" name="pass" class="input pass" placeholder="Mật khẩu" value="<%=pass%>">
            <input type="password" name="passAgain" class="input passAgain" placeholder="Nhập lại mật khẩu" value="<%=passAgain%>">
            <%--                <i class="fa-solid fa-check"></i>--%>
            <!-- <i class="fa-solid fa-xmark"></i> -->

            <input type="submit" class="submit" value="Đăng ký">
        </form>
        <span>Đã có tài khoản? <a href="<%=request.getContextPath()%>/doLogin">Đăng nhập</a></span>
    </div>
</div>
</body>

</html>