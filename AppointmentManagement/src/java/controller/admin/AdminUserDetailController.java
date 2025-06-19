package controller.admin;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Users;

import java.io.IOException;

@WebServlet(name = "AdminUserDetailController", urlPatterns = {"/admin/user-detail"})
public class AdminUserDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdStr = request.getParameter("userId");

        if (userIdStr != null) {
            try {
                int userId = Integer.parseInt(userIdStr);
                UserDAO userDAO = new UserDAO();
                Users user = userDAO.getUserById(userId);

                if (user != null) {
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/views/admin/user-detail.jsp").forward(request, response);
                    return;
                } else {
                    request.getSession().setAttribute("error", "Không tìm thấy người dùng với ID: " + userId);
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "ID không hợp lệ.");
            }
        } else {
            request.getSession().setAttribute("error", "Thiếu tham số userId.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/user-list");
    }
}
