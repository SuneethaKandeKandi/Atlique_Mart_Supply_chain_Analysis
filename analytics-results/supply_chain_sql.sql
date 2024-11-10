create database supplychain;
show tables;

select * from dim_customers;
select * from dim_date;
select * from dim_products;
select * from dim_targets_orders;
select * from fact_order_lines;
select * from fact_orders_aggregate;

alter table fact_orders_aggregate rename column ï»¿order_id to order_id;
alter table dim_date rename column `ï»¿date` to `date`;

#Total Order Lines -> Count of all order lines in fact_orders table

select count(order_id) as `Total order Lines` from fact_order_lines;

# 2. Line Fill Rate	(LIFR %	) Number of order lines shipped In Full Quantity / Total Order Lines
select * from fact_order_lines;
SELECT order_id,customer_id,
       concat(round((COUNT((CASE WHEN `In Full` = 1 THEN 1 END)) / COUNT(order_id)) * 100 ,0),'%') AS Line_Fill_Rate
FROM fact_order_lines
GROUP BY order_id,customer_id;

# 3. Volume Fill Rate(VOFR %)	Total Quantity shipped / Total Quantity Ordered

select * from fact_order_lines;
SELECT order_id,customer_id,product_id,order_qty,delivery_qty,
       concat(round((delivery_qty  / order_qty) *100 ,0),'%') AS Volume_Fill_Rate
FROM fact_order_lines;

# Total Orders by customer

select * from fact_order_lines;

select  order_id from  fact_order_lines group by order_id;

SELECT customer_id, COUNT(DISTINCT order_id) AS Total_orders
FROM fact_order_lines group by customer_id order by total_orders desc;

#5. On Time Delivery(OT %) Number of orders delivered On Time / Total Number of Orders

select * from fact_orders_aggregate;

select concat((count(case when on_time = 1 then 1 end)/count(order_id))*100,'%') as `On Time Delivery(OT %)`
from fact_orders_aggregate;

#6	In Full Delivery %	IF %	Number of orders delivered in Full quantity / Total Number of Orders

select * from fact_orders_aggregate;

select concat((count(case when in_full = 1 then 1 end)/count(order_id))*100,'%') as `In Full Delivery %`
from fact_orders_aggregate ;

select count(case when in_full = 1 then 1 end),count(order_id)
from fact_orders_aggregate ;

#7	On Time In Full %	OTIF %	Number of orders delivered both IN Full & On Time / Total Number of Orders

select * from fact_orders_aggregate;

select concat((count(case when in_full = 1 and on_time = 1 then 1 end)/count(order_id))*100,'%') as `In Full Delivery %`
from fact_orders_aggregate ;

select count(case when in_full = 1 and on_time=1  then 1 end),count(order_id)
from fact_orders_aggregate ;

#8	On Time Target - Average of On-Time Target 

select * from dim_targets_orders;

select round(avg(`ontime_target%`),2) as  `Average of On-Time Target`  from dim_targets_orders;

# 9. Average of In-Full Target

select round(avg(`infull_target%`),2) as  `Average of In-Full  Target`  from dim_targets_orders;

# 10 . Average of OTIF Target

select round(avg(`otif_target%`),2) as  ` Average of OTIF Target`  from dim_targets_orders;



show tables;
select * from dim_products;
select distinct(category) from dim_products;

show tables;
select * from dim_customers;
select distinct(city) from dim_customers;


show tables;
select * from dim_targets_orders;

show tables;
select * from fact_order_lines;
select distinct(city) from dim_customers;





