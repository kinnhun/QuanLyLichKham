<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Đăng ký tài khoản</title>
        <meta name="description" content="">
        <meta name="keywords" content="">

        <!-- Favicons -->
        <link href="${pageContext.request.contextPath}/views/user/assets/img/favicon.png" rel="icon">
        <link href="${pageContext.request.contextPath}/views/user/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com" rel="preconnect">
        <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto&family=Poppins&family=Raleway&display=swap" rel="stylesheet">

        <!-- Vendor CSS Files -->
        <link href="${pageContext.request.contextPath}/views/user/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/views/user/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/views/user/assets/vendor/aos/aos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/views/user/assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/views/user/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/views/user/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

        <!-- Main CSS File -->
        <link href="${pageContext.request.contextPath}/views/user/assets/css/main.css" rel="stylesheet">

    </head>

    <body class="starter-page-page">

        <%@ include file="header.jsp" %>

        <main class="main">

            <!-- Page Title -->
            <div class="page-title">
                <nav class="breadcrumbs">
                    <div class="container">
                        <ol>
                            <li><a href="home">Trang chủ</a></li>
                            <li class="current">Đăng ký</li>
                        </ol>
                    </div>
                </nav>
            </div><!-- End Page Title -->

            <!-- Starter Section Section -->
            <section id="starter-section" class="starter-section section">

                <div class="container" style="
                     max-width: 800px;
                     margin: auto;
                     padding: 40px 20px;
                     background: #f9f9f9;
                     border-radius: 12px;
                     box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                     ">

                    <h2 style="text-align: center; margin-bottom: 20px;">Đăng ký tài khoản</h2>

                    <form action="register" method="post" style="
                          display: flex;
                          flex-wrap: wrap;
                          gap: 20px;
                          ">

                        <!-- Cột trái -->
                        <div style="flex: 1 1 45%; display: flex; flex-direction: column; gap: 15px;">

                            <!-- Họ và tên -->
                            <div style="display: flex; flex-direction: column;">
                                <label for="fullname" style="margin-bottom: 5px;">Họ và tên:</label>
                                <input type="text" id="fullname" name="fullname" required style="
                                       padding: 10px;
                                       border-radius: 6px;
                                       border: 1px solid #ccc;
                                       font-size: 16px;
                                       ">
                            </div>

                            <!-- Tên đăng nhập -->
                            <div style="display: flex; flex-direction: column;">
                                <label for="username" style="margin-bottom: 5px;">Tên đăng nhập:</label>
                                <input type="text" id="username" name="username" required style="
                                       padding: 10px;
                                       border-radius: 6px;
                                       border: 1px solid #ccc;
                                       font-size: 16px;
                                       ">
                            </div>

                            <!-- Email -->
                            <div style="display: flex; flex-direction: column;">
                                <label for="email" style="margin-bottom: 5px;">Email:</label>
                                <input type="email" id="email" name="email" required style="
                                       padding: 10px;
                                       border-radius: 6px;
                                       border: 1px solid #ccc;
                                       font-size: 16px;
                                       ">
                            </div>

                        </div>

                        <!-- Cột phải -->
                        <div style="flex: 1 1 45%; display: flex; flex-direction: column; gap: 15px;">

                            <!-- Số điện thoại -->
                            <div style="display: flex; flex-direction: column;">
                                <label for="phone" style="margin-bottom: 5px;">Số điện thoại:</label>
                                <input type="text" id="phone" name="phone" required style="
                                       padding: 10px;
                                       border-radius: 6px;
                                       border: 1px solid #ccc;
                                       font-size: 16px;
                                       ">
                            </div>

                            <!-- Mật khẩu -->
                            <div style="display: flex; flex-direction: column;">
                                <label for="password" style="margin-bottom: 5px;">Mật khẩu:</label>
                                <input type="password" id="password" name="password" required style="
                                       padding: 10px;
                                       border-radius: 6px;
                                       border: 1px solid #ccc;
                                       font-size: 16px;
                                       ">
                            </div>

                            <!-- Xác nhận mật khẩu -->
                            <div style="display: flex; flex-direction: column;">
                                <label for="confirm-password" style="margin-bottom: 5px;">Xác nhận mật khẩu:</label>
                                <input type="password" id="confirm-password" name="confirm-password" required style="
                                       padding: 10px;
                                       border-radius: 6px;
                                       border: 1px solid #ccc;
                                       font-size: 16px;
                                       ">
                            </div>

                        </div>

                        <!-- Nút Đăng ký -->
                        <div style="flex: 1 1 100%; text-align: center; margin-top: 10px;">
                            <button type="submit" style="
                                    padding: 12px 40px;
                                    background-color: #3FBBC0;
                                    color: #fff;
                                    border: none;
                                    border-radius: 6px;
                                    font-size: 16px;
                                    font-weight: bold;
                                    cursor: pointer;
                                    ">Đăng ký</button>
                        </div>

                    </form>



                    <!-- Link quay về đăng nhập -->
                    <div style="text-align: center; margin-top: 20px;">
                        <span>Đã có tài khoản?</span>
                        <a href="login" style="color: #3FBBC0; font-weight: bold;">Đăng nhập</a>
                    </div>

                </div>

            </section><!-- /Starter Section Section -->

        </main>

        <%@ include file="./footer.jsp" %>

    </body>

</html>
