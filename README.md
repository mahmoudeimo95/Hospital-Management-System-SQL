# 🏥 Hospital Database — SQL Server Project

A SQL Server database project built to practice database design, DDL, DML, Views, and Stored Procedures.

---

## 📁 Project Structure

```
hospital-db/
│
├── HospitalDB.sql      # Full SQL script (tables, data, queries, view, procedure)
├── ERD.png             # Entity Relationship Diagram
└── README.md
```

---

## 🗄️ Database Tables

| Table | Description |
|---|---|
| `Departments` | Hospital departments (Cardiology, Neurology...) |
| `Doctors` | Doctors and their specializations |
| `Patients` | Patient personal information |
| `Rooms` | Hospital rooms and availability |
| `Appointments` | Patient-doctor appointments |
| `Treatments` | Treatments done per appointment |
| `Prescriptions` | Medicines prescribed per treatment |
| `MedicalRecords` | Patient medical history |
| `Bills` | Billing and payment status |

---

## 🔍 What the Script Covers

- ✅ Creating the database and all tables with constraints
- ✅ Primary keys, foreign keys, and CHECK constraints
- ✅ Inserting sample data
- ✅ SELECT queries with JOINs
- ✅ Aggregate queries (SUM, COUNT, GROUP BY)
- ✅ A View (`vw_PatientHistory`)
- ✅ A Stored Procedure (`AddPatient`)

---

## 🚀 How to Run

1. Open **SQL Server Management Studio (SSMS)**
2. Open the file `HospitalDB.sql`
3. Run the script from top to bottom
4. The database, tables, and sample data will be created automatically

---

## 🛠️ Tools Used

- SQL Server 2022
- SQL Server Management Studio (SSMS)
- T-SQL

---

## 👤 About Me

I'm a beginner learning SQL and database design. This is one of my first SQL projects!

📧 mahmoudeimo95@gmail.com  
🔗 [GitHub](https://github.com/mahmoudeimo95)
