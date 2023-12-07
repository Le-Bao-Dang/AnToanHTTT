<%@ page import="bean.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm</title>
    <link rel="stylesheet" href="css/reset.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>

    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/shipping.css">
</head>

<body>
<%@include file="header.jsp" %>

<div class="container content">
    <div class="row">

        <div class="col-7 left">
            <h5 class="title uppercase">Thanh toán</h5>

            <div class="choose-address">
                <h6 class="title uppercase"><i class="fa-solid fa-location-dot"></i>Địa chỉ </h6>

                <div class="list-address">
                    <%
                        List<Information> informations = (List<Information>) request.getAttribute("informations");
                        for (Information informaton : informations) {
                    %>
                    <div class="contain-address bd-bottom">
                        <p>
                            <input class="information" type="radio" id="test<%=informaton.getId()%>" name="address"
                                   value="<%=informaton.getId()%>">
                            <label class="label-information" for="test<%=informaton.getId()%>"><span
                                    class="name"><%=informaton.getName()%></span>
                                <span class="phone-number"><%=informaton.getPhone()%></span></label>
                        </p>
                        <div class="address">
                            <%Address address = informaton.getAddress();%>
                            <%=address.getDetail() + ", " + address.getDistrict() + ", " + address.getCity() + "."%>
                        </div>
                    </div>
                    <%}%>
                </div>
                <button type="button" class="btn-add-address button submit">
                    Thêm địa chỉ mới
                </button>

            </div>
            <div class="way-ship">
                <h6 class="title uppercase"><i class="fa-solid fa-truck-fast"></i>Hình thức giao hàng</h6>
                <div class="contain-way-ship">
                    <p class="bd-bottom">
                        <input type="radio" id="way1" name="way-ship" value="1" checked>
                        <label for="way1">
                            <span class="text">Giao hàng tiêu chuẩn <br/> (Thời gian dự kiến <span
                                    id="lead-time"></span>)</span>
                            <span><span class="text fee">0</span> VND</span>
                        </label>
                    </p>
                </div>
            </div>

            <div class="pay">
                <h6 class="title uppercase"><i class="fa-regular fa-credit-card"></i>Hình thức thanh toán</h6>
                <div class="contain-pay">
                    <p class="bd-bottom">
                        <input type="radio" id="pay1" name="pay" checked value="Thanh toán trực tiếp khi giao hàng">
                        <label for="pay1">
                            <span class="text">Thanh toán trực tiếp khi giao hàng</span>
                        </label>
                    </p>
                </div>
            </div>
            <div class="pay">
                <h6 class="title uppercase"><i class="fa-regular fa-credit-card"></i>Ghi Chú</h6>
                <textarea class="input note" rows="10" cols="10"></textarea>
            </div>

            <div class="pay">
                <h6 class="title uppercase"><i class="fa-regular fa-credit-card"></i>File khóa</h6>
<%--                <textarea class="input note" rows="10" cols="10"></textarea>--%>

                <input id="ajaxfile"class="input" accept=".pem" type="file"  onchange="getFileName()"/> <br/>
                <input id="hiddenInput" type="hidden" />
                <button class="button" onclick="uploadFile()"> Upload file </button>

            </div>
        </div>
        <div class="col-5 bill p-0">
            <div class="contain-bill p-4">
                <h5 class="title-bill uppercase">đơn hàng</h5>
                <div class="top bd-bottom">

                    <%
                        for (LineItem lineItem : cartItems) {
                    %>
                    <div class="product-price row ">
                        <div class="col-8 name-product text "><%=lineItem.getProduct().getName()%>
                        </div>
                        <div class="col-4 amount text text-right">x <%=lineItem.getQuantity()%>
                        </div>
                        <div class="col-8 text"></div>
                        <div class="col-4 price text text-right"><%=Format.format(lineItem.totalPrice())%> VND</div>
                    </div>
                    <%}%>
                </div>

                <div class="mid bd-bottom">
                    <div class="total row">
                        <div class="col-8 name-product text">Tổng đơn hàng</div>
                        <div class="col-4  text text-right"><%=Format.format(Cart.totalPrice(cartItems))%> VND</div>
                        <div class="col-8 text">Giảm</div>
                        <div class="col-4 price text text-right">- <%=Format.format(Cart.totalPriceSale(cartItems))%>
                            VND
                        </div>
                        <div class="col-8 text">Mã khuyến mãi</div>
                        <%int discountFee = (int) request.getAttribute("discountFee");%>
                        <div class="col-4 price text text-right">
                            - <%=Format.format(discountFee)%> VND
                        </div>
                        <div class="col-8 name-product text">Phí vận chuyển</div>
                        <div class="col-4 text text-right"><span class="fee">0</span> VND</div>
                    </div>

                </div>

                <div class="bottom">
                    <div class="row">
                        <div class="col-6 text uppercase">Tổng cộng</div>
                        <div class="col-6 text text-right"><span
                                class="total-price"><%=Format.format(Cart.total(cartItems, discountFee))%></span> VND
                        </div>
                    </div>
                    <button class="btn-total uppercase submit">thanh toán</button>
                </div>

            </div>
        </div>

    </div>
</div>
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog"
     aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title uppercase" id="exampleModalLongTitle">Thêm địa chỉ mới</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-add-address">
                    Bạn chưa có địa chỉ, thêm địa chỉ mới nhé!
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="button button-close submit"
                        data-dismiss="modal">Hủy
                </button>
                <button type="button" class="button submit btn-add-address">Thêm địa chỉ mới</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="exampleModalFile" tabindex="-1" role="dialog"
     aria-labelledby="exampleModalFileTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title uppercase" id="ModalLongTitle">Thêm file khóa private</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-add-address">
                    Bạn chưa có file khóa private,hãy up file khóa private nhé!
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="button button-close submit"
                        data-dismiss="modal">Đóng
                </button>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp" %>
<a href="#" class="scrolltotop"><i class="fa fa-arrow-up"></i></a>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
        integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
        crossorigin="anonymous"></script>

<script src="js/general.js"></script>
<script src="js/api-logistic.js"></script>

<script>
    async function uploadFile() {
        const ajaxfile = $('#ajaxfile')[0];
        let formData = new FormData();
        formData.append("file", ajaxfile.files[0]);
        await fetch('<%=request.getContextPath()%>/uploadfile', {
            method: "POST",
            body: formData
        }).then((data)=>{

        }).catch();
        alert('The file upload with Ajax and Java was a success!');
    }
    function getFileName() {
        var input = $('#ajaxfile')[0];
        var fileName = input.files[0].name;
        // Lưu tên tệp tin vào hidden input
        document.getElementById('hiddenInput').value = fileName;
        // Gửi tên tệp tin đến server bằng AJAX hoặc thực hiện các xử lý khác tại đây
        console.log(fileName);
    }
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

</script>
<%--<script src="js/shipping.js"></script>--%>
</body>

</html>