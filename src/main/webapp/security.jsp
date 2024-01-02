<%@ page import="bean.*" %>
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
    <link rel="stylesheet" href="css/show-address.css">

</head>

<body>
<%
    List<Information> informationList = (List<Information>) request.getAttribute("informationList");

%>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<div id="container">
    <!-- header -->
    <%@include file="header.jsp" %>

    <!-- end header -->


    <div class="after-header">
        <!-- content -->

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
                        <button class="nav-link" id="security-tab" data-toggle="tab" data-target="#security"
                                type="button"
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
                    <div class="tab-pane" id="security" role="tabpanel" aria-labelledby="security-tab">
                        <div class="choose-address inf">
                            <h3>Bảo mật tài khoản</h3>
                            <div class="contain-list-address">
                                <div class="list-address all-address">
                                    <div class="contain-address bd-bottom">
                                        <div class="contain-address left">
                                            <div class="security">
                                                Bạn đã bị lộ khóa? Yêu cầu tạo khóa mới!
                                            </div>
                                            <% List<Request> re = (List<Request>) request.getAttribute("request") ;%>

                                            <div class="order-list form">
                                                <table class="table order-list-table">
                                                    <h3>Danh sách yêu cầu của bạn</h3>
                                                    <thead>
                                                    <tr>
                                                        <th scope="colOrderId">Mã Yêu cầu</th>
                                                        <th scope="colOrderDate">Ngày tạo</th>
                                                        <th scope="colTotal">Ngày xác nhận</th>
                                                        <th scope="colSttPay">Trạng thái yêu cầu</th>
                                                        <th scope="colSttDelivery">ghi chú</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <%
                                                        for (Request r : re) {
                                                    %>

                                                    <tr>
                                                        <th scope="row">#<%= r.getId()%>
                                                        </th>
                                                        <td><%=Format.formatDate(r.getCreate_at())%>
                                                        </td>
                                                        <td><%=r.getConfim_at()!=null?Format.formatDate(r.getConfim_at()):""%></td>
                                                        <td>
                                                            <%=r.getStatus()==0?"Đang duyệt":r.getStatus()==-1?"Không được duyệt":"Đã duyệt"%>

                                                        </td>
                                                        <td><%=r.getNote()%>
                                                        </td>


                                                    </tr>

                                                    <%}%>


                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="contain-address right">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%if (re.size() > 0 && re.get(re.size()-1).getStatus() == 0) {%>
                            <button type="button" class=" button submit not-submit">
                               Có 1 yêu cầu đang chờ duyệt
                            </button>
                            <%} else {%>
                            <button type="button" class="btn-add-request button submit" id="add-request"
                                    data-toggle="modal" data-target="#formAddRequest">
                                Gửi yêu cầu
                            </button>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end content -->

        <!-- Modal add address-->

        <div class="modal fade" id="formAddRequest" tabindex="-1" role="dialog"
             aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title uppercase" id="modalLongTitle">Yêu cầu bảo mật</h5>
                    </div>
                    <p class="error"></p>
                    <div class="modal-body">
                        <div class="form-add-address">
                            <input class="input" type="text" name="input-note"
                                   id="input-note"
                                   placeholder="Mô tả vấn đề của bạn" >
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="button button-close submit"
                                data-dismiss="modal">Hủy
                        </button>
                        <button type="button" class="button button-save save-request submit">
                           Gửi yêu cầu
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <%--end modal add address--%>
        <!-- footer -->

        <%@include file="footer.jsp" %>

        <!-- end footer -->
    </div>
</div>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
        integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
        crossorigin="anonymous"></script>
<script src='https://cdn.jsdelivr.net/gh/vietblogdao/js/districts.min.js'></script>
<script src="js/api-logistic.js"></script>
<script src="js/general.js"></script>
<script>

    $(document).ready(function () {
        login();
        $('#infor-tab').click(function () {
            window.location = "<%=request.getContextPath()%>/userProfile";
        })
        $('.save-request').click(function () {
            let note = $('#input-note').val();


            if (checkNull(note)) {
                return $(".errorAddAddress").css('color', 'red').text("Chưa điền đủ thông tin");
            }

            $.ajax({
                url: "/userprofile/addRequest",
                type: "get",
                data: {
                    note: note,

                },
                success: function (response) {
                    $('.contain-list-address').append(response);
                },
                error: function (xhr) {
                }
            }).done(function () {
                window.location = "<%=request.getContextPath()%>/showSecurity";
            })
            ;
            $('#exampleAddAddress').modal('toggle');
        })





        function checkNull(text) {
            return text.length == 0 || text == null;
        }

        $('.btn-delete-all').click(function () {

            $.ajax({
                url: "/userprofile/deleteAllInformation",
                type: "get", //send it through get method
                data: {},
                success: function (response) {
                    $(".all-address").html(response);
                },
                error: function (xhr) {
                    //Do Something to handle error
                }
            });
            $('#exampleDeleteAllAddress').modal('toggle');

        })
        $('#logout-tab').click(function () {
            window.location = "<%=request.getContextPath()%>/logOut";
        })
    })
</script>
</body>

</html>