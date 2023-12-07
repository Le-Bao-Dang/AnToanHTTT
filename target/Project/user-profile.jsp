<%@ page import="bean.*" %>
<%@ page import="java.util.List" %>
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

</head>

<body>


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
                                role="tab" aria-controls="profile" aria-selected="false" value="<%=user.getId()%>">
                            <i class="fa-solid fa-location-dot"></i>Danh sách địa chỉ
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="logout-tab" data-toggle="tab" data-target="#messages" type="button"
                                role="tab" aria-controls="messages" aria-selected="false"><i
                                class="fa-solid fa-right-from-bracket"></i>Đăng xuất
                        </button>
                        <%--                        <a class="nav-link log-out"><i class="fa-solid fa-right-from-bracket"></i>Đăng--%>
                        <%--                            xuất</a>--%>
                    </li>

                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane active" id="infor" role="tabpanel" aria-labelledby="infor-tab">
                        <div class="inf">
                            <h3>Thông tin tài khoản</h3>
                            <div class="inf container">
                                <ul class="inf-left">
                                    <li id="avatar-user">
                                        <label for="input-avt-user">
                                            <img class="avatar" src="<%=user.getAvatar().getSource()%>"
                                                 alt="Ảnh đại diện của bạn">
                                        </label>
                                        <input id="input-avt-user" type="file" accept="image/png, image/jpeg">
                                    </li>
                                    <li>Họ và tên:  <%if (user.getName() == null) {%>
                                        <%=""%>
                                        <%} else {%>
                                        <%=user.getName()%>
                                        <%}%>
                                    </li>
                                    <li>Số điện thoại:  <%if (user.getPhone() == null) {%>
                                        <%=""%>
                                        <%} else {%>
                                        <%=user.getPhone()%>
                                        <%}%>
                                    </li>
                                    <li>Email:  <%if (user.getEmail() == null) {%>
                                        <%=""%>
                                        <%} else {%>
                                        <%=user.getEmail()%>
                                        <%}%>
                                    </li>
                                </ul>

                                <div class="inf-right">
                                    <button type="button" class="btn-add-address button submit" id="edit-info"
                                            data-toggle="modal" data-target="#formEditInfor">
                                        Sửa
                                    </button>

                                    <!-- Modal -->
                                    <div class="modal fade" id="formEditInfor" tabindex="-1" role="dialog"
                                         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title uppercase" id="modalLongTitle">Sửa thông
                                                        tin</h5>
                                                </div>
                                                <p class="error"></p>
                                                <div class="modal-body">
                                                    <div class="form-add-address">
                                                        <input class="input" type="text" name="input-edit-name"
                                                               id="input-edit-name"
                                                               placeholder="Họ tên" value="<%=user.getName()%>">
                                                        <input class="input" type="text" name="input-edit-phone"
                                                               id="input-edit-phone"
                                                               placeholder="    Số điện thoại"
                                                               value="<%=user.getPhone()%>">
                                                        <input class="input" type="email" name="input-edit-email"
                                                               id="input-edit-email"
                                                               placeholder="Email" value="<%=user.getEmail()%>">

                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="button button-close submit"
                                                            data-dismiss="modal">Hủy
                                                    </button>
                                                    <button type="button" class="button button-save save-info submit">
                                                        Lưu thông
                                                        tin
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- end modal for button sua--%>
                                </div>
                            </div>
                        </div>
                        <div class="order-list form">
                            <table class="table order-list-table">
                                <h3>Danh sách đơn hàng</h3>
                                <thead>
                                <tr>
                                    <th scope="colOrderId">Mã đơn hàng</th>
                                    <th scope="colOrderDate">Ngày đặt</th>
                                    <th scope="colTotal">Thành tiền</th>
                                    <th scope="colSttPay">Trạng thái đơn hàng</th>
                                    <th scope="colSttDelivery">Vận chuyển</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    List<Order> orders = (List<Order>) request.getAttribute("orders");
                                    for (Order order : orders) {
                                %>

                                <tr>
                                    <th scope="row">#<%= order.getId()%>
                                    </th>
                                    <td><%=Format.formatDate(order.getCreateDate())%>
                                    </td>
                                    <td><%=Format.format(order.getTotal())%> VND</td>
                                    <td><%=order.getTotal()%>
                                    </td>
                                    <td><%=order.getStatusDelivery()%>
                                    </td>
                                    <td>
                                        <a href="/showOrderDetail?orderId=<%=order.getId()%>"
                                           class="submit button see-more">Chi tiết <i
                                                class="fa-solid fa-circle-info"></i></a>

                                    </td>

                                </tr>

                                <%}%>


                                </tbody>
                            </table>
                        </div>


                    </div>


                </div>
            </div>
        </div>
        <!-- end content -->

        <!-- footer -->

        <%@include file="footer.jsp" %>

        <!-- end footer -->
    </div>
</div>

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
<script src="js/user-profile.js"></script>
</body>

</html>