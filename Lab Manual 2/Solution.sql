Select * from Customers
--	Question 1
Select * from Customers where city = 'New York' order by cust_name

--	Question 2
Select * from Customers where cust_name like '%John%' and city in ('New York', 'London', 'Paris')

--	Question 3
Update Customers set grade = 500 where city in ('London', 'New York') returning *

--	Question 4
Delete from Orders where purch_amt > 500 returning *

--	Question 5
Select distinct city "Cities" from Customers 

--	Question 6
Select * from Salesman where name like '_a%'

--	Question 7
Update Salesman set commission = commission + 0.5 where city = 'San Jose' returning *

--	Question 8
Select  * from Orders order by ord_date desc

--	Question 9
Select Split_part(name, ' ', 1) "Firstname" from Salesman

--	Question 10
Select * from Orders where Extract(Month from ord_date) = 1
