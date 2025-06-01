package controller;

import dao.UserDAO;
import model.PasswordResetToken;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(name = "ResetPasswordController", urlPatterns = {"/reset-password"})
public class ResetPasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy token từ URL
        String token = request.getParameter("token");

        UserDAO tokenDAO = new UserDAO();
        PasswordResetToken tokenObj = tokenDAO.getToken(token);

        // Kiểm tra token hợp lệ
        if (tokenObj == null || tokenObj.isIsUsed() || tokenObj.getExpiry().isBefore(LocalDateTime.now())) {
            request.setAttribute("error", "Liên kết không hợp lệ hoặc đã hết hạn.");
            request.getRequestDispatcher("./views/user/login.jsp").forward(request, response);
            return;
        }

        // Nếu hợp lệ → show form đổi mật khẩu
        request.setAttribute("token", token);
        request.getRequestDispatcher("./views/user/reset-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        String newPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra khớp
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu nhập lại không khớp.");
            request.setAttribute("token", token); // để giữ lại token khi quay lại form
            request.getRequestDispatcher("./views/user/reset-password.jsp").forward(request, response);
            return;
        }

        UserDAO tokenDAO = new UserDAO();
        PasswordResetToken tokenObj = tokenDAO.getToken(token);

        if (tokenObj == null || tokenObj.isIsUsed() || tokenObj.getExpiry().isBefore(LocalDateTime.now())) {
            request.setAttribute("error", "Liên kết không hợp lệ hoặc đã hết hạn.");
            request.getRequestDispatcher("./views/user/login.jsp").forward(request, response);
            return;
        }

        // Đổi mật khẩu
        UserDAO userDAO = new UserDAO();
        userDAO.updatePassword(tokenObj.getUserId(), newPassword);

        // Đánh dấu token đã dùng
        tokenDAO.markTokenAsUsed(token);

        // Gửi mail thông báo
        Users user = userDAO.getUserById(tokenObj.getUserId());
        utils.EmailUtils.sendPasswordChangedEmail(user.getEmail());

        // Chuyển đến trang báo thành công
        request.setAttribute("message", "Bạn đã đổi mật khẩu thành công. Vui lòng đăng nhập.");
        request.getRequestDispatcher("./views/user/login.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Reset Password Controller";
    }
}
