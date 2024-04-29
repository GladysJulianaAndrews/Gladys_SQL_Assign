drop database if exists HMBank;

-- TASK 1
-- 1. Create the database named "HMBank"
create database HMBank;
use HMBank;

-- 2. Define the schema for the Customers, Accounts, and Transactions tables based on the provided schema.
-- 5. Create appropriate Primary Key and Foreign Key constraints for referential integrity.
-- 6. Write SQL scripts to create the mentioned tables with appropriate data types, constraints, and relationships.

drop table if exists customers;

create table customers (
    customer_id int primary key,
    first_name varchar (50),
    last_name varchar(50),
    dob date,
    email varchar(50),
    phone_number varchar(20),
    address text);

drop table if exists accounts;

create table accounts (
    account_id int primary key,
    customer_id int,
    account_type varchar(50),
    balance numeric(10, 2),
    foreign key (customer_id) references customers(customer_id));

drop table if exists transactions;

create table transactions (
    transaction_id int primary key,
    account_id int,
    transaction_type varchar(50),
    amount numeric(10, 2),
    transaction_date date,
    foreign key (account_id) references accounts(account_id));
    
-- TASK 2
-- 1. Insert at least 10 sample records into each of the following tables.

-- Inserting sample records into Customers table
insert into customers (customer_id, first_name, last_name, dob, email, phone_number, address) values
(1, 'John', 'Doe', '1990-05-15', 'john@example.com', '1234567890', 'usa'),
(2, 'Jane', 'Smith', '1985-08-20', 'jane@example.com', '9876543210', 'usa'),
(3, 'Alice', 'Johnson', '1988-12-10', 'alice@example.com', '4567890123', 'uk'),
(4, 'Bob', 'Brown', '1976-03-25', 'bob@example.com', '7890123456', 'france'),
(5, 'Emily', 'Davis', '1995-09-03', 'emily@example.com', '8901234567', 'germany'),
(6, 'Michael', 'Wilson', '1982-06-18', 'michael@example.com', '9012345678', 'uk'),
(7, 'Sarah', 'M ', '1992-11-30', 'sarah@example.com', '1237894560', 'brazil'),
(8, 'David', 'Taylor', '1980-04-12', 'david@example.com', '2345678901', 'france'),
(9, 'Olivia', 'Thomas', '1987-07-22', 'olivia@example.com', '3456789012', 'germany'),
(10, 'Daniel', 'Anderson', '1993-01-08', 'daniel@example.com', '4567890123', 'india');

-- Inserting sample records into Accounts table
insert into accounts (account_id, customer_id, account_type, balance) values
(101, 1, 'savings', 5000.00),
(102, 2, 'current', 10000.00),
(103, 3, 'savings', 3000.00),
(104, 4, 'current', 7000.00),
(105, 5, 'savings', 6000.00),
(106, 6, 'current', 12000.00),
(107, 7, 'savings', 2000.00),
(108, 8, 'current', 9000.00),
(109, 9, 'savings', 4000.00),
(110, 10, 'current', 11000.00);

-- Inserting sample records into Transactions table
insert into transactions (transaction_id, account_id, transaction_type, amount, transaction_date) values
(1001, 101, 'deposit', 1000.00, '2024-04-01'),
(1002, 102, 'withdrawal', 500.00, '2024-04-02'),
(1003, 103, 'deposit', 700.00, '2024-04-03'),
(1004, 104, 'withdrawal', 300.00, '2024-04-04'),
(1005, 105, 'deposit', 200.00, '2024-04-05'),
(1006, 106, 'withdrawal', 1000.00, '2024-04-06'),
(1007, 107, 'deposit', 150.00, '2024-04-07'),
(1008, 108, 'withdrawal', 200.00, '2024-04-08'),
(1009, 109, 'deposit', 300.00, '2024-04-01'),
(1010, 110, 'withdrawal', 400.00, '2024-04-10');

-- 1. Retrieve name, account type, and email of all customers

select first_name, last_name, account_type, email from customers
inner join accounts on customers.customer_id = accounts.customer_id;

-- 2. List all transactions corresponding to customers

select * from transactions
inner join accounts on transactions.account_id = accounts.account_id
inner join customers on accounts.customer_id = customers.customer_id;

-- 3. Increase balance of a specific account by a certain amount

update accounts set balance = balance + 100 where account_id = 101;

-- 4. Combine first and last names of customers as full_name

select concat(first_name, ' ', last_name) as full_name from customers;

-- 5. Remove accounts with zero balance and account type savings
delete from accounts where balance = 0 and account_type = 'savings';

-- 6. Find customers living in a specific city

select * from customers where address = 'germany';

-- 7. Get account balance for a specific account

select balance from accounts where account_id = 101;

-- 8. List all current accounts with balance greater than $1,000

select * from accounts where account_type = 'current' and balance > 1000;

-- 9. Retrieve all transactions for a specific account

select * from transactions where account_id = 101;

-- 10. Calculate interest accrued on savings accounts based on a given interest rate

select account_id, balance * 0.05 as interest_accrued  from accounts  where account_type = 'savings';

-- 11. Identify accounts where balance is less than specified overdraft limit

select * from accounts where balance < 200;

-- 12. Find customers not living in a specific city

select * from customers where address not like 'brazil';

-- TASK 3
-- -- 1. Find the average account balance for all customers

select avg(balance) as average_balance from accounts;

-- 2. Retrieve the top 10 highest account balances

select * from accounts order by balance desc limit 10;

-- 3. Calculate Total Deposits for All Customers on a specific date

select sum(amount) as total_deposits from transactions where transaction_type = 'deposit' and transaction_date = '2024-04-01';

-- 4. Find the Oldest and Newest Customers

select * from customers where dob = (select min(dob) from customers) or dob = (select max(dob) from customers);

-- 5. Retrieve transaction details along with the account type

select t.*, a.account_type from transactions t inner join accounts a on t.account_id = a.account_id;

-- 6. Get a list of customers along with their account details

select c.*, a.* from customers c inner join accounts a on c.customer_id = a.customer_id;

-- 7. Retrieve transaction details along with customer information for a specific account

select t.*, c.* from transactions t inner join accounts a on t.account_id = a.account_id inner join customers c on a.customer_id = c.customer_id 
where t.account_id = '101';

-- 8. Identify customers who have more than one account

select customer_id from accounts group by customer_id having count(*) > 1;

-- 9. Calculate the difference in transaction amounts between deposits and withdrawals

select account_id, sum(case when transaction_type = 'deposit' then amount else 0 end) as total_deposits,
sum(case when transaction_type = 'withdrawal' then amount else 0 end) as total_withdrawals,
sum(case when transaction_type = 'deposit' then amount else -amount end) as net_difference from transactions group by account_id;

-- 10. Calculate the average daily balance for each account over a specified period

select account_id, avg(balance) as average_daily_balance from accounts group by account_id;

-- 11. Calculate the total balance for each account type

select account_type, sum(balance) as total_balance from accounts group by account_type;

-- 12. Identify accounts with the highest number of transactions ordered by descending order

select account_id, count(*) as num_transactions from transactions group by account_id order by num_transactions desc;

-- 13. List customers with high aggregate account balances, along with their account types

select c.*, sum(a.balance) as aggregate_balance from customers c inner join accounts a on c.customer_id = a.customer_id
group by c.customer_id order by aggregate_balance desc;

-- 14. Identify and list duplicate transactions based on transaction amount, date, and account

select * from transactions where (amount, transaction_date, account_id) in (select amount, transaction_date, account_id
from transactions group by amount, transaction_date, account_id having count(*) > 1);

-- TASK 4
-- 1. Retrieve the customer(s) with the highest account balance

select c.*, a.balance from customers c inner join accounts a on c.customer_id = a.customer_id 
where a.balance = (select max(balance) from accounts);

-- 2. Calculate the average account balance for customers who have more than one account

select avg(balance) as average_balance from (select customer_id, count(*) as num_accounts 
from accounts group by customer_id having num_accounts > 1) as multiple_accounts
inner join accounts on multiple_accounts.customer_id = accounts.customer_id;

-- 3. Retrieve accounts with transactions whose amounts exceed the average transaction amount

select distinct account_id from transactions where amount > (select avg(amount) from transactions);

-- 4. Identify customers who have no recorded transactions

select * from customers where customer_id not in (select distinct customer_id from transactions);

-- 5. Calculate the total balance of accounts with no recorded transactions

select sum(balance) as total_balance from accounts
where account_id not in (select distinct account_id from transactions);

-- 6. Retrieve transactions for accounts with the lowest balance

select t.* from transactions t inner join accounts a on t.account_id = a.account_id
where a.balance = (select min(balance) from accounts);

-- 7. Identify customers who have accounts of multiple types

select customer_id from accounts group by customer_id having count(distinct account_type) > 1;

-- 8. Calculate the percentage of each account type out of the total number of accounts

select account_type, count(*) * 100.0 / (select count(*) from accounts) as percentage
from accounts group by account_type;

-- 9. Retrieve all transactions for a customer with a given customer_id

select t.* from transactions t inner join accounts a on t.account_id = a.account_id
where a.customer_id = '7';

-- 10. Calculate the total balance for each account type, including a subquery within the SELECT clause

select account_type, (select sum(balance) from accounts where account_type = a.account_type) as total_balance
from accounts a group by account_type;
