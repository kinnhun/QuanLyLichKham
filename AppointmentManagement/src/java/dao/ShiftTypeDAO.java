package dao;

import model.ShiftType;
import java.sql.*;
import java.util.*;

public class ShiftTypeDAO extends DBContext {

    public List<ShiftType> getAllShiftTypes() {
        List<ShiftType> list = new ArrayList<>();
        String sql = "SELECT ShiftTypeId, TypeName FROM ShiftTypes";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ShiftType st = new ShiftType();
                st.setShiftTypeId(rs.getInt("ShiftTypeId"));
                st.setTypeName(rs.getString("TypeName"));
                list.add(st);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ShiftType getShiftTypeById(int id) {
        String sql = "SELECT ShiftTypeId, TypeName FROM ShiftTypes WHERE ShiftTypeId = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new ShiftType(rs.getInt("ShiftTypeId"), rs.getString("TypeName"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addShiftType(ShiftType shiftType) {
        String sql = "INSERT INTO ShiftTypes (TypeName) VALUES (?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, shiftType.getTypeName());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateShiftType(ShiftType shiftType) {
        String sql = "UPDATE ShiftTypes SET TypeName = ? WHERE ShiftTypeId = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, shiftType.getTypeName());
            ps.setInt(2, shiftType.getShiftTypeId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteShiftType(int id) {
        String sql = "DELETE FROM ShiftTypes WHERE ShiftTypeId = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isDuplicateTypeName(String typeName) {
        String sql = "SELECT COUNT(*) FROM ShiftTypes WHERE TypeName = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, typeName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isDuplicateTypeNameForEdit(String typeName, int excludeId) {
        String sql = "SELECT COUNT(*) FROM ShiftTypes WHERE TypeName = ? AND ShiftTypeId <> ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, typeName);
            ps.setInt(2, excludeId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
