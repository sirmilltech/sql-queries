/*
THIS QUERIES WRITTEN BY MILLTECH
Austine Obasuyi
+90-536-786-3479
milltech@datacalculations.com
https://www.datacalculations.com
CREATED ON 16-02-2025
*/
---DESCRIPTION: GENERATE A REPORT LISTING TRACK NAMES ALONGSIDE THEIR UNITPRICE >>>>>>>>1
---DESCRIPTION: HOW MANY INVOICES EXISTS BETWEEN $1.98 AND 5$  >>>>>>>>>>>>>>>>>>>>>>>>>>2
---DESCRIPTION: HOW MANY INVOICES DO WE HAVE THAT ARE EXACTLY $1.98 OR 3.96$>>>>>>>>>>>>>>3
---DESCRIPTION: HOW MANY INVOICES WERE BILLED TO BRUSSELS? >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>4
--DESCRIPTION: HOW MANY INVOICE WERE BILLED TO BRUSSELS, ORLANDO OR PARIS?..>>>>>>>>>>>>>>>>>5
---DESCRIPTION: HOW MANY INVOICE WERE BILLED IN THE CITY THAT START WITH B?>>>>>>>>>>>>>>>>>>>6
---DESCRIPTION: HOW MANY INVOICES WHERE BILLED IN A CITIES THAT HAVE 'B' ANYWHERE IN ITS NAME>>>>>>>>>>7
---DESCRIPTION: HOW MANY INVOICES WERE BILLED ON 2010-05-22 00:00:00 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>8
---DESCRIPTION: HOW MANY CUSTOMERS PURCHASED TWO SONGS AT $1.98 EACH? >>>>>>>>>>>>>>>>>>>>>>>>>>>>>9
---DESCRIPTION: GET ALL Invoice WERE BILLED AFTER 2010-05-22 AND HAVE A TOTAL OF LESS THAN 3.00?>>>>>>>>>>>>>10
---DESCRIPTION: GET ALL INVOICES WHOS THE BILLING CITY START WITH P OR STARTS WITH D?>>>>>>>>>>>>>>>>>>>>>>11
/*---====================================================================================--
---DESCRIPTION: GET ALL INVOICES THAT IS GRANTER THAN 1.98 FROM ANY CITY WHO NAME START FROM 'P' OR 'D'>>>>>>>12
PEMDAS - PERENTHESES, EXPONENTS, Multiplication, Division, AddICTION, Subtraction, EUROPE STATEMENT
BEMDAS - Brackets, Exponents, Multiplication, Division, Addiction, Subtraction,    AMERICA STATEMENT
*/
SELECT t.Name, UnitPrice FROM   track t;
SELECT InvoiceDate, BillingAddress,BillingCity,BillingCountry, total FROM Invoice where total BETWEEN 1.98 and 5
SELECT InvoiceDate, BillingAddress,BillingCity, total from Invoice where total in (1.98, 3.96)
SELECT InvoiceDate, BillingAddress, BillingCity from Invoice where BillingCity like "Brussel%"
SELECT InvoiceDate, BillingAddress, BillingCity, BillingPostalCode from Invoice where BillingCity in ("Brussels", "Orlando", "Paris")
SELECT InvoiceDate, BillingAddress, BillingCity FROM Invoice where BillingCity like "B%"
SELECT InvoiceDate, BillingAddress, BillingCity from Invoice where BillingCity like "%B%"
SELECT InvoiceDate, BillingAddress, BillingCity from Invoice WHERE InvoiceDate = "2010-05-22 00:00:00"
SELECT InvoiceDate, BillingAddress, BillingCity, total FROM Invoice where total = 1.98
SELECT InvoiceDate, BillingAddress, BillingCity, total from Invoice where InvoiceDate > "2010-05-22" AND total < 3
SELECT InvoiceDate, BillingAddress, BillingCity FROM Invoice where BillingCity like "p%" OR BillingCity like "D%"
SELECT InvoiceDate, BillingAddress, BillingCity, total from Invoice WHERE total > 1.98 AND (BillingCity LIKE "P%" OR BillingCity LIKE "D%")
=======================================================================================================================================
/*---DESCRIPTION: THEY WANT AS MANY AS POSSIBLE CUSTOMERS THAT SPEND BETWEEN $7.00 AND $15.00>>>>>>>>>>>>>>>>>>>>>>>>>>>>13
Sales categories:
Baseline Purchase - Between $0.99 and $1.99
Low Purchase      - Between $2.00 and $6.99
Target Purchase   - Between $7.00 and $15.00
Top Performer     - Above $15.00
*/
SELECT 
     InvoiceDate as Date, 
	 BillingAddress as 'Home Address', 
	 BillingCity as City,
	 total as 'Purchase Total',
	      CASE
		      WHEN total > 2.00 THEN 'Baseline Purchase'
			  WHEN total BETWEEN 2.00 and 6.99 THEN 'Low Purchase'
			  WHEN total BETWEEN 7.00 AND 15.00 THEN 'Target Purchase'
			  ELSE 'Top Performer'
		  END as PurchaseType
FROM Invoice
ORDER BY 
       BillingCity ASC

/*	   ---====================================================================================--
CHALLANGE: CATEGORIZE TRACKSS BY PRICE>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 14
WRITE A QUERY THAT SELECTS TRACK NAMES. COMPOSERS AND UNIT PRICE AND CATEGORIZES EACH TRACK BASE ON IT PRICE

Price Categories:
Budget: Tracks priced at 0.99 or less
Regular: Tracks priced between 1.00 and 1.49
Premium Tracks priced between 1.50 and 1.99
Exclusive tracks priced aboved 1.99
*/
SELECT 
      t.Name, 
	  t.Composer,
	  t.UnitPrice,
	     CASE
		  WHEN UnitPrice < 0.99 THEN 'Budget'
		  WHEN UnitPrice BETWEEN 1.00 and 1.49 THEN 'Regular'
		  WHEN UnitPrice BETWEEN 1.50 AND 1.99 THEN 'Premium'
		  ELSE 'Exclusive'
		 END as PurchaseType
FROM Track t
ORDER by t.UnitPrice ASC



SELECT Name, Composer, UnitPrice,
CASE WHEN UnitPrice <= 0.99 THEN 'Budget' WHEN UnitPrice > 0.99 AND 1.49 THEN 'Regular' WHEN UnitPrice >1.49 AND 1.99 THEN 'Premium'
ELSE'Exclusive' END as 'PriceCategory' FROM Track ORDER by UnitPrice

---DESCRIPTION: JOIN, STARTING WITH INNER JOIN>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 15
/* CUSTOMER SERVICE DEPARTMENT WANT TO REWARD THE EMPLOYEES THAT ARE RESPONSIBLE FOR THE 10 HIGHEST INDIVIDUAL SALES. 
CUSTOMER SERVICE WANTS TO CREATE A PLAQUE FOR EACH Employee WITH A LIST OF THE CUSTOMERS THAT THEY HAVE HELPED.
 
---DESCRIPTION: JOINS ON MORE THAN TWO TABLES | WHAT EMPLOYEES ARE RESPONSIBLE FOR 10 HIGHEST INDIVIDUAL SALES?
*/

SELECT
      e.FirstName, 
	  e.LastName, 
	  c.FirstName, 
	  c.LastName,
	  c.SupportRepId, 
	  c.CustomerId, 
	  total
FROM Invoice i
INNER JOIN Customer c ON i.CustomerId = c.CustomerId
INNER JOIN Employee e ON c.SupportRepId = e.EmployeeId
ORDER BY i.total DESC
 LIMIT 10

/*---====================================================================================--
UNDERSTANDING CUSTOMER SUPPORT DYNAMIC IS CRUCIAL FOR ENHANCING CUSTOMER SATISFACTION AND SERVICE EFFICIENCY. 
THE MANAGEMENT IS INTERESTED IN ANALYZING THE INTERACTION BETWEEN CUSTOMERS AND THEIR SUPPORT REPRESENTATIVE
---TEST- 
DESCRIPTION:  LIST EACH CUSTOMER ALONG WITH THEIR ASSIGNED SUPPORT REPRESENTATIVE.. >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 16
*/
SELECT 
        c.FirstName as 'First Name', 
		c.LastName AS 'Last Name',
		c.SupportRepId as 'Support Representative'
FROM Customer c
INNER JOIN employee e ON e.EmployeeId = c.CustomerId
Order by SupportRepId ASC

OR 

SELECT
      c.FirstName AS 'First Name', c.LastName AS 'Last Name',
	   e.FirstName AS 'Employee FirstName', e.LastName AS 'Employee LastName',
	  c.SupportRepId as 'Support Representative'
FROM 
    Customer c
INNER JOIN Employee e ON e.EmployeeId = c.CustomerId
order by
        SupportRepId ASC
/* 
TO DEMOSTRATE THE USE OF STRING FUNCTION, WE CAN TAKE A LOOK AT THE FOLLOWING SCENARIO. 
MANAGERIAL TEAM WANT TO SEND PERSONALIZE POSTALCARD TO EACH ONE OF THEIR CUSTOMERS.
*/-- DESCRIPTION:  CONCATENATE--- LINKING THINGS TOGETHER IN A CHAIN OR SERIES>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 17
SELECT
    c.FirstName as 'First Name', c.LastName AS 'Last Name (Surname)', 
	c.email as 'E-mail',
	Address || ' ' ||City|| ' ' ||State|| ' ' || PostalCode AS [Mailling Address],
	substr(Round(postalcode),1,5) AS [Mailling Address]
FROM 
Customer c
WHERE 
   country = "USA"

TRUBCATE --- REDUCE OR SHORTEN TEXT, UPPERCASE
---DESCRIPTION: CALCULATE THE AGES OF ALL Employee

SELECT
    c.FirstName, c.LastName, c.Email, c.Address,
	Address|| ''||State||''||City||''||PostalCode AS 'Mailling Address',
	length(postalcode),
	substr(round(postalcode),1,5) AS [5 Digit]
FROM
    customer c
WHERE 
    country = "Brazil"
	
/* ---DESCRIPTION: Select the Customers full Name and transforms their Postal Code INTO a standardized five-digit format>>>>>>>>>>>>>>>> 18
*/
SELECT 
       c.FirstName||' '||c.LastName AS 'Full Name',
       c.Address ||''||State||''||City||' '||PostalCode AS 'Mailing Address', substr(round(postalcode),1,5) AS 'Standardize-Five-Digit-Format'
FROM customer c
WHERE country = "USA"

--GET AVERAGE AMOUNT CUSTOMERS SPEND BY BILLING CITY "WHICH CITY HAVE THE BEST SALES">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>    19
SELECT
      BillingCity,
	 avg(total)
FROM 
    Invoice
ORDER By
     BillingCity DESC

 /*--DESCRIPTION: Grouping in SQL, What are the average sales by City. */ -->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 20
 SELECT BillingCity, round(avg(total),2)
 FROM Invoice
 ORDER BY BillingCity 
 
 --DESCRIPTION: Grouping In SQL | What are the Invoice average totals by cities for only the cities that start with L?>>>>>>>>>>>>>>>>>>>>>>>>> 21
SELECT
     BillingCity, 
	 round(avg(total),2)
FROM Invoice 
WHERE BillingCity like "L%"
GROUP by BillingCity
ORDER by BillingCity ASC

 
   --DESCRIPTION: Grouping In SQL | What are the averange Invoice totals greater than $5.00? >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     22
  SELECT
        InvoiceDate, BillingCity,
		round(avg(total),2)
  FROM Invoice
  WHERE total > 5.00
  GROUP by BillingCity
  ORDER by BillingCity
 
   --DESCRIPTION: Grouping In SQL | What are the averange Invoice totals greater than $5.00 for cities starting with B?   >>>>>>>>>>>>>>>>   23
 SELECT
      InvoiceDate,
	  BillingCity,
	  round(avg(total),2) AS Average
 FROM Invoice
 WHERE total > 5.00 and (BillingCity like "B%") 
 GROUP by BillingCity
 ORDER by BillingCity
 
 
 --DESCRIPTION: Grouping In SQL | What are the averange Invoice totals by billing country and City?>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 24
SELECT
       InvoiceDate, BillingCountry, BillingCity, round(avg(total),2) as Average
 FROM Invoice
GROUP by BillingCity
ORDER by BillingCity

/* CREATE a SQL report that calculates the average spending amount of Customer in each City..
The report should include: a list containing two columns: City and AverageSpending by customers in those cities.>>>>>>>>>>>>>>>>>>>>>    25
*/ 
SELECT 
      BillingCity,
	  round(avg(total),2) AS 'AverageSpending'
FROM Invoice i
INNER JOIN InvoiceLine ON i.InvoiceId = InvoiceLineID
GROUP by BillingCity
ORDER by BillingCity

--============================================================================================================
	                  SUBQUERY IS SIMPLY MEAN ONE QUERY WRITTEN INSIDE OF ANOTHER.
							WHEN A QUERY WRAPPED INSIDE OF ANOTHER QUERY
          					          IT'S' CALLED NESTED QUERY.
					--====================================================---
/* DESCRIPTION: HOW IS EACH CITY PERFORMING AGAINST GLOBAL AVERAGE SALES?     >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   26
        Gather data about all invoices that are less than the average?
*/
SELECT
      InvoiceDate, 
	  BillingCity, 
	  BillingAddress, 
	  total
FROM Invoice
WHERE total < (SELECT avg(total) FROM Invoice)
GROUP by BillingCity
ORDER by total DESC
			
--Description: Subqueries ,  How is each individual city perfomerming against the global average sales?     >>>>>>>>>>>>>>>>>>>>>>>>>  27                 
SELECT 
      BillingCity As City, 
	  round(avg(total),2) as 'Average Sales', 
	 (SELECT round(avg(total),2) FROM Invoice) AS 'Global Average'
FROM Invoice 
GROUP by 
	  BillingCity 
ORDER by 
       BillingCity

/*
====================================================================
                         SUBQUERIES
				Returning Multiple valumes from a subqueries >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  28
		======================================================
*/		

SELECT
     InvoiceDate as Date, 
	 BillingCity as City, 
	 BillingAddress as Address
FROM Invoice
WHERE InvoiceDate IN 
(SELECT InvoiceDate 
FROM Invoice 
WHERE InvoiceId in (251,252,255))

=====================================================================

SELECT
     InvoiceDate as Date, 
	 BillingCity as City, 
	 round(avg(total),2) as 'Average Sales', 
	 (SELECT round(avg(total),2)) as 'Global Average'
FROM
   Invoice
WHERE
      InvoiceDate IN 
	  (select InvoiceDate from Invoice WHERE InvoiceId BETWEEN 45 AND 413)
GROUP by BillingCity
ORDER by BillingCity
  

/*
==================================================================================
                                        SUBQUERIES
				subqueries and DISTINCT | which tracks are not selling? >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>          29
	==================================================================
*/
SELECT
     trackID, 
	 t.name as Name,
	 Composer
FROM Track t
WHERE trackID
NOT in
(SELECT DISTINCT TrackId from InvoiceLine WHERE TrackId)
ORDER by TrackId   
===============================================================
SELECT 
      TrackId,
	  t.name As Name, 
	  Composer
FROM track t
WHERE TrackId
      NOT in (select DISTINCT trackid FROM InvoiceLine ORDER by TrackId)
	  
	  
/*
SQL CHALLANGE: Uncovering Unpopular Tracks >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   30

WRITE A SQL QUERY THAT IDENTIFIES TRACKS THAT HAVE NEVER BEEN SOLD, YOUR QUERY SHOULD RETURN A 
LIST OF THESE TRACKS. ALONG WITH THEIR Composer AND THE Genre
Your report should include: a list that includes the TRACK ID, TRACK NAME, COMPOSER and GENRE,  
*/
SELECT
     TrackId AS ID,
	 t.name AS NAME,
	 Composer, (SELECT g.name from Genre g) AS Genre
FROM track t
WHERE TrackId
    NOT IN (select DISTINCT InvoiceId from InvoiceLine)
ORDER by 
      t.Name ASC
/*
===========================================================================
--- This query identifiers tracks that have never been sold.. >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  31
*/
SELECT 
      TrackId as ID,
	  t.name as 'Track Name',
	  Composer as Composer,
	  g.name as Genre
FROM Track t
INNER JOIN genre g ON g.GenreId = g.GenreId
where T.TrackId
        NOT IN
		     (SELECT DISTINCT InvoiceLine.TrackId FROM InvoiceLine)
ORDER by
      "Track Name" ASC
     NOT IN
	  (SELECT TrackId FROM 