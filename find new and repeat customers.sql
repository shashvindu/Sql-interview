
----find new and repeat customers
create table interview.customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
select * from interview.customer_orders
insert into interview.customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)


--- my solution
Select d.order_date, sum(d.tfsttime) tfsttime,sum(d.notfsttime) notfsttime,sum(d.torder_amount) as torder_amount,sum(d.notorder_amount) asnotorder_amount from
(Select c.order_date, sum(c.tfsttime) tfsttime, sum(c.notfsttime) as notfsttime,
case when c.tfsttime=1 then sum(c.order_amount) else 0 end as torder_amount,
case when c.notfsttime=1 then sum(c.order_amount) else 0 end as notorder_amount from 
(select a.order_date,case when b.fsttime=a.order_date then 1 else 0 end  tfsttime,
case when b.fsttime!=a.order_date then 1 else 0 end notfsttime, a.order_amount
from interview.customer_orders as a inner join 
(Select customer_id, min(order_date)  fsttime from interview.customer_orders group by customer_id) b 
 on a.customer_id=b.customer_id) c
 group by c.order_date,c.tfsttime,c.notfsttime) d
 group by d.order_date
