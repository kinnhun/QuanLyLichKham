<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Quên mật khẩu - Đặt lịch khám bệnh</title>
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
                        <li class="current">Quên mật khẩu</li>
                    </ol>
                </div>
            </nav>
        </div><!-- End Page Title -->

        <!-- Starter Section Section -->
        <section id="starter-section" class="starter-section section">

            <div class="container" style="max-width: 400px; margin: auto; padding: 40px 20px; background: #f9f9f9; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">

                <h2 style="text-align: center; margin-bottom: 20px;">Quên mật khẩu</h2>

                <p style="text-align: center; margin-bottom: 20px; color: #555;">
                    Vui lòng nhập <strong>Email</strong> hoặc <strong>Số điện thoại</strong> để đặt lại mật khẩu.
                </p>

                <!-- Form Forgot Password -->
                <form action="forgot-password" method="post">
                    <div style="margin-bottom: 15px;">
                        <label for="identifier" style="display: block; margin-bottom: 5px;">Email hoặc Số điện thoại:</label>
                        <input type="text" id="identifier" name="identifier" required style="
                            width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #ccc; font-size: 16px;
                        ">
                    </div>

                    <button type="submit" style="
                        width: 100%; padding: 12px; background-color: #3FBBC0; color: #fff; border: none;
                        border-radius: 6px; font-size: 16px; font-weight: bold; cursor: pointer;
                    ">Gửi yêu cầu đặt lại mật khẩu</button>
                </form>

                <!-- Link quay lại đăng nhập -->
                <div style="text-align: center; margin-top: 20px;">
                    <a href="login" style="color: #3FBBC0; font-weight: bold;">← Quay lại trang đăng nhập</a>
                </div>

            </div>

        </section><!-- /Starter Section Section -->

    </main>

    <%@ include file="./footer.jsp" %>

</body>

</html>
