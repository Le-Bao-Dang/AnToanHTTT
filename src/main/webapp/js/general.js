$(document).ready(function () {


    $(window).scroll(function () {
        var scroll = $(window).scrollTop();

        //>=, not <=
        if (scroll >= 5) {
            //clearHeader, not clearheader - caps H
            $(".nav-page").addClass("bg-light");

        } else {
            $(".nav-page").removeClass("bg-light");
        }
    }); //missing );

    $('button.btn-add-cart').click(function () {
        let amountAdd = parseInt($('#quantity').val());
        let idProduct = parseInt($(this).val());
        if (isNaN(amountAdd)) {
            amountAdd = 1;
        }
        $.ajax({
            url: "/cart/addCart",
            type: "get",
            data: {
                idProduct: idProduct,
                amount: amountAdd
            },
            success: function (response) {
                $('.amount-product').text(response.trim());
            },
            error: function (xhr) {

            }
        });
    })

    $("#search").click(function () {
            if (window.location == "/searches?search=" + $('.search-input').val().trim()) {
                alert($('.search-input').val().trim())
                $.ajax({
                    url: "/searches",
                    type: "get",
                    data: {
                        search: $('.search-input').val().trim()
                    },
                    success: function (response) {
                        $(".list-product .row").html(response);
                    },
                    error: function (xhr) {
                        //Do Something to handle error
                    }
                })
            } else {
                window.location = "/searches?search=" + $('.search-input').val().trim();
                // $.ajax({
                //     url: "/Searches",
                //     type: "get",
                //     data: {
                //         search: $('.search-input').val().trim()
                //     },
                //     success: function (response) {
                //         $(".list-product .row").html(response);
                //     },
                //     error: function (xhr) {
                //         //Do Something to handle error
                //     }
                // })
            }
        }
    )
    // document ready  
});


// var navItems = document.querySelectorAll(".sort-item a");
// for (var i = 0; i < navItems.length; i++) {
//     navItems[i].addEventListener("click", function() {
//         this.classList.add(" active");
//     });
// }

// ------Search Every Where----------



