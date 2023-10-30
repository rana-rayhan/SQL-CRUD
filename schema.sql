CREATE DATABASE collage;

CREATE TABLE student(
id INT(20) PRIMARY KEY AUTO_INCREMENT,
student_name VARCHAR(50) NOT NULL,
age INT(3) NOT NULL,
email VARCHAR(50) NOT NULL,
created TIMESTAMP NOT NULL DEFAULT NOW()
);

INSERT INTO student
(id,student_name,age,email)
VALUE
(101,"Ryan Rahman",26,"ryan@gmail.com") ;


-- Remove safe mode before update 
SET SQL_SAFE_UPDATES = 0;

-- Creating courses table
CREATE TABLE courses(
    id VARCHAR(100) PRIMARY KEY,
    courseName VARCHAR(50),
    courseId INT UNIQUE NOT NULL
);

-- Ensure courseId is set to INT, UNIQUE, and NOT NULL
ALTER TABLE courses
MODIFY courseId INT UNIQUE NOT NULL;

-- Display structure of the 'courses' table
DESCRIBE courses;

-- Empty the 'courses' table
TRUNCATE TABLE courses;

-- Insert course information
INSERT INTO courses (id, courseName, courseId)
VALUES 
    ("5abcde", "Mathematics", 108),
    ("3qwerty", "Science", 109),
    ("2tiger", "History", 110);

-- View all records in the 'courses' table
SELECT * FROM courses;

-- Creating students table
CREATE TABLE students(
    id VARCHAR(100) PRIMARY KEY,
    studentName VARCHAR(100),
    marks INT,
    courseId INT
);

-- Display structure of the 'students' table
DESCRIBE students;

-- Empty the 'students' table
TRUNCATE TABLE students;

-- Insert student information
INSERT INTO students (id, studentName, marks, courseId)
VALUES 
    ("1", "John Doe", 90, 105),      -- Grade A = 90
    ("2", "Alice Smith", 80, 105),   -- Grade B = 80
    ("3", "Ethan Johnson", 70, 104), -- Grade C = 70
    ("4", "Olivia Brown", 90, 104),  -- Grade A = 90
    ("5", "Liam Davis", 80, 103),    -- Grade B = 80
    ("6", "Sophia Wilson", 70, 103), -- Grade C = 70
    ("7", "Mia Martinez", 80, NULL),
    ("8", "Noah Anderson", 45, NULL),
    ("9", "Ava Taylor", 50, 107),    -- Grade C = 70
    ("10", "William Thomas", 30, NULL);

-- View all records in the 'students' table
SELECT * FROM students;

UPDATE students
SET studentName="Ryan Rahman"
WHERE id=1;

DELETE FROM students
WHERE student_id = 123;


-- Select query to calculate the overall average marks of all students
SELECT AVG(marks)
FROM students;

-- Select query to retrieve names and marks of students with marks higher than the overall average
SELECT studentName, marks
FROM students
WHERE marks > (SELECT AVG(marks) FROM students);

-- Query to display the average marks and count of students per course
SELECT courseId, AVG(marks), COUNT(courseId)
FROM students
GROUP BY courseId;

-- Joining 'students' and 'courses' tables using a FULL JOIN
SELECT *
FROM students
FULL JOIN courses;

-- Combining all records from 'students' table using UNION
SELECT * FROM students
UNION
SELECT * FROM students;

-- Query to retrieve student ID, name, and corresponding course name using INNER JOIN
SELECT students.id as studentId, students.studentName, courses.courseName
FROM students
INNER JOIN courses ON students.courseId = courses.courseId;

-- Query to retrieve student ID, name, and corresponding course name using LEFT JOIN
SELECT students.id as studentId, students.studentName, courses.courseName
FROM students
LEFT JOIN courses ON students.courseId = courses.courseId;

-- Query to retrieve student ID, name, and corresponding course name using RIGHT JOIN
SELECT students.id as studentId, students.studentName, courses.courseName
FROM students
RIGHT JOIN courses ON students.courseId = courses.courseId;

-- Query to retrieve course ID, course name, average marks, and the count of students per course
SELECT students.courseId, courses.courseName, AVG(marks), COUNT(students.courseId) as studentList
FROM students
INNER JOIN courses ON students.courseId = courses.courseId
GROUP BY courses.courseId, courses.courseName;
