package controller.admin;

import dao.DoctorRoomDAO;
import dao.DoctorDAO;
import dao.RoomDAO;
import model.DoctorRoom;
import model.Doctor;
import model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "AdminDoctorRoomManagerController", urlPatterns = {"/admin/doctor-rooms"})
public class AdminDoctorRoomManagerController extends HttpServlet {

    private final DoctorRoomDAO doctorRoomDAO = new DoctorRoomDAO();
    private final DoctorDAO doctorDAO = new DoctorDAO();
    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean deleted = doctorRoomDAO.deleteDoctorRoom(id);
                if (deleted) {
                    request.getSession().setAttribute("message", "Xóa phân công thành công.");
                } else {
                    request.getSession().setAttribute("error", "Không thể xóa phân công.");
                }
                response.sendRedirect(request.getContextPath() + "/admin/doctor-rooms");
                return;
            }
            // Default: list
            List<DoctorRoom> doctorRooms = doctorRoomDAO.getAllDoctorRooms();
            List<Doctor> doctors = doctorDAO.getAllDoctors();
            List<Room> rooms = roomDAO.getAllRooms();
            request.setAttribute("doctorRooms", doctorRooms);
            request.setAttribute("doctors", doctors);
            request.setAttribute("rooms", rooms);
            request.getRequestDispatcher("/views/admin/doctor-rooms.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Có lỗi xảy ra khi xử lý.");
            response.sendRedirect(request.getContextPath() + "/admin/doctor-rooms");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String doctorIdParam = request.getParameter("doctorId");
        String roomIdParam = request.getParameter("roomId");
        String status = request.getParameter("status");
        String startDateParam = request.getParameter("startDate");
        String endDateParam = request.getParameter("endDate");

        // Validate input
        if (doctorIdParam == null || roomIdParam == null || status == null
                || startDateParam == null || endDateParam == null
                || doctorIdParam.isEmpty() || roomIdParam.isEmpty()
                || status.isEmpty() || startDateParam.isEmpty() || endDateParam.isEmpty()) {
            request.getSession().setAttribute("error", "Vui lòng điền đầy đủ thông tin.");
            response.sendRedirect(request.getContextPath() + "/admin/doctor-rooms");
            return;
        }

        try {
            int doctorId = Integer.parseInt(doctorIdParam);
            int roomId = Integer.parseInt(roomIdParam);
            Date startDate = Date.valueOf(startDateParam);
            Date endDate = Date.valueOf(endDateParam);

            Doctor doctor = new Doctor();
            doctor.setDoctorId(doctorId);

            Room room = new Room();
            room.setRoomId(roomId);

            DoctorRoom dr = new DoctorRoom();
            dr.setDoctorId(doctor);
            dr.setRoomId(room);
            dr.setStatus(status);
            dr.setStartDate(startDate);
            dr.setEndDate(endDate);

            boolean isDuplicate;
            if (idParam == null || idParam.isEmpty()) {
                // ADD
                isDuplicate = doctorRoomDAO.isDuplicateTimeRange(doctorId, roomId, startDate, endDate, null);
                if (isDuplicate) {
                    request.getSession().setAttribute("error", "Đã có phân công trùng bác sĩ, phòng và thời gian.");
                    response.sendRedirect(request.getContextPath() + "/admin/doctor-rooms");
                    return;
                }
                boolean success = doctorRoomDAO.addDoctorRoom(dr);
                if (success) {
                    request.getSession().setAttribute("message", "Phân công thành công.");
                } else {
                    request.getSession().setAttribute("error", "Không thể phân công.");
                }
            } else {
                // EDIT
                int id = Integer.parseInt(idParam);
                dr.setDoctorRoomId(id);
                isDuplicate = doctorRoomDAO.isDuplicateTimeRange(doctorId, roomId, startDate, endDate, id);
                if (isDuplicate) {
                    request.getSession().setAttribute("error", "Đã có phân công trùng bác sĩ, phòng và thời gian.");
                    response.sendRedirect(request.getContextPath() + "/admin/doctor-rooms");
                    return;
                }
                boolean success = doctorRoomDAO.updateDoctorRoom(dr);
                if (success) {
                    request.getSession().setAttribute("message", "Cập nhật thành công.");
                } else {
                    request.getSession().setAttribute("error", "Không thể cập nhật.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Dữ liệu không hợp lệ hoặc thiếu.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/doctor-rooms");
    }

}
