<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Hồ sơ Admin</title>
        <!-- plugins:css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/vendors/iconfonts/font-awesome/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/vendors/css/vendor.bundle.addons.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/css/style.css">
        <link rel="shortcut icon" href="http://www.urbanui.com/" />
        <style>
            .profile-box {
                background: #fff;
                border-radius: 14px;
                padding: 32px 26px 22px 26px;
                max-width: 540px;
                margin: 24px auto;
                box-shadow: 0 4px 18px rgba(0,0,0,0.07);
            }
            .profile-avatar {
                width: 90px;
                height: 90px;
                border-radius: 50%;
                object-fit: cover;
                margin-bottom: 16px;
            }
            .profile-info th {
                text-align: left;
                color: #888;
                width: 140px;
                font-weight: 500;
                padding-right: 14px;
            }
            .profile-info td {
                font-weight: 500;
                color: #111;
            }
            .btn-profile-edit {
                background: #3fbbc0;
                color: #fff;
                border: none;
                border-radius: 8px;
                padding: 8px 22px;
                margin-top: 18px;
                transition: background .2s;
            }
            .btn-profile-edit:hover {
                background: #36aab0;
            }
            .badge-role-admin {
                background: #3fbbc0;
                color: #fff;
                font-size: 12px;
                padding: 4px 10px;
                border-radius: 12px;
                margin-left: 8px;
            }
            .badge-role-other {
                background: #888;
                color: #fff;
                font-size: 12px;
                padding: 4px 10px;
                border-radius: 12px;
                margin-left: 8px;
            }
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
                            <h3 class="page-title">
                                Hồ sơ cá nhân (Admin)
                            </h3>
                        </div>
                        <div class="profile-box">
                            <div style="text-align:center">
                                <!-- Nếu bạn có trường avatar có thể thay bằng src khác -->
                                <img src="https://ui-avatars.com/api/?name=${adminUser.fullName}&background=3fbbc0&color=fff&size=128"
                                     alt="avatar" class="profile-avatar"/>
                                <h4 style="margin-top: 10px;">
                                    ${userProfile.fullName}
                                    <c:choose>
                                        <c:when test="${adminUser.role eq 'Admin'}">
                                            <span class="badge-role-admin">Admin</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-role-other">${adminUser.role}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </h4>
                                <div style="color: #999; font-size:13px;">Mã người dùng: <b>${adminUser.userId}</b></div>
                            </div>
                            <table class="profile-info" style="margin: 22px auto 0 auto;">
                                <tr>
                                    <th>Username</th>
                                    <td>${userProfile.username}</td>
                                </tr>
                                <tr>
                                    <th>Email</th>
                                    <td>${userProfile.email}</td>
                                </tr>
                                <tr>
                                    <th>Điện thoại</th>
                                    <td>${userProfile.phone}</td>
                                </tr>
                                <tr>
                                    <th>Trạng thái</th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${userProfile.isActive}">
                                                <span class="badge bg-success">Đang hoạt động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">Đã khóa</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Ngày tạo</th>
                                    <td>
                                        <fmt:formatDate value="${userProfile.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Ghi chú</th>
                                    <td>
                                        <c:out value="${userProfile.note}" default="Không có"/>
                                    </td>
                                </tr>
                            </table>
                            <div style="text-align:center;">
                                <a href="${pageContext.request.contextPath}/admin/profile-edit" class="btn-profile-edit">
                                    <i class="fa fa-edit"></i> Chỉnh sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/change-password" class="btn-profile-edit" style="margin-left: 12px; background: #ffb200;">
                                    <i class="fa fa-key"></i> Đổi mật khẩu
                                </a>
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
