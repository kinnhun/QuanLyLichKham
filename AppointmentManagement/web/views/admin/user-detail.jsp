<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Chi tiết người dùng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/vendors/iconfonts/font-awesome/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/vendors/css/vendor.bundle.addons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/css/style.css">
    <link rel="shortcut icon" href="http://www.urbanui.com/" />
</head>

<body>
    <div class="container-scroller">
        <%@ include file="./header.jsp" %>
        <div class="container-fluid page-body-wrapper">
            <%@ include file="./sidebar.jsp" %>
            <div class="main-panel">
                <div class="content-wrapper">
                    <div class="page-header d-flex justify-content-between align-items-center">
                        <h3 class="page-title">Thông tin chi tiết người dùng</h3>
                        <div>
                            <a href="${pageContext.request.contextPath}/admin/user-list" class="btn btn-sm btn-secondary me-2">← Quay lại danh sách</a>
                            <button class="btn btn-sm btn-primary" onclick="openEditModal()">✏️ Sửa thông tin</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 stretch-card">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="mb-4 fw-bold text-primary">Thông tin Người Dùng</h4>
                                    <div class="container-fluid px-0">
                                        <div class="row g-3">
                                            <c:set var="colClass" value="col-md-4 col-sm-6" />
                                            <div class="${colClass}"><div class="p-3 border rounded bg-light h-100"><label class="text-muted small">Mã người dùng (ID)</label><div class="fw-semibold fs-6">${user.userId}</div></div></div>
                                            <div class="${colClass}"><div class="p-3 border rounded bg-light h-100"><label class="text-muted small">Tên đăng nhập</label><div class="fw-semibold fs-6">${user.username}</div></div></div>
                                            <div class="${colClass}"><div class="p-3 border rounded bg-light h-100"><label class="text-muted small">Họ và tên</label><div class="fw-semibold fs-6">${user.fullName}</div></div></div>
                                            <div class="${colClass}"><div class="p-3 border rounded bg-light h-100"><label class="text-muted small">Email</label><div class="fw-semibold fs-6">${user.email}</div></div></div>
                                            <div class="${colClass}"><div class="p-3 border rounded bg-light h-100"><label class="text-muted small">Số điện thoại</label><div class="fw-semibold fs-6"><c:choose><c:when test="${empty user.phone}"><span class="text-muted">N/A</span></c:when><c:otherwise>${user.phone}</c:otherwise></c:choose></div></div></div>
                                            <div class="${colClass}"><div class="p-3 border rounded bg-light h-100"><label class="text-muted small">Vai trò</label><div class="fw-semibold fs-6"><c:choose><c:when test="${user.role eq 'Admin'}">Quản trị viên</c:when><c:when test="${user.role eq 'Receptionist'}">Lễ tân</c:when><c:when test="${user.role eq 'Doctor'}">Bác sĩ</c:when><c:when test="${user.role eq 'Patient'}">Bệnh nhân</c:when><c:otherwise>Không rõ</c:otherwise></c:choose></div></div></div>
                                            <div class="${colClass}"><div class="p-3 border rounded bg-light h-100"><label class="text-muted small">Trạng thái</label><div class="fw-semibold fs-6"><span class="badge rounded-pill ${user.isActive ? 'bg-success' : 'bg-danger'}">${user.isActive ? 'Hoạt động' : 'Ngừng hoạt động'}</span></div></div></div>
                                            <div class="${colClass}"><div class="p-3 border rounded bg-light h-100"><label class="text-muted small">Ghi chú</label><div class="fw-semibold fs-6"><c:choose><c:when test="${empty user.note}"><span class="text-muted">Không có</span></c:when><c:otherwise>${user.note}</c:otherwise></c:choose></div></div></div>
                                            <div class="${colClass}"><div class="p-3 border rounded bg-light h-100"><label class="text-muted small">Ngày tạo</label><div class="fw-semibold fs-6"><fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy HH:mm" /></div></div></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal sửa thông tin -->
                <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <form method="post" action="${pageContext.request.contextPath}/admin/update-user">
                            <input type="hidden" name="userId" value="${user.userId}" />
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Sửa thông tin người dùng</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Họ và tên</label>
                                            <input type="text" name="fullName" value="${user.fullName}" class="form-control" required />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Email</label>
                                            <input type="email" name="email" value="${user.email}" class="form-control" required />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Số điện thoại</label>
                                            <input type="text" name="phone" value="${user.phone}" class="form-control" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Ghi chú</label>
                                            <input type="text" name="note" value="${user.note}" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- Footer -->
                <footer class="footer">
                    <div class="d-sm-flex justify-content-center justify-content-sm-between">
                        <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2018. All rights reserved.</span>
                        <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="far fa-heart text-danger"></i></span>
                    </div>
                </footer>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/views/admin/vendors/js/vendor.bundle.base.js"></script>
    <script src="${pageContext.request.contextPath}/views/admin/vendors/js/vendor.bundle.addons.js"></script>
    <script src="${pageContext.request.contextPath}/views/admin/js/off-canvas.js"></script>
    <script src="${pageContext.request.contextPath}/views/admin/js/hoverable-collapse.js"></script>
    <script src="${pageContext.request.contextPath}/views/admin/js/misc.js"></script>
    <script src="${pageContext.request.contextPath}/views/admin/js/settings.js"></script>
    <script src="${pageContext.request.contextPath}/views/admin/js/todolist.js"></script>
    <script>
        function openEditModal() {
            var modal = new bootstrap.Modal(document.getElementById('editUserModal'));
            modal.show();
        }
    </script>
</body>
</html>
