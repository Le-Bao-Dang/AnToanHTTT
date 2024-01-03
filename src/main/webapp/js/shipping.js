$(document).ready(function () {
    login();
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);

    let total = parseInt($('.total-price').text().replaceAll('.', ''));
    let shipFee;
    let shipDate;
    $(document).on('click', '.label-information', function () {
        getLeadTime(this);
    })

    function getLeadTime(label) {
        const addressId = $('#' + $(label).attr('for')).val();
        let to_district_id;
        let to_ward_id;
        $.ajax({
            url: "/getAddress",
            type: "get",
            data: {
                addressId: addressId,
            },
            success: function (response) {
                const listResponse = response.replace(/\r/g, "").split(/\n/);
                to_ward_id = listResponse[0];
                to_district_id = parseInt(listResponse[1]);
            },
            error: function (xhr) {

            }
        }).done(function () {
            $.ajax({
                url: "http://140.238.54.136/api/leadTime",
                type: "post",
                data: {
                    from_district_id: 1451,
                    from_ward_id: 20911,
                    to_district_id: to_district_id,
                    to_ward_id: to_ward_id,
                    height: 10,
                    length: 10,
                    width: 10,
                    weight: 10
                },
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'Bearer ' + accessToken);
                },
                headers: {
                    "X-Requested-With": "XMLHttpRequest"
                },
                success: function (response) {
                    let data = response.data;
                    shipDate = data[0].formattedDate;
                    const date = new Date(shipDate);


                    $('#lead-time').text(date.getDate() + '/' + (date.getMonth() + 1) + '/' + date.getFullYear());
                },
                error: function (xhr) {
                }
            });

            $.ajax({
                url: "http://140.238.54.136/api/calculateFee ",
                type: "post",
                data: {
                    from_district_id: 1451,
                    from_ward_id: 20911,
                    to_district_id: to_district_id,
                    to_ward_id: to_ward_id,
                    height: 10,
                    length: 10,
                    width: 10,
                    weight: 10
                },
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'Bearer ' + accessToken);
                },
                headers: {
                    "X-Requested-With": "XMLHttpRequest"
                },
                success: function (response) {
                    let data = response.data[0];
                    shipFee = data.service_fee;
                    $('.fee').text(shipFee.toLocaleString('vi-VN'));
                    $('.total-price').text((total + shipFee).toLocaleString('vi-VN'));
                },
                error: function (xhr) {
                }
            })
        });
    }

    $('.btn-total').click(function () {
        // const filePath = $('#fileInput').val();
        const ajaxfile = $('#ajaxfile')[0];
        if ($('.contain-address input:radio:checked').val() === undefined) {
            $('#exampleModalCenter').modal({
                show: true
            });
        }else if(!ajaxfile.files.length){
            $('#exampleModalFile').modal({
                show: true
            });
        } else {
            let idInformation = $('.contain-address input:radio:checked').val();
            let discountCode = urlParams.get('discountCode');
            let note = $('.note').val();
            // let encodedFilePath = encodeURIComponent(filePath);
            let filename = document.getElementById('hiddenInput').value;
            let splitName = filename.split('.')[0];

            window.location = '<%=request.getContextPath()%>/addOrder?idInformation=' +
                idInformation + '&discountCode=' +
                discountCode + '&note=' +
                note+ '&fileName='
                +splitName + '&shipFee=' +
                shipFee + '&shipDate=' +
                shipDate ;



        }


    })

    $('.btn-add-address').click(function () {
        window.location = '<%=request.getContextPath()%>/showAddress';
    })


})
