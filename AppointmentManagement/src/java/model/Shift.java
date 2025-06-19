/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Time;

public class Shift {

    private int shiftId;
    private String shiftName;
    private ShiftType shiftTypeId;
    private java.sql.Time startTime;
    private java.sql.Time endTime;

    public Shift() {
    }

    public Shift(int shiftId, String shiftName, ShiftType shiftTypeId, Time startTime, Time endTime) {
        this.shiftId = shiftId;
        this.shiftName = shiftName;
        this.shiftTypeId = shiftTypeId;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public int getShiftId() {
        return shiftId;
    }

    public void setShiftId(int shiftId) {
        this.shiftId = shiftId;
    }

    public String getShiftName() {
        return shiftName;
    }

    public void setShiftName(String shiftName) {
        this.shiftName = shiftName;
    }

    public ShiftType getShiftTypeId() {
        return shiftTypeId;
    }

    public void setShiftTypeId(ShiftType shiftTypeId) {
        this.shiftTypeId = shiftTypeId;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    @Override
    public String toString() {
        return "Shift{" + "shiftId=" + shiftId + ", shiftName=" + shiftName + ", shiftTypeId=" + shiftTypeId + ", startTime=" + startTime + ", endTime=" + endTime + '}';
    }

  

}
