/*==========================================================================
SETTING PREVILIGES FOR MY DATABASE
=========================================================================*/
-- Checking the databases  available in my server
SHOW DATABASES;

-- Choosing the database
USE microfinancedb2;


-- Checking the available tables
SHOW TABLES;

/*=======================================================================
ASSESSING THE TABLES TO SEE THE PREVILEGES TO GIVE
=======================================================================*/
-- Checking the person table
SELECT 
	*
FROM person;

-- Checking the table account
SELECT * FROM account;

-- Checking the table branch
SELECT * FROM branch;

-- checking the table group
SELECT * FROM groupaccount;

-- Checking table collateral
SELECT * FROM collateral;

-- Checking table transaction
SELECT * FROM transaction;

-- Checking the loan account
SELECT * FROM loanaudit;

-- Checking the table guarantor
SELECT * FROM guarantor;

/*==================================================================
CREEATING THE GLOBAL ADMIN USERS
=================================================================*/
-- Creating the admin user
CREATE USER 'micro_admin'@'%' IDENTIFIED BY 'A256';

-- Creat Edube user
CREATE USER 'admin_edube'@'%' IDENTIFIED BY 'E256';

-- Create Nsubuga admin
CREATE USER 'admin_nsubuga'@'%' IDENTIFIED BY 'N256';

-- Create Enoch admin
CREATE USER 'admin_enoch'@'%' IDENTIFIED BY 'K256';

-- Checking if the user has been created
SELECT 
	USER,
    HOST
 FROM mysql.user
 WHERE USER = 'micro_admin';
 
 -- Secting all the users from the system
 SELECT 
	USER,
    HOST
 FROM mysql.user;
 
 /*======================================================
 GRANTING PRIVILEGES TO THE ADMINS
 ======================================================*/
 -- Granting the privileges to micro_adnin
 GRANT ALL PRIVILEGES ON *.* TO 'micro_admin'@'%' WITH GRANT OPTION;
 
 -- Grant the privileges to admin edube
 GRANT ALL PRIVILEGES ON  *.* TO  'admin_edube'@'%' WITH GRANT OPTION;
 
 -- Granting the privileges to admin_nsubuga
 GRANT ALL PRIVILEGES ON microfinancedb2.* TO 'admin_nsubuga'@'%' WITH GRANT OPTION;
 
 -- Granting the privilenges to admin_enoch
 GRANT ALL PRIVILEGES ON microfinancedb2.* TO 'admin_enoch'@'%';
 
 -- Checking the privileges given to the admins
 SHOW GRANTS FOR 'micro_admin'@'%';
 SHOW GRANTS FOR 'admin_edube'@'%';
 
 -- Checking all privileges for Nsubuga and Enoch
 SHOW GRANTS FOR 'admin_nsubuga'@'%';
 SHOW GRANTS FOR 'admin_enoch'@'%';
 
 /*=====================================================
 CREATING MORE USER ROLES
 =======================================================*/
 -- Giving the roles to branch_mgr_rol
 CREATE ROLE 'branch_mgr_rol';
 
 -- Giving the roles to teller_rol
 CREATE ROLE 'teller_rol';
 
 -- Giving the loanofficer role
 CREATE ROLE 'loan_officer_rol';
 
 -- Giving the auditor_rol
 CREATE ROLE 'auditor_rol';
 
 -- Checking the created roles
 SELECT
	User,
    Host
FROM mysql.user;

/*=================================================================================
Create a user and assigning Individual roles and privileges
===================================================================================*/
-- Creating the user manager
CREATE USER 'Noela'@'Local instance MySQL80' IDENTIFIED BY 'noela@256';

-- Assigning Noela the branch manager role
GRANT 'branch_mgr_rol' TO 'Noela'@'Local instance MySQL80';

-- Granting previleges to manager on the database
GRANT SELECT ON MicrofinanceDB2.* TO 'branch_mgr_rol';

-- Granting the privileges on branch and loanofficer tables
-- branch
GRANT SELECT, INSERT, UPDATE ON MicrofinanceDB2.branch TO 'branch_mgr_rol';

-- loanofficer
GRANT SELECT, INSERT, UPDATE ON MicrofinanceDB2.loanofficer TO 'branch_mgr_rol';

-- loan
GRANT UPDATE ON MicrofinanceDB2.loan TO 'branch_mgr_rol';



-- CREATING THE LOAN OFFICER
-- Creating the person to make the loan officer
CREATE USER 'Oscar'@'Local instance MySQL80' IDENTIFIED BY 'oscar@256';

-- Assigning the loan_officer_role to Malon
GRANT 'loan_officer_rol' TO 'Oscar'@'Local instance MySQL80';

-- Giving the loan_officer_rol privileges
-- loan table
GRANT SELECT, INSERT, UPDATE ON MicrofinanceDB2.loan TO 'loan_officer_rol';

-- client table
GRANT SELECT, INSERT, UPDATE ON MicrofinanceDB2.client TO 'loan_officer_rol';




-- THE AUDITOR ROLE
-- Creating an auditor and it will be malon
CREATE USER 'Malon'@'Local instance MySQL80' IDENTIFIED BY 'malon@256';

-- Giving the auditor role to malon
GRANT 'auditor_rol' TO 'Malon'@'Local instance MySQL80';

-- Granting the privileges to the auditor_rol
GRANT SELECT ON MicrofinanceDB2.* TO 'auditor_rol';



-- THE TELLER ROLE
-- Creating a role
CREATE ROLE 'teller_rol';

-- Creating the user to give the teller_rol
CREATE USER 'Lyn'@'Local instance MySQL80' IDENTIFIED BY 'lyn@256';

-- Giving the teller role to lyn
GRANT 'teller_rol' TO 'Lyn'@'Local instance MySQL80';
SET DEFAULT ROLE 'teller_rol' TO 'Lyn'@'Local instance MySQL80';


-- Granting the privileges for the teller_role
-- transaction table
GRANT SELECT, INSERT ON MicrofinanceDB2.transaction TO  'teller_rol';
FLUSH PRIVILEGES;

-- savingsaccount table
GRANT SELECT, UPDATE ON MicrofinanceDB2.savingsaccount TO 'teller_rol';
FLUSH PRIVILEGES;

-- client table
GRANT SELECT ON MicrofinanceDB2.client TO 'teller_rol';
FLUSH PRIVILEGES;

-- Applying the changes in the privileges
FLUSH PRIVILEGES;


/*=========================================================================
TESTING THE AWARDED ROLES AND PRIVILEGES
========================================================================*/
-- Testing the privileges for the teller_rol who z Lyn
SHOW GRANTS FOR 'Lyn'@'Local instance MySQL80';

SHOW GRANTS FOR 'teller_rol';

-- Testing the privileges for loan_officer_rol who is Oscar
SHOW GRANTS FOR 'Oscar'@'Local instance MySQL80';

SHOW GRANTS FOR 'loan_officer_rol';

/*=========================================================================
GIVING PRIVILEGES TO PEOPLE WITHOUT ROLES
========================================================================*/
-- Creating the user john
CREATE USER 'john'@'Local instance MySQL80' IDENTIFIED BY 'john@256';

-- Checking what john can access from person
SELECT * FROM person WHERE PersonID = 2;

-- Allowing John to see only his information
CREATE VIEW John_Person_View2 AS
SELECT *
FROM MicrofinanceDB2.person
WHERE PersonID = 2;

-- Checking the view
SELECT * FROM John_Person_View2;

-- Granting the privilege
GRANT SELECT ON John_Person_View2 TO 'john'@'Local instance MySQL80';


/*==========================================
GIVING THE PRIVILEGES TO THE CLIENTS
==========================================*/
-- John (ClientID = 1)
CREATE OR REPLACE VIEW john_client_view AS
SELECT
    p.PersonID, p.FirstName, p.LastName, p.Email, p.PhoneNumber,
    c.ClientID, c.JoinDate, c.ClientType,
    a.AccountID, a.Balance, a.Status AS AccountStatus,
    l.LoanID, l.LoanType, l.PrincipalAmount, l.Status AS LoanStatus
FROM Person p
JOIN client c ON p.PersonID = c.ClientID
LEFT JOIN account a ON c.ClientID = a.ClientID
LEFT JOIN loan l ON c.ClientID = l.ClientID
WHERE p.PersonID = 1;

-- Amina (ClientID = 2)
CREATE OR REPLACE VIEW amina_client_view AS
SELECT
    p.PersonID, p.FirstName, p.LastName, p.Email, p.PhoneNumber,
    c.ClientID, c.JoinDate, c.ClientType,
    a.AccountID, a.Balance, a.Status AS AccountStatus,
    l.LoanID, l.LoanType, l.PrincipalAmount, l.Status AS LoanStatus
FROM Person p
JOIN client c ON p.PersonID = c.ClientID
LEFT JOIN account a ON c.ClientID = a.ClientID
LEFT JOIN loan l ON c.ClientID = l.ClientID
WHERE p.PersonID = 2;

-- Reviking the privileges on john
REVOKE ALL PRIVILEGES ON MicrofinanceDB2.Person FROM 'john_client'@'Local instance MySQL80';

-- Creating the users amina and john
CREATE USER 'john_client'@'Local instance MySQL80' IDENTIFIED BY 'John@256';
CREATE USER 'amina_client'@'Local instance MySQL80' IDENTIFIED BY 'amina@256';

-- Granting privileges to john and amina
GRANT SELECT, UPDATE ON MicrofinanceDB2.john_client_view TO 'john_client'@'Local instance MySQL80';
GRANT SELECT, UPDATE ON MicrofinanceDB2.amina_client_view TO 'amina_client'@'Local instance MySQL80';


SHOW GRANTS FOR 'loan_officer_rol';
 
 