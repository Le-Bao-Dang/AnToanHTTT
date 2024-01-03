$(document).ready(function () {
    $('#infor-tab').click(function () {
        window.location = "<%=request.getContextPath()%>/userProfile";
    });
});
