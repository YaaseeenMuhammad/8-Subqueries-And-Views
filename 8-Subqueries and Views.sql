-- Consider the Country table and Persons table that you created earlier and perform the following: 

USE population;

SELECT * FROM COUNTRY;
SELECT * FROM PERSONS;

-- 1. Find the number of persons in each country. 

SELECT Country_name, COUNT(*)
FROM Persons
GROUP BY Country_name;

SELECT Country_name, COUNT(*) AS Num_Of_Persons
FROM Persons
GROUP BY Country_name;

-- 2. Find the number of persons in each country sorted from high to low. 

SELECT Country_name, COUNT(*) AS Number_Of_Persons
FROM Persons
GROUP BY Country_name
ORDER BY Number_Of_Persons DESC;

-- 3. Find out an average rating for Persons in respective countries if the average is greater than 4.5

SELECT Country_name, AVG(Rating) AS Average_Rating
FROM Persons
GROUP BY Country_name
HAVING AVG(Rating) > 4.5;

-- 4. Find the countries with the same rating as the Italy.

SELECT Country_name
FROM Country
WHERE Id IN (
    SELECT Country_Id
    FROM Persons
    WHERE Rating = (SELECT Rating FROM Persons WHERE Country_name = 'Italy' LIMIT 1)
);

SELECT c.Country_name, p.Fname, p.Lname, p.Rating
FROM Country c
JOIN Persons p ON c.Id = p.Country_Id
WHERE p.Country_Id IN (
    SELECT Country_Id
    FROM Persons
    WHERE Rating = (SELECT Rating FROM Persons WHERE Country_name = 'Italy' LIMIT 1)
);

-- (Use Subqueries) 
-- 5. Select all countries whose population is greater than the average population of all nations.

SELECT AVG(Population) AS Avg_Population FROM Persons;

SELECT Country_name, Population
FROM Country
WHERE Population > (SELECT AVG(Population) FROM Country);


-- -------------------------------------------------------------------------------------------------------------------------------------------------------

-- Create a database named Product.

CREATE DATABASE PRODUCT;

USE PRODUCT;

-- Create a table called Customer with the following fields in the Product database: 
## Customer_Id - Make PRIMARY KEY First_name Last_name Email Phone_no Address City State Zip_code Country 

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,     
    First_Name VARCHAR(100),         
    Last_Name VARCHAR(100),   
    Email VARCHAR(100) UNIQUE,            
    Phone_no VARCHAR(15) UNIQUE,      
    Address VARCHAR(255),          
    City VARCHAR(100),         
    State VARCHAR(50),  
    Zip_code VARCHAR(20),            
    Country VARCHAR(100)             
);

DESC Customer;

INSERT INTO Customer (Customer_Id, First_name, Last_name, Email, Phone_no, Address, City, State, Zip_code, Country)
VALUES 
(1, 'Virat', 'Kohli', 'Virat.Kohli@test.com', '1234567890', '123 Elm St', 'Springfield', 'IL', '62701', 'USA'),
(2, 'Jane', 'Smith', 'jane.smith@test.com', '0123456789', '456 Oak St', 'Chicago', 'IL', '60601', 'USA'),
(3, 'Michael', 'Thomas', 'Michael.Thomas@test.com', '9012345678', '789 Pine St', 'San Francisco', 'CA', '94101', 'USA'),
(4, 'Sara', 'Jr', 'Sara.Jr@test.com', '8901234567', '101 Maple Ave', 'Los Angeles', 'CA', '90001', 'USA'),
(5, 'Arun', 'Mohan', 'Arun.Mohan@test.com', '7890321654', '202 Birch Rd', 'New York', 'NY', '10001', 'USA');

SELECT * FROM Customer;

-- 1. Create a view named customer_info for the Customer table that displays Customer’s Full name and email address. Then perform the SELECT operation for the customer_info view. 

CREATE VIEW customer_info AS
SELECT CONCAT(First_name, ' ', Last_name) AS Full_name, Email
FROM Customer;

SELECT * FROM customer_info;

-- 2. Create a view named US_Customers that displays customers located in the US. 

CREATE VIEW US_Customers AS
SELECT * FROM Customer WHERE COUNTRY='USA';

SELECT * FROM US_Customers;

-- 3. Create another view named Customer_details with columns full name(Combine first_name and last_name), email, phone_no, and state. 

CREATE VIEW Customer_Details AS 
SELECT CONCAT(First_name, ' ', Last_name) AS Full_name, Email, Phone_no, State
FROM Customer;

SELECT * FROM Customer_Details;

-- 4. Update phone numbers of customers who live in California for Customer_details view. 

UPDATE Customer
SET Phone_no = '6789012345'
WHERE State = 'CA' AND Customer_Id=3;

UPDATE Customer
SET Phone_no = '5678901234'
WHERE State = 'CA' AND Customer_Id=4;

CREATE VIEW Customer_Details_California AS 
SELECT CONCAT(First_name, ' ', Last_name) AS Full_name, Email, Phone_no, State
FROM Customer WHERE State= 'CA' ;

SELECT * FROM Customer_Details_California;

-- 5. Count the number of customers in each state and show only states with more than 1 customers. 

SELECT State, COUNT(*) AS Num_of_Customers
FROM Customer
GROUP BY State
HAVING COUNT(*) > 1;

-- 6. Write a query that will return the number of customers in each state, based on the "state" column in the "customer_details" view.

SELECT State, COUNT(*) AS Number_of_Customers
FROM Customer_details
GROUP BY State;

-- 7. Write a query that returns all the columns from the "customer_details" view, sorted by the "state" column in ascending order.

SELECT *
FROM Customer_details
ORDER BY State ASC;


