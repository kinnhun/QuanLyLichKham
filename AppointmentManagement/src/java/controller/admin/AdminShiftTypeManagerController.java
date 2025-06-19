package controller.admin;

import dao.ShiftTypeDAO;
import model.ShiftType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminShiftTypeManagerController", urlPatterns = {"/admin/shifttypes"})
public class AdminShiftTypeManagerController extends HttpServlet {
    private final ShiftTypeDAO shiftTypeDAO = new ShiftTypeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
                listShiftTypes(request, response);
            } else {
                switch (action) {
                    case "edit":
                        showEditForm(request, response);
                        break;
                    case "delete":
                        deleteShiftType(request, response);
                        break;
                    default:
                        listShiftTypes(request, response);
                        break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Có lỗi xảy ra khi xử lý yêu cầu.");
            response.sendRedirect(request.getContextPath() + "/admin/shifttypes");
        }
    }

    private void listShiftTypes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<ShiftType> shiftTypes = shiftTypeDAO.getAllShiftTypes();
        request.setAttribute("shiftTypes", shiftTypes);
        request.getRequestDispatcher("/views/admin/shifttypes.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ShiftType shiftType = shiftTypeDAO.getShiftTypeById(id);
            if (shiftType == null) {
                request.getSession().setAttribute("error", "Không tìm thấy loại ca.");
                response.sendRedirect(request.getContextPath() + "/admin/shifttypes");
                return;
            }
            request.setAttribute("shiftType", shiftType);
            request.getRequestDispatcher("/views/admin/edit-shifttype.jsp").forward(request, response);
        } catch (Exception e) {
            request.getSession().setAttribute("error", "ID loại ca không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/admin/shifttypes");
        }
    }

    private void deleteShiftType(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean deleted = shiftTypeDAO.deleteShiftType(id);
            if (deleted) {
                request.getSession().setAttribute("message", "Xóa loại ca thành công.");
            } else {
                request.getSession().setAttribute("error", "Không thể xóa loại ca. Có thể đang được sử dụng.");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Lỗi khi xóa loại ca.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/shifttypes");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String typeName = request.getParameter("typeName");

        if (typeName == null || typeName.trim().isEmpty()) {
            request.getSession().setAttribute("error", "Tên loại ca không được để trống.");
            response.sendRedirect(request.getContextPath() + "/admin/shifttypes");
            return;
        }

        ShiftType shiftType = new ShiftType();
        shiftType.setTypeName(typeName.trim());

        try {
            boolean success;
            if (idParam == null || idParam.isEmpty()) {
                // CREATE
                if (shiftTypeDAO.isDuplicateTypeName(typeName.trim())) {
                    request.getSession().setAttribute("error", "Tên loại ca đã tồn tại.");
                    response.sendRedirect(request.getContextPath() + "/admin/shifttypes");
                    return;
                }
                success = shiftTypeDAO.addShiftType(shiftType);
                if (success) {
                    request.getSession().setAttribute("message", "Thêm loại ca thành công.");
                } else {
                    request.getSession().setAttribute("error", "Không thể thêm loại ca.");
                }
            } else {
                // UPDATE
                int id = Integer.parseInt(idParam);
                shiftType.setShiftTypeId(id);

                if (shiftTypeDAO.isDuplicateTypeNameForEdit(typeName.trim(), id)) {
                    request.getSession().setAttribute("error", "Tên loại ca đã tồn tại.");
                    response.sendRedirect(request.getContextPath() + "/admin/shifttypes");
                    return;
                }
                success = shiftTypeDAO.updateShiftType(shiftType);
                if (success) {
                    request.getSession().setAttribute("message", "Cập nhật loại ca thành công.");
                } else {
                    request.getSession().setAttribute("error", "Không thể cập nhật loại ca.");
                }
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Đã xảy ra lỗi khi lưu thông tin loại ca.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/shifttypes");
    }
}
