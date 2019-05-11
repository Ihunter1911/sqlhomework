CREATE TABLE "Departments" (
    "dept_no" text  NOT NULL,
    "dept_name" text   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" integer   NOT NULL,
    "dept_no" text  NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "dept_managers" (
    "dept_no" text   NOT NULL,
    "emp_no" integer  NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "employee" (
    "emp_no" integer   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" text   NOT NULL,
    "last_name" text  NOT NULL,
    "gender" text   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employee" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" integer   NOT NULL,
    "salary" integer   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "Titles" (
    "emp_no" integer   NOT NULL,
    "titles" text,
	"from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employee" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "dept_managers" ADD CONSTRAINT "fk_dept_managers_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "dept_managers" ADD CONSTRAINT "fk_dept_managers_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employee" ("emp_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employee" ("emp_no");

ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employee" ("emp_no");

ALTER TABLE "Titles"
ADD COLUMN titles text;

##Confirm data output from tables
SELECT *
FROM "dept_managers";

SELECT * FROM "employee";

##Question 1
select * from "employee"; 
##List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT 
employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM
"employee"
LEFT JOIN salaries on employees.emp_no = salaries.emp_no;

##Question 2
##List employees who were hired in 1986.
select * from "employee" 
where hire_date >= ‘1986-01-01’
AND hire_date < ‘1986-12-31’ 
ORDER BY hire_date asc; 
                               
##Question 3 
##List the manager of each department with the following information: 
##department number, department name,
##the manager’s employee number, last name, 
##first name, and start and end employment dates.                             
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, 
dept_manager.from_date, dept_manager.to_date, 
FROM "departments", "dept_manager" 
LEFT JOIN dept_manager on departments.dept_no = dept_manager.dept_no; 
SELECT 
employees.emp_no, employees.last_name, 
employees.first_name, employees.gender, salaries.salary
FROM
"employee"
LEFT JOIN salaries on employees.emp_no = salaries.emp_no;
                                                           
select * from employees; 
-- List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT 
employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM
employees
LEFT JOIN salaries on employees.emp_no = salaries.emp_no;

                               
#Question 3
-- List the manager of each department with the following information: 
-- department number, department name,
-- the manager’s employee number, last name, 
-- first name, and start and end employment dates.                             
SELECT dept_emp.emp_no, dept_emp.dept_no, dept_emp.from_date, dept_emp.to_date,
employees.first_name, employees.last_name, departments.dept_name
FROM "dept_emp"  
LEFT JOIN employee on dept_emp.emp_no = employees.emp_no
LEFT JOIN departments on departments.dept_no = dept_emp.dept_no;

## Question 4
##List the department of each employee with the following information: 
## employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.first_name, employees.last_name,
departments.dept_name
FROM "employee"
LEFT JOIN dept_emp on employees.emp_no = dept_emp.emp_no
LEFT JOIN departments on departments.dept_no = dept_emp.dept_no; 

## Question 5
## List all employees whose first name is “Hercules” and last names begin with “B.”
SELECT employees.first_name, employees.last_name
FROM "employee"
WHERE first_name = ‘Hercules’
AND last_name LIKE ‘B%’; 
                                                           
##Question 6
## List all employees in the Sales department, 
## including their employee number, last name, 
## first name, and department name.                                                        
                                                           
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name 
FROM "employee"
LEFT JOIN dept_emp on employees.emp_no = dept_emp.emp_no
LEFT JOIN departments on departments.dept_no = dept_emp.dept_no
WHERE dept_name = ‘Sales’; 
##Question 7
## List all employees in the Sales and Development departments, 
## including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name 
FROM "employee"
LEFT JOIN dept_emp on employees.emp_no = dept_emp.emp_no
LEFT JOIN departments on departments.dept_no = dept_emp.dept_no
WHERE dept_name = ‘Sales’ 
OR dept_name = ‘Development’;

##Question 8
## In descending order, list the frequency count of employee last names, 
## i.e., how many employees share each last name.
select last_name, count(*)
from "employee"
GROUP BY last_name
ORDER BY last_name desc; 