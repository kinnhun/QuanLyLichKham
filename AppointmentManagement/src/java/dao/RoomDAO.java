package dao;

import model.Room;
import model.Department;
import java.sql.*;
import java.util.*;

public class RoomDAO extends DBContext {

    public List<Room> getAllRooms() {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT r.RoomId, r.RoomName, r.Floor, r.RoomType, r.Description, " +
                     "d.DepartmentId, d.DepartmentName, d.Description AS DeptDesc " +
                     "FROM Rooms r JOIN Departments d ON r.DepartmentId = d.DepartmentId";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Department dept = new Department();
                dept.setDepartmentId(rs.getInt("DepartmentId"));
                dept.setDepartmentName(rs.getString("DepartmentName"));
                dept.setDescription(rs.getString("DeptDesc"));

                Room room = new Room();
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomName(rs.getString("RoomName"));
                room.setDepartmentId(dept);
                room.setFloor(rs.getInt("Floor"));
                room.setRoomType(rs.getString("RoomType"));
                room.setDescription(rs.getString("Description"));
                list.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addRoom(Room room) {
        String sql = "INSERT INTO Rooms (RoomName, DepartmentId, Floor, RoomType, Description) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, room.getRoomName());
            ps.setInt(2, room.getDepartmentId().getDepartmentId());
            ps.setInt(3, room.getFloor());
            ps.setString(4, room.getRoomType());
            ps.setString(5, room.getDescription());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean updateRoom(Room room) {
        String sql = "UPDATE Rooms SET RoomName=?, DepartmentId=?, Floor=?, RoomType=?, Description=? WHERE RoomId=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, room.getRoomName());
            ps.setInt(2, room.getDepartmentId().getDepartmentId());
            ps.setInt(3, room.getFloor());
            ps.setString(4, room.getRoomType());
            ps.setString(5, room.getDescription());
            ps.setInt(6, room.getRoomId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean deleteRoom(int roomId) {
        String sql = "DELETE FROM Rooms WHERE RoomId=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
    
    // Trả về true nếu đã có phòng trùng RoomName + Department + Floor + RoomType
public boolean isDuplicateRoom(String roomName, int departmentId, int floor, String roomType, Integer excludeRoomId) {
    String sql = "SELECT COUNT(*) FROM Rooms WHERE RoomName = ? AND DepartmentId = ? AND Floor = ? AND RoomType = ?";
    if (excludeRoomId != null) {
        sql += " AND RoomId <> ?";
    }
    try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, roomName);
        ps.setInt(2, departmentId);
        ps.setInt(3, floor);
        ps.setString(4, roomType);
        if (excludeRoomId != null) {
            ps.setInt(5, excludeRoomId);
        }
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

}
