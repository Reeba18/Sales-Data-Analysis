-- Change USD transactions to INR
select distinct(currency) from  sales.transactions;
select * from sales.transactions where currency='USD'; -- number of USD transactions

-- Number of transactions in 2020
Use sales;
select distinct(currency)  from transactions t join 
date d on t.order_date= d.date
where year =2020;

-- Calculate the revenue in 2020 from Chennai
select sum(sales_amount) as 'Total Revenue in INR' from transactions t join 
date d on t.order_date= d.date
where year =2020 and market_code = (select markets_code from markets where markets_name='Chennai') ;

-- Calculate the total revenue from each zone in 2020
select zone,sum(sales_amount) as 'Total Revenue in INR' from transactions t join 
date d on t.order_date= d.date join markets m on t.market_code=m.markets_code
where year =2020 group by zone order by sum(sales_amount) desc;

-- Find the top 5 customers in each zone
With x as
(select zone,custmer_name,sum(sales_amount) as 'Total Revenue in INR' ,rank() over(partition by zone order by sum(sales_amount) desc) as 'Ranking'
from transactions t join 
date d on t.order_date= d.date join markets m on t.market_code=m.markets_code join customers c on c.customer_code=t.customer_code
where year =2020 
group by zone,custmer_name 
order by zone asc)
select * from x where Ranking <=5;

-- Rank the markets based on revenue generated in 2020
select markets_name,sum(sales_amount) as 'Total Sales Amount',rank() over(order by sum(sales_amount) desc) as 'Ranking'
from markets m join transactions t on t.market_code=m.markets_code join date d on t.order_date=d.date
where year ='2020'
group by markets_name;







