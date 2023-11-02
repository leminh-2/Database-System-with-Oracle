-----------------Create database-----------------------------------------------------
CREATE TABLE Employee 
(	fname		VARCHAR(15)	NOT NULL,
	minit		CHAR(1),						-- The default of CHAR is also 1 byte
	lname		VARCHAR(15)	NOT NULL,
	ssn			CHAR(9)		PRIMARY KEY,
	bdate		DATE,
	address		VARCHAR(30),
	sex			CHAR(1),
	salary		DECIMAL(10,2),
	superssn	CHAR(9),
	dno			INT			NOT NULL,
	CONSTRAINT 	fk_emp_superssn	FOREIGN KEY (superssn) 
				REFERENCES Employee(ssn) 
				ON DELETE SET NULL DEFERRABLE
);

CREATE TABLE Department
(	dname		VARCHAR(15) NOT NULL	UNIQUE,
	dnumber		INT			PRIMARY KEY,
	mgrssn		CHAR(9)		NOT NULL,
	mgrstartdate	DATE,
	CONSTRAINT 	fk_dept_emp_mgrssn FOREIGN KEY (mgrssn)
				REFERENCES Employee(ssn) 
				ON DELETE SET NULL	DEFERRABLE	
);

ALTER TABLE Employee
ADD CONSTRAINT	fk_emp_dept_dno	FOREIGN KEY (dno)
				REFERENCES Department(dnumber)
				ON DELETE SET NULL;
				
CREATE TABLE Dept_locations
(	dnumber		INT			NOT NULL,
	dlocation	VARCHAR(15)	NOT NULL,
	PRIMARY KEY	(dnumber, dlocation),
	CONSTRAINT	fk_loc_dept_dnum	FOREIGN KEY (dnumber)
				REFERENCES Department(dnumber)
				ON DELETE CASCADE
);

CREATE TABLE Project
(	pname		VARCHAR(15)	NOT NULL	UNIQUE,
	pnumber		INT			PRIMARY KEY,
	plocation	VARCHAR(15),
	dnum		INT			NOT	NULL,
	CONSTRAINT	fk_proj_dept_dnum	FOREIGN KEY (dnum)
				REFERENCES Department(dnumber)
				ON DELETE SET NULL
);

CREATE TABLE	Works_on
(	essn		CHAR(9)		NOT NULL,
	pno			INT			NOT NULL,
	hours		DECIMAL(3,1)	NOT NULL,
	PRIMARY KEY	(essn, pno),
	CONSTRAINT	fk_work_emp_essn	FOREIGN KEY (essn)
				REFERENCES Employee(ssn)
				ON DELETE CASCADE,
	CONSTRAINT	fk_work_proj_pno	FOREIGN KEY (pno)
				REFERENCES Project(pnumber)
				ON DELETE CASCADE
);

alter table works_on
modify hours	DECIMAL(3,1)	NULL;

CREATE TABLE Dependent
(	essn			CHAR(9)		NOT	NULL,
	dependent_name	VARCHAR(15)	NOT NULL,
	sex				CHAR,
	bdate			DATE,
	relationship	VARCHAR(8),
	PRIMARY KEY (essn, dependent_name),
	CONSTRAINT	fk_depend_emp_essn	FOREIGN KEY (essn)
				REFERENCES Employee(ssn)
				ON DELETE CASCADE
);

-------------------------Insert data-----------------------------------------------------------------------------------------------------
SET CONSTRAINTS fk_dept_emp_mgrssn  DEFERRED;
SET CONSTRAINTS fk_emp_superssn  DEFERRED;

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';

INSERT INTO Department VALUES ('Research', 5, '333445555', '22-05-1988');
INSERT INTO Department VALUES ('Administration', 4, '987654321', '01-01-1995');
INSERT INTO Department VALUES ('Headquarters', 1, '888665555', '19-06-1981');

INSERT INTO Employee VALUES ('John', 'B', 'Smith', '123456789', '09-01-1965', '731 Fondren, Houston, TX', 'M', 30000, '333445555', 5);
INSERT INTO Employee VALUES ('Franklin', 'T', 'Wong', '333445555', '08-12-1955', '638 Voss, Houston, TX', 'M', 40000, '888665555', 5);
INSERT INTO Employee VALUES ('Alicia', 'J', 'Zelaya', '999887777', '19-07-1968', '3321 Castle, Spring, TX', 'F', 25000, '987654321', 4);
INSERT INTO Employee VALUES ('Jennifer', 'S', 'Wallace', '987654321', '20-06-1941', '291 Berry, Bellaire, TX', 'F', 43000, '888665555', 4);
INSERT INTO Employee VALUES ('Ramesh', 'K', 'Narayan', '666884444', '15-09-1962', '975 Fire Oak, Humble, TX', 'M', 38000, '333445555', 5);
INSERT INTO Employee VALUES ('Joyce', 'A', 'English', '453453453', '31-07-1972', '5631 Rice, Houston, TX', 'F', 25000, '333445555', 5);
INSERT INTO Employee VALUES ('Ahmad', 'V', 'Jabbar', '987987987', '29-03-1969', '980 Dallas, Houston, TX', 'M', 25000, '987654321', 4);
INSERT INTO Employee VALUES ('James', 'E', 'Borg', '888665555', '10-11-1973', '450 Stone, Houston, TX', 'M', 55000, null, 1);

COMMIT;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';

INSERT INTO Dept_locations VALUES (1, 'Houston');
INSERT INTO Dept_locations VALUES (4, 'Stafford');
INSERT INTO Dept_locations VALUES (5, 'Bellaire');
INSERT INTO Dept_locations VALUES (5, 'Sugarland');
INSERT INTO Dept_locations VALUES (5, 'Houston');

INSERT INTO Project VALUES ('ProductX', 1, 'Bellaire', 5);
INSERT INTO Project VALUES ('ProductY', 2, 'Sugarland', 5);
INSERT INTO Project VALUES ('ProductZ', 3, 'Houston', 5);
INSERT INTO Project VALUES ('Computerization', 10, 'Stafford', 4);
INSERT INTO Project VALUES ('Reorganization', 20, 'Houston', 1);
INSERT INTO Project VALUES ('Newbenefits', 30, 'Stafford', 4);

INSERT INTO Works_on VALUES ('123456789', 1, 32.5);
INSERT INTO Works_on VALUES ('123456789', 2, 7.5);
INSERT INTO Works_on VALUES ('666884444', 3, 40.0);
INSERT INTO Works_on VALUES ('453453453', 1, 20.0);
INSERT INTO Works_on VALUES ('453453453', 2, 20.0);
INSERT INTO Works_on VALUES ('333445555', 2, 10.0);
INSERT INTO Works_on VALUES ('333445555', 3, 10.0);
INSERT INTO Works_on VALUES ('333445555', 10, 10.0);
INSERT INTO Works_on VALUES ('333445555', 20, 10.0);
INSERT INTO Works_on VALUES ('999887777', 30, 30.0);
INSERT INTO Works_on VALUES ('999887777', 10, 10.0);
INSERT INTO Works_on VALUES ('987987987', 10, 35.0);
INSERT INTO Works_on VALUES ('987987987', 30, 5.0);
INSERT INTO Works_on VALUES ('987654321', 30, 20.0);
INSERT INTO Works_on VALUES ('987654321', 20, 15.0);
INSERT INTO Works_on VALUES ('888665555', 20, null);

INSERT INTO Dependent VALUES ('333445555', 'Alice', 'F', '05-04-1986', 'Daughter');
INSERT INTO Dependent VALUES ('333445555', 'Theodore', 'M', '25-10-1983', 'Son');
INSERT INTO Dependent VALUES ('333445555', 'Joy', 'F', '03-05-1958', 'Spouse');
INSERT INTO Dependent VALUES ('987654321', 'Abner', 'M', '28-02-1942', 'Spouse');
INSERT INTO Dependent VALUES ('123456789', 'Michael', 'M', '04-01-1988', 'Son');
INSERT INTO Dependent VALUES ('123456789', 'Alice', 'M', '04-01-1988', 'Son');
INSERT INTO Dependent VALUES ('123456789', 'Elizabeth', 'M', '05-05-1967', 'Spouse');
