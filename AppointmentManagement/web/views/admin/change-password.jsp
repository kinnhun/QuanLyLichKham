<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Đổi mật khẩu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/vendors/iconfonts/font-awesome/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/vendors/css/vendor.bundle.addons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/css/style.css">
    <style>
        .changepass-box {
            background: #fff;
            max-width: 430px;
            margin: 32px auto;
            border-radius: 16px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.07);
            padding: 30px 28px 24px 28px;
        }
        .changepass-box h4 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group label { font-weight: 500; }
        .btn-change-pass {
            width: 100%;
            background: #3fbbc0;
            color: #fff;
            border-radius: 8px;
            padding: 10px;
            border: none;
            margin-top: 16px;
            transition: background .2s;
        }
        .btn-change-pass:hover {
            background: #36aab0;
        }
        .alert {
            padding: 10px 18px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 15px;
        }
        .alert-danger { background: #ffe2e2; color: #b10000; }
        .alert-success { background: #e8fff3; color: #18813c; }
    </style>
</head>
<body>
    <div class="container-scroller">
        <%@ include file="./header.jsp" %>
        <div class="container-fluid page-body-wrapper">
            <%@ include file="./sidebar.jsp" %>
            <div class="main-panel">
                <div class="content-wrapper">
                    <div class="page-header">
                        <h3 class="page-title">Đổi mật khẩu</h3>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div class="changepass-box">
                                <h4><i class="fa fa-key"></i> Đổi mật khẩu tài khoản</h4>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">${error}</div>
                                </c:if>
                                <c:if test="${not empty success}">
                                    <div class="alert alert-success">${success}</div>
                                </c:if>
                                <form method="post" action="${pageContext.request.contextPath}/admin/change-password">
                                    <div class="form-group">
                                        <label for="currentPassword">Mật khẩu hiện tại</label>
                                        <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                    </div>
                                    <div class="form-group" style="margin-top: 14px;">
                                        <label for="newPassword">Mật khẩu mới</label>
                                        <input type="password" class="form-control" id="newPassword" name="newPassword" required minlength="6">
                                    </div>
                                    <div class="form-group" style="margin-top: 14px;">
                                        <label for="confirmPassword">Xác nhận mật khẩu mới</label>
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required minlength="6">
                                    </div>
                                    <button type="submit" class="btn-change-pass">
                                        <i class="fa fa-save"></i> Đổi mật khẩu
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <footer class="footer">
                    <div class="d-sm-flex justify-content-center justify-content-sm-between">
                        <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2025. All rights reserved.</span>
                        <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="far fa-heart text-danger"></i></span>
                    </div>
                </footer>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/views/admin/vendors/js/vendor.bundle.base.js"></script>
    <script src="${pageContext.request.contextPath}/views/admin/vendors/js/vendor.bundle.addons.js"></script>
    <script src="${pageContext.request.contextPath}/views/admin/js/off-canvas.js"></script>
    <script src="${pageContext.request.contextPath}/views/admin/js/hoverable-collapse.js"></script>
    <script src="${pageContext.request.contextPath}/views/admin/js/misc.js"></script>
    <script src="${pageContext.request.contextPath}/views/admin/js/settings.js"></script>
    <script src="${pageContext.request.contextPath}/views/admin/js/todolist.js"></script>
</body>
</html>
