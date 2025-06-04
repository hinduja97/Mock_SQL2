
-- Solution 1

select product_id, year as first_year, quantity, price
from (
    select s.product_id, s.year, s.quantity, s.price,
           DENSE_RANK() over (partition by product_id order by year) as rnk
    from sales s
) ranked
where rnk = 1;

-- Solution 2

select s.product_id,newtab.first_year,s.quantity,s.price
from (select product_id, min(year) as first_year
     from sales
     group by product_id) as newtab
join sales s
on newtab.product_id=s.product_id and newtab.first_year=s.year;
