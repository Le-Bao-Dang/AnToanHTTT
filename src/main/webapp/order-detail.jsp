<%@ page import="bean.*" %>
<%@ page import="services.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ của tôi</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <!-- <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" /> -->
    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/user-profile.css">
    <link rel="stylesheet" href="css/order-detail.css">

</head>

<body>
<%
    Order order = (Order) request.getAttribute("order");
    String error = (String) request.getAttribute("error");
    String verify = (String) request.getAttribute("verify") ;
    List<HistoryPrice> listPrice = (List<HistoryPrice>) request.getAttribute("listPrice");
    int total = 0;
%>

<div id="container">
    <!-- header -->
    <%@include file="header.jsp" %>

    <!-- end header -->


    <!-- content -->
    <div class="after-header">
        <div id="content">
            <!-- Nav tabs -->
            <div id="title">
                <h1>Tài khoản của tôi</h1>
                <div class="border-h1"></div>
            </div>
            <div id="main">
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <h3>Tài khoản</h3>
                    <li class="nav-item" role="presentation">

                        <button class="nav-link active" id="infor-tab" data-toggle="tab" data-target="#infor"
                                type="button" role="tab" aria-controls="home" aria-selected="true"><i
                                class="fa-solid fa-user"></i>Thông tin tài khoản
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="address-tab" data-toggle="tab" data-target="#address" type="button"
                                role="tab" aria-controls="profile" aria-selected="false"><i
                                class="fa-solid fa-location-dot"></i>Danh sách địa chỉ
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="security-tab" data-toggle="tab" data-target="#security" type="button"
                                role="tab" aria-controls="profile" aria-selected="false" value="<%=user.getId()%>">
                            <i class="fa-solid fa-location-dot"></i>Bảo mật
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="logout-tab" data-toggle="tab" data-target="#messages" type="button"
                                role="tab" aria-controls="messages" aria-selected="false"><i
                                class="fa-solid fa-right-from-bracket"></i>Đăng xuất
                        </button>
                    </li>

                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane active" id="infor" role="tabpanel" aria-labelledby="infor-tab">
                        <div class="inf">
                            <h3>Thông tin địa chỉ</h3>
                            <div class="inf container" style="display: flex; flex-direction: row">
                                <ul class="inf-left">
                                    <li>Họ và tên: <%=order.getInformation().getName()%>
                                    </li>
                                    <li>Số điện thoại: <%=order.getInformation().getPhone()%>
                                    </li>
                                    <li>Địa
                                        chỉ: <%=order.getInformation().getAddress().getDetail() + ", " + order.getInformation().getAddress().getDistrict() + ", " + order.getInformation().getAddress().getCity()%>
                                    </li>
                                </ul>
                                <ul class="inf-left" >
                                    <li><div style="width: 100px; height: 25px; background-color: <%=verify.equals("Verified")?"#c8ffc9":"#ffc8c8"%>;text-align: center; border-radius: 25%"><p><%=verify%></p></div>
                                    </li>
                                    <% if (order.getStatus() !=-1 && verify.equals("Not Verified")){%>
                                    <li>---------------</li>
                                    <li><form class="form-order-detail">
                                        <input type="button" id="buttonSubmit" value="Hủy" content="-1" style="width: 100px; height: 35px;" onclick="setStatusOrder(this)"></input>
                                        <input type="text" class="oder_status" style="display: none;">
                                        <input type="text" class="oder_id"  value="<%=order.getId()%>" style="display: none;">
                                        <button type="submit" id="submit-button" style="display: none;"></button>
                                    </form>
                                    </li>
                                    <%}%>
                                </ul>
                            </div>
                        </div>

                        <div class="order-detail form">
                            <table class="table order-detail-table">
                                <h3>Danh sách đơn hàng</h3>
                                <thead>
                                <tr>
                                    <th scope="col">Tên sản phẩm</th>
                                    <th scope="col">Đơn giá</th>
                                    <th scope="col">Số lượng</th>
                                    <th scope="col">Thành tiền</th>
                                    <th scope="col">Trạng thái</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    List<LineItem> orderItems = order.getListOrderItem();
                                    for (int i = 0; i < orderItems.size(); i++) {
                                %>
                                <tr>
                                    <th scope="row"><%=orderItems.get(i).getProduct().getName()%>
                                    </th>
                                    <%if (listPrice.get(i).getPriceSale() == 0) {%>
                                    <td><%=Format.format(listPrice.get(i).getPrice())%>
                                        VND
                                    </td>
                                    <td><%=orderItems.get(i).getQuantity()%>
                                    </td>

                                    <td><%=Format.format(listPrice.get(i).getPrice() * orderItems.get(i).getQuantity())%>
                                        VND
                                    </td>
                                    <%total += listPrice.get(i).getPrice() * orderItems.get(i).getQuantity();%>
                                    <%} else {%>
                                    <td><%=Format.format(listPrice.get(i).getPriceSale())%>
                                        VND
                                    </td>
                                    <td><%=orderItems.get(i).getQuantity()%>
                                    </td>

                                    <td><%=Format.format(listPrice.get(i).getPriceSale() * orderItems.get(i).getQuantity())%>
                                        VND
                                    </td>
                                    <%total += listPrice.get(i).getPriceSale() * orderItems.get(i).getQuantity();%>
                                    <%}%>
                                    <td><%=order.getStatus()==0?"Chờ xác nhận":order.getStatus()==1?"Đã xác nhận":order.getStatus()==2?"Đang giao hàng":order.getStatus()==3?"Đã nhận hàng":"Đã hủy"%>
                                </tr>
                                <%}%>

                                </tbody>
                            </table>
                            <table class="total-detail">
                                <tr>
                                    <td>Ngày nhận hàng (dự kiến):</td>
                                    <td>Tổng tiền hàng:</td>
                                    <td>Phí vận chuyển:</td>
                                    <td>Mã giảm giá:</td>
                                    <td>Thành tiền:</td>
                                </tr>
                                                                <tr>
                                                                    <td><%=order.getReceivingDate()%></td>
                                                                    <td><%=Format.format(total - order.getTransport().getFee())%> VND</td>
                                                                    <td>+ <%=Format.format(order.getTransport().getFee())%> VND</td>
<%--                                                                    <%if (order.getListDiscount().size() == 0) {%>--%>
                                                                    <td>- 0 VND</td>
                                                                    <td><%=Format.format(total) %>
                                                                        VND
                                                                    </td>
<%--                                                                    <%--%>
<%--                                                                    } else {--%>
<%--                                                                    %>--%>
<%--                                                                    <td>- <%=Format.format(order.getListDiscount().get(0).getValue())%> VND</td>--%>
<%--                                                                    <td><%=Format.format(total + order.getTransport().getFee() - order.getListDiscount().get(0).getValue()) %>--%>
<%--                                                                        VND--%>
<%--                                                                    </td>--%>
<%--                                                                    <%--%>

<%--                                                                        }--%>
<%--                                                                    %>--%>
                                                                </tr>
                            </table>
                        </div>

                    </div>
                    <div class="tab-pane" id="address" role="tabpanel" aria-labelledby="address-tab">
                        <div class="choose-address">
                            <h6 class="title uppercase"><i class="fa-solid fa-location-dot"></i>Địa chỉ </h6>

                            <div class="list-address">
                                <div class="contain-address bd-bottom">
                                    <div class="contain-address left">
                                        <p>
                                            <label><span class="name"><%=order.getInformation().getName()%></span> <span
                                                    class="phone-number">0123456789</span></label>
                                        </p>
                                        <div class="address">
                                            Kí túc xá khu B đhqg, Đông Hòa, Dĩ An, Bình Dương.
                                        </div>
                                    </div>
                                    <div class="contain-address right">
                                        <button class="btn-add-address button submit" id="edit-address">Sửa</button>
                                        <button class="btn-add-address button submit" id="delete-address">Xóa</button>
                                    </div>

                                </div>

                            </div>
                            <button type="button" class="btn-add-address button submit" data-toggle="modal"
                                    data-target="#exampleModalCenter">
                                Thêm địa chỉ mới
                            </button>
                            <button type="button" class="btn-delete-address button submit" data-toggle="modal-dele"
                                    data-target="#exampleModalCenter">
                                Xóa tất cả
                            </button>


                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- end content -->


        <!-- Modal -->
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
                            <input class="input" type="text" name="" id="input-name" placeholder="Họ tên">
                            <input class="input" type="text" name="" id="input-number-phone"
                                   placeholder="Số điện thoại">
                            <select class="select-address" name="calc_shipping_provinces" required="">
                                <option value="">Tỉnh / Thành phố</option>
                            </select>
                            <select class="select-address" name="calc_shipping_district" required="">
                                <option value="">Quận / Huyện</option>
                            </select>
                            <input class="billing_address_1" name="" type="hidden" value="">
                            <input class="billing_address_2" name="" type="hidden" value="">
                            <input class="input" type="text" name="" id="input-num-house"
                                   placeholder="Số nhà, tên đường">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="button button-close submit" data-dismiss="modal">Hủy</button>
                        <button type="button" class="button button-save submit">Lưu địa chỉ</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="overlay" id="overlay">
            <div class="spinner"></div>
        </div>
        <!-- footer -->

        <%@include file="footer.jsp" %>

        <!-- end footer -->
    </div>
    <div class="overlay" id="overlay">
        <div class="spinner"></div>
    </div>
</div>
<style>

    .overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(255, 255, 255, 0.7);
        display: none;
    }

    .spinner {
        border: 8px solid #f3f3f3;
        border-top: 8px solid #3498db;
        border-radius: 50%;
        width: 50px;
        height: 50px;
        animation: spin 1s linear infinite;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
</style>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
        integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"
        integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="js/general.js"></script>
<script src="js/user-profile.js"></script>
<script src="js/order-detail.js"></script>
<script>
    function setStatusOrder(e) {

        $('.oder_status').val('-1');

        $('#submit-button').click();
    }
    $(document).ready(function () {
        $('.form-order-detail').submit(function (event) {
            event.preventDefault();
            $("#overlay").show();
            var orderStatus = $('.oder_status').val().trim();
            var orderId = $('.oder_id').val().trim();

            // Gửi yêu cầu AJAX đến server để lấy thông tin chi tiết đơn hàng
            $.ajax({
                url: "/showOrderDetail",
                type: "post",
                data: {
                    id: orderId,
                    status: orderStatus
                },
                success: function (data) {
                    // Hiển thị thông tin chi tiết đơn hàng trong .form-detail
                    $("#overlay").hide();
                    location.reload();
                },
                error: function (xhr) {
                    $("#overlay").hide();

                    // Xử lý lỗi nếu cần thiết
                }
            });
        });
    });


</script>
</body>

</html>