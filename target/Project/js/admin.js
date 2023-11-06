$(document).ready(function () {


    $('#dtHorizontalVerticalExample').DataTable({
        "scrollX": true,
        "scrollY": 200,
    });
    $('.dataTables_length').addClass('bs-select');
    //------------------ select all ------------------------
    $('#select-all').click(function (event) {
        if (this.checked) {
            // Iterate each checkbox
            $(':checkbox').each(function () {
                this.checked = true;
            });
        } else {
            $(':checkbox').each(function () {
                this.checked = false;
            });
        }
    });
    $('.nav-item').click(function () {
        const queryString = window.location.search;
        if (queryString.endsWith("userManager")) {
            $('.title').text("userManager")
        } else if (queryString.endsWith("ProductManager")) {
            $('.title').text("asddadsnager")
        } else if (queryString.endsWith("orderManager")) {
            $('.title').text("ewr5435")
        }
    })
    $('.detail-order').click(function () {
        $.ajax({
            url: "/detailOrder",
            type: "get",
            data: {
                id: $(this).val().trim()
            },
            success: function (data) {
                $('.form-detail').html(data)
            },
            error: function (xhr) {

            }
        })
    })
});


// $(document).ready(function () {
//     $('#dtHorizontalVerticalExample').DataTable();
// });


