-- ============================================
-- HospitalDB - SQL Server Project
-- Author: Mahmoud Atef
-- Description: Hospital management database
-- ============================================

CREATE DATABASE HospitalDB;
GO

USE HospitalDB;
GO

-- ============================================
-- DDL - Create Tables
-- ============================================

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentNM VARCHAR(100) NOT NULL UNIQUE,
    Location VARCHAR(100),
    Phone VARCHAR(20)
);

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentID INT NOT NULL,
    DoctorNM VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100) UNIQUE,
    HireDate DATE DEFAULT GETDATE(),
    CONSTRAINT FK_Doctor_Department
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100) NOT NULL,
    Gender VARCHAR(10) CHECK (Gender IN ('Male','Female')),
    BirthDate DATE,
    Phone VARCHAR(20),
    BloodType VARCHAR(5),
    Address VARCHAR(200),
    RegistrationDate DATE DEFAULT GETDATE()
);

CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY IDENTITY(1,1),
    RoomNumber VARCHAR(10) UNIQUE NOT NULL,
    RoomType VARCHAR(50),
    FloorNumber INT,
    Status VARCHAR(20) CHECK (Status IN ('Available','Occupied'))
);

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    DepartmentID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Reason VARCHAR(200),
    Status VARCHAR(20) CHECK (Status IN ('Scheduled','Completed','Cancelled')),
    CONSTRAINT FK_Appointments_Patients
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    CONSTRAINT FK_Appointments_Doctors
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    CONSTRAINT FK_Appointments_Departments
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Treatments (
    TreatmentID INT PRIMARY KEY IDENTITY(1,1),
    AppointmentID INT NOT NULL,
    TreatmentNM VARCHAR(100),
    Description VARCHAR(300),
    TreatmentDate DATE,
    Cost DECIMAL(10,2) CHECK (Cost >= 0),
    CONSTRAINT FK_Treatments_Appointments
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

CREATE TABLE Prescriptions (
    PrescriptionID INT PRIMARY KEY IDENTITY(1,1),
    TreatmentID INT NOT NULL,
    MedicineName VARCHAR(100),
    Dosage VARCHAR(50),
    Frequency VARCHAR(50),
    Duration VARCHAR(50),
    Notes VARCHAR(300),
    CONSTRAINT FK_Prescriptions_Treatments
    FOREIGN KEY (TreatmentID) REFERENCES Treatments(TreatmentID)
);

CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT NOT NULL,
    RecordDate DATE,
    Description VARCHAR(300),
    Diagnosis VARCHAR(200),
    Notes VARCHAR(300),
    CONSTRAINT FK_MedicalRecords_Patients
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE Bills (
    BillID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT NOT NULL,
    AppointmentID INT NOT NULL,
    BillDate DATE DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2) CHECK (TotalAmount >= 0),
    PaymentStatus VARCHAR(20) CHECK (PaymentStatus IN ('Paid','Unpaid')),
    CONSTRAINT FK_Bills_Patients
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    CONSTRAINT FK_Bills_Appointments
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- ============================================
-- DML - Insert Sample Data
-- ============================================

INSERT INTO Departments (DepartmentNM, Location, Phone) VALUES 
('Cardiology', 'Building A - 2nd Floor', '01000000001'),
('Neurology', 'Building B - 1st Floor', '01000000002'),
('Orthopedics', 'Building C - 3rd Floor', '01000000003');

INSERT INTO Doctors (DepartmentID, DoctorNM, Specialization, Phone, Email) VALUES
(1, 'Dr. Ahmed Ali', 'Heart Specialist', '01111111111', 'ahmed@hospital.com'),
(2, 'Dr. Sara Mohamed', 'Brain Specialist', '01111111112', 'sara@hospital.com'),
(3, 'Dr. Omar Hassan', 'Bone Specialist', '01111111113', 'omar@hospital.com');

INSERT INTO Patients (FullName, Gender, BirthDate, Phone, BloodType, Address) VALUES
('Khaled Mostafa', 'Male', '1995-05-10', '01234567890', 'O+', 'Cairo'),
('Mona Adel', 'Female', '2000-09-21', '01234567891', 'A+', 'Giza'),
('Youssef Tarek', 'Male', '1988-12-01', '01234567892', 'B-', 'Alexandria');

INSERT INTO Rooms (RoomNumber, RoomType, FloorNumber, Status) VALUES
('101', 'ICU', 1, 'Available'),
('102', 'General', 1, 'Occupied'),
('201', 'Surgery', 2, 'Available');

INSERT INTO Appointments (PatientID, DoctorID, DepartmentID, AppointmentDate, Reason, Status) VALUES
(1, 1, 1, '2026-06-15 10:00:00', 'Chest Pain', 'Scheduled'),
(2, 2, 2, '2026-06-16 12:00:00', 'Headache', 'Completed'),
(3, 3, 3, '2026-06-17 14:00:00', 'Knee Pain', 'Scheduled');

INSERT INTO Treatments (AppointmentID, TreatmentNM, Description, TreatmentDate, Cost) VALUES
(1, 'ECG Test', 'Heart monitoring test', '2026-06-15', 500.00),
(2, 'MRI Scan', 'Brain imaging', '2026-06-16', 1200.00),
(3, 'X-Ray', 'Knee bone scan', '2026-06-17', 300.00);

INSERT INTO Prescriptions (TreatmentID, MedicineName, Dosage, Frequency, Duration, Notes) VALUES
(1, 'Aspirin', '100mg', 'Once daily', '7 days', 'After meals'),
(2, 'Paracetamol', '500mg', 'Twice daily', '5 days', 'If pain persists'),
(3, 'Ibuprofen', '200mg', 'Thrice daily', '3 days', 'Take with food');

INSERT INTO MedicalRecords (PatientID, RecordDate, Description, Diagnosis, Notes) VALUES
(1, '2026-06-15', 'Chest pain checkup', 'Mild heart issue', 'Follow up needed'),
(2, '2026-06-16', 'Severe headache', 'Migraine', 'Reduce stress'),
(3, '2026-06-17', 'Knee injury', 'Ligament strain', 'Physiotherapy required');

INSERT INTO Bills (PatientID, AppointmentID, TotalAmount, PaymentStatus) VALUES
(1, 1, 500.00, 'Unpaid'),
(2, 2, 1200.00, 'Paid'),
(3, 3, 300.00, 'Unpaid');

-- ============================================
-- Queries
-- ============================================

-- 1. View all patients
SELECT * FROM Patients;

-- 2. Find bone specialist doctors
SELECT * FROM Doctors WHERE Specialization = 'Bone Specialist';

-- 3. Appointments with patient and doctor names
SELECT
    A.AppointmentID,
    P.FullName,
    D.DoctorNM,
    A.AppointmentDate
FROM Appointments A
JOIN Patients P ON A.PatientID = P.PatientID
JOIN Doctors D ON A.DoctorID = D.DoctorID;

-- 4. Total revenue
SELECT SUM(TotalAmount) AS TotalRevenue FROM Bills;

-- 5. Appointments per doctor
SELECT
    D.DoctorNM,
    COUNT(A.AppointmentID) AS TotalAppointments
FROM Doctors D
JOIN Appointments A ON D.DoctorID = A.DoctorID
GROUP BY D.DoctorNM;

-- 6. Appointments per department
SELECT
    D.DepartmentNM,
    COUNT(A.AppointmentID) AS TotalAppointments
FROM Departments D
JOIN Appointments A ON D.DepartmentID = A.DepartmentID
GROUP BY D.DepartmentNM;

-- ============================================
-- View - Patient History
-- ============================================

CREATE VIEW vw_PatientHistory AS
SELECT
    P.FullName,
    A.AppointmentDate,
    D.DoctorNM,
    T.TreatmentNM,
    T.Cost
FROM Patients P
JOIN Appointments A ON P.PatientID = A.PatientID
JOIN Doctors D ON A.DoctorID = D.DoctorID
JOIN Treatments T ON A.AppointmentID = T.AppointmentID;

SELECT * FROM vw_PatientHistory;

-- ============================================
-- Stored Procedure - Add Patient
-- ============================================

CREATE PROCEDURE AddPatient
    @FullName VARCHAR(100),
    @Gender VARCHAR(10),
    @BirthDate DATE,
    @Phone VARCHAR(20)
AS
BEGIN
    INSERT INTO Patients (FullName, Gender, BirthDate, Phone)
    VALUES (@FullName, @Gender, @BirthDate, @Phone);
END;

-- Test the procedure
EXEC AddPatient
    @FullName = 'Osman',
    @Gender = 'Male',
    @BirthDate = '2004-06-15',
    @Phone = '46656655';
