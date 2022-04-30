/*creating the database name assignment */

CREATE schema assignment;

/*switching to the database assignment */

use assignment;

/*creating the Salesman table */

CREATE TABLE Salesman(
  SNUM INT NOT NULL,
  SNAME VARCHAR(40),
  CITY VARCHAR(40),
  COMMISSION INT ,
  PRIMARY KEY(SNUM)
);

/*inserting values in the salesman table */

INSERT INTO Salesman VALUES(1001,"Piyush","London",12);
INSERT INTO Salesman VALUES(1002,"Sejal","Surat",13);
INSERT INTO Salesman VALUES(1004,"Miti","London",11);
INSERT INTO Salesman VALUES(1007,"Rajesh","Baroda",15);
INSERT INTO Salesman VALUES(1003,"Anand","New Delhi",10);

/*creating the table Customers */

CREATE TABLE Customers(
    CNUM INT NOT NULL,
    CNAME VARCHAR(40) NOT NULL,
    CITY VARCHAR(40),
    RATING INT,
    SNUM INT,
    FOREIGN KEY(SNUM) REFERENCES Salesman(SNUM) ON DELETE SET NULL,
    PRIMARY KEY(CNUM)
);

/*inserting values in the Customers table */

INSERT INTO Customers VALUES(2001,"Harsh","London",100,1001);
INSERT INTO Customers VALUES(2002,"Gita","Rome",200,1003);
INSERT INTO Customers VALUES(2003,"Lalit","Surat",200,1002);
INSERT INTO Customers VALUES(2004,"Govind","Bombay",300,1002);
INSERT INTO Customers VALUES(2006,"Chirag","London",100,1001);
INSERT INTO Customers VALUES(2008,"Chinmay","Surat",300,1007);
INSERT INTO Customers VALUES(2007,"Pratik","Rome",100,1004);

/* creating the orders table */

CREATE TABLE orders(
   ONUM INT NOT NULL,
   AMOUNT decimal(8,2),
   ODATE DATE,
   CNUM INT,
   SNUM INT,
   PRIMARY KEY(ONUM),
   FOREIGN KEY(CNUM) REFERENCES Customers(CNUM) ON DELETE SET NULL,
   FOREIGN KEY(SNUM) REFERENCES Salesman(SNUM) ON DELETE SET NULL
);

/* inserting into the orders table */


INSERT INTO orders VALUES(3001,18.69,'1997-03-10',2008,1007);
INSERT INTO orders VALUES(3003,767.19,'1997-03-10',2001,1001);
INSERT INTO orders VALUES(3002,1900.19,'1997-03-10',2007,1004);
INSERT INTO orders VALUES(3005,5160.45,'1997-03-10',2003,1002);
INSERT INTO orders VALUES(3006,1098.16,'1997-03-10',2008,1007);
INSERT INTO orders VALUES(3009,1713.23,'1997-04-10',2002,1003);
INSERT INTO orders VALUES(3007,75.75,'1997-04-10',2004,1002);
INSERT INTO orders VALUES(3008,4723.00,'1997-05-10',2006,1001);
INSERT INTO orders VALUES(3010,1309.95,'1997-06-10',2004,1002);
INSERT INTO orders VALUES(3011,9891.88,'1997-06-10',2006,1001);

select * from orders;

/*question 1 - produce the order no,amount and date of all orders */

SELECT ONUM,AMOUNT,ODATE FROM orders;

/*question 2 - give all the information about all the customers with salesman
number 1001 */

SELECT * 
FROM customers 
WHERE SNUM = 1001;

/*question 3 - display the following information in the order of city,sname,
snum and commission */

SELECT SNAME,SNUM,COMMISSION 
FROM salesman 
ORDER BY CITY;

/*question 4 - list of rating followed by the
 name of each customer from surat */
 
 SELECT RATING,CNAME FROM customers WHERE CITY = 'surat';
 
/*question 5 - list of snum of all salesman with 
orders in order table without any duplicates */

SELECT DISTINCT s.SNUM
FROM salesman s
JOIN orders o
on s.SNUM = o.SNUM;

/*question 6 - list of all orders for more than Rs.1000 */

SELECT * FROM orders 
WHERE AMOUNT > 1000;

/*question 7 - list of names and cities of all salesman in london
with commission above 10% */

SELECT SNAME,CITY FROM Salesman
WHERE CITY = 'London'
AND COMMISSION > 10; 

/*ques 8 - list all customers whose name
begins with letter 'C'; */

SELECT * FROM customers 
WHERE CNAME LIKE 'C%';

/*ques 9 - list all customers whose name
begins with letter 'A to G' */

SELECT * FROM customers 
WHERE CNAME regexp '^[a-g]';

/*ques 10 - list all orders with 0 and NULL amount */

SELECT * FROM orders 
WHERE amount = 0 or amount = NULL;

/* ques 11 - find the largest orders of salesman 1002 and 1007 */

SELECT max(o.amount) 
FROM orders o
JOIN Salesman s
ON o.SNUM = s.SNUM WHERE o.SNUM = 1002;


SELECT max(o.amount) 
FROM orders o
JOIN Salesman s
ON o.SNUM = s.SNUM WHERE o.SNUM = 1007;

/*ques 12 - count all orders of october 3,1997 */

SELECT count(orders.ONUM)
FROM orders 
WHERE ODATE = '1997-03-10';

/*ques 13 - calculate the total amount ordered */

SELECT SUM(orders.amount)
FROM orders;

/*ques 14 - calculate the avg amount ordered */

SELECT AVG(orders.amount)
FROM orders;

/* ques 15 - count the number of salesman currently having orders */

SELECT DISTINCT COUNT(s.SNUM)
FROM Salesman s
JOIN Orders o
ON s.SNUM = o.SNUM WHERE o.ONUM IS NOT NULL;

/*ques 16 - list all salesman with their % of commission */

SELECT SNUM,COMMISSION
FROM Salesman;

/* ques 17 - assume each salesman has a 12% commission.write a query on the
order table that will produce the order no,Salesman no and the amount of commission for that order */

SELECT o.ONUM ,s.SNUM,(12 * o.AMOUNT / 100) AS 'AMOUNT OF COMMISSION'
FROM orders o 
JOIN Salesman s
ON o.SNUM = s.sNUM;

/*ques 18 - find the highest rating in each city in the form : 
For the city(city),the highest rating is :(rating) */

SELECT city,max(RATING)
FROM Customers
GROUP BY CITY;

/*ques 19 - list all in the descending order of the rating */

SELECT Customers.RATING
from Customers
ORDER BY RATING DESC;

/*ques 20 - calculate the total of orders for each day and place the result
in descending order */

SELECT ODATE,SUM(AMOUNT)
FROM Orders
group by ODATE ORDER BY SUM(AMOUNT);

/*ques 21 - Show the name of all customers 
with their salesman name */

SELECT c.CNAME,s.SNAME
FROM Customers c
JOIN Salesman s
ON s.SNUM = c.SNUM;

/*ques 22 - list all customers and 
salesman who share the same city */

SELECT c.CNAME,s.SNAME
FROM Customers c
JOIN Salesman s
ON c.SNUM= s.SNUM WHERE c.CITY = s.CITY;

/*ques 23 - list all order with their customer
and salesman */

SELECT O.ONUM,c.CNAME,s.SNAME
FROM Orders o
JOIN Customers c 
ON o.CNUM = c.CNUM
JOIN Salesman s
ON o.SNUM = s.SNUM;

/*ques 24 - list all orders by the customers not located in 
the same city as their salesman */

SELECT o.ONUM,c.CNAME,c.city,s.city
FROM Orders o
JOIN Customers c
ON o.CNUM = c.CNUM
JOIN Salesman s
ON o.SNUM = s.SNUM 
WHERE s.CITY <> c.CITY;

/*ques 25- list all customers serviced by salesman
with commission above 12 & */

SELECT c.cname
FROM Customers c
JOIN Salesman s
ON c.snum= s.snum
WHERE s.commission  > 12 ;


/*ques 26 - Calculate the amount of salesman commission 
on each order by a customer with rating above 100 */

select s.commission
from Salesman s
join Customers c
on s.snum = c.snum 
join Orders o
on s.snum = o.snum;

#ques 27 - find all pairs of customers having the same rating without duplicates

SELECT distinct c.cname,copy.cname
from Customers c
join Customers copy
on c.rating= copy.rating
where c.rating = copy.rating;

#ques 28 - list all orders that are greater than average of October 4,1997;

select ONUM
from Orders 
where amount > (select avg(amount) from Orders where odate = '1997-04-10');

#ques 29 - find the average commission of salesman in london;



select round(avg(s.commission * o.amount / 100),2) as commission_amount
from Salesman s
join Orders o
on s.snum = o.snum 
where s.city = 'London';

#ques 30 - find all orders attributed to Salesman in london
# using both subquery and join method

select o.odate
from Orders o
join Salesman s
on o.snum = s.snum
where s.city = 'London';

/*ques 31 - list the commission of all salesman 
serving Customers in london */

SELECT round((s.commission * o.amount / 100),2)as commission
from Salesman s
join Orders o
on o.snum = s.snum
join Customers c
on s.snum = c.snum 
where c.city = 'London';

/*ques - 32 find all customers whose cnum is 1000
above than the snum of sejal */

SELECT c.cname 
from Customers c
join Salesman s
on c.snum = s.snum 
where c.cnum + 1000 > (select snum from Salesman where sname = 'Sejal');

/*ques 33 - count the number of customers with the rating above 
than the average of Surat */

SELECT count(cnum)
from Customers 
where rating > (select avg(rating) from Customers where city = 'Surat');

/*ques 34 - find all salesman with customers located in their cities 
using any and in */

SELECT s.sname,c.cname
from Customers c
join Salesman s
on c.snum = s.snum
where s.city = any(select city from Customers);

/*ques 35 - find all salesman for whom there are customers that follow
them in alphabetical order */

SELECT s.sname
from Salesman s;

/*ques 36 - find all customers having rating greater than
any customer in "Rome */

select cname
from Customers
where rating > any(select rating from Customers where city = 'Rome');


/*ques 37 - list all orders that has amount greater than atleast one of the 
orders from from 6th october ,1997 */

SELECT onum,odate
from orders 
where amount > any(select amount from orders where odate = '1997-06-10');

/*ques 38 - find all orders with amount smaller than any amount for a
customer in 'London' */

SELECT onum,amount
from orders 
join Customers 
on Customers.cnum = orders.cnum
where amount < any(select amount from orders where city = 'London');

/*ques 39 - find all customers who have greater
 rating than every customer in rome */
 
 select cname
 from customers
 where rating > all(select rating from customers where city = 'Rome');
 
 /*ques 41 - produce the name and number of each salesman 
 and each customer with more than one current order in the alphabetical
 order of names */
 
 select s.sname,s.snum,c.cname,c.cnum
 from Customers c
 join Salesman s
 on s.snum = c.snum
 join orders o
 on o.cnum = c.cnum;
 
 /*ques 43 - remove all orders from customer chirag
 from the orders table */
 
 
 delete o
 from orders o
 join customers c
 on o.cnum = c.cnum
 where c.cname = 'Chirag';
 
 
/*ques 44 - set the rating of all the customers of piyush to 400 */

update customers
join Salesman
on customers.snum = Salesman.snum
set customers.rating = customers.rating + 100
where Salesman.sname = 'piyush';

/*ques 45 - increase the rating of all customers 
in rome by 100 */

update customers
set rating = rating + 100
where city = 'Rome';





















