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

})