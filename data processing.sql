use brightcoffeeshopdataset.coffee_shop

--- check my Data/table
select * 
from brightcoffeeshopdataset.coffee_shop.coffee_shop_sales
limit 100;

---calculate total amount of revenue for each product category

SELECT
    product_category,
    SUM(transaction_qty * unit_price) AS total_revenue
FROM brightcoffeeshopdataset.coffee_shop.coffee_shop_sales
GROUP BY product_category
ORDER BY total_revenue DESC;

--- check how many sotres/names 
select distinct store_location
from brightcoffeeshopdataset.coffee_shop.coffee_shop_sales;

---period of this data
SELECT
    MIN(transaction_date) AS start_date,
    MAX(transaction_date) AS last_date
FROM brightcoffeeshopdataset.coffee_shop.coffee_shop_sales;

---check opareting times 
select min(transaction_time) AS opening_time,
       max(transaction_time) AS closing_time
 from brightcoffeeshopdataset.coffee_shop.coffee_shop_sales;  

 ---check how many products we have/selling 
select store_location,
count(distinct product_id) AS number_of_products
from brightcoffeeshopdataset.coffee_shop.coffee_shop_sales
group by store_location
order by number_of_products desc;   

---what are the different product categories?
select distinct product_category
from brightcoffeeshopdataset.coffee_shop.coffee_shop_sales;


---what are the different product types? in detail
           
select distinct product_detail,product_type
from brightcoffeeshopdataset.coffee_shop.coffee_shop_sales
where product_category = 'Coffee'
order by product_type;

----BIG CODE 
Select 
      transaction_date,transaction_time,---from original table
      dayname(transaction_date) as day_name,---extract the day of week will be a new column
      monthname(transaction_date) as month_name,---extract the name of a month will be a new column
      COUNT(transaction_id) AS number_of_sales,---counting all the new rows will be a new column
     SUM(transaction_qty) AS units_sold, ---calculating the total units sold will be a new column
     COUNT(DISTINCT product_id) AS unique_products,---counting the number of unique products will be a new column
     COUNT(store_id) AS number_of_stores,---counting the number of stores will be a new column
     SUM(transaction_qty * unit_price) AS revenue,---calculating the total revenue will be a new column
     
    CASE 
        WHEN DAYNAME(transaction_date) IN ('Sat','Sun') THEN 'Weekend'---creating a new column based on the day of the week
        WHEN DAYNAME(transaction_date) IN ('Mon','Tue','Wed','Thur','Fri') THEN 'Weekday'---creating a new column based on the day of the week
    END AS day_classification,

    CASE 
        WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'---creating a new column based on the time of day
        
        WHEN transaction_time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'---creating a new column based on the time of day 
        WHEN transaction_time BETWEEN '18:00:00' AND '20:59:59' THEN 'Evening'---creating a new column based on the time of day
    END AS time_classification,  

    store_location,---where the store is at but keeping the original columns
    product_category,---group of products but keeping the original columns
    product_type,---type of product but keeping the original columns
    product_detail---description keeping but keeping the original columns

FROM brightcoffeeshopdataset.coffee_shop.coffee_shop_sales

GROUP BY 
    transaction_date,
    day_name,
    month_name,
    day_classification,
    time_classification,
    store_location,
    product_category,
    product_type,
    product_detail,
    transaction_time

ORDER BY
    transaction_time;
    



SELECT
    product_type,
    HOUR(transaction_time) AS sales_hour,
    SUM(transaction_qty * unit_price) AS total_revenue
FROM brightcoffeeshopdataset.coffee_shop.coffee_shop_sales
GROUP BY
    product_type,
    HOUR(transaction_time)
ORDER BY
    sales_hour,
    total_revenue DESC;


SELECT
    product_type,
    transaction_time,
    SUM(transaction_qty * unit_price) AS total_revenue
FROM  brightcoffeeshopdataset.coffee_shop.coffee_shop_sales
GROUP BY
    product_type,
    transaction_time
ORDER BY
    transaction_time,
    total_revenue DESC;
