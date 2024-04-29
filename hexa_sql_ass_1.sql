-- TASK 1
-- 1)Create the database named "TechShop"

drop database if exists TechShop;
create database Techshop;
use TechShop;
-- 2) Define the schema for the Customers, Products, Orders, OrderDetails and Inventory tables based on the provided schema
-- 4)Create appropriate Primary Key and Foreign Key constraints for referential integrity

create table customers (customerid int primary key , firstname varchar(50), lastname varchar(50), email varchar(50), 
phone varchar(20),address varchar(75));

create table products (productid int primary key, productname varchar(100),
description varchar(100), price numeric(10, 2));
    
create table orders (orderid int primary key, customerid int, orderdate date, totalamount numeric(10, 2),
foreign key (customerid) references customers(customerid));

create table orderdetails (orderdetailid int primary key, orderid int, productid int, quantity int,
foreign key (orderid) references orders(orderid), foreign key (productid) references products(productid));

create table inventory (inventoryid int primary key, productid int, quantityinstock int, laststockupdate date,
foreign key (productid) references products(productid));

-- 3) Create an ERD (Entity Relationship Diagram) for the database.

-- 5) Insert at least 10 sample records into each of the following tables.

insert into customers (customerid, firstname, lastname, email, phone, address) values
(1, 'alice', 'smith', 'alice@example.com', '1234567890', 'usa'),
(2, 'ben', 'jones', 'ben@example.com', '9876543210', 'uk'),
(3, 'cathrine', 'rani', 'rani@example.com', '4567890123', 'india'),
(4, 'suresh', 'patel', 'suresh@example.com', '3456789012', 'india'),
(5, 'john', 'benny', 'john@example.com', '2345678901', 'usa'),
(6, 'david', 'thomas', 'david@example.com', '8901234567', 'canda'),
(7, 'lincy', 'wilson', 'lincy@example.com', '6789012345', 'brazil'),
(8, 'grace', 'sofia', 'grace@example.com', '4567890123', 'uk'),
(9, 'juli', 'garcia', 'juli@example.com', '5678901234', 'washington'),
(10, 'williams', 'martin', 'williams@example.com', '7890123456', 'india');

insert into products (productid, productname, description, price) values
(1, 'watch', 'A timepiece worn on the wrist', 10.99),
(2, 'mobile', 'A portable telephone', 29.99),
(3, 'laptop', 'A portable computer', 49.99),
(4, 'printer', 'A device that prints text or illustrations on paper', 19.99),
(5, 'mouse', 'A hand-held input device used to control a cursor on a computer screen', 14.99),
(6, 'pc', 'A personal computer', 39.99),
(7, 'adapter', 'A device for connecting pieces of equipment that cannot be connected directly', 9.99),
(8, 'earpods', 'A type of earphones', 7.99),
(9, 'mic', 'A microphone for audio recording', 12.99),
(10, 'keyboard', 'A set of keys used to input data into a computer or other device', 17.99);

insert into orders (orderid, customerid, orderdate, totalamount) values
(1, 1, '2024-04-01', 54.97),
(2, 2, '2024-04-02', 39.98),
(3, 3, '2024-04-03', 27.98),
(4, 4, '2024-04-04', 64.97),
(5, 5, '2024-04-05', 44.96),
(6, 6, '2024-04-06', 59.97),
(7, 7, '2024-04-07', 19.99),
(8, 8, '2024-04-08', 29.98),
(9, 9, '2024-04-09', 54.96),
(10, 10, '2024-04-10', 74.95);

insert into orderdetails (orderdetailid, orderid, productid, quantity) values
(1, 1, 1, 3),
(2, 1, 2, 1),
(3, 2, 3, 2),
(4, 2, 4, 1),
(5, 3, 5, 4),
(6, 4, 6, 2),
(7, 4, 7, 1),
(8, 5, 8, 3),
(9, 6, 9, 1),
(10, 7, 10, 2);

insert into inventory (inventoryid, productid, quantityinstock, laststockupdate) values
(1, 1, 50, '2024-04-25'),
(2, 2, 100, '2024-04-24'),
(3, 3, 30, '2024-04-21'),
(4, 4, 20, '2024-04-05'),
(5, 5, 80, '2024-03-15'),
(6, 6, 10, '2024-01-03'),
(7, 7, 70, '2024-02-12'),
(8, 8, 40, '2024-02-18'),
(9, 9, 60, '2024-02-19'),
(10, 10, 25, '2024-04-25');

-- TASK 2
-- 1)Write an SQL query to retrieve the names and emails of all customers

select firstname, lastname, email from customers;

-- 2) Write an SQL query to list all orders with their order dates and corresponding customer names

select orders.orderdate, customers.firstname, customers.lastname
from orders inner join customers on orders.customerid = customers.customerid;

-- 3) Write an SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address

insert into customers (customerid, firstname, lastname, email, phone, address)
values (11, 'jemila', 'sharon', 'jemila@example.com','9876543310', 'brazil');

-- 4) Write an SQL query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%.

update products set price = price * 1.1;
select * from products ;

-- 5) Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.

delete from orderdetails where orderid = 2;
delete from orders where orderid = 2;

-- 6) Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, order date, and any other necessary information.

insert into orders  (orderid, customerid, orderdate, totalamount)
values (11,11, '2024-04-25', 345);

-- 7) Write an SQL query to update the contact information (e.g., email and address) of a specific customer in the "Customers" table. Allow users to input the customer ID and new contact information.

update customers set email = 'new@example.com', address = 'spain' where customerid = 11;

-- 8) Write an SQL query to recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table.

update orders
set totalamount = (select sum(od.quantity * p.price) from orderdetails od inner join products p on od.productid = p.productid
where od.orderid = orders.orderid);
    
-- 9) Write an SQL query to delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter

delete from orders where customerid = 11;
delete from orderdetails where orderid in (select orderid from orders where customerid = 11);

-- 10)  Write an SQL query to insert a new electronic gadget product into the "Products" table, including product name, category, price, and any other relevant details.

insert into products (productid, productname, description, price)
values (11, 'camera', 'caputring the moments', 999.99);

-- 11) Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status

alter table orders add column status varchar(50);
update orders set status ='pending';
update orders set status = 'shipped' where orderid = 10;
select * from orders;

-- 12) Write an SQL query to calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table.

alter table customers add column num_orders int;

update customers
set num_orders = (select count(*) from orders where orders.customerid = customers.customerid);

-- TASK 3
-- 1)	Write an SQL query to retrieve a list of all orders along with customer information (e.g., customer name) for each order.

select orders.*, customers.firstname, customers.lastname, customers.email, customers.address
from orders inner join customers on orders.customerid = customers.customerid;

-- 2) Write an SQL query to find the total revenue generated by each electronic gadget product. Include the product name and the total revenue.

select products.productname, sum(orderdetails.quantity * products.price) as total_revenue
from orderdetails inner join products on orderdetails.productid = products.productid
group by products.productname;

-- 3) Write an SQL query to list all customers who have made at least one purchase. Include their names and contact information.

select distinct customers.firstname, customers.lastname, customers.email, customers.address
from customers inner join  orderdetails on quantity>=1;

-- 4) Write an SQL query to find the most popular electronic gadget, which is the one with the highest total quantity ordered. Include the product name and the total quantity ordered.

select products.productname, sum(orderdetails.quantity) as total_quantity_ordered
from orderdetails inner join products on orderdetails.productid = products.productid
group by products.productname order by total_quantity_ordered desc limit 1;

-- 5) Write an SQL query to retrieve a list of electronic gadgets along with their corresponding  categories.

alter table products add column categoryname varchar(255);

update products
set categoryname = case 
    when productid = 1 then 'Gift'
    when productid = 2 then 'Communication'
    when productid = 3 then 'Laptops'
    when productid = 4 then 'Printers'
    when productid = 5 then 'Pc'
    when productid = 6 then 'Pc'
    when productid = 7 then 'Adapters'
    when productid = 8 then 'Music'
    when productid = 9 then 'Audio'
    when productid = 10 then 'Music'
    when productid = 11 then 'cameras'
    else null
end;

select productid, productname ,categoryname from products ;

-- 6) Write an SQL query to calculate the average order value for each customer. Include the customer's name and their average order value

select customers.firstname, customers.lastname, avg(orders.totalamount) as average_order_value
from customers inner join orders on customers.customerid = orders.customerid group by customers.customerid;

-- 7) Write an SQL query to find the order with the highest total revenue. Include the order ID, customer information, and the total revenue.

select orders.orderid, orders.totalamount, customers.firstname, customers.lastname, customers.email, customers.address
from orders join customers on orders.customerid = customers.customerid order by orders.totalamount desc limit 1;

-- 8) Write an SQL query to list electronic gadgets and the number of times each product has been ordered

select products.productname, count(orderdetails.orderid) as times_ordered
from products left join orderdetails on products.productid = orderdetails.productid group by products.productname;

-- 9) Write an SQL query to find customers who have purchased a specific electronic gadget product. Allow users to input the product name as a parameter

select customers.firstname, customers.lastname, customers.email, customers.address
from customers
inner join orders on customers.customerid = orders.customerid inner join orderdetails on orders.orderid = orderdetails.orderid
inner join products on orderdetails.productid = products.productid where products.productname = 'watch';

-- 10) Write an SQL query to calculate the total revenue generated by all orders placed within a specific time period. Allow users to input the start and end dates as parameters.

select sum(totalamount) as total_revenue
from orders where orderdate between '2024-01-01' and '2024-12-31';

-- TASK 4
-- 1) Write an SQL query to find out which customers have not placed any orders

select firstname, lastname, email, address from customers
where customerid not in (select distinct customerid from orders);

-- 2) Write an SQL query to find the total number of products available for sale

select count(*) as total_products_available from products;

-- 3) Write an SQL query to calculate the total revenue generated by TechShop

select sum(totalamount) as total_revenue_generated from orders;

-- 4) Write an SQL query to calculate the average quantity ordered for products in a specific category.  Allow users to input the category name as a parameter

select avg(od.quantity) as average_quantity_ordered
from orderdetails od inner join products p on od.productid = p.productid  where p.categoryname = 'pc';

-- 5) Write an SQL query to calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter.

select sum(o.totalamount) as total_revenue_generated
from orders o where o.customerid = 4;

-- 6) Write an SQL query to find the customers who have placed the most orders. List their names and the number of orders they've placed.

select c.firstname, c.lastname, count(o.orderid) as order_count, sum(od.quantity) as total_quantity_ordered
from customers c inner join orders o on c.customerid = o.customerid inner join orderdetails od on o.orderid = od.orderid
group by c.customerid order by total_quantity_ordered desc limit 1;

-- 7) Write an SQL query to find the most popular product category, which is the one with the highest total quantity ordered across all orders.

select p.categoryname, sum(od.quantity) as total_quantity_ordered
from orderdetails od inner join products p on od.productid = p.productid
group by p.productid order by total_quantity_ordered desc limit 1;

-- 8) Write an SQL query to find the customer who has spent the most money (highest total revenue) on electronic gadgets. List their name and total spending.

select c.firstname, c.lastname, sum(od.quantity * p.price) as total_spending from customers c
inner join orders o on c.customerid = o.customerid inner join orderdetails od on o.orderid = od.orderid inner join products p on od.productid = p.productid
group by c.customerid order by total_spending desc limit 1;


-- 9) Write an SQL query to calculate the average order value (total revenue divided by the number of orders) for all customers

select avg(totalamount) as average_order_value from orders;

-- 10) Write an SQL query to find the total number of orders placed by each customer and list their names along with the order count

select c.firstname, c.lastname, count(o.orderid) as order_count
from customers c left join orders o on c.customerid = o.customerid group by c.customerid;
