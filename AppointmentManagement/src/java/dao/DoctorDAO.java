package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Doctor;
import model.Users;

public class DoctorDAO extends DBContext {

    // Lấy tất cả bác sỹ
    public List<Doctor> getAllDoctors() {
        List<Doctor> list = new ArrayList<>();
        String sql = "SELECT * FROM Doctors";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            UserDAO usersDAO = new UserDAO();

            while (rs.next()) {
                Doctor doctor = new Doctor();
                doctor.setDoctorId(rs.getInt("DoctorId"));
                int userId = rs.getInt("UserId");
                Users user = usersDAO.getUserById(userId);
                doctor.setUserId(user);
                doctor.setIsServiceDoctor(rs.getBoolean("IsServiceDoctor"));
                doctor.setIsActive(rs.getBoolean("IsActive"));
                doctor.setGender(rs.getString("Gender"));
                doctor.setDateOfBirth(rs.getDate("DateOfBirth"));
                doctor.setSpecialization(rs.getString("Specialization"));
                doctor.setQualifications(rs.getString("Qualifications"));
                doctor.setExperienceYears(rs.getInt("ExperienceYears"));
                doctor.setDescription(rs.getString("Description"));
                doctor.setProfileImageUrl(rs.getString("ProfileImageUrl"));
                doctor.setPositionTitle(rs.getString("PositionTitle"));
                doctor.setCreatedDate(rs.getDate("CreatedDate"));
                doctor.setUpdatedDate(rs.getDate("UpdatedDate"));
                list.add(doctor);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy 1 bác sỹ theo ID
    public Doctor getDoctorById(int doctorId) {
        String sql = "SELECT * FROM Doctors WHERE DoctorId = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, doctorId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Doctor doctor = new Doctor();
                    doctor.setDoctorId(rs.getInt("DoctorId"));
                    int userId = rs.getInt("UserId");
                    UserDAO usersDAO = new UserDAO();
                    Users user = usersDAO.getUserById(userId);
                    doctor.setUserId(user);
                    doctor.setIsServiceDoctor(rs.getBoolean("IsServiceDoctor"));
                    doctor.setIsActive(rs.getBoolean("IsActive"));
                    doctor.setGender(rs.getString("Gender"));
                    doctor.setDateOfBirth(rs.getDate("DateOfBirth"));
                    doctor.setSpecialization(rs.getString("Specialization"));
                    doctor.setQualifications(rs.getString("Qualifications"));
                    doctor.setExperienceYears(rs.getInt("ExperienceYears"));
                    doctor.setDescription(rs.getString("Description"));
                    doctor.setProfileImageUrl(rs.getString("ProfileImageUrl"));
                    doctor.setPositionTitle(rs.getString("PositionTitle"));
                    doctor.setCreatedDate(rs.getDate("CreatedDate"));
                    doctor.setUpdatedDate(rs.getDate("UpdatedDate"));
                    return doctor;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
