--SQL HW 3 Ian Glish
--1. 1. List all customers who live in Texas (use JOINs)
SELECT customer.customer_id,customer.first_name, customer.last_name, customer.address_id, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';
--The Texas customers are: Jennifer Davis, Kim Cruz, Richard McCrary, Bryan Hardison and Ian Still.

--2. Get all payments above $6.99 with the full customer's name
SELECT payment.customer_id, payment.payment_date, payment.amount, first_name, last_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99
ORDER BY customer_id;
-- There are 11,856 payments above $6.99 (customer names provided by the code).

--3. Show all customers names who have made payments over $175 (use subqueries)
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 175
);
--There are 0 customers (customer names) who have made payments over $175

--4. List all customers that live in Nepal (use the city table)
SELECT customer.first_name, customer.last_name, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';
--There is 1 customer from Nepal, named Kevin Schuler.

--5. Which staff member had the most transactions?
SELECT COUNT(staff.staff_id), staff.first_name, staff.last_name, SUM(amount)AS most_transactions
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY most_transactions DESC;
--Jon Stephens(staff_id 2) was the staff member with the most transactions

--6. How many movies of each rating are there?
SELECT COUNT(film_id), rating
FROM film
GROUP BY rating
--There are 194 PG, 178 G, 223 PG-13, 195 R, and 210 NC-17 movies.
--I couldn't think of a how a JOIN could be used for this problem, due to the fact both columns needed were in the same table already.

--7. Show all customers who have made a single payment above $6.99 (use subqueries)
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
	GROUP BY customer_id
	HAVING COUNT(customer_id) = 1
);
--There are no customers that have made a single payment above $6.99.

--8. How many free rentals did our stores give away?
SELECT rental.rental_id
FROM rental
FULL JOIN payment
ON rental.rental_id = payment.rental_id
INNER JOIN staff
ON payment.staff_id = staff.staff_id
INNER JOIN store
ON staff.store_id = store.store_id 
WHERE amount = 0;
--The stores gave away 12 free rentals for rental with rental_id of 508.