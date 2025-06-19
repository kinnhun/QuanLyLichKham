package controller.admin;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ToggleUserStatusController", urlPatterns = {"/admin/toggle-user-status"})
public class ToggleUserStatusController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdStr = request.getParameter("userId");
        String newStatusStr = request.getParameter("newStatus");
        String banReason = request.getParameter("banReason");

        if (userIdStr != null && newStatusStr != null) {
            try {
                int userId = Integer.parseInt(userIdStr);
                boolean newStatus = Boolean.parseBoolean(newStatusStr);

                UserDAO userDAO = new UserDAO();
                boolean success;

                if (!newStatus) {
                    // Nếu là ban → gọi deactivateUser có lý do
                    success = userDAO.deactivateUser(userId, banReason);
                } else {
                    // Nếu là unban → gọi activateUser
                    success = userDAO.activateUser(userId);
                }

                if (success) {
                    request.getSession().setAttribute("message", (newStatus ? "Unban" : "Ban") + " user thành công.");
                } else {
                    request.getSession().setAttribute("error", "Có lỗi khi " + (newStatus ? "unban" : "ban") + " user.");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "ID user không hợp lệ.");
            }
        } else {
            request.getSession().setAttribute("error", "Thiếu thông tin user hoặc trạng thái mới.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/user-list");
    }
}
