/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class ShiftType {

    private int shiftTypeId;
    private String typeName;

    public ShiftType() {
    }

    public ShiftType(int shiftTypeId, String typeName) {
        this.shiftTypeId = shiftTypeId;
        this.typeName = typeName;
    }

    public int getShiftTypeId() {
        return shiftTypeId;
    }

    public void setShiftTypeId(int shiftTypeId) {
        this.shiftTypeId = shiftTypeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    @Override
    public String toString() {
        return "ShiftType{" + "shiftTypeId=" + shiftTypeId + ", typeName=" + typeName + '}';
    }

}
