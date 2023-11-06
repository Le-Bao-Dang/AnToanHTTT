<%@ page import="java.util.List" %>
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
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Cấp quyền
                </th>
                <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                    Trạng thái
                </th>
                <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                    Số điện thoại
                </th>
                <th class="text-secondary opacity-7"></th>
            </tr>
            </thead>
            <tbody>
            <%
                List<User> list = (List<User>) request.getAttribute("listUser");
                for (int i = 1; i < list.size(); i++) {
            %>
            <tr>
                <td>
                    <div class="d-flex px-2 py-1">
                        <div>
                            <img src="<%=list.get(i).getAvatar().getSource()%>" class="avatar avatar-sm me-3 border-radius-lg"
                                 alt="user1">
                        </div>
                        <div class="d-flex flex-column justify-content-center">
                            <h6 class="mb-0 text-sm"><%=list.get(i).getName()%>
                            </h6>
                            <p class="text-xs text-secondary mb-0"><%=list.get(i).getEmail()%>
                            </p>
                        </div>
                    </div>
                </td>
                <td>
                    <%--                            <p class="text-xs font-weight-bold mb-0"><%=list.get(i).getVarieties()%></p>--%>

                    <select class="input-varieties user-varieties<%=list.get(i).getId()%>">
                        <option value="2" <%=list.get(i).getVariety() == 2 ? "selected" : " "%>>Quản lý</option>
                        <option value="1" <%=list.get(i).getVariety() == 1 ? "selected" : " "%>>Cộng tác viên</option>
                        <option value="0" <%=list.get(i).getVariety() == 0 ? "selected" : " "%>>Khách hàng</option>
                    </select>
                </td>
                <td class="align-middle text-center text-sm">
                    <select class="input-stt user-stt<%=list.get(i).getId()%>">
                        <option value="2" <%=list.get(i).getStatus() == 2 ? "selected" : " "%>>Khóa vĩnh viễn</option>
                        <option value="1" <%=list.get(i).getStatus() == 1 ? "selected" : " "%>>Tạm khóa</option>
                        <option value="0" <%=list.get(i).getStatus() == 0 ? "selected" : " "%>>Đang hoạt động</option>
                    </select>
                </td>
                <td class="align-middle text-center">
                    <span class="text-secondary text-xs font-weight-bold"><%=list.get(i).getPhone()%></span>
                </td>
                <td class="align-middle">
                    <button class="edit-user submit" value="<%=list.get(i).getId()%>" style="width: 150px">
                        Lưu thay đổi
                    </button>
                </td>
            </tr>
            <%}%>


            </tbody>
        </table>
    </div>
</div>

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
</body>

</html>