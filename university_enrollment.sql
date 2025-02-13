-- createing tables
CREATE TABLE students (
	student_id SERIAL PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	email TEXT,
	school_enrollment_date DATE
);

CREATE TABLE courses (
	course_id SERIAL PRIMARY KEY,
	course_name TEXT,
	course_description TEXT,
	prof_id INT REFERENCES professors(prof_id)
);

CREATE TABLE professors (
	prof_id SERIAL PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	department TEXT
);

CREATE TABLE enrollments (
	student_id INT REFERENCES students(student_id),
	course_id INT REFERENCES courses(course_id),
	enrollment_date DATE,
	PRIMARY KEY (student_id, course_id)
);

-- inserting data 
INSERT INTO students(first_name, last_name, email, school_enrollment_date) VALUES
('Emily', 'Smith', 'emilysmith@example.com', '2023-09-15'),
('Michael', 'Johnson', 'michaeljohnson@example.com', '2024-01-10'),
('Sophia', 'Williams', 'sophiawilliams@example.com', '2022-05-23'),
('Daniel', 'Brown', 'danielbrown@example.com', '2023-07-30'),
('Olivia', 'Davis', 'oliviadavis@example.com', '2025-02-04')

INSERT INTO professors(first_name, last_name, department) VALUES
('Alice', 'Roberts', 'Computer Science'),
('Benjamin', 'Harris', 'Mathematics'),
('Charlotte', 'Miller', 'Physics'),
('David', 'Anderson', 'Engineering')

INSERT INTO courses(course_name, course_description, prof_id) VALUES
('Intro to Programming', 'Basics of coding and problem-solving.', 1),
('Advanced Calculus', 'Covers integrals and derivatives.', 2),
('Quantum Mechanics', 'Fundamentals of quantum physics.', 3)

INSERT INTO enrollments(student_id, course_id, enrollment_date) VALUES
(1, 1, '2023-10-01'), 
(2, 2, '2024-03-01'),  
(3, 3, '2022-08-10'),  
(4, 1, '2023-09-05'), 
(5, 2, '2025-03-01') 

-- sql queries

-- retrieve full name of students enrolled in 'Intro to Programming'
SELECT students.first_name || ' ' || students.last_name AS full_name
FROM students
JOIN enrollments ON students.student_id = enrollments.student_id
JOIN courses ON enrollments.course_id = courses.course_id
WHERE courses.course_name = 'Intro to Programming';

--retrieve list of all courses and professor who teaches each
SELECT courses.course_name, professors.first_name || ' ' || professors.last_name AS professor_full_name
FROM courses
JOIN professors ON courses.prof_id = professors.prof_id;

-- retrieve list of all courses with students enrolled in them
SELECT DISTINCT courses.course_name
FROM courses
JOIN enrollments ON courses.course_id = enrollments.course_id;

-- update email
UPDATE students
SET email = 'newemail@example.com'
WHERE first_name = 'Emily' AND last_name = 'Smith';

-- delete a student from a course 
DELETE FROM enrollments
WHERE student_id = 2 AND course_id = 2;
