--lecture video: https://www.youtube.com/watch?v=EwttVpcIYDI&list=PLTpNwHSD94utlrWtWLQ2frBFoheiQEAvU&index=6&t=3731s
CREATE TABLE EMP2
(
    FNAME   VARCHAR(15),
    MINIT   VARCHAR(5),
    LNAME   VARCHAR(15),
    SSN     VARCHAR(10),
    SALARY  INT,
    DNO     INT,
    PRIMARY KEY(SSN)
)

--error: ALTER TABLE EMP ADD DNO INT; -> ORA-00922: missing or invalid option
DROP TABLE EMP;

SELECT ssn,lname,salary FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;

SELECT * FROM EMPLOYEE WHERE DNO=5;

SELECT * FROM EMPLOYEE WHERE SEX='F' AND SALARY>25000;

SELECT SALARY,ssn, lname FROM EMPLOYEE;

SELECT SALARY FROM EMPLOYEE where salary IS NOT NULL;
--bc NULL is datatype, is not value (salary = NULL)

SELECT distinct SALARY FROM EMPLOYEE where salary IS NOT NULL;

SELECT distinct(SALARY) FROM EMPLOYEE where salary IS NOT NULL;

SELECT * FROM EMPLOYEE where fname = "Ramesh"; -- ramesh invalid identifier

SELECT * FROM EMPLOYEE where fname = 'Ramesh'; 
SELECT * FROM EMPLOYEE where fname = 'ramesh'; --no output

SELECT * FROM EMPLOYEE where fname = 'Ramesh'; --no output bc value in db is 'Ramesh     ' -> using LIKE
SELECT * FROM EMPLOYEE where fname LIKE '%Ramesh%'; --using LIKE for string value instead of =
--when we ensure that format -> using =
SELECT * FROM EMPLOYEE where TRIM(fname) = 'Ramesh'; -- another way

--field alias
SELECT FName, Minit as "Middle_Name", LName FROM EMPLOYEE where fname = 'Ramesh'; 

--cross product
--first way
SELECT LName, DNO, DNAME
FROM EMPLOYEE JOIN DEPARTMENT ON (DNO = DNUMBER);
--second way
SELECT LName, DNO, DNAME
FROM EMPLOYEE, DEPARTMENT WHERE DNO = DNUMBER;

--exercise: GET Fname, Lname of employee and Fname, Lname of supervisor
SELECT E.Fname, E.Lname, S.Fname, S.Lname
FROM EMPLOYEE E JOIN EMPLOYEE S ON E.SUPPERSSN = S.SSN;

--exercise: GET FName, LName, Salary of employee and FName, LName, SupervisorSalary (> 10% salary of employee) of supervisor
SELECT E.Fname, E.Lname, S.Fname, S.Lname, E.salary, S.salary
FROM EMPLOYEE E JOIN EMPLOYEE S ON E.SUPPERSSN = S.SSN
WHERE E.salary > 1.1 * S.salary;

--logical operators: and vs between and
--using and
SELECT LNAME, SALARY
FROM EMPLOYEE
WHERE SALARY > 25000 AND SALARY < 40000;
--using between and
SELECT LNAME, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 25000 AND 40000;

--get Lname, salary (>40000) of supervisor

-----------------------------------------------------------------------
--Youtube SQL ch6 (p2)
--query 14
--1st way: join function
SELECT FNAME, LNAME, ADDRESS
FROM EMPLOYEE, DEPARTMENT
WHERE DNO = DNUMBER AND DNAME = 'Research';

--2nd way: nested query
SELECT FNAME, LNAME, ADDRESS
FROM EMPLOYEE
WHERE DNO IN (SELECT DNUMBER
                FROM DEPARTMENT
                WHERE DNAME = 'Research');

--exercise SQL query (slide #95)
--Q1
SELECT FNAME, LNAME, SSN, (EXTRACT(YEAR FROM CURRENT_TIMESTAMP) - EXTRACT(YEAR FROM BDATE)) AS AGE
FROM EMP
WHERE EXTRACT(YEAR FROM CURRENT_TIMESTAMP) - EXTRACT(YEAR FROM BDATE) > 35;
--GET MONTH
SELECT SSN, EXTRACT(MONTH FROM BDATE) AS MONTH
FROM EMP
WHERE EXTRACT(MONTH FROM BDATE) = 7;

--Q2
--CONCAT(P1, P2), WE CANNOT CONCAT 3 STRINGS
--ANOTHER WAY: FNAME || ' ' || MINIT || ' ' || LNAME
SELECT DISTINCT CONCAT(FNAME, LNAME), SSN
FROM (EMPLOYEE E JOIN DEPARTMENT D ON (E.DNO = D.DNUMBER))
JOIN WORKS_ON W ON (E.SSN = W.ESSN)
WHERE DNAME = 'Research' AND HOURS > 10;    

--Q3
SELECT *
FROM (SELECT DISTINCT SALARY FROM EMPLOYEE ORDER BY SALARY DESC)
WHERE ROWNUM <4;
--LIMIT attribute cannot execute in oracle

--Q4
SELECT *
FROM EMP
WHERE SALARY IN (<answer from q3>);

--Q5
SELECT SALARY
FROM (
    SELECT SALARY, COUNT(*) OVER () AS CNT
    FROM EMPLOYEE
    ORDER BY SALARY DESC
)
WHERE ROWNUM <= 0.3*(CNT);

--Q6







