$(document).ready(function () {

    // change information user
    $('.save-info').click(function () {
        let fullName = $("#input-edit-name").val();
        let phoneNumber = $('#input-edit-phone').val();
        let email = $("#input-edit-email").val();

        if (checkNull(fullName) || checkNull(phoneNumber) || checkNull(email)) {

            return $(".error").text("không");
        }

        $.ajax({
            url: "/userprofile/editUser",
            type: "get", //send it through get method
            data: {
                fullName: fullName,
                phoneNumber: phoneNumber,
                email: email
            },
            success: function (response) {
                $(".inf-left").html(response);
            },
            error: function (xhr) {
                //Do Something to handle error
            }
        });
        $('#formEditInfor').modal('toggle');
    })

    function checkNull(text) {
        return text.length == 0 || text == null;
    }


    $('#address-tab').click(function () {
        window.location = "https://shopbanhangonlineatbm.online/showAddress";
    })
    $('#logout-tab').click(function () {
        window.location = "https://shopbanhangonlineatbm.online/logOut";
    })
    $('#security-tab').click(function () {
        window.location = "https://shopbanhangonlineatbm.online/showSecurity"
    })

    $('#input-avt-user').change(function () {
            let formData = new FormData();
            formData.append('imageUpload', $('#input-avt-user')[0].files[0]);
            $.ajax({
                url: '/userprofile/editAvatarUser',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    let imageUrl = response;
                    $('.avatar').attr('src', imageUrl);
                    $('#small-avt').attr('src', imageUrl);
                    sessionStorage.setItem('imageUrl', imageUrl);
                }
            });
        }
    )

});