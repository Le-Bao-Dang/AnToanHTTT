$(document).ready(function () {
    $('#addBanner').click(function () {
        var name = $('#input-name').val();
        var srcIamge = $('#file-img').val();

        // var srcIamge = "images/image-banner/";
        if (name == null) {
            alert("kiểm tra lại");
            return;
        }
        $.ajax({
            url: "/addBanner",
            type: "get",
            data: {
                name: name,
                srcImg: srcIamge
            }, success: function (data) {

            }
        }).done(function () {
            $('.download-image').click()
        })
        // window.location = "/addBanner?name=" + name + "&srcImg=" + srcIamge;

    })
    $('.edit-banner').click(function () {
        var idbanner = $(this).val().trim();
        $.ajax({
            url: "/admins/editBannerForm",
            type: "get",
            data: {
                id: idbanner
            },
            success: function (data) {
                $('.form-edit').html(data)
            },
            error: function (xhr) {

            }
        }).done(function () {
            $('#save-editBanner').click(function () {
                var name = $('#edit-name').val();
                alert(name)
                var srcIamge = "ádgdkfh";
                if (name == null) {
                    alert("kiểm tra lại");
                    return;
                }
                window.location = "/editBannerinForm?name=" + name + "&imgSrc=" + srcIamge + "&id=" + idbanner;

            })
        })
    })
    $('.delete-banner').click(function () {
        var idbanner = $(this).val().trim()
        $.ajax({
            url: "/admins/deleteBanner",
            type: "get",
            data: {
                id: idbanner
            },
            success: function (data) {
                $('.name' + idbanner).remove()
            }
        })
    })
    $('#addPacategory').click(function () {
        var name = $('#input-pa').val().trim();

        if (name == null) {
            alert("kiểm tra lại");
            return;
        }
        window.location = "/addPaCategory?idSet=1&nameSet=" + name + "&id=0";
    })
    $('.delete-pa').click(function () {
        var id = $(this).val().trim();
        var nameSet = "none";
        var idset =3;
        $.ajax({
            url: "/addPaCategory",
            type:"get",
            data:{
                idSet:idset,
                nameSet:nameSet,
                id:id
            },success: function () {
                $('.name'+id).remove()
            }
        })
        // window.location = "/addPaCategory?idSet=3&nameSet=khong&id=" + id;
    })


    $(document).on("change", ".input-img", function (e) {

        let input = this;
        if (input.files && input.files[0]) {


            let reader = new FileReader();

            reader.onload = function (e) {
                $('.images').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    })
    $(document).on("click", ".remove-img", function (e) {
        let id = $(this).val();
        $('.item' + id).remove();
        $('#file-img' + id).remove();
    })

})