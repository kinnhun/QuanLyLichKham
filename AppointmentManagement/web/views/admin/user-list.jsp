<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">


    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Dashboard</title>
        <!-- plugins:css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/vendors/iconfonts/font-awesome/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/vendors/css/vendor.bundle.addons.css">
        <!-- endinject -->

        <!-- inject:css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/css/style.css">
        <!-- endinject -->

        <link rel="shortcut icon" href="http://www.urbanui.com/" />

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
                                Quản lý danh sách tài khoản
                            </h3>
                        </div>

                        <div class="row">
                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
                                            <h4 class="card-title" style="margin: 0;">Danh sách Users</h4>
                                            <div>
                                                <button onclick="createUser()" style="
                                                        background-color: #3fbbc0;
                                                        color: white;
                                                        border: none;
                                                        padding: 7px 14px;
                                                        border-radius: 6px;
                                                        cursor: pointer;
                                                        font-size: 13px;
                                                        transition: background-color 0.3s ease;
                                                        ">+ Tạo người dùng</button>

                                                <script>
                                                    function createUser() {
                                                        window.location.href = 'add-user'; // trỏ đến controller AddUserController
                                                    }
                                                </script>


                                            </div>
                                        </div>






                                        <div class="datatable-wrapper">

                                            <!-- Bộ lọc + Search -->
                                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
                                                <!-- Lọc theo Vai trò -->
                                                <div>
                                                    <label for="roleFilter">Lọc theo Vai trò:</label>
                                                    <select id="roleFilter" onchange="applyFilters()">
                                                        <option value="">Tất cả</option>
                                                        <option value="Quản trị viên">Quản trị viên</option>
                                                        <option value="Lễ tân">Lễ tân</option>
                                                        <option value="Bác sĩ">Bác sĩ</option>
                                                        <option value="Bệnh nhân">Bệnh nhân</option>
                                                    </select>
                                                </div>

                                                <!-- Ô search -->
                                                <div>
                                                    <label for="searchInput">Tìm kiếm:</label>
                                                    <input type="text" id="searchInput" placeholder="Nhập từ khóa..." onkeyup="applyFilters()">
                                                </div>
                                            </div>

                                            <!-- Table scroll ngang khi cần -->
                                            <div class="table-responsive" style="overflow-x: auto;">
                                                <table id="userTable" class="table table-striped table-hover align-middle">
                                                    <thead class="table-light">
                                                        <tr>
                                                            <th class="text-center" style="min-width: 80px;">ID</th>
                                                            <th class="text-start" style="min-width: 120px;">Tên đăng nhập</th>
                                                            <th class="text-start" style="min-width: 150px;">Họ và tên</th>
                                                            <th class="text-start" style="min-width: 220px;">Email</th>
                                                            <th class="text-start" style="min-width: 130px;">Số điện thoại</th>
                                                            <th class="text-center" style="min-width: 100px;">Vai trò</th>
                                                            <th class="text-center" style="min-width: 120px;">Trạng thái</th>
                                                            <th class="text-start" style="min-width: 200px;">Ghi chú</th>
                                                            <th class="text-center" style="min-width: 150px;">Ngày tạo</th>
                                                            <th class="text-center" style="min-width: 150px;">Hành động</th>

                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="user" items="${userList}">
                                                            <tr class="clickable-row" onclick="handleRowClick(event, ${user.userId})">
                                                                <td class="text-center">${user.userId}</td>
                                                                <td class="text-start">${user.username}</td>
                                                                <td class="text-start">${user.fullName}</td>
                                                                <td class="text-start" style="word-break: break-word;">${user.email}</td>
                                                                <td class="text-start" style="word-break: break-word;">
                                                                    <c:choose>
                                                                        <c:when test="${empty user.phone}">
                                                                            <span class="text-muted">N/A</span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            ${user.phone}
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <!-- Vai trò tiếng Việt -->
                                                                <td class="text-center">
                                                                    <c:choose>
                                                                        <c:when test="${user.role eq 'Admin'}">Quản trị viên</c:when>
                                                                        <c:when test="${user.role eq 'Receptionist'}">Lễ tân</c:when>
                                                                        <c:when test="${user.role eq 'Doctor'}">Bác sĩ</c:when>
                                                                        <c:when test="${user.role eq 'Patient'}">Bệnh nhân</c:when>
                                                                        <c:otherwise>Không rõ</c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td class="text-center">
                                                                    <c:choose>
                                                                        <c:when test="${user.isActive}">
                                                                            <span class="badge bg-success">Hoạt động</span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="badge bg-danger">Ngừng hoạt động</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td class="text-start" style="word-break: break-word;">${user.note}</td>
                                                                <td class="text-center">
                                                                    <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                                                </td>
                                                                <td class="text-center">
                                                                    <c:if test="${user.role ne 'Admin'}">
                                                                        <button 
                                                                            type="button" 
                                                                            class="btn btn-sm ${user.isActive ? 'btn-danger' : 'btn-success'}" 
                                                                            data-userid="${user.userId}" 
                                                                            data-username="${user.username}" 
                                                                            data-isactive="${user.isActive}" 
                                                                            onclick="event.stopPropagation(); openToggleModal(this)">
                                                                            ${user.isActive ? 'Ban' : 'Unban'}
                                                                        </button>

                                                                    </c:if>
                                                                    <c:if test="${user.role eq 'Admin'}">
                                                                        <span class="text-muted" style="font-size: 12px;">Không khả dụng</span>
                                                                    </c:if>
                                                                </td>

                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <script>
                                                function handleRowClick(event, userId) {
                                                    window.location.href = 'user-detail?userId=' + userId;
                                                }
                                            </script>

                                            <!-- Modal xác nhận Ban/Unban -->
                                            <div class="modal fade" id="confirmToggleModal" tabindex="-1" aria-labelledby="confirmToggleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <form id="toggleForm" method="post" action="toggle-user-status">
                                                        <input type="hidden" name="userId" id="modalUserId" />
                                                        <input type="hidden" name="newStatus" id="modalNewStatus" />
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="confirmToggleModalLabel">Xác nhận hành động</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <p id="modalBodyContent"></p>
                                                                <div id="banReasonGroup" style="display:none; margin-top: 1rem;">
                                                                    <label for="banReasonInput" class="form-label">Lý do ban:</label>
                                                                    <input type="text" name="banReason" id="banReasonInput" class="form-control" placeholder="Nhập lý do ban" />
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                                <button type="submit" class="btn btn-primary">Xác nhận</button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>


                                            <script>
                                                function openToggleModal(button) {
                                                    const userId = button.getAttribute('data-userid');
                                                    const username = button.getAttribute('data-username');
                                                    const isActive = button.getAttribute('data-isactive') === 'true';

                                                    // Set hidden inputs
                                                    document.getElementById('modalUserId').value = userId;
                                                    document.getElementById('modalNewStatus').value = !isActive;

                                                    const actionText = isActive ? 'ban' : 'unban';
                                                    document.getElementById('modalBodyContent').innerText = `Bạn có chắc muốn ${actionText} user "${username}" không?`;

                                                    // Hiện hoặc ẩn input lý do ban
                                                    const banReasonGroup = document.getElementById('banReasonGroup');
                                                    const banReasonInput = document.getElementById('banReasonInput');

                                                    if (isActive) {
                                                        // Nếu đang active thì đang ban → show input lý do và clear value
                                                        banReasonGroup.style.display = 'block';
                                                        banReasonInput.value = '';
                                                        banReasonInput.required = true;
                                                    } else {
                                                        // Nếu đang bị ban, chuẩn bị unban → ẩn input lý do
                                                        banReasonGroup.style.display = 'none';
                                                        banReasonInput.value = '';
                                                        banReasonInput.required = false;
                                                    }

                                                    // Hiển thị modal
                                                    const modal = new bootstrap.Modal(document.getElementById('confirmToggleModal'));
                                                    modal.show();
                                                }

                                            </script>


                                            <!-- Nút phân trang - căn phải -->
                                            <div style="margin-top: 12px; display: flex; justify-content: flex-end; align-items: center; font-size: 13px;">
                                                <button onclick="previousPage()">Trang trước</button>
                                                <span id="pageInfo" style="margin: 0 10px;">Trang 1</span>
                                                <button onclick="nextPage()">Trang sau</button>
                                            </div>
                                        </div>

                                        <!-- Script lọc + search + phân trang -->
                                        <script>
                                            let currentPage = 1;
                                            const rowsPerPage = 5; // 5 dòng 1 trang

                                            function applyFilters() {
                                                const searchValue = document.getElementById('searchInput').value.toLowerCase();
                                                const roleValue = document.getElementById('roleFilter').value;

                                                const table = document.getElementById('userTable');
                                                const tbody = table.getElementsByTagName('tbody')[0];
                                                const rows = tbody.getElementsByTagName('tr');

                                                let visibleRows = [];

                                                for (let i = 0; i < rows.length; i++) {
                                                    let rowText = rows[i].innerText.toLowerCase();
                                                    let roleText = rows[i].getElementsByTagName('td')[5].innerText.trim();

                                                    if ((rowText.includes(searchValue)) && (roleValue === "" || roleText === roleValue)) {
                                                        rows[i].style.display = '';
                                                        visibleRows.push(rows[i]);
                                                    } else {
                                                        rows[i].style.display = 'none';
                                                    }
                                                }

                                                paginate(visibleRows);
                                            }

                                            function paginate(visibleRows) {
                                                let totalRows = visibleRows.length;
                                                let totalPages = Math.ceil(totalRows / rowsPerPage);

                                                // Cập nhật trang nếu vượt quá tổng số trang
                                                if (currentPage > totalPages) {
                                                    currentPage = totalPages;
                                                }
                                                if (currentPage < 1) {
                                                    currentPage = 1;
                                                }

                                                for (let i = 0; i < totalRows; i++) {
                                                    if (i >= (currentPage - 1) * rowsPerPage && i < currentPage * rowsPerPage) {
                                                        visibleRows[i].style.display = '';
                                                    } else {
                                                        visibleRows[i].style.display = 'none';
                                                    }
                                                }

                                                // Cập nhật số trang hiển thị
                                                document.getElementById('pageInfo').innerText = 'Trang ' + currentPage + ' / ' + (totalPages === 0 ? 1 : totalPages);
                                            }

                                            function previousPage() {
                                                currentPage--;
                                                applyFilters();
                                            }

                                            function nextPage() {
                                                currentPage++;
                                                applyFilters();
                                            }

                                            // Khởi tạo lần đầu khi load trang
                                            window.onload = function () {
                                                applyFilters();
                                            }
                                        </script>


                                        <style>
                                            /* Bộ lọc và search */
                                            .datatable-wrapper > div:first-child {
                                                padding: 10px 0;
                                                border-bottom: 1px solid #ddd;
                                                background-color: #f9f9f9;
                                                border-radius: 8px;
                                                padding: 10px 15px;
                                                margin-bottom: 10px;
                                                display: flex;
                                                justify-content: space-between;
                                                align-items: center;
                                            }

                                            .datatable-wrapper label {
                                                font-weight: 500;
                                                margin-right: 5px;
                                                color: #333;
                                                font-size: 13px;
                                            }

                                            .datatable-wrapper select,
                                            .datatable-wrapper input[type="text"] {
                                                padding: 5px 10px;
                                                border-radius: 6px;
                                                border: 1px solid #ccc;
                                                font-size: 13px;
                                                transition: all 0.3s ease;
                                            }

                                            .datatable-wrapper select:focus,
                                            .datatable-wrapper input[type="text"]:focus {
                                                border-color: #3fbbc0;
                                                box-shadow: 0 0 5px rgba(63, 187, 192, 0.5);
                                                outline: none;
                                            }

                                            /* Table */
                                            .table-responsive {
                                                border: 1px solid #ddd;
                                                border-radius: 8px;
                                                overflow: hidden;
                                            }

                                            .table {
                                                margin-bottom: 0;
                                                font-size: 13px;
                                                color: #333;
                                            }

                                            .table thead th {
                                                background-color: #f0f4f7;
                                                color: #333;
                                                border-bottom: 2px solid #ddd;
                                            }

                                            .table-striped > tbody > tr:nth-of-type(odd) {
                                                background-color: #f9fcfd;
                                            }

                                            .table-hover > tbody > tr:hover {
                                                background-color: #eef6f8;
                                            }

                                            /* Badge trạng thái */
                                            .badge {
                                                padding: 4px 8px;
                                                font-size: 12px;
                                                border-radius: 12px;
                                            }

                                            .badge.bg-success {
                                                background-color: #28a745 !important;
                                                color: white;
                                            }

                                            .badge.bg-danger {
                                                background-color: #dc3545 !important;
                                                color: white;
                                            }

                                            /* Nút phân trang - căn phải */
                                            .datatable-wrapper > div:last-child {
                                                margin-top: 12px;
                                                display: flex;
                                                justify-content: flex-end; /* căn phải */
                                                align-items: center;
                                                font-size: 13px;
                                            }

                                            .datatable-wrapper button {
                                                background-color: #3fbbc0;
                                                color: white;
                                                border: none;
                                                padding: 6px 12px;
                                                margin: 0 5px;
                                                border-radius: 6px;
                                                cursor: pointer;
                                                font-size: 13px;
                                                transition: background-color 0.3s ease;
                                            }

                                            .datatable-wrapper button:hover {
                                                background-color: #36aab0;
                                            }

                                            #pageInfo {
                                                font-weight: 500;
                                                color: #333;
                                                font-size: 13px;
                                            }
                                        </style>








                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>





                    <!-- content-wrapper ends -->
                    <!-- partial:partials/_footer.html -->
                    <footer class="footer">
                        <div class="d-sm-flex justify-content-center justify-content-sm-between">
                            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2018. All rights reserved.</span>
                            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="far fa-heart text-danger"></i></span>
                        </div>
                    </footer>
                    <!-- partial -->
                </div>
                <!-- main-panel ends -->
            </div>
            <!-- page-body-wrapper ends -->
        </div>
        <!-- container-scroller -->

        <!-- plugins:js -->
        <script src="${pageContext.request.contextPath}/views/admin/vendors/js/vendor.bundle.base.js"></script>
        <script src="${pageContext.request.contextPath}/views/admin/vendors/js/vendor.bundle.addons.js"></script>
        <!-- endinject -->

        <!-- Plugin js for this page-->
        <!-- End plugin js for this page-->

        <!-- inject:js -->
        <script src="${pageContext.request.contextPath}/views/admin/js/off-canvas.js"></script>
        <script src="${pageContext.request.contextPath}/views/admin/js/hoverable-collapse.js"></script>
        <script src="${pageContext.request.contextPath}/views/admin/js/misc.js"></script>
        <script src="${pageContext.request.contextPath}/views/admin/js/settings.js"></script>
        <script src="${pageContext.request.contextPath}/views/admin/js/todolist.js"></script>
        <!-- endinject -->

        <!-- Custom js for this page-->
        <script src="${pageContext.request.contextPath}/views/admin/js/dashboard.js"></script>
        <!-- End custom js for this page-->

        <script src="${pageContext.request.contextPath}/views/admin/js/data-table.js"></script>
        <!-- End custom js for this page-->

    </body>


</html>
