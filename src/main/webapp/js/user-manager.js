$(document).ready(function () {
    $('.edit-user').click(function () {
        let idUer = $(this).val().trim();
        let varieties = $('.user-varieties' + $(this).val()).val().trim();
        let stt = $('.user-stt' + $(this).val()).val().trim();
        window.location = "/editUserManager?id=" + idUer + "&varieties=" + varieties + "&stt=" + stt;
    })
    $('#closeBtn').click(function (){
        document.getElementById('formAddRequest').style.display="none";
    })
    $('.show-request').click(function () {
        let id = $(this).val().trim();
        alert(id)
        $.ajax({

            url: "/userprofile/requestUserManager",
            type: "get", //send it through get method
            data: {
                id: id,
            },
            success: function (response) {
                $(".modal-body").html(response);
            },
            error: function (xhr) {
                //Do Something to handle error
            }
        });
    })
    $('.confirm-request').click(function () {
        let id = $(this).val().trim();
        let i = 1;
        alert(id)
        $.ajax({

            url: "/userprofile/confirmRequest",
            type: "get", //send it through get method
            data: {
                id: id,
                i:i
            },
            success: function (response) {
               location.reload();
            },
            error: function (xhr) {
                //Do Something to handle error
            }
        });
    })
    $('.refuse-request').click(function () {
        let id = $(this).val().trim();
        let i = -1;
        alert(id)
        $.ajax({

            url: "/userprofile/confirmRequest",
            type: "get", //send it through get method
            data: {
                id: id,
                i:i
            },
            success: function (response) {
                location.reload();
            },
            error: function (xhr) {
                //Do Something to handle error
            }
        });
    })
})