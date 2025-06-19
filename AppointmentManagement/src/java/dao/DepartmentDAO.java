package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Department;

public class DepartmentDAO extends DBContext {

    // Lấy toàn bộ khoa
    public List<Department> getAllDepartments() {
        List<Department> list = new ArrayList<>();
        String sql = "SELECT DepartmentId, DepartmentName, Description FROM Departments";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Department d = new Department();
                d.setDepartmentId(rs.getInt("DepartmentId"));
                d.setDepartmentName(rs.getString("DepartmentName"));
                d.setDescription(rs.getString("Description"));
                list.add(d);
            }
        } catch (Exception e) {
            System.out.println("Lỗi getAllDepartments: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // Lấy theo ID
    public Department getDepartmentById(int id) {
        String sql = "SELECT DepartmentId, DepartmentName, Description FROM Departments WHERE DepartmentId = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Department d = new Department();
                d.setDepartmentId(rs.getInt("DepartmentId"));
                d.setDepartmentName(rs.getString("DepartmentName"));
                d.setDescription(rs.getString("Description"));
                return d;
            }
        } catch (Exception e) {
            System.out.println("Lỗi getDepartmentById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Thêm khoa
    public boolean addDepartment(Department department) {
        String sql = "INSERT INTO Departments (DepartmentName, Description) VALUES (?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, department.getDepartmentName());
            ps.setString(2, department.getDescription());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Lỗi addDepartment: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật khoa
    public boolean updateDepartment(Department department) {
        String sql = "UPDATE Departments SET DepartmentName = ?, Description = ? WHERE DepartmentId = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, department.getDepartmentName());
            ps.setString(2, department.getDescription());
            ps.setInt(3, department.getDepartmentId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Lỗi updateDepartment: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Xóa khoa
    public boolean deleteDepartment(int id) {
        String sql = "DELETE FROM Departments WHERE DepartmentId = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Lỗi deleteDepartment: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean isDuplicateDepartment(String name, String description) {
        String sql = "SELECT COUNT(*) FROM Departments WHERE DepartmentName = ? OR Description = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, description);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // Nếu có dòng nào trùng thì trả về true
                }
            }
        } catch (Exception e) {
            System.out.println("Lỗi isDuplicateDepartment: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean isDuplicateDepartmentForEdit(String name, String description, int excludeId) {
        String sql = "SELECT COUNT(*) FROM Departments WHERE (DepartmentName = ? OR Description = ?) AND DepartmentId <> ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setInt(3, excludeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // Nếu tồn tại dòng trùng (trừ ID này) thì trả về true
                }
            }
        } catch (Exception e) {
            System.out.println("Lỗi isDuplicateDepartmentForEdit: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

}
