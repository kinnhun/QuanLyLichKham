package dao;

import model.Shift;
import model.ShiftType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShiftDAO extends DBContext {

    // Lấy toàn bộ ca làm, JOIN ShiftTypes để có tên loại ca
    public List<Shift> getAllShifts() {
        List<Shift> list = new ArrayList<>();
        String sql = "SELECT s.ShiftId, s.ShiftName, s.ShiftTypeId, t.TypeName, s.StartTime, s.EndTime "
                + "FROM Shifts s JOIN ShiftTypes t ON s.ShiftTypeId = t.ShiftTypeId";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ShiftType type = new ShiftType();
                type.setShiftTypeId(rs.getInt("ShiftTypeId"));
                type.setTypeName(rs.getString("TypeName"));

                Shift shift = new Shift();
                shift.setShiftId(rs.getInt("ShiftId"));
                shift.setShiftName(rs.getString("ShiftName"));
                shift.setShiftTypeId(type);
                shift.setStartTime(rs.getTime("StartTime"));
                shift.setEndTime(rs.getTime("EndTime"));
                list.add(shift);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm ca mới
    public boolean addShift(Shift shift) {
        String sql = "INSERT INTO Shifts (ShiftName, ShiftTypeId, StartTime, EndTime) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, shift.getShiftName());
            ps.setInt(2, shift.getShiftTypeId().getShiftTypeId());
            ps.setTime(3, shift.getStartTime());
            ps.setTime(4, shift.getEndTime());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa ca
    public boolean deleteShift(int id) {
        String sql = "DELETE FROM Shifts WHERE ShiftId = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Sửa ca
    public boolean updateShift(Shift shift) {
        String sql = "UPDATE Shifts SET ShiftName = ?, ShiftTypeId = ?, StartTime = ?, EndTime = ? WHERE ShiftId = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, shift.getShiftName());
            ps.setInt(2, shift.getShiftTypeId().getShiftTypeId());
            ps.setTime(3, shift.getStartTime());
            ps.setTime(4, shift.getEndTime());
            ps.setInt(5, shift.getShiftId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean isDuplicateShift(String shiftName, int shiftTypeId, Integer excludeId) {
    String sql = "SELECT COUNT(*) FROM Shifts WHERE ShiftName = ? AND ShiftTypeId = ? ";
    if (excludeId != null) {
        sql += "AND ShiftId <> ?";
    }
    try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, shiftName);
        ps.setInt(2, shiftTypeId);
        if (excludeId != null) {
            ps.setInt(3, excludeId);
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
