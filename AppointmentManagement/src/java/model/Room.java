/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Room {

    private int roomId;
    private String roomName;
    private Department departmentId;
    private int floor;
    private String roomType;
    private String description;

    public Room() {
    }

    public Room(int roomId, String roomName, Department departmentId, int floor, String roomType, String description) {
        this.roomId = roomId;
        this.roomName = roomName;
        this.departmentId = departmentId;
        this.floor = floor;
        this.roomType = roomType;
        this.description = description;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public Department getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Department departmentId) {
        this.departmentId = departmentId;
    }

    public int getFloor() {
        return floor;
    }

    public void setFloor(int floor) {
        this.floor = floor;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Room{" + "roomId=" + roomId + ", roomName=" + roomName + ", departmentId=" + departmentId + ", floor=" + floor + ", roomType=" + roomType + ", description=" + description + '}';
    }

}
