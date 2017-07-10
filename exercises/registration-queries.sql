use registration;

update dept set name = 'Mathematics' where dept_id = 'Math';
update dept set name = 'Rock n Roll' where dept_id = 'Music';
insert into course values ('IE', 202, 'Simulation', 3);

-- What are all the departments?

select * from dept;

-- What are the names of all the department deans?

select dept_id, dean from dept;

-- What is the name of the dean of the CS dept?

select dean from dept where dept_id = 'CS';

-- What are all the course numbers, e.g., ‘CS 2316’?

select dept_id, course_id from course;

-- What are the course numbers of all the first-year courses?

select dept_id, course_id from course where course_id < 200;

-- What are the course numbers of all the CS courses?

select course_id from course where dept_id = 'CS';

-- What are all the CS and IE courses?

select dept_id, course_id
from course
where dept_id = 'CS' or dept_id = 'IE';

-- What are the names of the students enrolled in CS 101?

select name
from student natural join enrolled
where dept_id = 'CS' and course_id = 101;

-- What is the total enrollment of each department?

select dept_id, count(student_id) as enrollment
from dept natural join enrolled
group by dept_id;

-- What are the names of the deans of departments that have zero enrollment?

select dept_id, dean, count(student_id) as enrollment
from dept left join enrolled using (dept_id)
group by dept_id
having enrollment = 0;

-- Which department(s) have the greatest enrollment?

select dept_id, count(student_id) as enrollment
from dept natural join enrolled
group by dept_id
having enrollment = (select count(student_id) as enrollment
                     from dept natural join enrolled
                     group by dept_id
                     order by enrollment desc
                     limit 1);
