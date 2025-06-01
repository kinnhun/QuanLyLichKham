package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import model.Users;
import utils.PasswordUtils;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.PasswordResetToken;

public class UserDAO extends DBContext {

    public String responsePage(String role) {
        if (role == null) {
            return "error";
        }

        switch (role) {
            case "Admin":
                return "admin/dashboard";
            case "Receptionist":
                return "receptionist/dashboard";
            case "Doctor":
                return "doctor/dashboard";
            case "Patient":
                return "home";
            default:
                return "errorssssssss";
        }
    }

    public boolean registerUser(Users user) {
        String sql = "INSERT INTO Users (Username, PasswordHash, FullName, Email, Phone, Role, IsActive, Note, CreatedAt) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());

            // MÃ HÓA password ở đây:
            String hashedPassword = PasswordUtils.hashPassword(user.getPasswordHash());
            ps.setString(2, hashedPassword);

            ps.setString(3, user.getFullName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getRole());
            ps.setBoolean(7, user.getIsActive());
            ps.setString(8, user.getNote());

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
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

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, usernameInput);
            ps.setString(2, usernameInput);
            ps.setString(3, usernameInput);

            // MÃ HÓA password trước khi so sánh:
            String hashedPassword = PasswordUtils.hashPassword(password);
            ps.setString(4, hashedPassword);

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
                user.setCreatedAt(rs.getTimestamp("CreatedAt"));
                return user;
            }

        } catch (Exception e) {
            System.out.println("Lỗi khi login: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    public Users getUserByEmail(String email) {
        String sql = "SELECT UserId, Username, PasswordHash, FullName, Email, Phone, Role, IsActive, Note, CreatedAt "
                + "FROM Users WHERE Email = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

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
                user.setCreatedAt(rs.getTimestamp("CreatedAt"));
                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null; // Không tìm thấy
    }

    public Users getUserByPhone(String phone) {
        String sql = "SELECT UserId, Username, PasswordHash, FullName, Email, Phone, Role, IsActive, Note, CreatedAt "
                + "FROM Users WHERE Phone = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, phone);
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
                user.setCreatedAt(rs.getTimestamp("CreatedAt"));
                return user;
            }

        } catch (Exception e) {
            System.out.println("Lỗi khi getUserByPhone: " + e.getMessage());
            e.printStackTrace();
        }

        return null; // Không tìm thấy
    }

    public void createToken(int userId, String token, java.time.LocalDateTime expiry) {
        String sql = "INSERT INTO PasswordResetToken (UserId, Token, Expiry, IsUsed) VALUES (?, ?, ?, 0)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, token);
            ps.setTimestamp(3, Timestamp.valueOf(expiry));

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Users getUserById(int userId) {
        String sql = "SELECT UserId, Username, PasswordHash, FullName, Email, Phone, Role, IsActive, Note, CreatedAt "
                + "FROM Users WHERE UserId = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
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
                user.setCreatedAt(rs.getTimestamp("CreatedAt"));
                return user;
            }

        } catch (Exception e) {
            System.out.println("Lỗi khi getUserById: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    public void updatePassword(int userId, String newPassword) {
        String sql = "UPDATE Users SET PasswordHash = ? WHERE UserId = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            // Mã hóa mật khẩu mới
            String hashedPassword = PasswordUtils.hashPassword(newPassword);

            ps.setString(1, hashedPassword);
            ps.setInt(2, userId);

            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Lỗi khi updatePassword: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void markTokenAsUsed(String token) {
        String sql = "UPDATE PasswordResetToken SET IsUsed = 1 WHERE Token = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, token);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Lỗi khi markTokenAsUsed: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public PasswordResetToken getToken(String token) {
        String sql = "SELECT * FROM PasswordResetToken WHERE Token = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                PasswordResetToken tokenObj = new PasswordResetToken();
                tokenObj.setTokenId(rs.getInt("TokenId"));
                tokenObj.setUserId(rs.getInt("UserId"));
                tokenObj.setToken(rs.getString("Token"));
                tokenObj.setExpiry(rs.getTimestamp("Expiry").toLocalDateTime());
                tokenObj.setIsUsed(rs.getBoolean("IsUsed"));

                return tokenObj;
            }

        } catch (Exception e) {
            System.out.println("Lỗi khi getToken: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    public List<Users> getAllUsers() {
        List<Users> list = new ArrayList<>();
        String sql = "SELECT UserId, Username, PasswordHash, FullName, Email, Phone, Role, IsActive, Note, CreatedAt FROM Users";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
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

                Timestamp ts = rs.getTimestamp("CreatedAt");
                if (ts != null) {
                    user.setCreatedAt(ts);
                }

                list.add(user);
            }

        } catch (Exception e) {
            System.out.println("Lỗi khi getAllUsers: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }
    
    public static void main(String[] args) {
        UserDAO udao = new UserDAO();
         List<Users> list = udao.getAllUsers();
         for (Users users : list) {
             System.out.println(users.toString());
        }
    }

}
