<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Đặt lịch khám bệnh</title>
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
                            <li class="current">Đăng nhập</li>
                        </ol>
                    </div>
                </nav>
            </div><!-- End Page Title -->

            <!-- Starter Section Section -->
            <section id="starter-section" class="starter-section section">

                <div class="container" style="max-width: 400px; margin: auto; padding: 40px 20px; background: #f9f9f9; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">

                    <h2 style="text-align: center; margin-bottom: 20px;">Đăng nhập</h2>

                    <!-- Form Login -->
                    <form action="login" method="post">
                        <div style="margin-bottom: 15px;">
                            <label for="username" style="display: block; margin-bottom: 5px;">Email, Số điện thoại hoặc Tên đăng nhập:</label>
                            <input type="text" id="username" name="username" required style="
                                   width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #ccc; font-size: 16px;
                                   ">
                        </div>

                        <div style="margin-bottom: 15px;">
                            <label for="password" style="display: block; margin-bottom: 5px;">Mật khẩu:</label>
                            <input type="password" id="password" name="password" required style="
                                   width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #ccc; font-size: 16px;
                                   ">
                        </div>

                        <div style="margin-bottom: 20px; text-align: right;">
                            <a href="forgot-password" style="font-size: 14px; color: #3FBBC0; text-decoration: none;">Quên mật khẩu?</a>
                        </div>

                        <button type="submit" style="
                                width: 100%; padding: 12px; background-color: #3FBBC0; color: #fff; border: none;
                                border-radius: 6px; font-size: 16px; font-weight: bold; cursor: pointer;
                                ">Đăng nhập</button>
                    </form>

                    <!-- Google Login -->
                    <div class="col-lg-12 text-center mt-4">
                        <p style="margin-bottom: 10px;">Hoặc đăng nhập bằng:</p>
                        <div id="g_id_onload"
                             data-client_id="20495276859-asgm8cn4636ehlrsktoc6klk7ldujrp5.apps.googleusercontent.com"
                             data-login_uri="http://localhost:9999/AppointmentManagement/oauth2handler"
                             data-auto_prompt="false"
                             data-ux_mode="redirect">
                        </div>

                        <div class="g_id_signin"
                             data-type="standard"
                             data-shape="rectangular"
                             data-theme="outline"
                             data-text="signin_with"
                             data-size="large"
                             data-logo_alignment="left">
                        </div>
                    </div>

                    <!-- Link đến đăng ký -->
                    <div style="text-align: center; margin-top: 20px;">
                        <span>Chưa có tài khoản?</span>
                        <a href="register" style="color: #3FBBC0; font-weight: bold;">Đăng ký ngay</a>
                    </div>

                </div>

            </section><!-- /Starter Section Section -->

        </main>

        <%@ include file="./footer.jsp" %>

        <!-- Load Google Identity Services SDK -->
        <script src="https://accounts.google.com/gsi/client" async defer></script>

    </body>

</html>
