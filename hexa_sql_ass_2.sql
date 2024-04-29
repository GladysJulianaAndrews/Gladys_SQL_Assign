-- TASK 1
-- 1. Create the database named "SISDB"

drop database if exists sisdb;
create database sisdb;
use sisdb;

-- 2. Define the schema for the Students, Courses, Enrollments, Teacher, and Payments tables based  on the provided schema. Write SQL scripts to create the mentioned tables with appropriate data types, constraints, and relationships. 
-- 4. Create appropriate Primary Key and Foreign Key constraints for referential integrity.

drop table if exists students;
create table students (
    student_id int primary key,
    first_name varchar(50),
    last_name varchar(50),
    date_of_birth date,
    email varchar(100),
    phone_number varchar(15));

-- create teacher table

drop table if exists teacher;
create table teacher (
    teacher_id int primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100));

-- create courses table
drop table if exists courses;
create table courses (
    course_id int primary key,
    course_name varchar(100),
    credits int,
    teacher_id int,
    foreign key (teacher_id) references teacher(teacher_id));

-- create enrollments table
drop table if exists enrollments;
create table enrollments (
    enrollment_id int primary key,
    student_id int,
    course_id int,
    enrollment_date date,
    foreign key (student_id) references students(student_id),
    foreign key (course_id) references courses(course_id));

-- create payments table
drop table if exists payments;
create table payments (
    payment_id int primary key,
    student_id int,
    amount numeric(10, 2),
    payment_date date,
    foreign key (student_id) references students(student_id));

-- insert sample records into students table
-- 5. Insert at least 10 sample records into each of the following tables.

insert into students values
(1, 'John', 'D', '2000-01-01', 'john@example.com', '1234567890'),
(2, 'Jenni', 'Anu ', '1999-05-15', 'jenni@example.com', '9876543210'),
(3, 'Alice', 'Johnson', '2001-07-20', 'alice@example.com', '4567890123'),
(4, 'Jack', 'Michael', '1998-11-30', 'jack@example.com', '7890123456'),
(5, 'Emi', 'Jones', '2002-03-10', 'emi@example.com', '0123456789'),
(6, 'William', 'David', '1997-09-05', 'william@example.com', '3456789012'),
(7, 'Sophia', 'Jasmine', '2003-01-25', 'sophia@example.com', '6789012345'),
(8, 'Daniel', 'Garcia', '1996-06-15', 'daniel@example.com', '9012345678'),
(9, 'Olivia', 'Robert', '2000-08-12', 'olivia@example.com', '2345678901'),
(10, 'Alexander', 'Wilson', '1999-04-05', 'alexander@example.com', '5678901234');

-- insert sample records into teacher table
insert into teacher values
(1, 'Professor', 'Smith', 'prof.smith@example.com'),
(2, 'Professor', 'Johnson', 'prof.johnson@example.com'),
(3, 'Professor', 'Williams', 'prof.williams@example.com'),
(4, 'Professor', 'Brown', 'prof.brown@example.com'),
(5, 'Professor', 'Jones', 'prof.jones@example.com'),
(6, 'Professor', 'Davis', 'prof.davis@example.com'),
(7, 'Professor', 'Martin', 'prof.martin@example.com'),
(8, 'Professor', 'Garcia', 'prof.garcia@example.com'),
(9, 'Professor', 'Robert', 'prof.robert@example.com'),
(10, 'Professor', 'Wilson', 'prof.wilson@example.com');

-- insert sample records into courses table
insert into courses values
(1, 'Mathematics', 3, 1),
(2, 'History', 3, 2),
(3, 'Computer Science', 4, 3),
(4, 'English Literature', 3, 4),
(5, 'Physics', 4, 5),
(6, 'Chemistry', 4, 6),
(7, 'Biology', 4, 7),
(8, 'Art', 2, 8),
(9, 'Music', 2, 9),
(10, 'Physical Education', 2, 10);

-- insert sample records into enrollments table
insert into enrollments values
(1, 1, 1, '2024-01-15'),
(2, 2, 2, '2024-01-20'),
(3, 3, 3, '2024-01-25'),
(4, 4, 4, '2024-01-30'),
(5, 5, 5, '2024-02-05'),
(6, 6, 6, '2024-02-10'),
(7, 7, 7, '2024-02-15'),
(8, 8, 8, '2024-02-20'),
(9, 9, 9, '2024-02-25'),
(10, 10, 10, '2024-03-01');

-- insert sample records into payments table
insert into payments values
(1, 1, 100.00, '2024-02-01'),
(2, 2, 150.00, '2024-02-05'),
(3, 3, 200.00, '2024-02-10'),
(4, 4, 125.00, '2024-02-15'),
(5, 5, 180.00, '2024-02-20'),
(6, 6, 220.00, '2024-02-25'),
(7, 7, 195.00, '2024-03-01'),
(8, 8, 150.00, '2024-03-05'),
(9, 9, 175.00, '2024-03-10'),
(10, 10, 200.00, '2024-03-15');

-- TASK 2
-- 1. Write an SQL query to insert a new student into the "Students" table with the following details

insert into students (student_id, first_name, last_name, date_of_birth, email, phone_number) 
values (11, 'John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');

-- 2. Write an SQL query to enroll a student in a course. Choose an existing student and course and insert a record into the "Enrollments" table with the enrollment date.

insert into enrollments (enrollment_id, student_id, course_id, enrollment_date) 
values (11, 7, 8, '2024-04-26');

-- 3. Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and modify their email address.

update teacher set email = 'prof.jjones@example.com' where  teacher_id = 5;
select * from teacher;

-- 4. Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select an enrollment record based on the student and course.

delete from enrollments where student_id = 7 and course_id = 8;

-- 5. Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables.

update courses set teacher_id = 5 where course_id = 6;

-- 6. Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. Be sure to maintain referential integrity.

delete from Payments where student_id = 3;
delete from Enrollments where student_id = 3;
delete from Students where student_id = 3;

-- 7. Update the payment amount for a specific payment record in the "Payments" table. Choose any payment record and modify the payment amount.

update payments set amount = 1000 where payment_id = 2; 

-- TASK 3
-- 1. Write an SQL query to calculate the total payments made by a specific student. You will need to join the "Payments" table with the "Students" table based on the student's ID

select sum(amount), p.student_id , s.first_name, s.last_name
from payments p inner join students s on p.student_id = s.student_id where s.student_id = 1; 

-- 2. Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course. Use a JOIN operation between the "Courses" table and the "Enrollments" table

select c.course_id, c.course_name, count(e.student_id) as enrolled_students
from courses c left join enrollments e on c.course_id = e.course_id group by c.course_id, c.course_name;

-- 3. Write an SQL query to find the names of students who have not enrolled in any course. Use a LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments

select s.first_name, s.last_name from students s left join enrollments e on s.student_id = e.student_id
where e.student_id is null;

-- 4. Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in. Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables

select s.first_name, s.last_name, c.course_name
from students s inner join enrollments e on s.student_id = e.student_id inner join courses c on e.course_id = c.course_id;

-- 5. Create a query to list the names of teachers and the courses they are assigned to. Join the "Teacher" table with the "Courses" table.

select t.first_name, t.last_name, c.course_name from teacher t inner join courses c on t.teacher_id = c.teacher_id;

-- 6. Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the "Students" table with the "Enrollments" and "Courses" tables

select s.student_id, s.first_name,s.last_name, c.course_name , e.enrollment_date from students s
inner join enrollments e on s.student_id = e.student_id 
inner join courses c on c.course_id = e.course_id 
where c.course_id = 8; 

-- 7. Find the names of students who have not made any payments. Use a LEFT JOIN between the "Students" table and the "Payments" table and filter for students with NULL payment records.

select s.first_name, s.last_name from students s left join payments p on s.student_id = p.student_id
where p.payment_id is null;

-- 8. Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN between the "Courses" table and the "Enrollments" table and filter for courses with NULL enrollment records.

select c.course_id, c.course_name from courses c left join enrollments e on c.course_id = e.course_id
where e.course_id is null;

-- 9. Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments" table to find students with multiple enrollment records.

select s.first_name, s.last_name
from students s
inner join (
    select student_id
    from enrollments
    group by student_id
    having count(course_id) > 1
) as multi_course_students on s.student_id = multi_course_students.student_id;

-- 10. Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher" table and the "Courses" table and filter for teachers with NULL course assignments.

select t.first_name, t.last_name from teacher t left join courses c on t.teacher_id = c.teacher_id where c.course_id is null;


-- TASK 4
-- 1. Write an SQL query to calculate the average number of students enrolled in each course. Use aggregate functions and subqueries to achieve this.

select avg(enrollment_count) as average_enrollment_count
from (select count(student_id) as enrollment_count from enrollments group by course_id) as enrollment_counts;

-- 2. Identify the student(s) who made the highest payment. Use a subquery to find the maximum payment amount and then retrieve the student(s) associated with that amount.

select student_id from payments where amount = (select max(amount) from payments);

-- 3. Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the course(s) with the maximum enrollment count.

select course_id from (select course_id, count(student_id) as enrollment_count from enrollments group by course_id) as course_enrollments
inner join (select max(enrollment_count) as max_enrollment_count from (select count(student_id) as enrollment_count from enrollments
group by course_id) as inner_query) as max_enrollment_subquery
on course_enrollments.enrollment_count = max_enrollment_subquery.max_enrollment_count limit 1;

-- 4. Calculate the total payments made to courses taught by each teacher. Use subqueries to sum payments for each teacher's courses.

select t.teacher_id, sum(p.amount) as total_payments
from teacher t inner join courses c on t.teacher_id = c.teacher_id inner join enrollments e on c.course_id = e.course_id
inner join payments p on e.student_id = p.student_id group by t.teacher_id;

-- 5. Identify students who are enrolled in all available courses. Use subqueries to compare a student's enrollments with the total number of courses.

select student_id from (select student_id, count(distinct course_id) as enrolled_courses from enrollments group by student_id) as student_enrollments
where enrolled_courses = (select count(distinct course_id) from courses);

-- 6. Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to find teachers with no course assignments.

select t.first_name, t.last_name from teacher t left join courses c on t.teacher_id = c.teacher_id where c.course_id is null;

-- 7. Calculate the average age of all students. Use subqueries to calculate the age of each student based on their date of birth.

select avg(datediff(curdate(), date_of_birth) / 365) as average_age from students;

-- 8. Identify courses with no enrollments. Use subqueries to find courses without enrollment records.

select course_id from courses where course_id not in (select distinct course_id from enrollments);

-- 9. Calculate the total payments made by each student for each course they are enrolled in. Use subqueries and aggregate functions to sum payments.

select sum(amount), p.student_id , s.first_name, s.last_name
from payments p inner join students s on p.student_id = s.student_id group by s.student_id;

-- 10. Identify students who have made more than one payment. Use subqueries and aggregate functions to count payments per student and filter for those with counts greater than one.

select student_id from payments group by student_id having count(payment_id) > 1;

-- 11. Write an SQL query to calculate the total payments made by each student. Join the "Students" table with the "Payments" table and use GROUP BY to calculate the sum of payments for each student.

select sum(amount), p.student_id , s.first_name, s.last_name
from payments p inner join students s on p.student_id = s.student_id group by s.student_id;

-- 12. Retrieve a list of course names along with the count of students enrolled in each course. Use JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count enrollments.

select c.course_name, count(e.student_id) as enrolled_students from courses c left join enrollments e on c.course_id = e.course_id
group by c.course_id, c.course_name;

-- 13. Calculate the average payment amount made by students. Use JOIN operations between the "Students" table and the "Payments" table and GROUP BY to calculate the averag

select s.student_id, s.first_name, s.last_name, avg(p.amount) as average_payment_amount
from students s inner join payments p on s.student_id = p.student_id group by s.student_id, s.first_name, s.last_name;
