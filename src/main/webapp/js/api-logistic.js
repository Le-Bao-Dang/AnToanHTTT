var accessToken;

function login() {
    const email = 'thphung2@gmail.com';
    const password = '123456';

    $.ajax({
        url: "http://140.238.54.136/api/auth/login",
        type: "post",
        data: {
            email: email,
            password: password
        },
        success: function (response) {
            accessToken = response.access_token;
        },
        error: function (xhr) {

        }
    });
}

