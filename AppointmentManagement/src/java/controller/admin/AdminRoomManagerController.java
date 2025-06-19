package controller.admin;

import dao.RoomDAO;
import dao.DepartmentDAO;
import model.Room;
import model.Department;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminRoomManagerController", urlPatterns = {"/admin/rooms"})
public class AdminRoomManagerController extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();
    private final DepartmentDAO departmentDAO = new DepartmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean deleted = roomDAO.deleteRoom(id);
                if (deleted) {
                    request.getSession().setAttribute("message", "Xóa phòng thành công.");
                } else {
                    request.getSession().setAttribute("error", "Không thể xóa phòng.");
                }
                response.sendRedirect(request.getContextPath() + "/admin/rooms");
                return;
            }
            // Default: list
            List<Room> rooms = roomDAO.getAllRooms();
            List<Department> departments = departmentDAO.getAllDepartments();
            request.setAttribute("rooms", rooms);
            request.setAttribute("departments", departments);
            request.getRequestDispatcher("/views/admin/rooms.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Có lỗi xảy ra khi xử lý.");
            response.sendRedirect(request.getContextPath() + "/admin/rooms");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String name = request.getParameter("roomName");
        String deptIdParam = request.getParameter("departmentId");
        String floorParam = request.getParameter("floor");
        String roomType = request.getParameter("roomType");
        String description = request.getParameter("description");

        try {
            // Kiểm tra dữ liệu đầu vào
            if (name == null || name.trim().isEmpty()
                    || deptIdParam == null || deptIdParam.isEmpty()
                    || floorParam == null || floorParam.isEmpty()
                    || roomType == null || roomType.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Vui lòng điền đầy đủ thông tin phòng.");
                response.sendRedirect(request.getContextPath() + "/admin/rooms");
                return;
            }

            int deptId = Integer.parseInt(deptIdParam);
            int floor = Integer.parseInt(floorParam);

            Department dept = new Department();
            dept.setDepartmentId(deptId);

            Room room = new Room();
            room.setRoomName(name.trim());
            room.setDepartmentId(dept);
            room.setFloor(floor);
            room.setRoomType(roomType.trim());
            room.setDescription(description);

            boolean success;
            boolean isDuplicate;

            if (idParam == null || idParam.isEmpty()) {
                // ADD
                isDuplicate = roomDAO.isDuplicateRoom(name.trim(), deptId, floor, roomType.trim(), null);
                if (isDuplicate) {
                    request.getSession().setAttribute("error", "Phòng này đã tồn tại (trùng tên, khoa, tầng, loại).");
                    response.sendRedirect(request.getContextPath() + "/admin/rooms");
                    return;
                }
                success = roomDAO.addRoom(room);
                if (success) {
                    request.getSession().setAttribute("message", "Thêm phòng thành công.");
                } else {
                    request.getSession().setAttribute("error", "Không thể thêm phòng.");
                }
            } else {
                // EDIT
                int id = Integer.parseInt(idParam);
                isDuplicate = roomDAO.isDuplicateRoom(name.trim(), deptId, floor, roomType.trim(), id);
                if (isDuplicate) {
                    request.getSession().setAttribute("error", "Phòng này đã tồn tại (trùng tên, khoa, tầng, loại).");
                    response.sendRedirect(request.getContextPath() + "/admin/rooms");
                    return;
                }
                room.setRoomId(id);
                success = roomDAO.updateRoom(room);
                if (success) {
                    request.getSession().setAttribute("message", "Cập nhật phòng thành công.");
                } else {
                    request.getSession().setAttribute("error", "Không thể cập nhật phòng.");
                }
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Dữ liệu không hợp lệ hoặc thiếu.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }

}
