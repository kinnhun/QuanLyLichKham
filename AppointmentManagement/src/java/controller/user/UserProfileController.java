package controller;

import dao.UserDAO;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "UserProfileController", urlPatterns = {"/profile"})
public class UserProfileController extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy userId từ session (hoặc cookie tùy hệ thống bạn đã lưu khi login)
        Users currentUser = (Users) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Users user = userDAO.getUserById(currentUser.getUserId());
        request.setAttribute("userProfile", user);
        request.getRequestDispatcher("/views/admin/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users currentUser = (Users) request.getSession().getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String note = request.getParameter("note");

        Users user = userDAO.getUserById(currentUser.getUserId());
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setNote(note);

        boolean updated = userDAO.updateUser(user);
        if (updated) {
            request.getSession().setAttribute("message", "Cập nhật thành công!");
            // Update lại trong session nếu muốn
            request.getSession().setAttribute("user", userDAO.getUserById(user.getUserId()));
        } else {
            request.getSession().setAttribute("error", "Có lỗi khi cập nhật thông tin.");
        }
        response.sendRedirect(request.getContextPath() + "/profile");
    }
}
