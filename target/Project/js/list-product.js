const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);
$(window).scroll(function () {

    if ($(this).scrollTop() > 100) {
        $('.scrolltotop').fadeIn();
    } else {
        $('.scrolltotop').fadeOut();
    }
});

// Click event to scroll to top
$('.scrolltotop').click(function () {
    $('html, body').animate({scrollTop: 0}, 1500);
    return false;
});

// ------------Loc san pham theo nhom--------------------
$('.item-groupProduct').click(function () {
    $('.item-groupProduct').removeClass("active-navbar-left")
    $(this).addClass("active-navbar-left")
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    $.ajax({
        url: "/listProducts/listProductGroup",
        type: "get", //send it through get method
        data: {
            groups: $(this).text().trim(),
            kind: urlParams.get('kind')

        },
        success: function (response) {
            $(".list-product .row").html(response);
        },
        error: function (xhr) {
            //Do Something to handle error
        }
    });
})

// ---------- Tim kiem -------------
//         $("#search").click(function () {
//             $.ajax({
//                 url: "/search",
//                 type: "get", //send it through get method
//                 data: {
//                     search: $(".search-input").val(),
//                 },
//                 success: function (response) {
//                     $(".list-product .row").html(response);
//                 },
//                 error: function (xhr) {
//                     //Do Something to handle error
//                 }
//             });
//         })


// =============== Phan Trang =====================
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
        url: "/listProducts/listProductInPage",
        type: "get",
        data: {
            page: page,
            kind: urlParams.get('kind'),
            group: $('.active-navbar-left').text(),
            sort: $('.sort-table').val().trim()
        },
        success: function (response) {
            $(".list-product .row").html(response);
        },
        error: function (xhr) {
        }
    });
}

)
//================= Phan TRang ===================


//================ Sap xep =====================
$('.sort-table').change(function () {
    // alert($(this).val().trim())
    $.ajax({
        url: "/listProducts/sort",
        type: "get",
        data: {
            kind: urlParams.get('kind'),
            group: $('.active-navbar-left').text().trim(),
            sorts: $(this).val().trim()
        },
        success: function (response) {
            $(".list-product .row").html(response);
        },
        error: function (xhr) {
        }
    })
})
//================ /Sap xep =====================
