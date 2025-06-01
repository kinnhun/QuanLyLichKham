package model;

import java.util.Date;


public class Users {

    private int userId;
    private String username;
    private String passwordHash;
    private String fullName;
        private String email;
    private String phone;
    private String role;
    private boolean isActive;
    private String note;
    private Date createdAt;

    // Constructors (optional)
    public Users() {
    }

    public Users(int userId, String username, String passwordHash, String fullName, String email, String phone, String role, boolean isActive, String note, Date createdAt) {
        this.userId = userId;
        this.username = username;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.isActive = isActive;
        this.note = note;
        this.createdAt = createdAt;
    }


    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }


    @Override
    public String toString() {
        return "Users{" + "userId=" + userId + ", username=" + username + ", passwordHash=" + passwordHash + ", fullName=" + fullName + ", email=" + email + ", phone=" + phone + ", role=" + role + ", isActive=" + isActive + ", note=" + note + ", createdAt=" + createdAt + '}';
    }

}
