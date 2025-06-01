/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import dao.UserDAO;
import model.Users;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="AdminManagerUserController", urlPatterns={"/admin/user-list"})
public class AdminManagerUserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Load danh sách user từ DB
        UserDAO userDAO = new UserDAO();
        List<Users> userList = userDAO.getAllUsers();

        // Đẩy danh sách sang JSP
        request.setAttribute("userList", userList);
        
        // Forward tới trang JSP hiển thị
        request.getRequestDispatcher("/views/admin/user-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Tạm thời để trống - sau này xử lý thêm/sửa/xóa nếu cần
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Admin Manager User Controller";
    }
}
