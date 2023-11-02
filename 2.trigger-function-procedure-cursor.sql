--lecture videos: https://www.youtube.com/watch?v=RNacqKW-Fnc&list=PLTpNwHSD94utlrWtWLQ2frBFoheiQEAvU&index=7
CREATE OR REPLACE VIEW DEPT_ANNUAL_SALARY AS 
select SSN, FNAME, LNAME, SALARY * 12 AS ANNUAL_SALARY
FROM employee
WHERE dno = 5
WITH READ ONLY
;

--app: database security
SELECT * FROM dept_annual_salary;

--try to update data from view: ERROR: virtual column not allowed herer
UPDATE dept_annual_salary
SET annual_salary = 100
WHERE SSN = '123456789';

--try to update data from view: successful -> set read-only access when creating view
UPDATE dept_annual_salary
SET LNAME = 'TOM'
WHERE SSN = '123456789';

--exercise: view for manager to see SSN manager, Fname, Lname, salary, name of department, #employee
--CREATE OR REPLACE VIEW Dept_manager as
SELECT * --d.DNAME, d.MGRSSN, e1.FNAME, e1.LNAME, e1.SALARY, COUNT(*) AS NUMBER_EMPLOYEE
FROM DEPARTMENT d, EMPLOYEE e1, EMPLOYEE e2
WHERE d.MGRSSN = e1.SSN AND d.MGRSSN = e2.SUPERSSN
GROUP BY d.DNAME, d.MGRSSN, e1.FNAME, e1.LNAME, e1.SALARY --WHY
--WITH READ ONLY
;
--note: khi x�i group by, th� nh?ng c?t tr�n m?nh ?? select (tr? h�m g?p) ph?i xu?t hi?n trong group by

--exercise trigger: not allow update less salary
CREATE OR REPLACE TRIGGER NO_ALLOW_LOWER_SALARY
BEFORE UPDATE OF SALARY ON EMPLOYEE
FOR EACH ROW
WHEN (NEW.SALARY < OLD.SALARY)
BEGIN
    RAISE_APPLICATION_ERROR(-20000, 'lower salary is not allowed');
    --other ways:
END
;

BEGIN
--CHANGE SOME VALUES TO CHECK TRIGGER

END;

--exercise: write function to get dept nam from ssn
CREATE OR REPLACE FUNCTION Get_Dept_from_SSN
(inSSN IN Employee.SSN%type)
RETURN department.Dname%type
AS 
temp department.Dname%type;
BEGIN
SELECT DNAME INTO temp
FROM EMPLOYEE, DEPARTMENT
WHERE  SSN = inSSN AND DNO = DNUMBER;
RETURN temp;
END Get_Dept_from_SSN;

--exercise using procedure and cursor
CREATE OR REPLACE PROCEDURE PRINT_EMP_INFO
AS
	CURSOR C1 IS SELECT SSN, LNAME, SALARY
			FROM EMPLOYEE
			;
BEGIN
	FOR rec in C1
	LOOP
		DBMS_OUTPUT.PUT_LINE(REC.SSN || ' ' || rec.LNAME || ' ' || rec.SALARY*12);
	END LOOP;
END
;

SET SERVEROUTPUT ON;
EXEC PRINT_EMP_INFO;
















