CREATE DATABASE IF NOT EXISTS db_book;

USE db_book;
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE classroom
(
	building VARCHAR(15),
    room_number VARCHAR(7),
    capacity NUMERIC(4, 0),
    PRIMARY KEY (building, room_number)
);
DESCRIBE classroom;

CREATE TABLE department
(
	dept_name VARCHAR(20),
    building VARCHAR(15),
    budget NUMERIC(12, 2) CHECK(budget > 0),
    PRIMARY KEY(dept_name)
);
DESCRIBE department;

CREATE TABLE course
(
	course_id VARCHAR(8),
    title VARCHAR(50),
    dept_name VARCHAR(20),
    credits NUMERIC(2, 0) CHECK (credits > 0),
    PRIMARY KEY(course_id),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
    ON DELETE SET NULL
);
DESCRIBE course;

CREATE TABLE instructor
(
	ID VARCHAR(5),
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    salary NUMERIC(8,2) CHECK(salary > 29000),
    PRIMARY KEY(ID),
    FOREIGN KEY(dept_name) REFERENCES department(dept_name)
    ON DELETE SET NULL
);
DESCRIBE instructor;

CREATE TABLE section
(
	course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6) CHECK(semester In ('Fall', 'Winter', 'Spring', 'Summer')),
    year numeric(4, 0) CHECK (year> 1701 AND year < 2100),
    building VARCHAR(15),
    room_number VARCHAR(7),
    time_slot_id VARCHAR(4),
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
    ON DELETE CASCADE,
    FOREIGN KEY (building, room_number) REFERENCES classroom(building, room_number)
    ON DELETE SET NULL
);
ALTER TABLE section 
ADD FOREIGN KEY(time_slot_id) REFERENCES time_slot(time_slot_id);
DESCRIBE section;

CREATE TABLE teaches
(
	ID VARCHAR(5),
	course_id VARCHAR(8),
	sec_id VARCHAR(8),
	semester VARCHAR(6),
	year NUMERIC(4, 0),
	PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY(course_id, sec_id, semester, year)
    REFERENCES section(course_id, sec_id, semester, year)
    ON DELETE CASCADE,
    FOREIGN KEY (ID) REFERENCES instructor(ID) 
    ON DELETE CASCADE
);
DESCRIBE teaches;

CREATE TABLE student
(
	ID VARCHAR(5),
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    tot_cred NUMERIC(3,0) CHECK (tot_cred >= 0),
    PRIMARY KEY (ID),
    FOREIGN KEY(dept_name) REFERENCES department(dept_name)
    ON DELETE SET NULL
);
DESCRIBE student;

CREATE TABLE takes
(
	ID VARCHAR(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4, 0),
    grade VARCHAR(2),
    PRIMARY KEY(ID, course_id, sec_id, semester, year),
    FOREIGN KEY(course_id, sec_id, semester, year) 
    REFERENCES section(course_id, sec_id, semester, year)
    ON DELETE CASCADE,
    FOREIGN KEY(ID) REFERENCES student(ID)
    ON DELETE CASCADE
);
DESCRIBE takes;

CREATE TABLE advisor
(
	s_ID VARCHAR(5),
    i_ID VARCHAR(5),
    PRIMARY KEY (s_ID),
    FOREIGN KEY(i_ID) REFERENCES instructor(ID)
    ON DELETE SET NULL,
    FOREIGN KEY(s_ID) REFERENCES student(ID)
    ON DELETE CASCADE
);
DESCRIBE advisor;

CREATE TABLE time_slot
(
	time_slot_id VARCHAR(4),
    day VARCHAR(1),
    start_hr NUMERIC(2) CHECK (start_hr >= 0 AND start_hr < 24),
    start_min NUMERIC(2) CHECK (start_min >= 0 AND start_min < 60),
    end_hr NUMERIC(2) CHECK (end_hr >= 0 AND end_hr < 24),
    end_min NUMERIC(2) CHECK (end_min >= 0 AND end_min < 60),
    PRIMARY KEY(time_slot_id, day, start_hr, start_min)
);
DESCRIBE time_slot;

CREATE TABLE prereq
(
	course_id VARCHAR(8),
    prereq_id VARCHAR(8),
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
    ON DELETE CASCADE,
    FOREIGN KEY (prereq_id) REFERENCES course(course_id)
);

INSERT INTO classroom
VALUES
('Packard', '101', '500'),
('Painter', '514', '10'),
('Taylor', '3128', '70'),
('Watson', '100', '30'),
('Watson', '120', '50');
SELECT * FROM classroom;

INSERT INTO department(dept_name, building, budget)
VALUES
('Biology', 'Watson', '90000'),
('Comp. Sci.', 'Taylor', '100000'),
('Elec. Eng.', 'Taylor', '85000'),
('Finance', 'Painter', '120000'),
('History', 'Painter', '50000'),
('Music', 'Packard', '80000'),
('Physics', 'Watson', '70000');
SELECT * FROM department;

INSERT INTO course(course_id, title, dept_name, credits)
VALUES
('BIO-101', 'Intro. to Biology', 'Biology', '4'),
('BIO-301', 'Genetics', 'Biology', '4'),
('BIO-399', 'Computational Biology', 'Biology', '3'),
('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', '4'),
('CS-190', 'Game Design', 'Comp. Sci.', '4'),
('CS-315', 'Robotics', 'Comp. Sci.', '3'),
('CS-319', 'Image Processing', 'Comp. Sci.', '3'),
('CS-347', 'Database System Concepts', 'Comp. Sci.', '3'),
('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', '3'),
('FIN-201', 'Investment Banking', 'Finance', '3'),
('HIS-351', 'World History', 'History', '3'),
('MU-199', 'Music Video Production', 'Music', '3'),
('PHY-101', 'Physical Principles', 'Physics', '4');
SELECT * FROM course;

DELETE FROM instructor;
INSERT INTO instructor(ID, name, dept_name, salary)
VALUES
('10101', 'Srinivasan', 'Comp. Sci.', '65000'),
('12121', 'Wu', 'Finance', '90000'),
('15151', 'Mozart', 'Music', '40000'),
('22222', 'Einstein', 'Physics', '95000'),
('32343', 'El Said', 'History', '60000'),
('33456', 'Gold', 'Physics', '87000'),
('45565', 'Katz', 'Comp. Sci.', '75000'),
('58583', 'Califieri', 'History', '62000'),
('76543', 'Singh', 'Finance', '80000'),
('76766', 'Crick', 'Biology', '72000'),
('83821', 'Brandt', 'Comp. Sci.', '92000'),
('98345', 'Kim', 'Elec. Eng.', '80000');
SELECT * FROM instructor;

INSERT INTO section
VALUES
('BIO-101', '3', 'Fall', '2017', 'Painter', '514', 'B'),
('BIO-101', '1', 'Summer', '2017', 'Painter', '514', 'B'),
('BIO-301', '1', 'Summer', '2018', 'Painter', '514', 'A'),
('CS-101', '1', 'Fall', '2017', 'Packard', '101', 'H'),
('CS-101', '1', 'Spring', '2018', 'Packard', '101', 'F'),
('CS-190', '1', 'Spring', '2017', 'Taylor', '3128', 'E'),
('CS-190', '2', 'Spring', '2017', 'Taylor', '3128', 'A'),
('CS-315', '1', 'Spring', '2018', 'Watson', '120', 'D'),
('CS-319', '1', 'Spring', '2018', 'Watson', '100', 'B'),
('CS-319', '2', 'Spring', '2018', 'Taylor', '3128', 'C'),
('CS-347', '1', 'Fall', '2017', 'Taylor', '3128', 'A'),
('EE-181', '1', 'Spring', '2017', 'Taylor', '3128', 'C'),
('FIN-201', '1', 'Spring', '2018', 'Packard', '101', 'B'),
('HIS-351', '1', 'Spring', '2018', 'Painter', '514', 'C'),
('MU-199', '1', 'Spring', '2018', 'Packard', '101', 'D'),
('PHY-101', '1', 'Fall', '2017', 'Watson', '100', 'A');
SELECT * FROM section;

INSERT INTO teaches
VALUES
('10101', 'CS-101', '1', 'Fall', '2017'),
('10101', 'CS-315', '1', 'Spring', '2018'),
('10101', 'CS-347', '1', 'Fall', '2017'),
('12121', 'FIN-201', '1', 'Spring', '2018'),
('15151', 'MU-199', '1', 'Spring', '2018'),
('22222', 'PHY-101', '1', 'Fall', '2017'),
('32343', 'HIS-351', '1', 'Spring', '2018'),
('45565', 'CS-101', '1', 'Spring', '2018'),
('45565', 'CS-319', '1', 'Spring', '2018'),
('76766', 'BIO-101', '1', 'Summer', '2017'),
('76766', 'BIO-301', '1', 'Summer', '2018'),
('83821', 'CS-190', '1', 'Spring', '2017'),
('83821', 'CS-190', '2', 'Spring', '2017'),
('83821', 'CS-319', '2', 'Spring', '2018'),
('98345', 'EE-181', '1', 'Spring', '2017');
SELECT * FROM teaches;

INSERT INTO student
VALUES
('00128', 'Zhang', 'Comp. Sci.', '102'),
('12345', 'Shankar', 'Comp. Sci.', '32'),
('19991', 'Brandt', 'History', '80'),
('23121', 'Chavez', 'Finance', '110'),
('44553', 'Peltier', 'Physics', '56'),
('45678', 'Levy', 'Physics', '46'),
('54321', 'Williams', 'Comp. Sci.', '54'),
('55739', 'Sanchez', 'Music', '38'),
('70557', 'Snow', 'Physics', '0'),
('76543', 'Brown', 'Comp. Sci.', '58'),
('76653', 'Aoi', 'Elec. Eng.', '60'),
('98765', 'Bourikas', 'Elec. Eng.', '98'),
('98988', 'Tanaka', 'Biology', '120');
SELECT * FROM student;

INSERT INTO takes
VALUES
('00128', 'CS-101', '1', 'Fall', '2017', 'A'),
('00128', 'CS-347', '1', 'Fall', '2017', 'A-'),
('12345', 'CS-101', '1', 'Fall', '2017', 'C'),
('12345', 'CS-190', '2', 'Spring', '2017', 'A'),
('12345', 'CS-315', '1', 'Spring', '2018', 'A'),
('12345', 'CS-347', '1', 'Fall', '2017', 'A'),
('19991', 'HIS-351', '1', 'Spring', '2018', 'B'),
('23121', 'FIN-201', '1', 'Spring', '2018', 'C+'),
('44553', 'PHY-101', '1', 'Fall', '2017', 'B-'),
('45678', 'CS-101', '1', 'Fall', '2017', 'F'),
('45678', 'CS-101', '1', 'Spring', '2018', 'B+'),
('45678', 'CS-319', '1', 'Spring', '2018', 'B'),
('54321', 'CS-101', '1', 'Fall', '2017', 'A-'),
('54321', 'CS-190', '2', 'Spring', '2017', 'B+'),
('55739', 'MU-199', '1', 'Spring', '2018', 'A-'),
('76543', 'CS-101', '1', 'Fall', '2017', 'A'),
('76543', 'CS-319', '2', 'Spring', '2018', 'A'),
('76653', 'EE-181', '1', 'Spring', '2017', 'C'),
('98765', 'CS-101', '1', 'Fall', '2017', 'C-'),
('98765', 'CS-315', '1', 'Spring', '2018', 'B'),
('98988', 'BIO-101', '1', 'Summer', '2017', 'A'),
('98988', 'BIO-301', '1', 'Summer', '2018', null);
DESCRIBE takes;

INSERT INTO advisor
VALUES
('00128', '45565'),
('12345', '10101'),
('23121', '76543'),
('44553', '22222'),
('45678', '22222'),
('76543', '45565'),
('76653', '98345'),
('98765', '98345'),
('98988', '76766');
SELECT * FROM advisor;

INSERT INTO time_slot
VALUES
('A', 'W', '8', '0', '8', '50'),
('A', 'F', '8', '0', '8', '50'),
('B', 'M', '9', '0', '9', '50'),
('B', 'W', '9', '0', '9', '50'),
('B', 'F', '9', '0', '9', '50'),
('C', 'M', '11', '0', '11', '50'),
('C', 'W', '11', '0', '11', '50'),
('C', 'F', '11', '0', '11', '50'),
('D', 'M', '13', '0', '13', '50'),
('D', 'W', '13', '0', '13', '50'),
('D', 'F', '13', '0', '13', '50'),
('E', 'T', '10', '30', '11', '45 '),
('E', 'R', '10', '30', '11', '45 '),
('F', 'T', '14', '30', '15', '45 '),
('F', 'R', '14', '30', '15', '45 '),
('G', 'M', '16', '0', '16', '50'),
('G', 'W', '16', '0', '16', '50'),
('G', 'F', '16', '0', '16', '50'),
('H', 'W', '10', '0', '12', '30');
SELECT * FROM time_slot;

INSERT INTO prereq(course_id, prereq_id)
VALUES
('BIO-301', 'BIO-101'),
('BIO-399', 'BIO-101'),
('CS-190', 'CS-101'),
('CS-315', 'CS-101'),
('CS-319', 'CS-101'),
('CS-347', 'CS-101'),
('EE-181', 'PHY-101');
SELECT * FROM prereq;

/*
Fnd the information about all the instructors who work in the Watson building.
*/
SELECT instructor.name, instructor.dept_name, department.building
FROM instructor, department
WHERE instructor.dept_name = department.dept_name AND department.building = 'Watson';
/*
Fnd the information about all instructors together with the course id of all courses they have taught
*/
SELECT instructor.ID, instructor.name, instructor.dept_name, teaches.course_id
FROM instructor, teaches WHERE instructor.ID = teaches.ID 
ORDER BY instructor.ID;
/*
Fnd the set of all courses taught in the Fall 2017 semester, the Spring 2018 semester, or both.
*/
-- Method1:
SELECT DISTINCT course_id FROM section
WHERE (semester = 'Fall' AND year = 2017) OR (semester = 'Spring' AND year = '2018')
ORDER BY course_id;
-- Method2:
SELECT course_id FROM section
WHERE semester = 'Fall' AND year = '2017'
UNION
SELECT course_id FROM section
WHERE semester = 'Spring' AND year = '2018' ORDER BY course_id;
/*
Find the set of all courses taught in both the Fall 2017 and the Spring 2018 semesters.
*/
-- Method1:
SELECT DISTINCT a.course_id FROM 
	(SELECT course_id FROM section WHERE semester='Fall' AND year='2017') AS a,
	(SELECT course_id FROM section WHERE semester='Spring' AND year='2018') AS b
WHERE a.course_id = b.course_id;
-- Method2:
SELECT DISTINCT a.course_id FROM 
(SELECT course_id FROM section WHERE semester='Fall' AND year='2017') AS a
WHERE a.course_id IN (SELECT course_id FROM section WHERE semester='Spring' AND year='2018');
-- Method3: 
SELECT course_id FROM section 
WHERE semester='Fall' AND year='2017' 
	AND course_id IN (SELECT course_id FROM section WHERE semester='Spring' AND year='2018');

/*
Find all the courses taught in the Fall 2017 semester but not in Spring 2018
semester.
*/
SELECT course_id FROM section 
WHERE semester='Fall' AND year='2017' AND course_id NOT IN(
	SELECT course_id FROM section WHERE semester='Spring' AND year='2018'
);

/*
Find the ID and name of those instructors who earn more than the instructor whose ID is 12121.
*/
SELECT id, name, salary FROM instructor
WHERE salary > (SELECT salary FROM instructor WHERE id = '12121');
/*
Finds information about courses taught by instructors in the Physics department.
*/
-- Solved By Yeasin
SELECT course_id, title FROM course
WHERE course_id IN (
	SELECT t.course_id FROM teaches t, instructor i
	WHERE t.id = i.id AND i.dept_name = 'Physics'
);
-- Solved By ChatGPT
SELECT c.course_id, c.title, t.sec_id, t.semester, t.year, i.name
FROM course c
INNER JOIN teaches t ON c.course_id = t.course_id
INNER JOIN instructor i ON t.ID = i.ID
WHERE i.dept_name = 'Physics';
/*
Find the names of all instructors whose salary is greater than at least one instructor in the Biology department.
*/
-- Method1:
SELECT a.name FROM instructor AS a, instructor AS b
WHERE a.salary > b.salary AND b.dept_name = 'Biology';
-- Method2:
SELECT name FROM instructor 
WHERE salary > (SELECT salary FROM instructor WHERE dept_name='Biology');
-- Method3:
SELECT name FROM instructor
WHERE salary > SOME (SELECT salary FROM instructor WHERE dept_name='Biology');
/*
Find the names of all instructors who earn more than the lowest paid instructor in the Biology department.
*/
-- Method1:
SELECT name FROM instructor 
WHERE salary > (SELECT MIN(salary) FROM instructor WHERE dept_name = 'Physics');
/*
Find the names of all departments whose building name includes the substring 'Wat'.
*/
SELECT dept_name, building FROM department
WHERE building LIKE '%wat%';
/*
Find the total number of instructors who teach a course in the Spring 2018 semester.
*/
SELECT COUNT(DISTINCT id) FROM teaches
WHERE semester='Spring' AND year='2018';
/*
Find the average salary in each department.
*/
SELECT dept_name, AVG(salary) FROM instructor GROUP BY dept_name;
/*
Find the number of instructors in each department who teach a course in the Spring 2018 semester.
*/
SELECT dept_name, count( DISTINCT teaches.id) FROM teaches, instructor
WHERE semester='Spring' AND year='2018' AND instructor.id = teaches.id GROUP BY dept_name;
/*
Find the average salary of instructors in those departments where the average salary is more than $42,000.
*/
-- Method1:
SELECT dept_name, AVG(salary) FROM instructor 
GROUP BY dept_name HAVING AVG(salary) > 42000;
-- Method2:
SELECT r.dept_name, r.avs FROM (SELECT dept_name, AVG(salary) AS avs FROM instructor GROUP BY dept_name) AS r
WHERE r.avs > 42000;
/*
For each course section offered in 2017, ﬁnd the average total credits (tot cred) of all students enrolled in the section, if the section has at least 2 students.
*/
select course_id, semester, year, sec_id, avg (tot_cred)
from student, takes
where student.ID= takes.ID and year = 2017
group by course_id, semester, year, sec_id
having COUNT(student.ID) >= 2;
/*
Find the total number of (distinct) students who have taken course sections taught by the instructor with ID 10101.
*/
SELECT count(DISTINCT id) FROM takes
WHERE (course_id, sec_id, semester, year) 
IN (SELECT course_id, sec_id, semester, year FROM teaches WHERE id = '10101');
/*
ﬁnd the names of all instructors that have a salary value greater than that of each instructor in the Biology department.
*/
SELECT name FROM instructor
WHERE salary > ALL (SELECT salary FROM instructor WHERE dept_name = 'Biology'); 
/*
Find the departments that have the highest average salary.
*/
SELECT dept_name, avg(salary) FROM instructor 
GROUP BY dept_name HAVING avg(salary) >= ALL(SELECT AVG(salary) FROM instructor GROUP BY dept_name);
/*
Find all courses that were offered at most once in 2017
*/
-- Method1:
SELECT t.course_id FROM course AS t 
WHERE (SELECT count(r.course_id) FROM section AS r WHERE t.course_id = r.course_id AND year=2017) = 1;
-- Method2:
SELECT s.course_id FROM 
(SELECT course_id, count(course_id) AS course_freq FROM section WHERE year= 2017 GROUP BY course_id) AS s
WHERE course_freq = 1;
/*
Find the maximum across all departments of the total of all instructor's salaries in each department.
*/
-- Method1:
SELECT MAX(r.ts) FROM (
SELECT sum(salary) AS ts FROM instructor GROUP BY dept_name) AS r;
-- Method2:
WITH 
total_salary(dept_name, ts) AS (SELECT dept_name, sum(salary) FROM instructor GROUP BY dept_name),
mxs(value) AS (SELECT MAX(ts) FROM total_salary)
SELECT dept_name, ts FROM total_salary, mxs
WHERE total_salary.ts = mxs.value;

/*
Print the names of each instructor, along with their salary and the average salary in their department.
*/
-- Method1:
SELECT name, salary, r.avs FROM instructor, 
(SELECT dept_name, AVG(salary) AS avs FROM instructor GROUP BY dept_name) AS r
WHERE instructor.dept_name = r.dept_name;
/*
Find all departments where the total salary is greater than the average of the total salary at all departments.
*/
WITH
total_salary(dept_name, salary) AS (SELECT dept_name, SUM(salary) FROM instructor GROUP BY dept_name),
average_salary(avg_salary) AS (SELECT AVG(salary) FROM instructor)
SELECT total_salary.dept_name, total_salary.salary, avg_salary FROM total_salary, average_salary
WHERE total_salary.salary > avg_salary;
/*
Lists all departments along with the number of instructors in each department.
*/
SELECT dept_name, (SELECT count(*) FROM instructor WHERE instructor.dept_name = department.dept_name)
FROM department;
/*
Make each student in the Music department who has earned more than 144 credit hours an instructor in the Music department with a salary of $18,000.
*/
INSERT INTO instructor(id, name, dept_name, salary)
SELECT id, name, dept_name, 18000 FROM student
WHERE dept_name = 'Music' AND tot_cred > 144;
/*
Give a 5 percent salary raise to instructors whose salary is less than average.
*/
-- Method1:
UPDATE instructor 
SET salary = salary * 1.05
WHERE salary < (SELECT * FROM (SELECT avg(salary) FROM instructor) AS temp);
-- Method2:
UPDATE instructor 
SET salary = salary * 1.05 WHERE id IN (
SELECT * FROM( SELECT id FROM instructor 
WHERE salary < (SELECT AVG(salary) FROM instructor)) AS temp);
/*
Delete the records of all instructors with salary below the average at the university.
*/
DELETE FROM instructor WHERE salary < (SELECT * 
FROM (SELECT AVG(salary) FROM instructor) AS temp
);
/*
Find the IDs of all students who were taught by an instructor named Einstein.
*/
-- Method1:
WITH einstein_teaches AS (SELECT * FROM teaches
WHERE id = (SELECT id FROM instructor WHERE name = 'Einstein'))
SELECT t.id FROM takes AS t, einstein_teaches AS et
WHERE t.course_id = et.course_id AND t.sec_id = et.sec_id AND t.semester = et.semester AND t.year = et.year;
-- Method2:
SELECT DISTINCT takes.id
FROM takes, instructor, teaches
WHERE takes.course_id = teaches.course_id AND
takes.sec_id = teaches.sec_id AND
takes.semester = teaches.semester AND
takes.year = teaches.year AND
teaches.id = instructor.id AND
instructor.name = 'Einstein';
/*
Find the enrollment of each section that was offered in Fall 2017.
*/
-- Method1:
SELECT s.course_id, s.sec_id, (SELECT COUNT(id) FROM takes AS t
WHERE t.course_id = s.course_id AND t.sec_id = s.sec_id AND t.semester = s.semester AND t.year = s.year) AS enrollment
FROM section AS s WHERE s.semester = 'Fall' AND s.year = '2017';
-- Method2:
SELECT sec_id, (SELECT COUNT(id) FROM takes AS t WHERE t.sec_id = s.sec_id AND t.year=s.year AND t.semester=s.semester) AS total_students
FROM section AS s WHERE semester = 'Fall' AND year = '2017' GROUP BY sec_id;
/*
Find the maximum enrollment, across all sections, in Fall 2017.
*/
SELECT MAX(temp.enrollment) FROM 
(SELECT s.course_id, s.sec_id, (SELECT COUNT(id) FROM takes AS t
WHERE t.course_id = s.course_id AND t.sec_id = s.sec_id AND t.semester = s.semester AND t.year = s.year) AS enrollment
FROM section AS s WHERE s.semester = 'Fall' AND s.year = '2017') AS temp;
-- Intermediate SQL
/*
For all students in the university who have taken some course, ﬁnd their names and the course ID of all courses they took.
*/
-- Method1:
SELECT name, student.id, course_id FROM student, takes
WHERE student.id = takes.id;
-- Method2:
SELECT name, id, course_id FROM 
student NATURAL JOIN takes;
/*
List the names of students along with the titles of courses that they have taken.
*/
-- Method1:
SELECT student.id, student.name, course_id, title FROM student NATURAL LEFT OUTER JOIN 
 (SELECT id, course_id, title FROM takes NATURAL JOIN course) as updated_takes;
 -- Method2:
 SELECT student.id, student.name, course_id, title FROM
 student LEFT OUTER JOIN (takes NATURAL JOIN course) USING (id);
 /*
 Find all students who have not taken a course.
 */
 -- Method1:
 SELECT id, name FROM student
 WHERE id NOT IN(SELECT id FROM takes);
 -- Methdo2:
 SELECT id, name, course_id FROM student NATURAL LEFT OUTER JOIN takes
 WHERE course_id IS NULL;
-- View Practice
CREATE VIEW faculty AS SELECT id, name, dept_name FROM instructor;

SELECT * FROM faculty;
INSERT INTO faculty
VALUES
('20233', 'Yeasin', 'Comp. Sci.');
SELECT * FROM instructor;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM instructor WHERE salary is null;

DELIMITER //
CREATE FUNCTION dept_count(dept_name VARCHAR(20))
RETURNS INTEGER DETERMINISTIC
BEGIN
	DECLARE d_count INTEGER;
    SELECT COUNT(*) INTO d_count FROM instructor 
    WHERE instructor.dept_name = dept_name;
    RETURN d_count;
END
//
DELIMITER ;

