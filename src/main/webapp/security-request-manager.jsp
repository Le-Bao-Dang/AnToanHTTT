<%@ page import="java.util.List" %>
<%@ page import="bean.Request" %>
<%@ page import="services.RequestService" %>
<%@ page import="bean.Format" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

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

    <link rel="stylesheet" href="css/admin.css">
    <link rel="stylesheet" href="css/user-manager.css">
</head>

<body>
<%@include file="header-admin.jsp" %>
<div class="card-body px-0 pb-2 content">
    <div class="table-responsive p-0">
        <table class="table align-items-center mb-0">
            <thead>
            <tr>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Tên người dùng
                </th>
                <th class="text-center text-secondary text-xs  opacity-7 ps-2">Ngày tạo
                </th>
                <th class="text-center text-secondary text-xs  opacity-7">
                    Trạng thái
                </th>
                <th class="text-center text-secondary text-xs opacity-7">
                   Ngày xác nhận
                </th>
                <th class="text-secondary opacity-7">Ghi chú</th>
                <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                    Bảo mật
                </th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Request> list = (List<Request>) request.getAttribute("listRequest");
                for (Request r:
                     list)
               {
            %>
            <tr>
                <td>
                    <div class="d-flex px-2 py-1">
                        <div>
                            <img src="<%=r.getUser().getAvatar().getSource()%>"
                                 class="avatar avatar-sm me-3 border-radius-lg"
                                 alt="user1">
                        </div>
                        <div class="d-flex flex-column justify-content-center">
                            <h6 class="mb-0 text-sm"><%=r.getUser().getName()%>
                            </h6>
                            <p class="text-xs text-secondary mb-0"><%=r.getUser().getEmail()%>
                            </p>
                        </div>
                    </div>
                </td>
                <td class="align-middle text-center text-sm"><%=Format.formatDate(r.getCreate_at())%>
                </td>
                <td class="align-middle text-center text-sm">
                        <%=r.getStatus()==0?"Đang chờ duyệt":r.getStatus()==-1?"Không được duyệt":"Đã duyệt"%>
                </td>
                <td class="align-middle text-center text-sm">
                    <%=r.getConfirm_at()!=null?Format.formatDate(r.getConfirm_at()):""%>
                </td>
                <td class="align-middle">
               <%=r.getNote()==null?"":r.getNote()%>
                </td>
                <td class="align-middle">
                    <%if (r.getStatus() == 0){%>
                    <button type="button" class="button submit refuse-request"
                            data-dismiss="modal" value="<%=r.getId()%>"> Từ chối
                    </button>
                    <button type="button" class="button confirm-request submit" value="<%=r.getId()%>">
                        Chấp nhận
                    </button>
                    <%} else {%>
                    <button type="button"  class="show-request warning " style="display: none">
                        Done
                    </button>
                    <%}%>
                </td>

            </tr>

            <%}%>
            </tbody>
            <div class="modal fade" id="formAddRequest" tabindex="-1" role="dialog"
                 aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title uppercase" id="modalLongTitle">Yêu cầu bảo mật</h5>
                            <span type="button" id="closeBtn" onclick="close()">&times;</span>
                        </div>
                        <p class="error"></p>
                        <div class="modal-body">

                        </div>
<%--                        <div class="modal-footer">--%>
<%--                            <button type="button" class="button button-close submit"--%>
<%--                                    data-dismiss="modal"> Từ chối--%>
<%--                            </button>--%>
<%--                            <button type="button" class="button button-save save-request submit">--%>
<%--                                Chấp nhận--%>
<%--                            </button>--%>
<%--                        </div>--%>
                    </div>
                </div>
            </div>
        </table>

    </div>
    <div class="overlay" id="overlay">
        <div class="spinner"></div>
    </div>
</div>

<style>
    #closeBtn {
        border: none;
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }
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

<script>
function show() {
    document.getElementById('formAddRequest').style.opacity="1";
    document.getElementById('formAddRequest').style.display="block";
}
function close() {
    document.getElementById('formAddRequest').style.display="none";
    // document.getElementById('formAddRequest').style.opacity="0";
}
</script>

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
<script src="js/user-manager.js"></script>
<script>
    $(document).ready(function () {

        $('#closeBtn').click(function (){
            document.getElementById('formAddRequest').style.display="none";
        })
        $('.show-request').click(function () {
            let id = $(this).val().trim();
            // alert(id)
            $.ajax({

                url: "/userprofile/requestUserManager",
                type: "get", //send it through get method
                data: {
                    id: id,
                },
                success: function (response) {
                },
                error: function (xhr) {
                    //Do Something to handle error
                }
            });
        })
        $('.confirm-request').click(function () {
            let id = $(this).val().trim();
            let i = 1;
            $("#overlay").show();
            $.ajax({

                url: "/userprofile/confirmRequest",
                type: "get", //send it through get method
                data: {
                    id: id,
                    i:i
                },
                success: function (response) {
                    $("#overlay").hide();
                    location.reload();
                },
                error: function (xhr) {
                    $("#overlay").hide();
                    //Do Something to handle error
                }
            });
        })
        $('.refuse-request').click(function () {
            let id = $(this).val().trim();
            let i = -1;
            $("#overlay").show();
            // alert(id)
            $.ajax({

                url: "/userprofile/confirmRequest",
                type: "get", //send it through get method
                data: {
                    id: id,
                    i:i
                },
                success: function (response) {
                    $("#overlay").hide();
                    location.reload();
                },
                error: function (xhr) {
                    $("#overlay").hide();
                    //Do Something to handle error
                }
            });
        })
    })
</script>
</body>

</html>