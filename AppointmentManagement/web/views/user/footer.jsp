<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

    <body>
        <footer id="footer" class="footer light-background">

            <div class="container footer-top">
                <!-- ... các cột footer của bạn ... -->
            </div>

            <div class="container copyright text-center mt-4">
                <p>© <span>Copyright</span> <strong class="px-1 sitename">Medicio</strong> <span>All Rights Reserved</span></p>
                <div class="credits">
                    Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a> Distributed by <a href="https://themewagon.com">ThemeWagon</a>
                </div>
            </div>
        </footer>

        <!-- 👇👈 Đặt include plugin-chat.jsp Ở NGOÀI FOOTER -->
<!-- plugin-chat.jsp -->
<!-- Chỉ để trống hoặc chỉ có dòng import JS: -->
<script src="${pageContext.request.contextPath}/views/user/assets/js/plugin-chat.js"></script>

        <!-- Vendor JS Files -->
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/php-email-form/validate.js"></script>
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/aos/aos.js"></script>
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/glightbox/js/glightbox.min.js"></script>
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/purecounter/purecounter_vanilla.js"></script>
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/swiper/swiper-bundle.min.js"></script>

        <!-- Main JS File -->
        <script src="${pageContext.request.contextPath}/views/user/assets/js/main.js"></script>
        
    </body>
</html>
