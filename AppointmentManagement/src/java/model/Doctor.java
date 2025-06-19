/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

public class Doctor {

    private int doctorId;
    private Users userId;
    private boolean isServiceDoctor;
    private boolean isActive;
    private String gender;
    private Date dateOfBirth;
    private String specialization;
    private String qualifications;
    private int experienceYears;
    private String description;
    private String profileImageUrl;
    private String positionTitle;
    private Date createdDate;
    private Date updatedDate;

    public Doctor() {
    }

    public Doctor(int doctorId, Users userId, boolean isServiceDoctor, boolean isActive, String gender, Date dateOfBirth, String specialization, String qualifications, int experienceYears, String description, String profileImageUrl, String positionTitle, Date createdDate, Date updatedDate) {
        this.doctorId = doctorId;
        this.userId = userId;
        this.isServiceDoctor = isServiceDoctor;
        this.isActive = isActive;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.specialization = specialization;
        this.qualifications = qualifications;
        this.experienceYears = experienceYears;
        this.description = description;
        this.profileImageUrl = profileImageUrl;
        this.positionTitle = positionTitle;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
    }

    public int getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }

    public Users getUserId() {
        return userId;
    }

    public void setUserId(Users userId) {
        this.userId = userId;
    }

    public boolean isIsServiceDoctor() {
        return isServiceDoctor;
    }

    public void setIsServiceDoctor(boolean isServiceDoctor) {
        this.isServiceDoctor = isServiceDoctor;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public String getQualifications() {
        return qualifications;
    }

    public void setQualifications(String qualifications) {
        this.qualifications = qualifications;
    }

    public int getExperienceYears() {
        return experienceYears;
    }

    public void setExperienceYears(int experienceYears) {
        this.experienceYears = experienceYears;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getProfileImageUrl() {
        return profileImageUrl;
    }

    public void setProfileImageUrl(String profileImageUrl) {
        this.profileImageUrl = profileImageUrl;
    }

    public String getPositionTitle() {
        return positionTitle;
    }

    public void setPositionTitle(String positionTitle) {
        this.positionTitle = positionTitle;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    @Override
    public String toString() {
        return "Doctor{" + "doctorId=" + doctorId + ", userId=" + userId + ", isServiceDoctor=" + isServiceDoctor + ", isActive=" + isActive + ", gender=" + gender + ", dateOfBirth=" + dateOfBirth + ", specialization=" + specialization + ", qualifications=" + qualifications + ", experienceYears=" + experienceYears + ", description=" + description + ", profileImageUrl=" + profileImageUrl + ", positionTitle=" + positionTitle + ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + '}';
    }

}
