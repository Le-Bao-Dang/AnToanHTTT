<%@ page import="java.util.List" %>
<%@ page import="bean.*" %>
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
    <link rel="stylesheet" href="css/general-manager.css">
</head>

<body>
<%@include file="header-admin.jsp" %>
<div class="content">
    <div class="manager-banner">
        <h3>Quản lý ảnh bìa</h3>
        <button type="button" class="btn-add-address button submit add" data-toggle="modal"
                data-target="#exampleModalCenter">Thêm
        </button>
        <div class="table-wrapper-scroll-y my-custom-scrollbar table-banner">

            <table class="table table-bordered table-striped mb-0">
                <thead>
                <tr>
                    <th>Mã ảnh bìa</th>
                    <th>Tên ảnh bìa</th>
                    <th>Hình ảnh</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
<%--                <%--%>
<%--                    List<Banner> bannerList = (List<Banner>) request.getAttribute("listBanner");--%>
<%--                    for (Banner banner : bannerList) {--%>
<%--                %>--%>
<%--                <tr class="name<%=banner.getId()%>">--%>
<%--                    <td><%=banner.getId()%>--%>
<%--                    </td>--%>
<%--                    <td><%=banner.getName()%>--%>
<%--                    </td>--%>
<%--                    <td><img src="<%=banner.getImage_src()%>" alt="" style="width: 200px; height: 100px"></td>--%>
<%--                    <td>--%>
<%--                        <button class="edit-banner button submit" value="<%=banner.getId()%>" data-toggle="modal"--%>
<%--                                data-target="#exampleModalCenterEdit">--%>
<%--                            Sửa--%>
<%--                        </button>--%>
<%--                        <button type="button" class="delete-banner button submit" class="button btn-indigo btn-sm m-0 delete button submit"--%>
<%--                                value="<%=banner.getId()%>">Xóa--%>
<%--                        </button>--%>
<%--                    </td>--%>
<%--                </tr>--%>
<%--                <%}%>--%>
                </tbody>
            </table>
            <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog"
                 aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title uppercase" id="exampleModalLongTitle">Thêm quảng cáo mới</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form class="form-add-address">
                                <div class="name">
                                    <label>Tên quảng cáo</label>
                                    <select class="input" type="text" name="name" id="input-name">
                                        <option value="home">Trang chủ</option>
                                        <option value="product">Sản phẩm</option>
                                        <option value="none">
                                            <Ẩn></Ẩn>
                                        </option>
                                    </select></div>
                                <form action="/admins/uploadImageBanner" method="post" class="upload"
                                      enctype="multipart/form-data">
                                    <label>Hình ảnh </label>
                                    <div class="row">
                                        <img src="#" class="images" style="width: 98px; height: 100px">
                                        <input type="file" name="img-banner" id="file-img" class="input-img"
                                               accept="image/png">
                                    </div>
                                    <button type="submit" style="display: none" class="download-image"></button>
                                </form>
                                <div class="modal-footer">
                                    <button type="button" class="button button-close" data-dismiss="modal">Hủy
                                    </button>
                                    <button type="button" class="button button-save" id="addBanner"
                                            value="Lưu sản phẩm">Thêm ảnh bìa
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="exampleModalCenterEdit" tabindex="-1" role="dialog"
                 aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title uppercase" id="Title">Thêm sản phẩm mới</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body form-edit">

                        </div>


                    </div>
                </div>
            </div>

        </div>


    </div>
    <div class="manager-kindProduct">
        <h3>Quản lý danh mục sản phẩm</h3>
        <button type="button" class="btn-add-address button submit add" data-toggle="modal"
                data-target="#exampleModalCenterDanhMuc">Thêm
        </button>
        <div class="table-wrapper-scroll-y my-custom-scrollbar table-banner">

            <table class="table table-bordered table-striped mb-0">
                <thead>
                <tr>
                    <th>Mã danh mục</th>
                    <th>Tên danh mục</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<Category> paCategoryList = (List<Category>) request.getAttribute("listPaCategory");
                    for (Category pa : paCategoryList) {
                %>
                <tr class="name<%=pa.getPaCategory()%>">
                    <td><%=pa.getId()%>
                    </td>
                    <td><%=pa.getName()%>
                    </td>
                    <td>
                                                <button class="edit-pa" value="<%=pa.getId()%>">Lưu sữa đổi</button>
                        <button type="button" class="delete-pa submit" class="button btn-indigo btn-sm m-0 delete"
                                value="<%=pa.getPaCategory()%>">Xóa
                        </button>

                    </td>
                </tr>
                <%}%>
                </tbody>
            </table>
            <div class="modal fade" id="exampleModalCenterDanhMuc" tabindex="-1" role="dialog"
                 aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title uppercase" id="exampleModalLongTitleDanhMuc">Thêm danh mục mới</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form class="form-add-address">
                                <div class="name">
                                    <label>Tên quảng cáo</label>

                                    <input type="text" id="input-pa">
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="button button-close" data-dismiss="modal">Hủy
                                    </button>
                                    <button type="button" class="button button-save" id="addPacategory"
                                            value="Lưu sản phẩm">Thêm danh mục
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>


        </div>


    </div>
        <div class="manager-groupProduct">
            <h3>Quản lý nhóm sản phẩm</h3>
            <button type="button" class="btn-add-address button submit add" data-toggle="modal"
                    data-target="#exampleModalCenterGroup">Thêm
            </button>
            <div class=" table-group">

                <table class="table">
                    <thead>
                    <tr>
                        <th>Mã nhóm sản phẩm</th>
                        <th>Nhóm sản phẩm</th>
                        <th>Tên danh mục</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Category> categoryList = (List<Category>) request.getAttribute("listCategory");
                        for (Category ca : categoryList) {
                    %>
                    <tr class="name">
                        <td><%=ca.getId()%></td>
                        <td><%=ca.getName()%></td>
                        <td><%=ca.getPaCategory().getName()%></td>
                        <td>
                                                    <button class="edit-pa" value="<%=ca.getPaCategory()%>">Lưu sữa đổi</button>
                            <button class="delete-ca"
                                    value="<%=ca.getId()%>">Xóa
                            </button>

                        </td>
                    </tr>
                    <%}%>
                    </tbody>
                </table>


            </div>


        </div>

</div>
</div>


<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
<script src="js/general-manager.js"></script>
</body>

</html>