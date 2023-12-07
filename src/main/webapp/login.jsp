<%@ page contentType="text/html; charsetUTF-8" language="java" pageEncoding="UTF-8" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="google-signin-client_id"
          content="1034647834889-cac969ni56lqahndnovhocna77j0lda3.apps.googleusercontent.com">
    <title>login</title>
    <link rel="stylesheet" href="css/reset.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" href="css/login.css">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
</head>
<body>
<%
    String error = (String) request.getAttribute("error");
    error = error == null ? "" : error;
%>
<div class="form-login">
    <div class="background"></div>
    <form action="/doLogin" method="post">
        <img src="images/logo/logo-rmbg1.png" alt="">
        <h2> Đăng nhập</h2>
        <div class="user">
            <p class="error"><%= error%>
            </p>
            <input type="text" name="user" class="name input" placeholder="Email hoặc số điện thoại">
            <input type="password" name="password" class="pass input" placeholder="Mật khẩu">
            <a href="<%=request.getContextPath()%>/forgotPass" class="forget"> Bạn quên mật khẩu?</a>

            <input type="submit" name="submit" class="submit" value="Đăng nhập">
            <p style="color:red;text-align: center">Hoặc bạn có thể đăng nhập bằng:</p>
            <fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
            </fb:login-button>
            <div class="g-signin2" data-onsuccess="onSignIn"></div>
            <div id="status"></div>
            <p class="sign-up">Tạo tài khoản mới miễn phí <a href="<%=request.getContextPath()%>/doSignUp">tại đây</a></p>
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.1.1.min.js">
    <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
        integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
        crossorigin="anonymous"></script>
<script src="js/general.js"></script>
<%--// đăng nhập bằng fb--%>
<script>
    window.fbAsyncInit = function () {
        FB.init({
            appId: '262888572779226',
            xfbml: true,
            version: 'v16.0'
        });
        FB.AppEvents.logPageView();
    };

    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {
            return;
        }
        js = d.createElement(s);
        js.id = id;
        js.src = "https://connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));

    function checkLoginState() {
        FB.getLoginStatus(function (response) {
            statusChangeCallback(response);
        });
    }

    function statusChangeCallback(response) {
        console.log('statusChangeCallback');
        console.log(response);
        if (response.status === 'connected') {
            testAPI();
        } else {
            document.getElementById('status').innerHTML = 'Please log ' +
                'into this app.';
        }
    }

    function testAPI() {
        console.log('Welcome!  Fetching your information.... ');
        FB.api('/me', function (response) {
            $.ajax({
                url: "/loginByFB",
                type: "post", //send it through get method
                data: {
                    name: response.name,
                    id: response.id
                },
                success: function (response) {
                    window.location = "<%=request.getContextPath()%>/homepage";
                }
            });
            document.getElementById('status').innerHTML =
                'Thanks for logging in, ' + response.name+response.id + '!';
        });
    }

    // hết đăng nhập bằng fb

</script>
<%-- đăng nhập bằng gg--%>
<script type="text/javascript">
    function login() {
        var myParams = {
            'clientid': '1034647834889-cac969ni56lqahndnovhocna77j0lda3.apps.googleusercontent.com',
            'cookiepolicy': 'single_host_origin',
            'callback': 'loginCallback',
            'approvalprompt': 'force',
            'scope': 'https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/plus.profile.emails.read'
        };
        gapi.auth.signIn(myParams);
    }

    function loginCallback(result) {
        if (result['status']['signed_in']) {
            var request = gapi.client.plus.people.get(
                {
                    'userId': 'me'
                });
            request.execute(function (resp) {
                console.log(resp);
                if (resp != null) {
                    window.location.href = 'Login?action=Google&name=' + resp.name.givenName + '&email=' + resp.emails[0].value + '&id=' + resp.id + '&fullName=' + resp.displayName + '&image=' + resp.image.url + '&age=' + resp.ageRange.max + '&etag=' + resp.etag;
                }
                var email = '';
                if (resp['emails']) {
                    for (i = 0; i < resp['emails'].length; i++) {
                        if (resp['emails'][i]['type'] == 'account') {
                            email = resp['emails'][i]['value'];//here is required email id
                        }
                    }
                }
                var usersname = resp['displayName'];//required name
            });
        }
    }

    function onLoadCallback() {
        gapi.client.setApiKey('AIzaSyBvKg3asprpxMgAVhaonZOjJ_O-bcEoGxw');
        gapi.client.load('plus', 'v1', function () {
        });
    }

</script>

<script type="text/javascript">
    (function () {
        var po = document.createElement('script');
        po.type = 'text/javascript';
        po.async = true;
        po.src = 'https://apis.google.com/js/client.js?onload=onLoadCallback';
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(po, s);
    })();
</script>
</body>

</html>