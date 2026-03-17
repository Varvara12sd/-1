USE PraktLabBD;
GO

IF OBJECT_ID('EmployeeAllowances', 'U') IS NOT NULL DROP TABLE EmployeeAllowances;
IF OBJECT_ID('PositionAllowances', 'U') IS NOT NULL DROP TABLE PositionAllowances;
IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;
IF OBJECT_ID('Allowances', 'U') IS NOT NULL DROP TABLE Allowances;
IF OBJECT_ID('Positions', 'U') IS NOT NULL DROP TABLE Positions;
GO

CREATE TABLE Positions (
   PositionID int PRIMARY KEY,
   Title NVARCHAR(100) UNIQUE,
   BaseSalary DECIMAL(11,2),
   Description NVARCHAR(500)
);

CREATE TABLE Employees (
   EmployeeID int PRIMARY KEY,
   Name NVARCHAR(100),
   BirthDate Date,
   PositionID int FOREIGN KEY REFERENCES Positions(PositionID),
   Phone VARCHAR(20) UNIQUE,
   Email VARCHAR(100) UNIQUE,
   HireDate Date,
   TerminationDate Date,
   Address NVARCHAR(200)
);

CREATE TABLE Allowances (
   AllowanceID int PRIMARY KEY,
   Name NVARCHAR(100) UNIQUE,
   DefaultAmount DECIMAL(11,2),
   AllowanceType NVARCHAR(20),
   Description NVARCHAR(500)
);

CREATE TABLE PositionAllowances (
   PositionID int FOREIGN KEY REFERENCES Positions(PositionID),
   AllowanceID int FOREIGN KEY REFERENCES Allowances(AllowanceID),
   MinAmount DECIMAL(11,2),
   MaxAmount DECIMAL(11,2),
   PRIMARY KEY (PositionID, AllowanceID)
);

CREATE TABLE EmployeeAllowances (
   AssignmentID int PRIMARY KEY,
   EmployeeID int FOREIGN KEY REFERENCES Employees(EmployeeID),
   AllowanceID int FOREIGN KEY REFERENCES Allowances(AllowanceID),
   AssignedAmount DECIMAL(11,2),
   StartDate Date,
   EndDate Date
);
GO