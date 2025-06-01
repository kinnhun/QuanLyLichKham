/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import utils.EmailUtils;

@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/forgot-password"})
public class ForgotPasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Mặc định GET → load trang forgot-password.jsp
        request.getRequestDispatcher("./views/user/forgot-password.jsp").forward(request, response);
    }

   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String identifier = request.getParameter("identifier");

    UserDAO userDAO = new UserDAO();
    Users user = null;

    // Ưu tiên tìm theo Email
    if (userDAO.isEmailExists(identifier)) {
        user = userDAO.getUserByEmail(identifier);
    } else if (userDAO.isPhoneExists(identifier)) {
        user = userDAO.getUserByPhone(identifier);
    }

    if (user == null) {
        request.setAttribute("error", "Không tìm thấy tài khoản phù hợp với thông tin bạn đã nhập.");
        request.getRequestDispatcher("./views/user/forgot-password.jsp").forward(request, response);
        return;
    }

    // 1️⃣ Tạo token
    String token = java.util.UUID.randomUUID().toString();
    java.time.LocalDateTime expiry = java.time.LocalDateTime.now().plusMinutes(15); // Token hết hạn sau 15 phút

    // 2️⃣ Lưu token vào DB
    UserDAO tokenDAO = new UserDAO();
    tokenDAO.createToken(user.getUserId(), token, expiry);

    // 3️⃣ Tạo link reset
    String resetLink = "http://localhost:9999/AppointmentManagement/reset-password?token=" + token;

    // 4️⃣ Gửi mail
    boolean sent = EmailUtils.sendForgotPasswordEmail(user.getEmail(), resetLink);

    if (sent) {
        request.setAttribute("message", "Hệ thống đã gửi hướng dẫn đặt lại mật khẩu tới email của bạn.");
    } else {
        request.setAttribute("error", "Gửi email thất bại. Vui lòng thử lại.");
    }

    // Quay lại trang forgot-password.jsp
    request.getRequestDispatcher("./views/user/forgot-password.jsp").forward(request, response);
}

    @Override
    public String getServletInfo() {
        return "Forgot Password Controller";
    }
}
