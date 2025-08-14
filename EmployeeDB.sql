-- 1. Create Department Table
CREATE TABLE Departments1 (
    depart_id SERIAL PRIMARY KEY,
    depart_name VARCHAR(50) NOT NULL,
    depart_city VARCHAR(50)
);

-- 2. Create Roles Table
CREATE TABLE Roles (
    role_id SERIAL PRIMARY KEY,
    role VARCHAR(50) NOT NULL
);

-- 3. Create Salaries Table
CREATE TABLE Salaries (
    salary_id SERIAL PRIMARY KEY,
    salary_pa NUMERIC(10,2) NOT NULL
);

-- 4. Create Overtime Hours Table
CREATE TABLE OvertimeHours (
    overtime_id SERIAL PRIMARY KEY,
    overtime_hours INT NOT NULL
);

-- 5. Create Employees Table
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10) NOT NULL CHECK (gender IN ('Male', 'Female', 'Other')),
    address VARCHAR(255),
    email VARCHAR(100) UNIQUE NOT NULL,
    depart_id INT NOT NULL,
    role_id INT NOT NULL,
    salary_id INT NOT NULL,
    overtime_id INT,

    CONSTRAINT fk_dept FOREIGN KEY (depart_id) REFERENCES Departments1(depart_id) ON DELETE CASCADE,
    CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES Roles(role_id) ON DELETE CASCADE,
    CONSTRAINT fk_salary FOREIGN KEY (salary_id) REFERENCES Salaries(salary_id) ON DELETE CASCADE,
    CONSTRAINT fk_overtime FOREIGN KEY (overtime_id) REFERENCES OvertimeHours(overtime_id) ON DELETE SET NULL
);

-- Insert Sample Data
INSERT INTO Departments1 (depart_name, depart_city) VALUES
('IT', 'Johannesburg'),
('HR', 'Pretoria'),
('GM', 'Cape Town');

INSERT INTO Roles (role) VALUES
('Developer'),
('HR Manager'),
('Project Manager');

INSERT INTO Salaries (salary_pa) VALUES
(500000.00),
(350000.00),
(650000.00);

INSERT INTO OvertimeHours (overtime_hours) VALUES
(10),
(5),
(7);

-- Valid Employee Insert
INSERT INTO Employees (first_name, last_name, gender, address, email, depart_id, role_id, salary_id, overtime_id) VALUES
('John', 'Smith', 'Male', '123 Main St', 'john.smith@gmail.com', 1, 1, 1, 1),
('Jane', 'Doe', 'Female', '456 Oak St', 'jane.doe@gmail.com', 2, 2, 2, 2),
('Peter', 'Duma', 'Female', '456 Oak St', 'peter10@gmail.com', 3, 3, 3, 3);

-- This should fail because depart_id = 99 does not exist in department
INSERT INTO employees (first_name, last_name, email, depart_id, role_id, salary_id, overtime_id)
VALUES ('Mike','Brown','mike.b@example.com', 99, 1, 1, 1);

DELETE FROM department WHERE depart_id = 1;

select * from Departments1;
select * from Roles;
select * from Salaries;
select * from OvertimeHours;
select * from Employees;
drop table Departments1;
drop table Roles;
drop table Salaries;
drop table OvertimeHours;
drop table Employees;

-- LEFT JOIN Query
SELECT e.first_name, e.last_name, d.depart_name, r.role, s.salary_pa, o.overtime_hours
FROM Employees e
LEFT JOIN Departments1 d ON e.depart_id = d.depart_id
LEFT JOIN Roles r ON e.role_id = r.role_id
LEFT JOIN Salaries s ON e.salary_id = s.salary_id
LEFT JOIN OvertimeHours o ON e.overtime_id = o.overtime_id;
