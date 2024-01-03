<%@ page import="java.util.List" %>
<%@ page import="bean.Contact" %>
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
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Tên người phản hồi
                </th>

                <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                    Nội dung phản hồi
                </th>
                <th class="text-secondary opacity-7"></th>
            </tr>
            </thead>
            <tbody>
<%--            <%--%>
<%--                List<Contact> list = (List<Contact>) request.getAttribute("listContact");--%>
<%--                for (Contact c : list) {--%>
<%--            %>--%>
<%--            <tr class="contactS<%=c.getId()%>">--%>
<%--                <td>--%>
<%--                    <div class="d-flex px-2 py-1">--%>
<%--                        <div class="d-flex flex-column justify-content-center">--%>
<%--                            <h6 class="mb-0 text-sm"><%=c.getName()%>--%>
<%--                            </h6>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </td>--%>


<%--                <td class="align-middle text-center">--%>
<%--                    <span class="text-secondary text-xs font-weight-bold"><%=c.getContent()%></span>--%>
<%--                </td>--%>
<%--                <td class="align-middle">--%>
<%--                    <button class="delete-contact" value="<%=c.getId()%>">--%>
<%--                        Xóa--%>
<%--                    </button>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            <%}%>--%>


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
<script>
    $('.delete-contact').click(function () {
        $.ajax({
            url: "/admins/deleteContact",
            type: "get",
            data: {
                id: $(this).val().trim()
            },
            success: function () {
                window.location='<%=request.getContextPath()%>/contactManager';
            }
        })

    })
</script>
</body>

</html>