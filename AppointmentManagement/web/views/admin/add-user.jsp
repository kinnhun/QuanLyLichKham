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
                                Tạo tài khoản mới
                            </h3>
                        </div>

                        <!-- Bước 1: Chọn Vai trò -->
                        <div id="roleSelection" class="row mb-4">
                            <h5>Chọn vai trò:</h5>
                            <div style="display: flex; gap: 15px; flex-wrap: wrap;">
                                <a href="#admin-form" class="btn btn-info role-btn" role="button">Quản trị viên</a>
                                <a href="#receptionist-form" class="btn btn-primary role-btn" role="button">Lễ tân</a>
                                <a href="#doctor-form" class="btn btn-success role-btn" role="button">Bác sĩ</a>
                                <a href="#patient-form" class="btn btn-warning role-btn" role="button">Bệnh nhân</a>

                            </div>

                        </div>

                        <!-- Bước 2: Form theo Role -->

                        <!-- Form Admin -->
                        <div id="adminForm" class="role-form fade-in" style="display: none;">
                            <h5>Form tạo Quản trị viên</h5>
                            <form action="add-user" method="post" onsubmit="return validatePassword()">
                                <input type="hidden" name="role" value="Admin">

                                <label>Username:</label>
                                <input type="text" name="username" required placeholder="Nhập tên đăng nhập">

                                <label>Mật khẩu và Xác nhận:</label>
                                <div style="display: flex; gap: 10px;">
                                    <input type="password" name="password" id="password" required style="flex: 1;" placeholder="Nhập mật khẩu">
                                    <input type="password" name="confirmPassword" id="confirmPassword" required style="flex: 1;" placeholder="Nhập lại mật khẩu">
                                </div>

                                <label>Họ và tên:</label>
                                <input type="text" name="fullName" required placeholder="Nhập họ và tên">

                                <label>Email:</label>
                                <input type="email" name="email" required placeholder="Nhập địa chỉ email">

                                <label>Số điện thoại:</label>
                                <input type="text" name="phone" placeholder="Nhập số điện thoại">

                                <!-- Nút cùng hàng -->
                                <div style="display: flex; justify-content: space-between; gap: 10px; margin-top: 10px;">
                                    <button type="submit" class="btn btn-success">Lưu Quản trị viên</button>
                                    <button type="button" class="btn btn-secondary" onclick="goBack()">Quay lại</button>
                                </div>
                            </form>
                        </div>




                        <!-- Form Receptionist -->
                        <div id="receptionistForm" class="role-form fade-in container" style="display: none; max-width: 1200px;">
                            <h5 class="mb-4">Form tạo Lễ tân</h5>
                            <form action="add-user" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="role" value="Receptionist">

                                <div class="row g-4">

                                    <!-- Cột 1: Users fields -->
                                    <div class="col-md-4">
                                        <h6>Thông tin tài khoản</h6>

                                        <label>Username:</label>
                                        <input type="text" name="username" required class="form-control" placeholder="Nhập username">

                                        <label class="mt-2">Mật khẩu:</label>
                                        <input type="password" name="password" required class="form-control" placeholder="Nhập mật khẩu">

                                        <label class="mt-2">Xác nhận mật khẩu:</label>
                                        <input type="password" name="confirmPassword" required class="form-control" placeholder="Nhập lại mật khẩu">

                                        <label class="mt-2">Trạng thái (IsActive):</label>
                                        <div class="form-check mb-2">
                                            <input type="checkbox" name="isActive" class="form-check-input" checked>
                                            <label class="form-check-label">Kích hoạt</label>
                                        </div>

                                        <label>Ghi chú (Note):</label>
                                        <textarea name="note" rows="2" class="form-control" placeholder="Ghi chú"></textarea>
                                    </div>

                                    <!-- Cột 2: Thông tin cá nhân -->
                                    <div class="col-md-4">
                                        <h6>Thông tin cá nhân</h6>

                                        <label>Họ và tên:</label>
                                        <input type="text" name="fullName" required class="form-control" placeholder="Nhập họ và tên">

                                        <label class="mt-2">Số điện thoại:</label>
                                        <input type="text" name="phone" class="form-control" placeholder="Nhập số điện thoại">

                                        <label class="mt-2">Email:</label>
                                        <input type="email" name="email" required class="form-control" placeholder="Nhập địa chỉ email">

                                        <label class="mt-2">Địa chỉ:</label>
                                        <input type="text" name="address" class="form-control" placeholder="Nhập địa chỉ">

                                        <label class="mt-2">Giới tính:</label>
                                        <select name="gender" class="form-select">
                                            <option value="Nam">Nam</option>
                                            <option value="Nữ">Nữ</option>
                                            <option value="Khác">Khác</option>
                                        </select>

                                        <label class="mt-2">Ngày sinh:</label>
                                        <input type="date" name="birthDate" class="form-control">
                                    </div>

                                    <!-- Cột 3: Thông tin công việc -->
                                    <div class="col-md-4">
                                        <h6>Thông tin công việc</h6>

                                        <label>Ca làm (ShiftType):</label>
                                        <select name="shiftType" required class="form-select">
                                            <option value="Morning">Sáng</option>
                                            <option value="Afternoon">Chiều</option>
                                            <option value="Evening">Tối</option>
                                            <option value="Full-time">Full-time</option>
                                        </select>

                                        <label class="mt-2">Ngày làm việc (WorkDays):</label>
                                        <input type="text" name="workDays" class="form-control" placeholder="VD: Mon,Tue,Wed,Thu,Fri">

                                        <label class="mt-2">Ngày vào làm (HireDate):</label>
                                        <input type="date" name="hireDate" required class="form-control">

                                        <div class="mb-3">
                                            <label class="form-label">Ảnh thẻ (PhotoUrl):</label>
                                            <input type="file" name="photoUrl" accept="image/*" class="form-control" onchange="previewPhoto(event)">

                                            <!-- Khung preview ảnh -->
                                            <div class="mt-2">
                                                <img id="photoPreview" src="#" alt="Preview ảnh" style="max-width: 100%; height: auto; display: none; border: 1px solid #ccc; padding: 4px;">
                                            </div>
                                        </div>
                                        <script>
                                            function previewPhoto(event) {
                                                const input = event.target;
                                                const preview = document.getElementById('photoPreview');

                                                if (input.files && input.files[0]) {
                                                    const reader = new FileReader();

                                                    reader.onload = function (e) {
                                                        preview.src = e.target.result;
                                                        preview.style.display = 'block';
                                                    };

                                                    reader.readAsDataURL(input.files[0]);
                                                } else {
                                                    preview.src = '#';
                                                    preview.style.display = 'none';
                                                }
                                            }
                                        </script>


                                        <label class="mt-2">Người liên hệ khẩn cấp (EmergencyContact):</label>
                                        <input type="text" name="emergencyContact" class="form-control" placeholder="Nhập SĐT người liên hệ">

                                        <label class="mt-2">Ghi chú khác:</label>
                                        <textarea name="receptionistNotes" rows="2" class="form-control" placeholder="Ghi chú khác"></textarea>
                                    </div>

                                </div>

                                <!-- Nút -->
                                <div class="d-flex justify-content-between mt-4">
                                    <button type="submit" class="btn btn-success">Lưu Lễ tân</button>
                                    <button type="button" class="btn btn-secondary" onclick="goBack()">Quay lại</button>
                                </div>
                            </form>
                        </div>


                        <!-- Form Doctor -->
                        <div id="doctorForm" class="role-form fade-in" style="display: none;">
                            <h5>Form tạo Bác sĩ</h5>
                            <form action="add-user" method="post">
                                <input type="hidden" name="role" value="Doctor">

                                <label>Username:</label>
                                <input type="text" name="username" required>

                                <label>Họ và tên:</label>
                                <input type="text" name="fullName" required>

                                <label>Email:</label>
                                <input type="email" name="email" required>

                                <label>Chuyên khoa:</label>
                                <input type="text" name="specialty">

                                <!-- Nút cùng hàng -->
                                <div style="display: flex; justify-content: space-between; gap: 10px; margin-top: 10px;">
                                    <button type="submit" class="btn btn-success">Lưu Bác sĩ</button>
                                    <button type="button" class="btn btn-secondary" onclick="goBack()">Quay lại</button>
                                </div>
                            </form>
                        </div>


                        <!-- Form Patient -->
                        <div id="patientForm" class="role-form fade-in" style="display: none;">
                            <h5>Form tạo Bệnh nhân</h5>
                            <form action="add-user" method="post">
                                <input type="hidden" name="role" value="Patient">

                                <label>Username:</label>
                                <input type="text" name="username" required>

                                <label>Họ và tên:</label>
                                <input type="text" name="fullName" required>

                                <label>Email:</label>
                                <input type="email" name="email" required>

                                <label>Ngày sinh:</label>
                                <input type="date" name="dob">

                                <!-- Nút cùng hàng -->
                                <div style="display: flex; justify-content: space-between; gap: 10px; margin-top: 10px;">
                                    <button type="submit" class="btn btn-success">Lưu Bệnh nhân</button>
                                    <button type="button" class="btn btn-secondary" onclick="goBack()">Quay lại</button>
                                </div>
                            </form>
                        </div>


                    </div>

                    <!-- Script xử lý show form + quay lại -->
                    <script>
                        function showFormByHash() {
                            const hash = window.location.hash;

                            // Nếu không có hash hoặc hash rỗng, hiển thị phần chọn vai trò
                            if (!hash || hash === '#') {
                                document.getElementById('roleSelection').style.display = 'block';

                                // Ẩn tất cả các biểu mẫu
                                const forms = document.querySelectorAll('.role-form');
                                forms.forEach(form => {
                                    form.style.display = 'none';
                                });
                                return;
                            }

                            // Chuyển hash từ dạng 'admin-form' thành 'adminForm'
                            const formId = hash.substring(1).split('-').map((word, index) => {
                                if (index === 0)
                                    return word;
                                return word.charAt(0).toUpperCase() + word.slice(1);
                            }).join('');

                            // Ẩn phần chọn vai trò
                            document.getElementById('roleSelection').style.display = 'none';

                            // Ẩn tất cả các biểu mẫu
                            const forms = document.querySelectorAll('.role-form');
                            forms.forEach(form => {
                                form.style.display = 'none';
                            });

                            // Hiển thị biểu mẫu tương ứng nếu tồn tại
                            const selectedForm = document.getElementById(formId);
                            if (selectedForm) {
                                selectedForm.style.display = 'block';
                                selectedForm.classList.add('fade-in');
                            }
                        }

                        function goBack() {
                            // Xóa hash trên URL
                            window.location.hash = '';
                        }

                        // Khi tải trang
                        window.addEventListener('DOMContentLoaded', showFormByHash);

                        // Khi hash trên URL thay đổi
                        window.addEventListener('hashchange', showFormByHash);
                    </script>




                    <style>
                        /* Container content-wrapper */
                        .content-wrapper {
                            display: flex;
                            flex-direction: column;
                            align-items: center;
                            padding: 30px 20px;
                        }

                        /* Nút chọn Vai trò */
                        #roleSelection {
                            width: 100%;
                            max-width: 600px;
                            background-color: #fff;
                            padding: 20px 25px;
                            border-radius: 10px;
                            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
                            margin-top: 30px;
                            text-align: center;
                            animation: fadeIn 0.5s forwards;
                        }

                        #roleSelection > div button {
                            min-width: 150px;
                            padding: 10px 16px;
                            font-size: 14px;
                            font-weight: 500;
                            border-radius: 8px;
                            transition: all 0.3s ease;
                            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                            border: none;
                            margin-top: 10px;
                        }

                        #roleSelection > div button:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
                        }

                        /* Các form */
                        .role-form {
                            background-color: #fff;
                            padding: 25px 30px;
                            border-radius: 12px;
                            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
                            margin-top: 30px;
                            max-width: 600px;
                            width: 100%;
                            transition: all 0.3s ease;
                            opacity: 0;
                            animation: fadeIn 0.5s forwards;
                        }

                        /* Fade-in animation */
                        @keyframes fadeIn {
                            to {
                                opacity: 1;
                            }
                        }

                        /* Header form */
                        .role-form h5 {
                            font-size: 20px;
                            margin-bottom: 20px;
                            color: #333;
                            text-align: center;
                        }

                        /* Label + Input */
                        .role-form label {
                            display: block;
                            font-weight: 500;
                            margin-bottom: 6px;
                            color: #555;
                        }

                        .role-form input[type="text"],
                        .role-form input[type="email"],
                        .role-form input[type="date"],
                        .role-form input[type="password"],
                        .role-form textarea,
                        .role-form select {
                            width: 100%;
                            padding: 10px 14px;
                            border-radius: 8px;
                            border: 1px solid #ccc;
                            font-size: 14px;
                            transition: border-color 0.3s ease, box-shadow 0.3s ease;
                            margin-bottom: 16px;
                        }

                        .role-form input[type="text"]:focus,
                        .role-form input[type="email"]:focus,
                        .role-form input[type="date"]:focus,

                        .role-form textarea:focus,
                        .role-form select:focus {
                            border-color: #3fbbc0;
                            box-shadow: 0 0 5px rgba(63, 187, 192, 0.5);
                            outline: none;
                        }

                        /* Nút submit + quay lại */
                        .role-form button[type="submit"],
                        .role-form button[type="button"] {
                            padding: 10px 18px;
                            border-radius: 8px;
                            font-size: 14px;
                            font-weight: 500;
                            cursor: pointer;
                            transition: background-color 0.3s ease, transform 0.2s ease;
                            width: 48%;
                            display: inline-block;
                            margin-right: 2%;
                        }

                        .role-form button[type="submit"] {
                            background-color: #3fbbc0;
                            color: white;
                            border: none;
                        }

                        .role-form button[type="submit"]:hover {
                            background-color: #36aab0;
                            transform: translateY(-1px);
                        }

                        .role-form button[type="button"] {
                            background-color: #6c757d;
                            color: white;
                            border: none;
                        }

                        .role-form button[type="button"]:hover {
                            background-color: #5a6268;
                            transform: translateY(-1px);
                        }
                        .role-btn {
                            min-width: 160px;
                            padding: 12px 20px;
                            font-size: 16px;
                            font-weight: 600;
                            border-radius: 10px;
                            transition: all 0.3s ease;
                            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                            text-decoration: none;
                            margin: 10px;
                            display: inline-block;
                        }

                        .role-btn:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
                            text-decoration: none;
                        }
                        #roleSelection > div {
                            display: flex;
                            justify-content: center;
                            align-items: center;
                            flex-wrap: wrap;
                            gap: 15px;
                        }

                    </style>






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

    </body>


</html>
