-- Checking for USD transactions and transforming them
select distinct(currency) from transactions;
-- 'INR','INR\r','USD','USD\r'

select count(*) from transactions where currency ='INR\r';  -- 150000
select count(*) from transactions where currency ='INR';  -- 279
select * from transactions where currency LIKE 'USD%';  
-- most transactions have the currency 'INR\r' and 'USD\r'

with x as (select * from transactions where currency NOT IN ('USD','INR')) -- to not conside duplicate rows
select product_code,customer_code,market_code,order_date,sales_qty,sales_amount,currency,
case 
when currency = 'USD\r' then sales_amount * 81
when currency = 'INR\r' then sales_amount
end as 'normalisedSalesAmount'
from x;



-- Checking for sales_amount
select * from transactions where sales_amount<=0;

