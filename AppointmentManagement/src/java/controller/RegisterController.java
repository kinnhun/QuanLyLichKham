/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import model.Users;

import java.io.IOException;
import java.time.LocalDateTime;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển tới trang register.jsp
        request.getRequestDispatcher("./views/user/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu từ form
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");

        // Kiểm tra mật khẩu nhập lại có khớp không
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp!");
            request.getRequestDispatcher("./views/user/register.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();

        // Kiểm tra username đã tồn tại chưa
        if (userDAO.isUsernameExists(username)) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("./views/user/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra email đã tồn tại chưa
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email đã được sử dụng!");
            request.getRequestDispatcher("./views/user/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra phone đã tồn tại chưa
        if (userDAO.isPhoneExists(phone)) {
            request.setAttribute("error", "Số điện thoại đã được sử dụng!");
            request.getRequestDispatcher("./views/user/register.jsp").forward(request, response);
            return;
        }

        // Tạo User mới
        Users user = new Users();
        user.setFullName(fullname);
        user.setUsername(username);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPasswordHash(password); // Nếu có mã hóa thì xử lý tại đây hoặc trong DAO
        user.setRole("Patient"); // mặc định Patient
        user.setIsActive(true); // Đặt trạng thái kích hoạt
        user.setNote(null); // ban đầu chưa có ghi chú

        // Gọi DAO để insert
        boolean success = userDAO.registerUser(user);

        if (success) {
            // Đăng ký thành công
            request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("./views/user/login.jsp").forward(request, response);
        } else {
            // Lỗi khi đăng ký
            request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại.");
            request.getRequestDispatcher("./views/user/register.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "RegisterController handles user registration";
    }

}
