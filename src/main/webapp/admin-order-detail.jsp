<%@ page import="java.util.List" %>
<%@ page import="bean.Order" %>
<%@ page import="bean.Format" %>
<%@ page import="services.OrderService" %>
<%@ page import="bean.LineItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="https://mdbootstrap.com/docs/b4/jquery/getting-started/cdn/">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" href="css/import-manager.css">
    <link rel="stylesheet" href="css/admin.css">
</head>

<body>
<%@include file="header-admin.jsp" %>
<div class="content">
    <% User u = (User) request.getAttribute("user");
        Order order = (Order) request.getAttribute("order");
        int total = (int) request.getAttribute("total");
        List<LineItem>  orderDetails = (List<LineItem> ) request.getAttribute("orderDetails");
        boolean verify =(boolean)request.getAttribute("verify");
    %>

<div class="table">
    <div class="table-cart">
        <form class="form form-order-detail">
            <button class="close"type="button"><p style="color: #1cde00"><%=verify?"Đã xác minh":"Chưa xác minh"%></p></button>
            <header style="font-weight: bold;color: #0059d3">Chi tiết đơn hàng <%=order.getId()%></header>
            <div class="input-box">
                <label style="font-weight: bold"> Tên khách hàng</label>
                <input type="text"  placeholder="<%=u.getName()%>"  disabled />
            </div>
            <div class="input-box">
                <label style="font-weight: bold">Thông tin</label>
                <div class="row">
                    <div class="col-md-4 ">
                        <p class="mb-0">Địa chỉ</p>
                    </div>
                    <div class="col-md-8 col-lg-5">
                        <p class="formatPrice mb-0" style="width:300px ">
                            <%=order.getInformation().getAddress().formatAddress()%>
                        </p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 ">
                        <p class="mb-0">Số điện thoại</p>
                    </div>
                    <div class="col-md-8 col-lg-5">
                        <p class="formatPrice mb-0" style="width:300px ">
                            <%=u.getPhone()%>
                        </p>
                    </div>
                </div>


            </div>

            <div class="input-box address">
                <label style="font-weight: bold">Chi tiết sản phẩm</label>
                <div class="row">
                    <div class="col-md-8 ">
                        <p class="mb-0">Tiền vận chuyển</p>
                    </div>
                    <div class="col-md-4 col-lg-3">
                        <p class="formatPrice mb-0" style="width:300px ">
                            <%=Format.format(order.getTransport().getFee())%> VNĐ
                        </p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-8 ">
                        <p class="mb-0">Tiền giảm giá</p>
                    </div>
                    <div class="col-md-4 col-lg-3">
                        <p class="formatPrice mb-0" style="width:300px ">
                            <%=order.getDiscount() == null?0:Format.format(order.getDiscount().getValue())%> VNĐ
                        </p>
                    </div>
                </div>
            </div>
            <div class="input-box productAdd">
                <lable style="font-weight: bold">Chi tiết sản phẩm</lable>
                <table class="tableImport">
                    <thead>
                    <tr>
                        <th class="stt">STT</th>
                        <th>Tên sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Giá tiền</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody id="import-group">
                    <% int  i =1;
                        for (LineItem or:
                                orderDetails) {%>
                    <tr class="import-item" id="product1">
                        <td class="stt "><input type="button" value="<%=i%>" name="indexRow"></td>
                        <td><input id="nameProduct1" name="nameProduct" type="text" class="nameProduct" value="<%=or.getProduct().getName()%> "
                                   disabled></td>
                        <td><input id="quantity1" name="quantity" type="text" class="quantity" min="0" value="<%=or.getQuantity()%>"
                                   disabled>
                        </td>
                        <td><input id="priceImport1" name="priceImport" type="text" min="0" class="priceImport"
                                   value="<%=Format.format(or.totalPrice())%> VNĐ"
                                   disabled></td>
                        <%--                        <td>--%>
                        <%--                            <div class="buttonItem">--%>
                        <%--                                <p type="button" class="minus icon" onclick="remove('product1')"><i--%>
                        <%--                                        class="fas fa-minus"></i></p></div>--%>
                        <%--                        </td>--%>
                    </tr>
                    <%i++;}%>
                    </tbody>
                </table>
            </div>
            <%--        <div class="input-box">--%>
            <%--            <div><p type="button" class="plus icon" onclick="addRow()"><i--%>
            <%--                    class="fas fa-plus"></i>--%>
            <%--            </p></div>--%>
            <%--        </div>--%>
            <div class="input-box">
                <label style="font-weight: bold">Tổng tiền</label>
                <div class="row">
                    <div class="col-lg-12">
                        <p><%=Format.format(total)%> VNĐ</p>
                    </div>
                </div>
            </div>
            <%
                String oStatus = "Đã hủy";
                String oStatusColor = "status-red";
                if (order.getStatus()==0){
                    oStatus= "Chờ xác nhận";
                    oStatusColor = "status-yellow";
                } else if (order.getStatus()==1) {
                    oStatus= "Đã xác nhận";
                    oStatusColor = "status-green";
                } else if (order.getStatus()==2) {
                    oStatus= "Đang giao hàng";
                    oStatusColor = "status-blue";
                } else if (order.getStatus()==3) {
                    oStatus= "Đã nhận hàng";
                    oStatusColor = "status-white";
                }
            %>
            <div class="input-box">
                <label style="font-weight: bold">Trạng thái đơn hàng</label>
                <div class="row">
                    <div class="col-lg-12">
                        <p style="width: 125px" class="<%=oStatusColor%>"><%=oStatus%></p>
                    </div>
                </div>
                <label style="font-weight: bold">Trạng thái vận chuyển</label>
                <div class="row">
                    <div class="col-lg-12">
                        <p style="width: 125px"><%=order.getStatusDelivery()==0?"Chờ vận chuyển":order.getStatusDelivery()==1?"Đang vận chuyển":order.getStatusDelivery()==2?"Đã vận chuyển":"Đã hủy"%></p>
                    </div>
                </div>
            </div>
            <div class="bottom-form" style="gap: 1rem">
                <%if (order.getStatus() ==0){
                %>
                <input type="button" onclick="setStatusOrder(this)" value="Xác nhận" content="1"  style="background-color: #c4ffc2;color: black;border: none;width: 100px;height: 45px">
                <%} else if (order.getStatus() ==1) {
                %>
                <input type="button" onclick="setStatusOrder(this)" value="Giao hàng" content="2" style="background-color: #c2d3ff;color: black;border: none;width: 100px;height: 45px">
                <%}%>

                <% if (order.getStatus() <3 && order.getStatus()> -1){

                %>
                <input type="button" onclick="setStatusOrder(this)" value="Hủy" content="-1"  style="background-color: #ffc2c2;color: black;border: none;width: 100px;height: 45px">
<%}%>
                <input type="text" class="oder_status" style="display: none;">
                <input type="text" class="oder_id"  value="<%=order.getId()%>" style="display: none;">
<button type="submit" id="submit-button" style="display: none;"></button>
            <%--                <div class="submit" onclick="addImport()"> Thêm</div>--%>
<%--                <div type="button" class="submit cant" onclick="hide()">Hủy</div>--%>
<%--                <input id="jsonItem" name="jsonItem" value="" style="display: none">--%>
            </div>
        </form>
    </div>

</div>


</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.2.1/dist/chart.umd.min.js"></script>
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
<!-- <script src="js/general.js"></script> -->
<script src="js/jquery.dataTables.min.js"></script>
<script src="js/admin.js"></script>

<script>
    function setStatusOrder(e) {
        if (e.value === 'Xác nhận') {
            $('.oder_status').val('1');
        } else if (e.value === 'Giao hàng') {
            $('.oder_status').val('2');
        } else {
            $('.oder_status').val('-1');
        }
        $('#submit-button').click();
    }
    $(document).ready(function () {
        $('.form-order-detail').submit(function (event) {
            event.preventDefault();

            var orderStatus = $('.oder_status').val().trim();
            var orderId = $('.oder_id').val().trim();

            // Gửi yêu cầu AJAX đến server để lấy thông tin chi tiết đơn hàng
            $.ajax({
                url: "/detailOrder",
                type: "post",
                data: {
                    id: orderId,
                    status: orderStatus
                },
                success: function (data) {
                    // Hiển thị thông tin chi tiết đơn hàng trong .form-detail
                    location.reload();
                },
                error: function (xhr) {
                    // Xử lý lỗi nếu cần thiết
                }
            });
        });
    });




</script>
</body>

</html>