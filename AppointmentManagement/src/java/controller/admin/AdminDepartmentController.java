package controller.admin;

import dao.DepartmentDAO;
import model.Department;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminDepartmentController", urlPatterns = {"/admin/departments"})
public class AdminDepartmentController extends HttpServlet {

    private final DepartmentDAO departmentDAO = new DepartmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
                listDepartments(request, response);
            } else {
                switch (action) {
                    case "edit":
                        showEditForm(request, response);
                        break;
                    case "delete":
                        deleteDepartment(request, response);
                        break;
                    default:
                        listDepartments(request, response);
                        break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Đã xảy ra lỗi khi xử lý yêu cầu.");
            response.sendRedirect(request.getContextPath() + "/admin/departments");
        }
    }

    private void listDepartments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Department> departments = departmentDAO.getAllDepartments();
        request.setAttribute("departments", departments);
        request.getRequestDispatcher("/views/admin/departments.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Department department = departmentDAO.getDepartmentById(id);

            if (department == null) {
                request.getSession().setAttribute("error", "Không tìm thấy khoa cần sửa.");
                response.sendRedirect(request.getContextPath() + "/admin/departments");
                return;
            }

            request.setAttribute("department", department);
            request.getRequestDispatcher("/views/admin/edit-department.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID khoa không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/admin/departments");
        }
    }

    private void deleteDepartment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean deleted = departmentDAO.deleteDepartment(id);

            if (deleted) {
                request.getSession().setAttribute("message", "Xóa khoa thành công.");
            } else {
                request.getSession().setAttribute("error", "Không thể xóa khoa. Vui lòng thử lại.");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID khoa không hợp lệ.");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Đã xảy ra lỗi trong quá trình xóa.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/departments");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (name == null || name.trim().isEmpty()) {
            request.getSession().setAttribute("error", "Tên khoa không được để trống.");
            response.sendRedirect(request.getContextPath() + "/admin/departments");
            return;
        }

        Department department = new Department();
        department.setDepartmentName(name.trim());
        department.setDescription(description != null ? description.trim() : "");

        try {
            boolean success;

            if (idParam == null || idParam.isEmpty()) {
                // ADD - Check duplicate name or description
                boolean isDuplicate = departmentDAO.isDuplicateDepartment(name.trim(), description != null ? description.trim() : "");
                if (isDuplicate) {
                    request.getSession().setAttribute("error", "Tên khoa hoặc mô tả đã tồn tại. Vui lòng nhập thông tin khác.");
                    response.sendRedirect(request.getContextPath() + "/admin/departments");
                    return;
                }

                success = departmentDAO.addDepartment(department);
                if (success) {
                    request.getSession().setAttribute("message", "Thêm khoa mới thành công.");
                } else {
                    request.getSession().setAttribute("error", "Không thể thêm khoa. Vui lòng thử lại.");
                }
            } else {
                // UPDATE - Check duplicate for edit (exclude self)
                int id = Integer.parseInt(idParam);
                department.setDepartmentId(id);

                boolean isDuplicate = departmentDAO.isDuplicateDepartmentForEdit(
                        name.trim(),
                        description != null ? description.trim() : "",
                        id
                );
                if (isDuplicate) {
                    request.getSession().setAttribute("error", "Tên khoa hoặc mô tả đã tồn tại. Vui lòng nhập thông tin khác.");
                    response.sendRedirect(request.getContextPath() + "/admin/departments");
                    return;
                }

                success = departmentDAO.updateDepartment(department);

                if (success) {
                    request.getSession().setAttribute("message", "Cập nhật thông tin khoa thành công.");
                } else {
                    request.getSession().setAttribute("error", "Không thể cập nhật khoa. Vui lòng thử lại.");
                }
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID khoa không hợp lệ.");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Đã xảy ra lỗi khi lưu thông tin khoa.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/departments");
    }
}
