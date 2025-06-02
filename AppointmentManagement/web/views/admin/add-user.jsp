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
                                <button type="button" class="btn btn-info" onclick="showForm('adminForm')">Quản trị viên</button>
                                <button type="button" class="btn btn-primary" onclick="showForm('receptionistForm')">Lễ tân</button>
                                <button type="button" class="btn btn-success" onclick="showForm('doctorForm')">Bác sĩ</button>
                                <button type="button" class="btn btn-warning" onclick="showForm('patientForm')">Bệnh nhân</button>
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
                        <div id="receptionistForm" class="role-form fade-in" style="display: none;">
                            <h5>Form tạo Lễ tân</h5>
                            <form action="add-user" method="post">
                                <input type="hidden" name="role" value="Receptionist">

                                <label>Username:</label>
                                <input type="text" name="username" required>

                                <label>Họ và tên:</label>
                                <input type="text" name="fullName" required>

                                <label>Số điện thoại:</label>
                                <input type="text" name="phone">

                                <label>Email:</label>
                                <input type="email" name="email" required>

                                <!-- Nút cùng hàng -->
                                <div style="display: flex; justify-content: space-between; gap: 10px; margin-top: 10px;">
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
                        function showForm(formId) {
                            // Ẩn phần chọn vai trò
                            document.getElementById('roleSelection').style.display = 'none';

                            // Ẩn tất cả các form
                            const forms = document.querySelectorAll('.role-form');
                            forms.forEach(form => {
                                form.style.display = 'none';
                            });

                            // Hiện form đã chọn
                            const selectedForm = document.getElementById(formId);
                            selectedForm.style.display = 'block';
                            selectedForm.classList.add('fade-in');
                        }

                        function goBack() {
                            // Ẩn tất cả các form
                            const forms = document.querySelectorAll('.role-form');
                            forms.forEach(form => {
                                form.style.display = 'none';
                            });

                            // Hiện lại phần chọn vai trò
                            document.getElementById('roleSelection').style.display = 'block';
                        }
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
