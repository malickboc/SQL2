-- q-company.sql
-- partial queries

-- keep these two commands at the top of every sql file
set echo on
set linesize 120

-- test queries, not to be submitted
select * from employee;
select * from department;
select count(*) from employee;
select count(*) as DEPT_COUNT from department;

-- comment out the above queries for your homework

-- your homework queries goes here

-- a: the first name, last name of employees who work in department 5.
select fname, lname from employee where dno = 5;

-- b: the first name, last name of every employee and name of his/her department

-- 'as' is optional and can be omitted
-- FIRST_NAME, LAST_NAME, DEPARTMENT_NAME are column aliases
-- E, D are table aliases

select E.fname as FIRST_NAME, E.lname as LAST_NAME, D.dname as DEPARTMENT_NAME
from employee E, department D
where E.dno = D.dnumber;

-- c The firstname, last name of employees who works in the department called 'research'
select E.fname as FIRST_NAME, E.lname as LAST_NAME, D.dname as DEPARTMENT_NAME
from employee E, department D
where D.dname = 'Research' and Dnumber = Dno;

-- d the first name , last name of employees who works in the project called 'computerization')
select E.fname as FIRST_NAME, E.lname as LAST_NAME, P.pname as PROJECT_NAME
from employee E, project P, works_on w
where P.pname = 'Computerization' and pnumber = pno and ssn = essn;


-- 1 Retrieve the names of all employees in department 5 who work more than 10 hours per week on the 'ProductX' project
select e.fname as first_name, e.lname last_name from employee e, project p, works_on w where e.dno = 5 and p.pname ='productX' and w.hours >10 and p.pnumber = w.pno and e.ssn = w.essn;

-- 2 List the names of all employees who have a dependent with the same first name as themselves
select e.fname, e.lname from employee e, dependent d where e.ssn= d.essn and fname=d.dependent_name;

-- 3 Find the names of all employees who are directly supervised by 'Franklin Wong'.
select e.fname, e.lname from employee e, employee s where e.superssn = s.ssn and s.fname ='Franklin' and s.lname = 'Wong';

-- 4 For each project, list the project name and the total hours per week (by all employees) spent on that project
select p.pname, sum(w.hours) from project p, works_on w, employee E where w.pno= p.pnumber and w.essn = e.ssn group by p.pname;

-- 5 Retrieve the names of all employees who work on every project.
 
select fname, lname from employee, works_on where ssn=essn group by lname, fname having count(*) = (select count (pnumber) from project);

-- 6 Retrieve the names of all employees who don't work on any project
select fname, lname from employee where not exists (select * from works_on where ssn=essn);

-- 7 For each department, retrieve the department name and the average salary of all employees working in that department
select dname, avg(salary) from (employee join department on dno = dnumber) group by (dname, dno) order by dno;

-- 8 Retrieve the average salary of all female employees
select avg(salary) from employee where sex= 'F';

-- 9 Retrieve the maximum and minimum salary of all employees.
select min(salary), max(salary) from employee;

-- 10 List the last names of all department managers who have no dependents.
select e.fname, e.lname from employee e, department d 
where e.ssn = d.mgrssn and not exists (select * from dependent dp where e.ssn = dp.essn);




