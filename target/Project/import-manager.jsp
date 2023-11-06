<%@ page import="java.util.List" %>
<%@ page import="bean.Format" %>
<%@ page import="bean.Vendor" %>
<%@ page import="bean.Import" %>
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
<div class="card-body px-0 pb-2 content">
    <div class="table">
        <div class="table-cart">
            <h2>Danh sách đơn nhập hàng</h2>
            <div class="right">
                <button type="button" class="btn-add-address button submit add" onclick="show()">Tạo phiếu
                </button>
            </div>

            <table id="dtHorizontalVerticalExample" class="table table-striped table-bordered table-sm "
                   cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>Ngày nhập hàng</th>
                    <th>Nhà cung cấp</th>
                    <th>Số điện thoại</th>
                    <th>Số lượng sản phẩm</th>
                    <th>Nhân viên nhập kho</th>
                    <th>Trạng thái đơn hàng</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <% List<Import> list = (List<Import>) request.getAttribute("importList");
                    for (Import anImpor : list) {%>
                <tr class="product-<%=anImpor.getId()%>">
                    <td><%=anImpor.getCreateDate()%>
                    </td>
                    <td><%=anImpor.getVendor().getInformation().getName()%>
                    </td>
                    <td><%=anImpor.getVendor().getInformation().getPhone()%>
                    </td>
                    <td><%=anImpor.getListLineItem().size()%>
                    </td>
                    <td><%=anImpor.getUserImport().getName()%>
                    </td>
                    <td>
                        <select class="input-status statusImport<%=anImpor.getId()%>">
                            <option value="0" <%=anImpor.getStatus() == 0 ? "selected" : " "%>>Đang Duyệt</option>
                            <option value="1" <%=anImpor.getStatus() == 1 ? "selected" : " "%>>Đã duyệt</option>
                            <option value="2" <%=anImpor.getStatus() == 2 ? "selected" : " "%>>Chờ nhận hàng</option>
                            <option value="3" <%=anImpor.getStatus() == 3 ? "selected" : " "%>>Nhập hàng thành công
                            </option>
                        </select>
                    </td>
                    <td>
                        <button class="edit-product button " value="<%=anImpor.getId()%>"
                                onclick="showDetail(this)">
                            <i class="far fa-eye"></i>
                        </button>
                        <button class="edit-product button " value="<%=anImpor.getId()%>"
                                onclick="editStatus(this)">
                            <i class="fas fa-pen"></i>
                        </button>
                    </td>

                </tr>
                <%}%>
                </tbody>
            </table>


        </div>
    </div>
</div>
<div id="detail-import">
</div>
<div id="add-Import">
    <section class="container">
        <div id="border-import">
            <form class="form">
                <button class="close" onclick="hide()"><i class="fas fa-times"></i></button>
                <header>Tạo phiếu nhập hàng</header>
                <div class="input-box">
                    <label> Nhà cung cấp</label>
                    <select name="vendor" id="vendor" class="vendor">
                        <% List<Vendor> vendorList = (List<Vendor>) request.getAttribute("vendors");
                            for (Vendor vendor : vendorList) { %>
                        <option value="<%=vendor.getId()%>" selected><%=vendor.getInformation().getName()%>
                        </option>
                        <% }
                        %>
                    </select>
                </div>
                <div class="input-box">
                    <label>Số điện thoại</label>
                    <input type="text" name="email" placeholder="Số điện thoại" required/>
                </div>

                <div class="input-box address">
                    <label>Địa chỉ</label>
                    <input type="text" name="detail" placeholder="Số nhà,tên đường, xã/phường" required/>
                    <input type="text" name="district" placeholder="Quận/huyện" required/>
                    <input type="text" name="city" placeholder="Tỉnh/thành phố" required/>
                </div>
                <div class="input-box productAdd">
                    <lable>Sản phẩm</lable>
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
                        <tr class="import-item" id="product1">
                            <td class="stt "><input type="button" value="1" name="indexRow"></td>
                            <td><input id="nameProduct1" name="nameProduct" type="text" class="nameProduct" value=""
                                       required></td>
                            <td><input id="quantity1" name="quantity" type="number" class="quantity" min="0" value=""
                                       required>
                            </td>
                            <td><input id="priceImport1" name="priceImport" type="number" min="0" class="priceImport"
                                       value=""
                                       required></td>
                            <td>
                                <div class="buttonItem">
                                    <p type="button" class="minus icon" onclick="remove('product1')"><i
                                            class="fas fa-minus"></i></p></div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="input-box">
                    <div><p type="button" class="plus icon" onclick="addRow()"><i
                            class="fas fa-plus"></i>
                    </p></div>
                </div>
                <div class="input-box">
                    <label>Tổng tiền: <p></p></label>
                </div>
                <div class="input-box">
                    <label>Ghi chú</label>
                    <textarea name="note" id="note" cols="105" rows="5"></textarea>
                </div>
                <div class="bottom-form">
                    <div class="submit" onclick="addImport()"> Thêm</div>
                    <div type="button" class="submit cant" onclick="hide()">Hủy</div>
                    <input id="jsonItem" name="jsonItem" value="" style="display: none">
                </div>
            </form>
        </div>
    </section>
    <div class="margin-b"></div>
</div>

<script type="text/javascript">
    // thêm phiếu nhập hàng
    function addImport() {
        let vendorId = $('.vendor').find(":selected").val();
        let note = $('#note').val();
        const name = document.getElementsByName('nameProduct');
        const quantity = document.getElementsByName('quantity');
        const priceImport = document.getElementsByName('priceImport');
        let sizeList = document.getElementsByClassName('import-item').length;
        console.log(sizeList)
        var arr = [];
        for (let i = 0; i < sizeList; i++) {
            var item = {
                id: 0,
                name: name[i].value,
                quantity: quantity[i].value,
                priceImport: priceImport[i].value,
            }
            arr[i] = item;
        }
        console.log(arr)
        var jsonItem = JSON.stringify(arr);
        $('#jsonItem').val(jsonItem);
        console.log($('#jsonItem').val())
        $.ajax({
            url: "/addImport",
            type: "get",
            data: {
                vendorId: vendorId,
                note: note,
                jsonItem: $('#jsonItem').val(),
            }, success: function (data) {
                alert("Tạo phiếu thành công")
                location.reload();
            }, error: function (error) {

            }
        })

    }

    function show() {
        document.getElementById('add-Import').style.display = "block";
    }

    function hide() {
        document.getElementById('add-Import').style.display = "none";
    }

    function closes() {
        document.getElementById('detail-import').style.display = "none";
        $('.contents').delete();
    }

    // Xem chi tiết nhập hàng
    function showDetail(param) {
        var id = param.value;
        $.ajax({
                url: "/importDetail",
                type: "get",
                data: {
                    id: id,
                },
                success: function (data) {
                    $('#detail-import').html(data);
                },
                error: function (xhr) {

                }
            }
        )
        document.getElementById("detail-import").style.display = "block";
    }

    // Chỉnh sửa trạng thái phiếu nhập hàng
    function editStatus(param) {
        var id = param.value;
        var status = $('.statusImport' + id).val();
        window.location = "/editStatusImport?id=" + id + "&status=" + status;
    }

    // Xóa hàng nhập sản phẩm
    function remove(id) {
        document.getElementById(id).remove();
        const totalRow = document.getElementsByClassName('import-item').length;
        var elementIndexRow = document.getElementsByName('indexRow');
        for (let i = 1; i <= totalRow; i++) {
            elementIndexRow[i].value = i;
        }

    }

    // Thêm hàng nhập sản phẩm
    function addRow() {
        let index = document.getElementsByClassName('import-item').length + 1;
        $('#import-group').append("  <tr class=\"import-item\" id=\"product" + index + "\">\n" +
            "                            <td class=\"stt \"><input type=\"button\" value=\"" + index + "\" name=\"indexRow\"></td>\n" +
            "                            <td><input id=\"nameProduct" + index + "\" name=\"nameProduct\" type=\"text\"></td>\n" +
            "                            <td><input id=\"quantity" + index + "\" name=\"quantity\" min='0' type=\"number\"></td>\n" +
            "                            <td><input id=\"priceImport" + index + "\" name=\"priceImport\" min='0' type=\"number\"></td>\n" +
            "                            <td>\n" +
            "                                <div class=\"buttonItem\">" +
            "                                    <p type=\"button\" class=\"minus icon\" onclick=\"remove('product" + index + "')\"><i\n" +
            "                                            class=\"fas fa-minus\"></i></p></div>\n" +
            "                            </td>\n" +
            "                        </tr>");
    }
</script>

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
</body>

</html>