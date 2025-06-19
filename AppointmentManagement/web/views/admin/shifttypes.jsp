<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Quản lý loại ca</title>
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
                            <h3 class="page-title">Quản lý loại ca làm</h3>
                        </div>
                        <div class="row">
                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <!-- Header & Button -->
                                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
                                            <h4 class="card-title" style="margin: 0;">Danh sách loại ca</h4>
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
                                                + Thêm loại ca
                                            </button>
                                        </div>

                                        <!-- Search/filter -->
                                        <div style="display: flex; justify-content: flex-end; align-items: center; margin-bottom: 10px;">
                                            <label for="searchInput" style="margin-right: 8px; font-weight: 500;">Tìm kiếm:</label>
                                            <input type="text" id="searchInput" placeholder="Nhập tên loại ca..." onkeyup="applyFilters()" style="padding: 5px 10px; border-radius: 6px; border: 1px solid #ccc; font-size: 13px;" />
                                        </div>

                                        <!-- Table -->
                                        <div class="table-responsive" style="overflow-x: auto;">
                                            <table id="shiftTypeTable" class="table table-striped table-hover align-middle">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th class="text-center" style="min-width: 80px;">ID</th>
                                                        <th class="text-start" style="min-width: 180px;">Tên loại ca</th>
                                                        <th class="text-center" style="min-width: 180px;">Hành động</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="type" items="${shiftTypes}">
                                                        <tr>
                                                            <td class="text-center">${type.shiftTypeId}</td>
                                                            <td class="text-start">${type.typeName}</td>
                                                            <td class="text-center">
                                                                <button 
                                                                    class="btn btn-sm btn-warning"
                                                                    onclick="openEditModal('${type.shiftTypeId}', '${type.typeName}')"
                                                                    >
                                                                    <i class="fas fa-edit"></i> Sửa
                                                                </button>
                                                                <a
                                                                    href="${pageContext.request.contextPath}/admin/shifttypes?action=delete&id=${type.shiftTypeId}"
                                                                    class="btn btn-sm btn-danger"
                                                                    onclick="return confirm('Xác nhận xóa loại ca này?')"
                                                                    >
                                                                    <i class="fas fa-trash"></i> Xóa
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty shiftTypes}">
                                                        <tr>
                                                            <td colspan="3" class="text-center text-muted">Chưa có loại ca nào</td>
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
                                        <div class="modal fade" id="shiftTypeModal" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <form method="post" action="${pageContext.request.contextPath}/admin/shifttypes" class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="modalTitle">Thêm loại ca</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <input type="hidden" name="id" id="shiftTypeId" />
                                                        <div class="mb-3">
                                                            <label for="typeName" class="form-label">Tên loại ca</label>
                                                            <input type="text" class="form-control" name="typeName" id="typeName" required />
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                        <button type="submit" class="btn btn-primary">Lưu</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

                                        <!-- Script filter & pagination -->
                                        <script>
                                            let currentPage = 1;
                                            const rowsPerPage = 5;

                                            function applyFilters() {
                                                const searchValue = document.getElementById('searchInput').value.toLowerCase();
                                                const table = document.getElementById('shiftTypeTable');
                                                const tbody = table.getElementsByTagName('tbody')[0];
                                                const rows = tbody.getElementsByTagName('tr');
                                                let visibleRows = [];

                                                for (let i = 0; i < rows.length; i++) {
                                                    // Bỏ qua dòng "chưa có loại ca nào"
                                                    if (rows[i].textContent.includes("Chưa có loại ca nào")) {
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
                                                document.getElementById('modalTitle').innerText = 'Thêm loại ca';
                                                document.getElementById('shiftTypeId').value = '';
                                                document.getElementById('typeName').value = '';
                                                new bootstrap.Modal(document.getElementById('shiftTypeModal')).show();
                                            }
                                            function openEditModal(id, typeName) {
                                                document.getElementById('modalTitle').innerText = 'Chỉnh sửa loại ca';
                                                document.getElementById('shiftTypeId').value = id;
                                                document.getElementById('typeName').value = typeName;
                                                new bootstrap.Modal(document.getElementById('shiftTypeModal')).show();
                                            }
                                        </script>

                                        <!-- Custom style đồng bộ -->
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
        <!-- JS -->
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
