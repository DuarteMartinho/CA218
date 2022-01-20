-- Save the file with your student ID number and upload it on loop.
-- Write your equivalent SQL query for each of the questions under the following entries

-- Student Name: Duarte Martinho
-- Student ID: 20410974

-- Part I
#======================
#Q1. Using Dreamhome database, show all the details of the staff members.
USE dreamhome;
SELECT *
FROM staff;




#======================
#Q2. Using Dreamhome database, list the first name and last name of private owners 
# in ascending order of owner’s first name and in an ascending order of 
# owner’s last name.
USE dreamhome;
SELECT fName, lName
FROM privateOwner
ORDER BY fName ASC, lName ASC;




#======================
#Q3. Using World database, list all the country code and country name of all 
# countries with country name ending with “land”, like Ireland, Iceland etc.
USE world;
SELECT Code, Name
FROM country
WHERE Name LIKE "%land";






#======================
#Q4. Using World database, show the number of countries in the middle east region.  
USE world;
SELECT COUNT(*)
FROM country
WHERE region = "Middle East";



-- Part II
#======================
#Q5. Using world database, list the region, number of countries, the total 
# population, and average population of each region. (25 rows, 4 columns)
USE world;
SELECT Region, COUNT(*), SUM(Population), AVG(Population)
FROM country
GROUP BY region;



#======================
#Q6. Using world database, list the name of the languages, and the number of 
# countries that speak the language along with the total population of the 
# countries for those languages that are spoken in more than 10 countries. 
# (13 rows, 3 columns)
USE world;
SELECT Language, COUNT(CountryCode), SUM(Population)
FROM countrylanguage 
JOIN country ON CountryCode = Code
GROUP BY Language
HAVING COUNT(CountryCode) > 10;




-- Part III
#======================
#Q7. Using the classicmodels database, list the product code, 
# product name and product buy price of those products with buy price
# is greater than the average product buy price. (54 rows, 3 columns)
USE classicmodels;
SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice > (SELECT AVG(buyPrice) FROM products);





#======================
#Q8. Using the classicmodels database, for customers who have more than 10 
# distinct orders and total amount greater than 10,000, list the total 
# price of their order and the number of orders. (use order and orderdetail tables). (2 rows, 3 columns)
USE classicmodels;
SELECT customerNumber, COUNT(orderNumber)
FROM orders
GROUP BY customerNumber
HAVING COUNT(customerNumber) > 10;





-- Part IV
#======================
#Q9. Using sakila database, show the first_name and last_name of actors
# who participate in PG-13 rated films. The result should be order by 
# first_name and should not contain duplicates. (199 rows, 2 columns)
USE sakila;
SELECT DISTINCT(first_name), last_name
FROM actor
JOIN film_actor USING(actor_id)
JOIN film USING(film_id)
WHERE rating = "PG-13"
ORDER BY first_name;

#======================
#Q10. Using sakila database, show the first_name and last_name of the actors
# who do not participate in G rated films.  (1 row, 2 columns)
USE sakila;
SELECT DISTINCT(first_name), last_name
FROM actor
WHERE actor_id 
	NOT IN (
		SELECT actor_id
        FROM film_actor
        JOIN film USING(film_id)
        WHERE rating = "G"
	)
ORDER BY first_name;