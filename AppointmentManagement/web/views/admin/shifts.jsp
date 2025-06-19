<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Quản lý ca làm</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/vendors/iconfonts/font-awesome/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/vendors/css/vendor.bundle.addons.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/css/style.css">
    </head>
    <body>
        <div class="container-scroller">
            <%@ include file="./header.jsp" %>
            <div class="container-fluid page-body-wrapper">
                <%@ include file="./sidebar.jsp" %>
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="page-header">
                            <h3 class="page-title">Quản lý ca làm</h3>
                        </div>
                        <div class="row">
                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
                                            <h4 class="card-title" style="margin: 0;">Danh sách ca làm</h4>
                                            <button onclick="openAddModal()" style="
                                                    background-color: #3fbbc0;
                                                    color: white;
                                                    border: none;
                                                    padding: 7px 14px;
                                                    border-radius: 6px;
                                                    cursor: pointer;
                                                    font-size: 13px;
                                                    transition: background-color 0.3s ease;
                                                    ">
                                                + Thêm ca làm
                                            </button>
                                        </div>
                                        <!-- Search -->
                                        <div style="display: flex; justify-content: flex-end; align-items: center; margin-bottom: 10px;">
                                            <label for="searchInput" style="margin-right: 8px; font-weight: 500;">Tìm kiếm:</label>
                                            <input type="text" id="searchInput" placeholder="Nhập tên ca, loại ca..." onkeyup="applyFilters()" style="padding: 5px 10px; border-radius: 6px; border: 1px solid #ccc; font-size: 13px;" />
                                        </div>
                                        <!-- Table -->
                                        <div class="table-responsive" style="overflow-x: auto;">
                                            <table id="shiftTable" class="table table-striped table-hover align-middle">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th class="text-center" style="min-width: 80px;">ID</th>
                                                        <th class="text-start" style="min-width: 160px;">Tên ca</th>
                                                        <th class="text-start" style="min-width: 160px;">Loại ca</th>
                                                        <th class="text-center" style="min-width: 120px;">Giờ bắt đầu</th>
                                                        <th class="text-center" style="min-width: 120px;">Giờ kết thúc</th>
                                                        <th class="text-center" style="min-width: 180px;">Hành động</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="shift" items="${shifts}">
                                                        <tr>
                                                            <td class="text-center">${shift.shiftId}</td>
                                                            <td class="text-start">${shift.shiftName}</td>
                                                            <td class="text-start">
                                                                <c:choose>
                                                                    <c:when test="${not empty shift.shiftTypeId}">
                                                                        ${shift.shiftTypeId.typeName}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-danger">[Thiếu loại ca]</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td class="text-center">${shift.startTime}</td>
                                                            <td class="text-center">${shift.endTime}</td>
                                                            <td class="text-center">
                                                                <button 
                                                                    class="btn btn-sm btn-warning"
                                                                    onclick="openEditModal('${shift.shiftId}', '${shift.shiftName}', '${shift.shiftTypeId.shiftTypeId}', '${shift.startTime}', '${shift.endTime}')"
                                                                    >
                                                                    <i class="fas fa-edit"></i> Sửa
                                                                </button>
                                                                <a
                                                                    href="${pageContext.request.contextPath}/admin/shifts?action=delete&id=${shift.shiftId}"
                                                                    class="btn btn-sm btn-danger"
                                                                    onclick="return confirm('Xác nhận xóa ca này?')"
                                                                    >
                                                                    <i class="fas fa-trash"></i> Xóa
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty shifts}">
                                                        <tr>
                                                            <td colspan="6" class="text-center text-muted">Chưa có ca nào</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                        <!-- Pagination -->
                                        <div style="margin-top: 12px; display: flex; justify-content: flex-end; align-items: center; font-size: 13px;">
                                            <button onclick="previousPage()">Trang trước</button>
                                            <span id="pageInfo" style="margin: 0 10px;">Trang 1</span>
                                            <button onclick="nextPage()">Trang sau</button>
                                        </div>
                                        <!-- Modal Thêm/Sửa -->
                                        <div class="modal fade" id="shiftModal" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <form method="post" action="${pageContext.request.contextPath}/admin/shifts" class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="modalTitle">Thêm ca làm</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <input type="hidden" name="id" id="shiftId" />
                                                        <div class="mb-3">
                                                            <label for="shiftName" class="form-label">Tên ca</label>
                                                            <input type="text" class="form-control" name="shiftName" id="shiftName" required />
                                                        </div>
                                                        <div class="mb-3">
                                                            <label for="shiftTypeId" class="form-label">Loại ca</label>
                                                            <select class="form-select" name="shiftTypeId" id="shiftTypeId" required>
                                                                <option value="">-- Chọn loại ca --</option>
                                                                <c:forEach var="type" items="${shiftTypes}">
                                                                    <option value="${type.shiftTypeId}">${type.typeName}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="mb-3">
                                                            <label for="startTime" class="form-label">Giờ bắt đầu</label>
                                                            <input type="time" class="form-control" name="startTime" id="startTime" required />
                                                        </div>
                                                        <div class="mb-3">
                                                            <label for="endTime" class="form-label">Giờ kết thúc</label>
                                                            <input type="time" class="form-control" name="endTime" id="endTime" required />
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                        <button type="submit" class="btn btn-primary">Lưu</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                        <style>
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
                                            .datatable-wrapper button, .card-body > div > button {
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
                                            .datatable-wrapper button:hover, .card-body > div > button:hover {
                                                background-color: #36aab0;
                                            }
                                            #pageInfo {
                                                font-weight: 500;
                                                color: #333;
                                                font-size: 13px;
                                            }
                                        </style>
                                        <!-- Script filter & pagination -->
                                        <script>
                                            let currentPage = 1;
                                            const rowsPerPage = 5;
                                            function applyFilters() {
                                                const searchValue = document.getElementById('searchInput').value.toLowerCase();
                                                const table = document.getElementById('shiftTable');
                                                const tbody = table.getElementsByTagName('tbody')[0];
                                                const rows = tbody.getElementsByTagName('tr');
                                                let visibleRows = [];
                                                for (let i = 0; i < rows.length; i++) {
                                                    if (rows[i].textContent.includes("Chưa có ca nào")) {
                                                        rows[i].style.display = 'none';
                                                        continue;
                                                    }
                                                    let rowText = rows[i].innerText.toLowerCase();
                                                    if (rowText.includes(searchValue)) {
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
                                                if (currentPage > totalPages)
                                                    currentPage = totalPages;
                                                if (currentPage < 1)
                                                    currentPage = 1;
                                                for (let i = 0; i < totalRows; i++) {
                                                    if (i >= (currentPage - 1) * rowsPerPage && i < currentPage * rowsPerPage) {
                                                        visibleRows[i].style.display = '';
                                                    } else {
                                                        visibleRows[i].style.display = 'none';
                                                    }
                                                }
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
                                            window.onload = function () {
                                                applyFilters();
                                            };
                                            // Modal function
                                            function openAddModal() {
                                                document.getElementById('modalTitle').innerText = 'Thêm ca làm';
                                                document.getElementById('shiftId').value = '';
                                                document.getElementById('shiftName').value = '';
                                                document.getElementById('shiftTypeId').selectedIndex = 0;
                                                document.getElementById('startTime').value = '';
                                                document.getElementById('endTime').value = '';
                                                new bootstrap.Modal(document.getElementById('shiftModal')).show();
                                            }
                                            function openEditModal(id, name, shiftTypeId, startTime, endTime) {
                                                document.getElementById('modalTitle').innerText = 'Chỉnh sửa ca làm';
                                                document.getElementById('shiftId').value = id;
                                                document.getElementById('shiftName').value = name;
                                                document.getElementById('shiftTypeId').value = shiftTypeId;
                                                document.getElementById('startTime').value = startTime;
                                                document.getElementById('endTime').value = endTime;
                                                new bootstrap.Modal(document.getElementById('shiftModal')).show();
                                            }
                                        </script>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <footer class="footer">
                        <div class="d-sm-flex justify-content-center justify-content-sm-between">
                            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">&copy; 2025. All rights reserved.</span>
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
