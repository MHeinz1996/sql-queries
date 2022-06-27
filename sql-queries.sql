-- Select all rows from the `classes` table.
SELECT * FROM classes;

-- Select the `name` and `credits` from the `classes` table where the number of credits is greater than 3.
SELECT name, credits FROM classes WHERE credits > 3;

-- All rows from the `classes` table where credits is an even number.
SELECT * FROM classes WHERE credits%2 = 0;

-- All of Tianna's enrollments that she hasn't yet received a grade for.
SELECT enrollments.id FROM classes INNER JOIN enrollments ON classes.id = class_id WHERE enrollments.student_id = 1 AND grade = 'NULL';

-- All of Tianna's enrollments that she hasn't yet received a grade for, selected by her first name, not her `student.id`
SELECT enrollments.id FROM enrollments INNER JOIN students ON enrollments.student_id = students.id INNER JOIN classes ON class_id = classes.id WHERE students.first_name = 'Tianna' and grade = 'NULL';

-- All of Tianna's enrollments that she hasn't yet received a grade for, selected by her first name, not her `student.id`, with the class name included in the result set.
SELECT enrollments.id, classes.name FROM enrollments INNER JOIN students ON enrollments.student_id = students.id INNER JOIN classes ON class_id = classes.id WHERE students.first_name = 'Tianna' and grade = 'NULL';

-- All students born before 1986 who have a 't' in their first or last name.
SELECT * FROM students WHERE birthdate < '1986-01-01' AND first_name LIKE '%t%' OR last_name LIKE '%t%' OR first_name LIKE '%T%' OR last_name LIKE '%T%';

-- The average age of all the students.
SELECT to_timestamp(avg(extract(epoch from birthdate)))::date AS avg_birth_date FROM students;

-- Addresses that have a space in their city name.
SELECT * FROM addresses WHERE city LIKE '% %';

-- Students & their addresses that live in a city with more than one word in the city name.
SELECT * FROM students INNER JOIN addresses ON students.address_id = addresses.id WHERE addresses.city LIKE '% %';

-- The average number of credits for classes offered at the school.
SELECT AVG(credits) FROM classes;

-- The first and last name of all students who have received an 'A'.
SELECT students.first_name, students.last_name FROM students INNER JOIN enrollments ON students.id = enrollments.student_id WHERE enrollments.grade = 'A';

-- Each student's first name and the total credits they've enrolled in
SELECT students.first_name, SUM(classes.credits) FROM students INNER JOIN enrollments ON students.id = enrollments.student_ID INNER JOIN classes ON classes.id = enrollments.class_id GROUP BY students.first_name ORDER BY SUM DESC;

-- The total number of credits each student has received a grade for.
SELECT students.first_name, SUM(classes.credits) FROM students INNER JOIN enrollments ON students.id = enrollments.student_ID INNER JOIN classes ON classes.id = enrollments.class_id WHERE enrollments.grade <> 'NULL' GROUP BY students.first_name ORDER BY SUM DESC;

-- All enrollments, including the class name.
SELECT enrollments.id, enrollments.student_id, enrollments.class_id, classes.name, enrollments.grade FROM enrollments INNER JOIN classes ON enrollments.class_id = classes.id;

-- Students born between 1982-1985 (inclusive).
SELECT * FROM students WHERE birthdate BETWEEN '1982-01-01' AND '1985-12-31';

-- Insert a new enrollment recording that Andre Rohan took PHYS 218 and got an A.
INSERT INTO enrollments (student_id, class_id, grade) VALUES (5, 4, 'A');