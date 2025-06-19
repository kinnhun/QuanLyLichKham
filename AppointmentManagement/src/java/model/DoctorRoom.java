/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

public class DoctorRoom {

    private int doctorRoomId;
    private Doctor doctorId;
    private Room roomId;
    private String status;
    private Date startDate;
    private Date endDate;

    public DoctorRoom() {
    }

    public DoctorRoom(int doctorRoomId, Doctor doctorId, Room roomId, String status, Date startDate, Date endDate) {
        this.doctorRoomId = doctorRoomId;
        this.doctorId = doctorId;
        this.roomId = roomId;
        this.status = status;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public int getDoctorRoomId() {
        return doctorRoomId;
    }

    public void setDoctorRoomId(int doctorRoomId) {
        this.doctorRoomId = doctorRoomId;
    }

    public Doctor getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(Doctor doctorId) {
        this.doctorId = doctorId;
    }

    public Room getRoomId() {
        return roomId;
    }

    public void setRoomId(Room roomId) {
        this.roomId = roomId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    @Override
    public String toString() {
        return "DoctorRoom{" + "doctorRoomId=" + doctorRoomId + ", doctorId=" + doctorId + ", roomId=" + roomId + ", status=" + status + ", startDate=" + startDate + ", endDate=" + endDate + '}';
    }

}
