package controller.admin;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Users;

import java.io.IOException;

@WebServlet(name = "UpdateUserController", urlPatterns = {"/admin/update-user"})
public class AdminUpdateUserController  extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String note = request.getParameter("note");

            UserDAO userDAO = new UserDAO();
            Users user = userDAO.getUserById(userId);

            if (user == null) {
                request.getSession().setAttribute("error", "Không tìm thấy người dùng.");
                response.sendRedirect(request.getContextPath() + "/admin/user-list");
                return;
            }

            // Cập nhật thông tin
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setNote(note);

         boolean check = userDAO.updateUser(user);

if (check) {
    request.getSession().setAttribute("success", "Cập nhật thông tin thành công.");
} else {
    request.getSession().setAttribute("error", "Cập nhật thất bại.");
}
response.sendRedirect(request.getContextPath() + "/admin/user-detail?userId=" + userId);

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID người dùng không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/admin/user-list");
        } catch (Exception ex) {
            ex.printStackTrace();
            request.getSession().setAttribute("error", "Đã xảy ra lỗi khi cập nhật.");
            response.sendRedirect(request.getContextPath() + "/admin/user-list");
        }
    }
}
