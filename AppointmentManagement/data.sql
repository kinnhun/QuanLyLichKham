

-- Tạo database (nếu chưa có)
CREATE   DATABASE ClinicBookingSystem;
GO
USE ClinicBookingSystem;
GO

-- ================================================
-- 1) USERS - Tài khoản người dùng
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(MAX) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    Role NVARCHAR(20), -- 'Admin', 'Receptionist', 'Doctor', 'Patient'
    IsActive BIT DEFAULT 1,
    Note NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- ================================================
-- 2) DEPARTMENTS - Khoa / chuyên khoa
CREATE TABLE Departments (
    DepartmentId INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX)
);

-- ================================================
-- 3) ROOMS - Phòng khám
CREATE TABLE Rooms (
    RoomId INT IDENTITY(1,1) PRIMARY KEY,
    RoomName NVARCHAR(100) NOT NULL,
    DepartmentId INT,
    FOREIGN KEY (DepartmentId) REFERENCES Departments(DepartmentId)
);

-- ================================================
-- 4) DOCTORS - Bác sĩ
CREATE TABLE Doctors (
    DoctorId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    IsServiceDoctor BIT DEFAULT 0,
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- ================================================
-- 5) DOCTOR_DEPARTMENTS - Bác sĩ thuộc nhiều khoa
CREATE TABLE DoctorDepartments (
    DoctorDepartmentId INT IDENTITY(1,1) PRIMARY KEY,
    DoctorId INT NOT NULL,
    DepartmentId INT NOT NULL,
    FOREIGN KEY (DoctorId) REFERENCES Doctors(DoctorId),
    FOREIGN KEY (DepartmentId) REFERENCES Departments(DepartmentId)
);

-- ================================================
-- 6) DOCTOR_ROOMS - Bác sĩ làm ở nhiều phòng
CREATE TABLE DoctorRooms (
    DoctorRoomId INT IDENTITY(1,1) PRIMARY KEY,
    DoctorId INT NOT NULL,
    RoomId INT NOT NULL,
    FOREIGN KEY (DoctorId) REFERENCES Doctors(DoctorId),
    FOREIGN KEY (RoomId) REFERENCES Rooms(RoomId)
);

-- ================================================
-- 7) PATIENTS - Hồ sơ bệnh nhân
CREATE TABLE Patients (
    PatientId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(10),
    DateOfBirth DATE,
    Phone NVARCHAR(20),
    Email NVARCHAR(100),
    Address NVARCHAR(255),
    MedicalHistory NVARCHAR(MAX),
    PreferredDoctorId INT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (PreferredDoctorId) REFERENCES Doctors(DoctorId)
);

-- ================================================
-- 8) DOCTOR_SCHEDULES - Lịch công tác bác sĩ
CREATE TABLE DoctorSchedules (
    ScheduleId INT IDENTITY(1,1) PRIMARY KEY,
    DoctorId INT NOT NULL,
    WorkDate DATE NOT NULL,
    Shift NVARCHAR(20), -- 'Morning', 'Afternoon', 'Evening'
    TimeSlot NVARCHAR(50), -- cụ thể: '08:00-08:30'
    RoomId INT,
    Note NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (DoctorId) REFERENCES Doctors(DoctorId),
    FOREIGN KEY (RoomId) REFERENCES Rooms(RoomId)
);

-- ================================================
-- 9) APPOINTMENTS - Lịch hẹn khám
CREATE TABLE Appointments (
    AppointmentId INT IDENTITY(1,1) PRIMARY KEY,
    PatientId INT NOT NULL,
    DoctorId INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    TimeSlot NVARCHAR(50) NOT NULL,
    Status NVARCHAR(20) DEFAULT 'Pending', -- 'Pending', 'Confirmed', 'Rejected', 'Cancelled', 'Completed', 'NoShow'
    CreatedByUserId INT,
    CancelReason NVARCHAR(255),
    RejectReason NVARCHAR(255),
    NoShow BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME,
    FOREIGN KEY (PatientId) REFERENCES Patients(PatientId),
    FOREIGN KEY (DoctorId) REFERENCES Doctors(DoctorId),
    FOREIGN KEY (CreatedByUserId) REFERENCES Users(UserId)
);

-- ================================================
-- 10) APPOINTMENT_LIMITS - Giới hạn số bệnh nhân / khung giờ
CREATE TABLE AppointmentLimits (
    LimitId INT IDENTITY(1,1) PRIMARY KEY,
    DoctorId INT,
    TimeSlot NVARCHAR(50),
    MaxPatients INT DEFAULT 5,
    EffectiveDate DATE,
    FOREIGN KEY (DoctorId) REFERENCES Doctors(DoctorId)
);

-- ================================================
-- 11) APPOINTMENT_REMINDERS - Log gửi nhắc lịch
CREATE TABLE AppointmentReminders (
    ReminderId INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentId INT NOT NULL,
    ReminderDate DATETIME DEFAULT GETDATE(),
    SentVia NVARCHAR(50), -- 'Email', 'SMS'
    FOREIGN KEY (AppointmentId) REFERENCES Appointments(AppointmentId)
);

-- ================================================
-- 12) APPOINTMENT_CANCEL_HISTORY - Lịch sử hủy của bệnh nhân
CREATE TABLE AppointmentCancelHistory (
    CancelId INT IDENTITY(1,1) PRIMARY KEY,
    PatientId INT NOT NULL,
    CancelDate DATETIME DEFAULT GETDATE(),
    AppointmentId INT,
    CancelType NVARCHAR(50), -- 'Normal', 'LateCancel'
    FOREIGN KEY (PatientId) REFERENCES Patients(PatientId),
    FOREIGN KEY (AppointmentId) REFERENCES Appointments(AppointmentId)
);

-- ================================================
-- 13) MEDICAL_RECORDS - Lịch sử bệnh án
CREATE TABLE MedicalRecords (
    RecordId INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentId INT NOT NULL,
    PatientId INT NOT NULL,
    DoctorId INT NOT NULL,
    Diagnosis NVARCHAR(MAX),
    Treatment NVARCHAR(MAX),
    Prescription NVARCHAR(MAX),
    Notes NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (AppointmentId) REFERENCES Appointments(AppointmentId),
    FOREIGN KEY (PatientId) REFERENCES Patients(PatientId),
    FOREIGN KEY (DoctorId) REFERENCES Doctors(DoctorId)
);

-- ================================================
-- ================================================
-- VIEW 1: Lịch sử đặt hẹn của bệnh nhân
CREATE VIEW vw_PatientAppointmentHistory AS
SELECT 
    A.AppointmentId,
    A.PatientId,
    P.FullName AS PatientName,
    A.DoctorId,
    D.UserId AS DoctorUserId,
    U.FullName AS DoctorName,
    A.AppointmentDate,
    A.TimeSlot,
    A.Status,
    A.NoShow,
    A.CancelReason,
    A.RejectReason,
    A.CreatedAt,
    A.UpdatedAt
FROM Appointments A
INNER JOIN Patients P ON A.PatientId = P.PatientId
INNER JOIN Doctors D ON A.DoctorId = D.DoctorId
INNER JOIN Users U ON D.UserId = U.UserId;
GO
-- ================================================
-- VIEW 2: Lịch sử khám (kết quả từng lần khám)
CREATE VIEW vw_PatientMedicalHistory AS
SELECT 
    MR.RecordId,
    MR.PatientId,
    P.FullName AS PatientName,
    MR.DoctorId,
    D.UserId AS DoctorUserId,
    U.FullName AS DoctorName,
    A.AppointmentDate,
    A.TimeSlot,
    MR.Diagnosis,
    MR.Treatment,
    MR.Prescription,
    MR.Notes,
    MR.CreatedAt
FROM MedicalRecords MR
INNER JOIN Patients P ON MR.PatientId = P.PatientId
INNER JOIN Doctors D ON MR.DoctorId = D.DoctorId
INNER JOIN Users U ON D.UserId = U.UserId
INNER JOIN Appointments A ON MR.AppointmentId = A.AppointmentId;
GO




  CREATE TABLE PasswordResetToken (
    TokenId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    Token NVARCHAR(255) NOT NULL,
    Expiry DATETIME NOT NULL,
    IsUsed BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_PasswordResetToken_User FOREIGN KEY (UserId) REFERENCES Users(UserId)
);
