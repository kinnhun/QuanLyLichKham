/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;

@WebServlet(name = "AdminAddUserController", urlPatterns = {"/admin/add-user"})
@MultipartConfig
public class AdminAddUserController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminAddUserController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminAddUserController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("../views/admin/add-user.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String role = request.getParameter("role"); // lấy role từ form

        // Kiểm tra role có null không (bảo vệ)
        if (role == null || role.isEmpty()) {
            request.setAttribute("error", "Thiếu thông tin role.");
            request.getRequestDispatcher("../views/admin/add-user.jsp").forward(request, response);
            return;
        }

        switch (role) {
            case "Admin":
                handleAddAdmin(request, response);
                break;

            case "Receptionist":
                handleAddReceptionist(request, response);
                break;

            case "Doctor":
                handleAddDoctor(request, response);
                break;

            default:
                // Nếu role không hợp lệ
                request.setAttribute("error", "Role không hợp lệ.");
                request.getRequestDispatcher("../views/admin/add-user.jsp").forward(request, response);
                break;
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void handleAddAdmin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        // Validate password confirm
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp.");
            doGet(request, response);         
            return;
        }

        UserDAO userDAO = new UserDAO();

        // Validate trùng username / email / phone
        if (userDAO.isUsernameExists(username)) {
            request.setAttribute("error", "Username đã tồn tại.");
            doGet(request, response);         
            return;
        }

        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email đã tồn tại.");
            doGet(request, response);         
            return;
        }

        if (phone != null && !phone.isEmpty() && userDAO.isPhoneExists(phone)) {
            request.setAttribute("error", "Số điện thoại đã tồn tại.");
            doGet(request, response);         
            return;
        }

        // Tạo user
        Users newUser = new Users();
        newUser.setUsername(username);
        newUser.setPasswordHash(password);
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        newUser.setPhone(phone);
        newUser.setRole("Admin");
        newUser.setIsActive(true);
        newUser.setNote("Tạo bởi Admin");

        boolean success = userDAO.registerUser(newUser);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/user-list");
        } else {
            request.setAttribute("error", "Có lỗi khi tạo tài khoản Admin.");
            response.sendRedirect(request.getContextPath() + "/admin/user-list#admin-form");
        }
    }

  private void handleAddReceptionist(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession();

    // Lấy các tham số từ request
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String note = request.getParameter("note");
    boolean isActive = request.getParameter("isActive") != null;

    // Lấy các tham số cho Receptionist
    String shiftType = request.getParameter("shiftType");
    String workDays = request.getParameter("workDays");
    String hireDate = request.getParameter("hireDate");
    String address = request.getParameter("address");
    String gender = request.getParameter("gender");
    String birthDate = request.getParameter("birthDate");
    String emergencyContact = request.getParameter("emergencyContact");
    String receptionistNotes = request.getParameter("receptionistNotes");

    // Xử lý upload ảnh
    String photoUrl = "";
    try {
        photoUrl = request.getPart("photoUrl").getSubmittedFileName();
    } catch (Exception e) {
        System.out.println("Không lấy được file ảnh: " + e.getMessage());
    }

    // Kiểm tra mật khẩu và xác nhận mật khẩu
    if (!password.equals(confirmPassword)) {
        session.setAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp.");
        response.sendRedirect(request.getContextPath() + "/admin/add-user#receptionist-form");
        return;
    }

    UserDAO userDAO = new UserDAO();

    // Kiểm tra trùng username
    if (userDAO.isUsernameExists(username)) {
        session.setAttribute("error", "Username đã tồn tại.");
        response.sendRedirect(request.getContextPath() + "/admin/add-user#receptionist-form");
        return;
    }

    // Kiểm tra trùng email
    if (userDAO.isEmailExists(email)) {
        session.setAttribute("error", "Email đã tồn tại.");
        response.sendRedirect(request.getContextPath() + "/admin/add-user#receptionist-form");
        return;
    }

    // Kiểm tra trùng số điện thoại
    if (phone != null && !phone.isEmpty() && userDAO.isPhoneExists(phone)) {
        session.setAttribute("error", "Số điện thoại đã tồn tại.");
        response.sendRedirect(request.getContextPath() + "/admin/add-user#receptionist-form");
        return;
    }

    // Tạo đối tượng Users
    Users newUser = new Users();
    newUser.setUsername(username);
    newUser.setPasswordHash(password);
    newUser.setFullName(fullName);
    newUser.setEmail(email);
    newUser.setPhone(phone);
    newUser.setRole("Receptionist");
    newUser.setIsActive(isActive);
    newUser.setNote(note);

    // Lưu Users
    boolean success = userDAO.registerUser(newUser);

    if (!success) {
        session.setAttribute("error", "Có lỗi khi tạo tài khoản Receptionist.");
        response.sendRedirect(request.getContextPath() + "/admin/add-user#receptionist-form");
        return;
    }

    // Lấy UserId của user vừa thêm
    Users createdUser = userDAO.getUserByUsername(username);
    if (createdUser == null) {
        session.setAttribute("error", "Không lấy được thông tin UserId sau khi thêm.");
        response.sendRedirect(request.getContextPath() + "/admin/add-user#receptionist-form");
        return;
    }

    int userId = createdUser.getUserId();

    // Thêm thông tin vào bảng Receptionists
    success = userDAO.insertReceptionist(
            userId, shiftType, workDays, hireDate, photoUrl,
            address, gender, birthDate, emergencyContact, receptionistNotes
    );

    if (success) {
        session.setAttribute("message", "Thêm lễ tân thành công.");
        response.sendRedirect(request.getContextPath() + "/admin/user-list");
    } else {
        session.setAttribute("error", "Có lỗi khi lưu thông tin Receptionist.");
        response.sendRedirect(request.getContextPath() + "/admin/add-user#receptionist-form");
    }
}


    private void handleAddDoctor(HttpServletRequest request, HttpServletResponse response) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
