$(document).ready(function () {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    let click = false;
    $.ajax({
        url: "/detailProduct/loadComment",
        type: "get",
        data: {
            page: '1',
            id: urlParams.get('id'),
        },
        success: function (response) {
            $(".list-comment").html(response);
        },
        error: function (xhr) {
        }
    });

    $('.slider-show-img').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false,
        fade: true,
    });

    $('.slider-img').slick({
        infinite: true,
        slidesToShow: 3,
        slidesToScroll: 1,
        rows: 1,
        asNavFor: '.slider-show-img',
        centerMode: true,
        focusOnSelect: true,
        prevArrow: "<button type='button' class='slick-prev pull-left'><i class='fa fa-angle-left' aria-hidden='true'></i></button>",
        nextArrow: "<button type='button' class='slick-next pull-right'><i class='fa fa-angle-right' aria-hidden='true'></i></button>"

    });
    $('.slider-similar-product').slick({
        infinite: true,
        slidesToShow: 4,
        slidesToScroll: 1,
        centerMode: true,
        focusOnSelect: true,
        prevArrow: "<button type='button' class='slick-prev pull-left'><i class='fa fa-angle-left' aria-hidden='true'></i></button>",
        nextArrow: "<button type='button' class='slick-next pull-right'><i class='fa fa-angle-right' aria-hidden='true'></i></button>"

    });

    $("button.page-link").click(
        function () {
            let page = $(this).text().trim();

            if (page === 'Previous') {
                let buttonActive = $('li.active>button');
                page = buttonActive.text() - 1 <= 0 ? 1 : buttonActive.text() - 1;
                buttonActive.parent('.page-item').removeClass('active');
                $("button.page-link:contains('" + page + "')").parent('li.page-item').addClass('active');
            } else if (page === 'Next') {
                let countPage = $('button.page-link').length - 2;
                let buttonActive = $('li.active>button');

                page = parseInt(buttonActive.text()) + 1 >= countPage ? countPage : parseInt(buttonActive.text()) + 1;
                buttonActive.parent('.page-item').removeClass('active');
                $("button.page-link:contains('" + page + "')").parent('li.page-item').addClass('active');

            } else {
                $("button.page-link").parent('.page-item').removeClass("active");
                $(this).parent('.page-item').addClass("active");
            }

            $.ajax({
                url: "/detailProduct/loadComment",
                type: "get",
                data: {
                    page: page,
                    id: urlParams.get('id'),
                },
                success: function (response) {
                    $(".list-comment").html(response);
                },
                error: function (xhr) {
                }
            });
        }
    )
    //search product


    $("#submit-cmt").click(function () {
        let idProduct = urlParams.get("id");
        let value = $(".write-cmt").val();
        let rate = $('.write-ratting .yellow').length;

        $.ajax({
            url: "/detailProduct/upComment",
            type: "get",
            data: {
                text: value,
                rate: rate,
                idProduct: idProduct
            },
            success: function (response) {
                if(response == 'false'){
                    $('.write-ratting .message').text("Bạn cần đăng nhập để thực hiện bình luận.");
                }

                let containListComment = $('.list-comment');
                containListComment.children().last().remove();
                containListComment.prepend(response);
                $(".write-cmt").val("");
            },
            error: function (xhr) {

            }
        });
    })



    $('.write-ratting .fa-star').click(function () {
        click = !click;
        let count = $('.write-ratting .fa-star').index(this);
        for (let i = 0; i <= $('.write-ratting .fa-star').length; i++) {
            if (count > 0) {
                count--;
                $('.write-ratting .fa-star').eq(i).addClass('yellow');
            }
        }
    })

    $('.write-ratting .fa-star').hover(function () {
        if (!click) {
            for (let i = 0; i <= $('.write-ratting .fa-star').index(this); i++) {
                $('.write-ratting .fa-star').eq(i).addClass('yellow');
            }
        }
    }, function () {
        if (!click) {
            $('.write-ratting .fa-star').removeClass('yellow');
        }
    })
    


});

