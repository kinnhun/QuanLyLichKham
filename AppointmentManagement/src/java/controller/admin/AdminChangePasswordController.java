package controller.admin;

import dao.UserDAO;
import model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "AdminChangePasswordController", urlPatterns = {"/admin/change-password"})
public class AdminChangePasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy user đang đăng nhập từ session
        HttpSession session = request.getSession(false);
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra nhập thiếu
        if (currentPassword == null || newPassword == null || confirmPassword == null
                || currentPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin.");
            request.getRequestDispatcher("/views/admin/change-password.jsp").forward(request, response);
            return;
        }

        // Kiểm tra xác nhận
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.getRequestDispatcher("/views/admin/change-password.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu hiện tại
        UserDAO userDAO = new UserDAO();
        if (!userDAO.checkPassword(currentUser.getUserId(), currentPassword)) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng.");
            request.getRequestDispatcher("/views/admin/change-password.jsp").forward(request, response);
            return;
        }

        // Không cho phép đặt mật khẩu mới giống mật khẩu cũ
        if (currentPassword.equals(newPassword)) {
            request.setAttribute("error", "Mật khẩu mới không được trùng mật khẩu hiện tại.");
            request.getRequestDispatcher("/views/admin/change-password.jsp").forward(request, response);
            return;
        }

        // Update mật khẩu
        boolean updateSuccess = userDAO.updatePassword1(currentUser.getUserId(), newPassword);

        if (updateSuccess) {
            request.setAttribute("success", "Đổi mật khẩu thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại.");
        }
        request.getRequestDispatcher("/views/admin/change-password.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Chức năng đổi mật khẩu admin";
    }
}
