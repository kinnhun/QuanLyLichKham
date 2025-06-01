/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("./views/user/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu từ form
        String usernameInput = request.getParameter("username"); // có thể là username, email, phone
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();

        // Kiểm tra đăng nhập
        Users user = userDAO.login(usernameInput, password);

        if (user != null) {
            // Đăng nhập thành công → lưu user vào session
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

           
            // Chuyển về trang chủ
            response.sendRedirect( userDAO.responsePage(user.getRole()));
        } else {
            // Sai thông tin đăng nhập
            request.setAttribute("error", "Sai thông tin đăng nhập hoặc tài khoản chưa được kích hoạt.");
            request.getRequestDispatcher("./views/user/login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "LoginController cho phép đăng nhập bằng username, email hoặc số điện thoại";
    }
}
