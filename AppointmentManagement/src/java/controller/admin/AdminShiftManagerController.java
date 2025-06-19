package controller.admin;

import dao.ShiftDAO;
import dao.ShiftTypeDAO;
import model.Shift;
import model.ShiftType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Time;
import java.util.List;

@WebServlet(name = "AdminShiftManagerController", urlPatterns = {"/admin/shifts"})
public class AdminShiftManagerController extends HttpServlet {

    private final ShiftDAO shiftDAO = new ShiftDAO();
    private final ShiftTypeDAO shiftTypeDAO = new ShiftTypeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if (action == null) {
                listShifts(request, response);
            } else if ("delete".equals(action)) {
                deleteShift(request, response);
            } else {
                listShifts(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Có lỗi xảy ra khi xử lý.");
            response.sendRedirect(request.getContextPath() + "/admin/shifts");
        }
    }

    private void listShifts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Shift> shifts = shiftDAO.getAllShifts();
        List<ShiftType> shiftTypes = shiftTypeDAO.getAllShiftTypes();
        request.setAttribute("shifts", shifts);
        request.setAttribute("shiftTypes", shiftTypes);
        request.getRequestDispatcher("/views/admin/shifts.jsp").forward(request, response);
    }

    private void deleteShift(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean deleted = shiftDAO.deleteShift(id);
            if (deleted) {
                request.getSession().setAttribute("message", "Xóa ca thành công.");
            } else {
                request.getSession().setAttribute("error", "Không thể xóa ca.");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Lỗi khi xóa ca.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/shifts");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String name = request.getParameter("shiftName");
        String shiftTypeIdParam = request.getParameter("shiftTypeId");
        String startTimeParam = request.getParameter("startTime");
        String endTimeParam = request.getParameter("endTime");

        if (name == null || name.trim().isEmpty()) {
            request.getSession().setAttribute("error", "Tên ca không được để trống.");
            response.sendRedirect(request.getContextPath() + "/admin/shifts");
            return;
        }
        try {
    int shiftTypeId = Integer.parseInt(shiftTypeIdParam);

    // Chuẩn hóa time
    if (startTimeParam != null && startTimeParam.length() == 5) startTimeParam += ":00";
    if (endTimeParam != null && endTimeParam.length() == 5) endTimeParam += ":00";
    Time startTime = Time.valueOf(startTimeParam);
    Time endTime = Time.valueOf(endTimeParam);

    ShiftType shiftType = new ShiftType();
    shiftType.setShiftTypeId(shiftTypeId);

    Shift shift = new Shift();
    shift.setShiftName(name);
    shift.setShiftTypeId(shiftType);
    shift.setStartTime(startTime);
    shift.setEndTime(endTime);

    boolean success;

    if (idParam == null || idParam.isEmpty()) {
        // ===== Kiểm tra trùng khi thêm =====
        if (shiftDAO.isDuplicateShift(name, shiftTypeId, null)) {
            request.getSession().setAttribute("error", "Tên ca và loại ca đã tồn tại!");
            response.sendRedirect(request.getContextPath() + "/admin/shifts");
            return;
        }
        // CREATE
        success = shiftDAO.addShift(shift);
        if (success) {
            request.getSession().setAttribute("message", "Thêm ca thành công.");
        } else {
            request.getSession().setAttribute("error", "Không thể thêm ca.");
        }
    } else {
        // ===== Kiểm tra trùng khi cập nhật =====
        int id = Integer.parseInt(idParam);
        if (shiftDAO.isDuplicateShift(name, shiftTypeId, id)) {
            request.getSession().setAttribute("error", "Tên ca và loại ca đã tồn tại!");
            response.sendRedirect(request.getContextPath() + "/admin/shifts");
            return;
        }
        // UPDATE
        shift.setShiftId(id);
        success = shiftDAO.updateShift(shift);
        if (success) {
            request.getSession().setAttribute("message", "Cập nhật ca thành công.");
        } else {
            request.getSession().setAttribute("error", "Không thể cập nhật ca.");
        }
    }
} catch (Exception e) {
    request.getSession().setAttribute("error", "Dữ liệu không hợp lệ hoặc thiếu.");
}
response.sendRedirect(request.getContextPath() + "/admin/shifts");
    }
}
