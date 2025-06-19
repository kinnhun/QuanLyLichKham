package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.DoctorRoom;
import model.Doctor;
import model.Room;

public class DoctorRoomDAO extends DBContext {

    // Lấy danh sách tất cả phân công phòng của bác sĩ
    public List<DoctorRoom> getAllDoctorRooms() {
        List<DoctorRoom> list = new ArrayList<>();
        String sql = "SELECT dr.DoctorRoomId, dr.DoctorId, dr.RoomId, dr.Status, dr.StartDate, dr.EndDate "
                + "FROM DoctorRooms dr";
        try (
                Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery();) {
            DoctorDAO doctorDAO = new DoctorDAO();
            RoomDAO roomDAO = new RoomDAO();
            while (rs.next()) {
                DoctorRoom dr = new DoctorRoom();
                dr.setDoctorRoomId(rs.getInt("DoctorRoomId"));

                // Lấy Doctor object
                int doctorId = rs.getInt("DoctorId");
                Doctor doctor = doctorDAO.getDoctorById(doctorId);
                dr.setDoctorId(doctor);

                // Lấy Room object
                int roomId = rs.getInt("RoomId");
                Room room = roomDAO.getRoomById(roomId);
                dr.setRoomId(room);

                dr.setStatus(rs.getString("Status"));
                dr.setStartDate(rs.getDate("StartDate"));
                dr.setEndDate(rs.getDate("EndDate"));

                list.add(dr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm phân công phòng mới cho bác sĩ
    public boolean addDoctorRoom(DoctorRoom dr) {
        String sql = "INSERT INTO DoctorRooms (DoctorId, RoomId, Status, StartDate, EndDate) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, dr.getDoctorId().getDoctorId());
            ps.setInt(2, dr.getRoomId().getRoomId());
            ps.setString(3, dr.getStatus());
            ps.setDate(4, dr.getStartDate());
            ps.setDate(5, dr.getEndDate());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật phân công phòng cho bác sĩ
    public boolean updateDoctorRoom(DoctorRoom dr) {
        String sql = "UPDATE DoctorRooms SET DoctorId = ?, RoomId = ?, Status = ?, StartDate = ?, EndDate = ? WHERE DoctorRoomId = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, dr.getDoctorId().getDoctorId());
            ps.setInt(2, dr.getRoomId().getRoomId());
            ps.setString(3, dr.getStatus());
            ps.setDate(4, dr.getStartDate());
            ps.setDate(5, dr.getEndDate());
            ps.setInt(6, dr.getDoctorRoomId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa phân công phòng của bác sĩ
    public boolean deleteDoctorRoom(int id) {
        String sql = "DELETE FROM DoctorRooms WHERE DoctorRoomId = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra trùng lặp phân công phòng cho bác sĩ trong cùng thời gian
    public boolean isDuplicate(int doctorId, int roomId, String status, Date startDate, Date endDate) {
        String sql = "SELECT COUNT(*) FROM DoctorRooms WHERE DoctorId = ? AND RoomId = ? AND Status = ? AND StartDate = ? AND EndDate = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, doctorId);
            ps.setInt(2, roomId);
            ps.setString(3, status);
            ps.setDate(4, startDate);
            ps.setDate(5, endDate);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

   // Trong DoctorRoomDAO:
public boolean isDuplicateTimeRange(int doctorId, int roomId, Date newStart, Date newEnd, Integer excludeDoctorRoomId) {
    String sql = "SELECT COUNT(*) FROM DoctorRooms " +
            "WHERE DoctorId = ? AND RoomId = ? " +
            "AND ((StartDate <= ? AND EndDate >= ?) " + 
            "OR (StartDate <= ? AND EndDate >= ?) " +    
            "OR (StartDate >= ? AND EndDate <= ?))";   
    if (excludeDoctorRoomId != null) {
        sql += " AND DoctorRoomId <> ?";
    }
    try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, doctorId);
        ps.setInt(2, roomId);
        ps.setDate(3, newStart);
        ps.setDate(4, newStart);
        ps.setDate(5, newEnd);
        ps.setDate(6, newEnd);
        ps.setDate(7, newStart);
        ps.setDate(8, newEnd);
        if (excludeDoctorRoomId != null) {
            ps.setInt(9, excludeDoctorRoomId);
        }
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1) > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

}
