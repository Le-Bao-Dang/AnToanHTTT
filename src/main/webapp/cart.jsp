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
    <link rel="stylesheet" href="css/cart.css">
</head>

<body>

<%@include file="header.jsp" %>
<div class="container content">
    <div class="row">
        <div class="<%=cartItems.size()==0?"col-12":"col-8"%> list-product">
            <h5 class="title uppercase">giỏ hàng</h5>
            <ul class="container-list-product">
                <%
                    if (cartItems.size() != 0) {
                        for (LineItem line : cartItems) {
                            Product product = line.getProduct();
                %>

                <li class="product bd-bottom pb-4 pt-4">
                    <div class="row">

                        <div class="col-3 p-0 left"><img
                                src="<%=product.getMainImage().getSource()%>"
                                alt=""></div>
                        <div class="col-6">
                            <div class="top">
                                <h5 class="product-name"><%=product.getName()%>
                                </h5>
                                <div class="contain-price">
                                    <span>Giá:</span>
                                    <%if (product.getPriceSale() == 0) {%>
                                    <span class="price"><%=Format.format(product.getPrice())%> VND</span>
                                    <%} else {%>
                                    <span class="price"><%=Format.format(product.getPrice())%> VND</span>
                                    <span class="sale"><%=Format.format(product.getPriceSale())%> VND</span>
                                    <%}%>
                                </div>
                            </div>
                            <div class="bottom">
                                <div class="text">Số lượng</div>
                                <input type="number" id="quantity" class="input" name="quantity" min="1" max="20"
                                       placeholder=" " value="<%=line.getQuantity()%>">
                            </div>

                        </div>
                        <div class="col-3 right">
                            <div class="top">
                                <div class="price"><%=Format.format(line.totalPrice())%> VND</div>
                                <div class="stocking">
                                    <%if (product.getStatus() == 0) {%>
                                    Còn hàng
                                    <%} else if (product.getStatus() == 1) {%>
                                    Tạm hết hàng
                                    <%}%>
                                </div>
                            </div>
                            <div class="bottom">
                                <button class="btn-remove" value="<%=line.getId()%>"><i
                                        class="fa-solid fa-trash"></i> Xóa
                                </button>
                            </div>
                        </div>
                    </div>

                </li>

                <%
                    }
                } else {
                %>
                <li class="notification bd-bottom pb-4 pt-4 uppercase">
                    Giỏ hàng của bạn đang trống, quay lại mua hàng nhé!
                </li>
                <%}%>
            </ul>
            <%if (cartItems.size() != 0) {%>
            <div class="contain-btn">
                <button class="delete-all uppercase submit">Xóa tất cả</button>
                <%} else {%>
                <div class="contain-btn" style="justify-content: center">
                    <%}%>
                    <a href="<%=request.getContextPath()%>/listProduct?kind=<%=ProductService.ALL%>"
                       class="return uppercase submit">quay lại mua hàng</a>
                </div>

            </div>
            <%if (cartItems.size() != 0) {%>
            <div class="col-4 bill p-0">
                <div class="contain-bill p-4">
                    <h5 class="title-bill uppercase">đơn hàng</h5>
                    <div class="top bd-bottom  pb-4">
                        <div class="text-bill uppercase">nhập mã khuyến mãi</div>
                        <div class="input-voucher">
                            <input id="input-voucher" class="input" type="text">
                            <button id="submit-voucher" class="uppercase submit">áp dụng</button>
                        </div>
                        <div id="mess-voucher"></div>
                    </div>

                    <div class="mid bd-bottom">
                        <div class="arow">
                            <span>Đơn hàng</span>
                            <span class="total-real"><%=Format.format(Cart.totalPrice(cartItems))%> VND</span>
                        </div>
                        <div class="arow">
                            <span>Giảm</span>
                            <span class="sale">- <%=Format.format(Cart.totalPriceSale(cartItems))%> VND</span>
                        </div>
                        <div class="arow">
                            <span>Mã khuyến mãi</span>
                            <span class="sale-voucher">- <span class="money-sale-voucher">0</span> VND</span>
                        </div>
                    </div>

                    <div class="bottom">
                        <div class="arow">
                            <span class="text uppercase">tạm tính</span>
                            <span class="total"><span><%=Format.format(Cart.total(cartItems))%></span> VND</span>
                        </div>
                        <button class="btn-total uppercase submit">Tiếp tục thanh toán</button>

                    </div>

                </div>
            </div>
            <%}%>
        </div>
    </div>
    <%@include file="footer.jsp" %>
    <%@include file="scroll-to-top.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
            integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
            crossorigin="anonymous"></script>
    <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
            integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
            integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"
            integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="js/general.js"></script>
    <%--    <script type="text/javascript" src="js/cart.js" charset="UTF-8"></script>--%>
    <script>
        $(document).ready(function () {
            let isAppendVoucher = false;
            $('.btn-remove').click(function () {
                let idCartItem = $(this).val();
                $(this).closest('.product').remove();

                $.ajax({
                    url: "/cart/removeProduct",
                    type: "get",
                    data: {
                        idCartItem: idCartItem,
                    },
                    success: function (response) {
                        let listResponse = response.replace(/\r/g, "").split(/\n/);
                        $('#input-voucher').val('');
                        $('.money-sale-voucher').text(0);
                        if (parseInt(listResponse[3].trim()) === 0) {
                            removeEmlement();
                        } else {
                            $('.total-real').text(listResponse[0] + ' VND');
                            $('.sale').text(listResponse[1] + ' VND');
                            $('.total span').text(listResponse[2]);
                        }
                        $('.amount-product').text(listResponse[3]);
                    },
                    error: function (xhr) {

                    }
                });
            })

            $('.delete-all').click(function () {
                removeEmlement();
                $('.amount-product').text(0);
                $.ajax({
                    url: "/cart/removeAllProduct",
                    type: "get",
                    data: {},
                    success: function (response) {
                    },
                    error: function (xhr) {

                    }
                });
            })

            function removeEmlement() {
                $('.product').remove();
                $('.bill').remove();
                $('.list-product').removeClass('col-8');
                $('.list-product').addClass('col-12');
                $('.container-list-product').html('<li class="notification bd-bottom pb-4 pt-4 uppercase">\n' +
                    '            Giỏ hàng của bạn đang trống, quay lại mua hàng nhé!\n' +
                    '        </li>');
                $('.delete-all').remove();
                $('.contain-btn').css('justify-content', 'center');
                $('.input-voucher').val('');
            }

            $('.btn-total').click(function () {
                window.location = "<%=request.getContextPath()%>/shipping?discountCode=" + $('#input-voucher').val();
            })
            $('#submit-voucher').click(function () {

                $.ajax({
                    url: "/cart/checkVoucher",
                    type: "get",
                    data: {
                        voucher: $('#input-voucher').val(),
                    },
                    success: function (response) {
                        let listResponse = response.replace(/\r/g, "").split(/\n/);
                        $('#mess-voucher').text(listResponse[0]);
                        $('.money-sale-voucher').text(new Intl.NumberFormat('de-DE').format(listResponse[1]));
                        $('.total span').text(new Intl.NumberFormat('de-DE').format(listResponse[2]));


                    },
                    error: function (xhr) {

                    }
                });

            })

        })</script>
</body>

</html>