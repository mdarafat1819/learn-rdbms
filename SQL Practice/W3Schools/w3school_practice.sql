USE w3schools;

SELECT count(CustomerID) as Total_Entry FROM Customers;

SELECT CustomerName, City FROM Customers;

SELECT Country, count(Country) FROM Customers GROUP BY Country;
SELECT COUNT(DISTINCT Country) FROM Customers;
SELECT COUNT(A.Country) FROM (SELECT DISTINCT Country FROM Customers)AS A;
SELECT Count(*) AS DistinctCountries
FROM (SELECT DISTINCT Country FROM Customers) AS A;
SELECT COUNT(DISTINCT Country) FROM Customers;

SELECT count(*) FROM Customers WHERE Country='Mexico';

SELECT * FROM Customers 
	WHERE CustomerID = 1 OR CustomerID = 2;
    
SELECT * FROM Products ORDER BY Price;

SELECT * FROM Customers 
	ORDER BY Country, CustomerName;
    
SELECT * FROM Customers
	ORDER BY Country ASC, CustomerName DESC;

SELECT * FROM Customers WHERE Country = 'Spain' AND CustomerName LIKE 'G%';

SELECT * FROM Customers WHERE Country = 'Brazil' AND City = 'Rio de Janeiro' AND CustomerID > 50;

SELECT * FROM Customers 
	WHERE Country = 'Spain' AND (CustomerName LIKE 'G%' OR CustomerName LIKE 'R%');
    
SELECT * FROM Customers 
	WHERE NOT Country = 'Spain';
    
SELECT * FROM Customers
	WHERE CustomerName NOT LIKE 'A%';
SELECT * FROM Customers
	WHERE NOT CustomerID BETWEEN 10 AND 60; 
    
SELECT * FROM Customers 
	WHERE NOT City IN ('Paris', 'London');
