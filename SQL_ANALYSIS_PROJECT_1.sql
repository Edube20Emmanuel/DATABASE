/*===================================================================
THIS PROJECTS AIMS TO PRACTISE AND PERFECT ON WHAT WE HAVE DONE
====================================================================*/
-- Checking the databases available
SELECT
	name
FROM sys.databases;

-- Selecting the  database
USE SalesDB;

-- THE SELECTION tables
SELECT 
	name
FROM sys.tables;

-- Retrieve all customers from  Germany
SELECT 
	*
FROM Sales.Customers
WHERE Country = 'Germany';

-- Retrieve all customers who are not from Germany
SELECT 
	* 
FROM Sales.Customers
WHERE Country != 'Germany';

-- OR

SELECT
	*
FROM Sales.Customers
WHERE Country <> 'Germany';

-- Retrieve all customers with a score of 500 or more 
SELECT
	*
FROM Sales.Customers
WHERE Score >= 500;

-- Retrieve all customers with a score of 500 or less
SELECT
	*
FROM Sales.Customers
WHERE Score <= 500;

--Retrieve all customers who either from USA or have a score greater than 500
SELECT 
	*
FROM Sales.Customers
WHERE Country = 'USA' OR Score > 500;

-- Retrieve all customers with score not less than 500
SELECT * FROM Sales.Customers WHERE Score !< 500;

-- Retrieve all customers whose score falls in the range bbtn 100 and 500
SELECT
	*
FROM Sales.Customers
WHERE Score BETWEEN 100 AND 500;

-- Retrieve all customers from either germany or usa
SELECT 
	* 
FROM Sales.Customers 
WHERE Country = 'Germany' OR Country = 'USA';


-- Find all customers whose first name starts with 'M'
SELECT 
	*
FROM Sales.Customers
WHERE FirstName LIKE 'M%';

-- Find all customers whose first name ends with 'n'
SELECT 
	*
FROM Sales.Customers
WHERE FirstName LIKE '%n';

-- Find all customers whose first name has 'r' in the third position
SELECT 
	*
FROM Sales.Customers
WHERE FirstName LIKE '__r%';


-- Retrieve tables without applying a join
SELECT * FROM Sales.Customers;
SELECT * FROM Sales.Employees;


-- Retrieve all data from customers and orders into different results or tables
SELECT * FROM Sales.Customers;
SELECT * FROM Sales.Orders;

-- Get all customers along with their orders, including those without orders
SELECT * FROM Sales.Customers AS C
LEFT JOIN
	Sales.Orders AS O
ON C.CustomerID = O.CustomerID;;


--Retrieve all customers along with their orders including orders without matching customers
SELECT
	*
FROM Sales.Customers AS C
RIGHT JOIN
		Sales.Orders AS O
ON C.CustomerID = O.CustomerID;

-- Get all customrs and all orders even if there is no match
SELECT
	* 
FROM Sales.Customers AS C
FULL JOIN
	Sales.Orders AS O
ON C.CustomerID = O.CustomerID;
	


-- Retrieve all customers who have not placed an oreder
-- Anti join
SELECT 
	C.CustomerID,
	C.FirstName
FROM Sales.Customers AS C
LEFT JOIN
	Sales.Orders AS O
ON C.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL;


-- Get all oreders without matching customers
SELECT 
	R.CustomerID,
	R.OrderID,
	R.OrderStatus,
	R.Quantity
FROM Sales.Customers AS L
RIGHT JOIN
	Sales.Orders AS R
ON L.CustomerID = R.CustomerID
WHERE L.CustomerID IS NULL;

-- The right anti join
SELECT * FROM Sales.Orders AS O
FULL JOIN
Sales.Customers AS C
ON O.CustomerID = C.CustomerID;

-- The left anti join
SELECT 
	*
FROM Sales.Customers AS L
LEFT JOIN
	Sales.Orders AS R
ON R.CustomerID = L.CustomerID
WHERE R.CustomerID IS NULL;

-- Find customers without orders and orders without customers
-- Full anti join
SELECT 
	* 
FROM Sales.Customers AS C
FULL JOIN
	Sales.Orders AS O
ON C.CustomerID = O.CustomerID
WHERE C.CustomerID IS NULL
OR O.CustomerID IS NULL;

-- Using SalesDB retrieve a list of all orders along with the related customer, products and employee details
SELECT * FROM Sales.Customers
CROSS JOIN Sales.Orders;

-- Combine the data from employees and customers into one table
-- UNION
SELECT * FROM Sales.Employees;
SELECT * FROM Sales.Customers;

-- combining
SELECT
	'Employee_table' AS Source_table,
	E.EmployeeID AS personID,
	E.FirstName,
	E.LastName
FROM Sales.Employees AS E
UNION
SELECT 
	'customer_table' AS Source_table,
	C.CustomerID,
	C.FirstName,
	C.LastName
FROM Sales.Customers AS C
ORDER BY personID;

-- Combine the data from employees and customers into one table including duplictes
-- UNION ALL, Employees and Customers
SELECT
	EmployeeID,
	FirstName,
	LastName
FROM Sales.Employees
UNION ALL
SELECT 
	CustomerID,
	FirstName,
	LastName
FROM Sales.Customers;

-- Find employees who are not customers at the same time
-- Except -- Used mostly by data engineers
SELECT 
	E.EmployeeID,
	E.FirstName,
	E.LastName
FROM Sales.Employees AS E
EXCEPT
SELECT 
	C.CustomerID,
	C.FirstName,
	C.LastName
FROM Sales.Customers AS C;

-- Find the employees who are customers
-- INTERSECTION
SELECT
	E.EmployeeID,
	E.FirstName,
	E.LastName
FROM Sales.Employees AS E
INTERSECT
SELECT
	C.CustomerID,
	C.FirstName,
	C.LastName
FROM Sales.Customers AS C;

-- The orders table and orderachive table
SELECT * FROM Sales.Orders
UNION ALL
SELECT * FROM Sales.OrdersArchive;

-- Specifying the table
SELECT 
	'Order_table' AS Source_Table,
	O.OrderID,
	O.ProductID,
	O.CustomerID,
	O.SalesPersonID,
	O.OrderDate,
	O.ShipDate,
	O.OrderStatus,
	O.ShipAddress,
	O.BillAddress,
	O.Quantity,
	O.Sales,
	O.CreationTime
FROM Sales.Orders AS O
UNION ALL
SELECT 
	'archieve_table' AS Source_Table,
	A.OrderID,
	A.ProductID,
	A.CustomerID,
	A.SalesPersonID,
	A.OrderDate,
	A.ShipDate,
	A.OrderStatus,
	A.ShipAddress,
	A.BillAddress,
	A.Quantity,
	A.Sales,
	A.CreationTime
FROM Sales.OrdersArchive AS A
ORDER BY OrderID;


-- String functions
-- Show a list of first name and country into one column
SELECT
	CustomerID,
	FirstName,
	LastName,
	CONCAT(FirstName,' ', LastName) AS Full_Name
FROM Sales.Customers;

-- Find customers whose first name contains leading or trailing  spaces
SELECT * FROM Sales.Customers
WHERE LEN(FirstName) != LEN(TRIM(FirstName));

SELECT * FROM Sales.Customers
WHERE FirstName = TRIM(FirstName);

-- String  extraction
-- Extract the first two characters from the first name
SELECT 
	LEFT(FirstName, 2)
FROM Sales.Customers;

-- Extract the last two characters from the first name
SELECT 
	RIGHT(FirstName,2)
FROM Sales.Customers;
 
-- Extract specific characters from any part of the string
SELECT
	FirstName,
	SUBSTRING(FirstName,4,LEN(FirstName))
FROM Sales.Customers;
