package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Users;

public class UserDAO extends DBContext {

    public boolean registerUser(Users user) {
        String sql = "INSERT INTO Users (Username, PasswordHash, FullName, Email, Phone, Role, IsActive, Note, CreatedAt) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";

        try {
            // Mở connection mới từ DBContext
            Connection conn = new DBContext().getConnection();

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPasswordHash());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getRole());
            ps.setBoolean(7, user.getIsActive());
            ps.setString(8, user.getNote());

            int rows = ps.executeUpdate();

            ps.close();
            conn.close(); // Đóng connection

            return rows > 0;

        } catch (Exception e) {  // Bắt cả Exception để bắt lỗi ClassNotFoundException
            System.out.println("Lỗi khi registerUser: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    // Kiểm tra Username đã tồn tại chưa
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM Users WHERE Username = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (Exception e) { // Bắt Exception vì DBContext().getConnection() có thể ném ClassNotFoundException
            System.out.println("Lỗi khi kiểm tra Username: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

// Kiểm tra Email đã tồn tại chưa
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE Email = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            System.out.println("Lỗi khi kiểm tra Email: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

// Kiểm tra Phone đã tồn tại chưa
    public boolean isPhoneExists(String phone) {
        String sql = "SELECT COUNT(*) FROM Users WHERE Phone = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            System.out.println("Lỗi khi kiểm tra Phone: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

 public Users login(String usernameInput, String password) {
    String sql = "SELECT * FROM Users "
               + "WHERE (Username = ? OR Email = ? OR Phone = ?) "
               + "AND PasswordHash = ? "
               + "AND IsActive = 1";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, usernameInput);
        ps.setString(2, usernameInput);
        ps.setString(3, usernameInput);
        ps.setString(4, password); // Nếu có mã hóa password thì mã hóa trước khi truyền

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            // Nếu tìm thấy user → trả về đối tượng Users
            Users user = new Users();
            user.setUserId(rs.getInt("UserId"));
            user.setUsername(rs.getString("Username"));
            user.setPasswordHash(rs.getString("PasswordHash"));
            user.setFullName(rs.getString("FullName"));
            user.setEmail(rs.getString("Email"));
            user.setPhone(rs.getString("Phone"));
            user.setRole(rs.getString("Role"));
            user.setIsActive(rs.getBoolean("IsActive"));
            user.setNote(rs.getString("Note"));
            user.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());

            return user;
        }

    } catch (Exception e) {
        System.out.println("Lỗi khi login: " + e.getMessage());
        e.printStackTrace();
    }

    return null; // Không tìm thấy user hoặc có lỗi
}

public Users getUserByEmail(String email) {
    String sql = "SELECT UserId, Username, PasswordHash, FullName, Email, Phone, Role, IsActive, Note, CreatedAt "
               + "FROM Users WHERE Email = ?";
    
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            Users user = new Users();
            user.setUserId(rs.getInt("UserId"));
            user.setUsername(rs.getString("Username"));
            user.setPasswordHash(rs.getString("PasswordHash"));
            user.setFullName(rs.getString("FullName"));
            user.setEmail(rs.getString("Email"));
            user.setPhone(rs.getString("Phone"));
            user.setRole(rs.getString("Role"));
            user.setIsActive(rs.getBoolean("IsActive"));
            user.setNote(rs.getString("Note"));
            user.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
            return user;
        }
        
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    return null; // Không tìm thấy
}


}
