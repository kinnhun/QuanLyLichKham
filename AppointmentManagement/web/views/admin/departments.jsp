<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Quản lý Khoa</title>
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
                    <h3 class="page-title">Quản lý Khoa</h3>
                </div>
                <div class="row">
                    <div class="col-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">

                                <!-- HEADER + BUTTON -->
                                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
                                    <h4 class="card-title" style="margin: 0;">Danh sách Khoa</h4>
                                    <button class="btn btn-primary" onclick="openAddModal()">
                                        <i class="fas fa-plus"></i> Thêm Khoa
                                    </button>
                                </div>

                                <!-- FILTER + SEARCH -->
                                <div style="display: flex; justify-content: flex-end; align-items: center; margin-bottom: 10px;">
                                    <label for="searchInput" style="margin-right: 8px; font-weight: 500;">Tìm kiếm:</label>
                                    <input type="text" id="searchInput" placeholder="Nhập tên khoa..." onkeyup="applyFilters()" style="padding: 5px 10px; border-radius: 6px; border: 1px solid #ccc; font-size: 13px;"/>
                                </div>

                                <!-- TABLE -->
                                <div class="table-responsive" style="overflow-x: auto;">
                                    <table id="deptTable" class="table table-striped table-hover align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="text-center" style="min-width: 80px;">ID</th>
                                                <th style="min-width: 200px;">Tên Khoa</th>
                                                <th style="min-width: 300px;">Mô Tả</th>
                                                <th class="text-center" style="min-width: 180px;">Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="dept" items="${departments}">
                                                <tr>
                                                    <td class="text-center">${dept.departmentId}</td>
                                                    <td>${dept.departmentName}</td>
                                                    <td>${dept.description}</td>
                                                    <td class="text-center">
                                                        <button class="btn btn-sm btn-warning" onclick="openEditModal(${dept.departmentId}, '${dept.departmentName}', '${dept.description}')">
                                                            <i class="fas fa-edit"></i> Sửa
                                                        </button>
                                                        <a href="${pageContext.request.contextPath}/admin/departments?action=delete&id=${dept.departmentId}" 
                                                           class="btn btn-sm btn-danger" 
                                                           onclick="return confirm('Xác nhận xóa khoa này?')">
                                                            <i class="fas fa-trash"></i> Xóa
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty departments}">
                                                <tr>
                                                    <td colspan="4" class="text-center text-muted">Chưa có khoa nào</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- PAGINATION -->
                                <div style="margin-top: 12px; display: flex; justify-content: flex-end; align-items: center; font-size: 13px;">
                                    <button onclick="previousPage()">Trang trước</button>
                                    <span id="pageInfo" style="margin: 0 10px;">Trang 1</span>
                                    <button onclick="nextPage()">Trang sau</button>
                                </div>

                                <!-- MODAL FORM -->
                                <div class="modal fade" id="departmentModal" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <form method="post" action="${pageContext.request.contextPath}/admin/departments">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="modalTitle">Thêm Khoa</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <input type="hidden" name="id" id="deptId" />
                                                    <div class="mb-3">
                                                        <label for="deptName" class="form-label">Tên Khoa</label>
                                                        <input type="text" class="form-control" name="name" id="deptName" required />
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="deptDesc" class="form-label">Mô tả</label>
                                                        <textarea class="form-control" name="description" id="deptDesc" rows="3"></textarea>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                    <button type="submit" class="btn btn-primary">Lưu</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                                <!-- SCRIPT FILTER & PAGINATION -->
                                <script>
                                    let currentPage = 1;
                                    const rowsPerPage = 5;

                                    function applyFilters() {
                                        const searchValue = document.getElementById('searchInput').value.toLowerCase();
                                        const table = document.getElementById('deptTable');
                                        const tbody = table.getElementsByTagName('tbody')[0];
                                        const rows = tbody.getElementsByTagName('tr');
                                        let visibleRows = [];

                                        for (let i = 0; i < rows.length; i++) {
                                            // Nếu là dòng "Chưa có khoa nào", bỏ qua filter (ẩn nếu có filter)
                                            if (rows[i].textContent.includes("Chưa có khoa nào")) {
                                                rows[i].style.display = 'none';
                                                continue;
                                            }
                                            let nameText = rows[i].getElementsByTagName('td')[1].innerText.toLowerCase();
                                            if (nameText.includes(searchValue)) {
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
                                        if (currentPage > totalPages) currentPage = totalPages;
                                        if (currentPage < 1) currentPage = 1;

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
                                </script>

                                <script>
                                    function openAddModal() {
                                        document.getElementById('modalTitle').innerText = 'Thêm Khoa';
                                        document.getElementById('deptId').value = '';
                                        document.getElementById('deptName').value = '';
                                        document.getElementById('deptDesc').value = '';
                                        new bootstrap.Modal(document.getElementById('departmentModal')).show();
                                    }
                                    function openEditModal(id, name, desc) {
                                        document.getElementById('modalTitle').innerText = 'Chỉnh sửa Khoa';
                                        document.getElementById('deptId').value = id;
                                        document.getElementById('deptName').value = name;
                                        document.getElementById('deptDesc').value = desc;
                                        new bootstrap.Modal(document.getElementById('departmentModal')).show();
                                    }
                                </script>

                                <!-- CUSTOM STYLE cho đồng bộ giao diện -->
                                <style>
                                    .datatable-wrapper label {
                                        font-weight: 500;
                                        margin-right: 5px;
                                        color: #333;
                                        font-size: 13px;
                                    }
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
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <footer class="footer">
                <div class="d-sm-flex justify-content-center justify-content-sm-between">
                    <span class="text-muted d-block d-sm-inline-block">&copy; 2025. All rights reserved.</span>
                    <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Made with <i class="far fa-heart text-danger"></i></span>
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
