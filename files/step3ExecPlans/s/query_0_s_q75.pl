                                                                                                         QUERY PLAN                                                                                                         
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=262171.87..262171.88 rows=1 width=80) (actual time=1568.462..1568.471 rows=100 loops=1)
   CTE all_sales
     ->  HashAggregate  (cost=259262.97..259886.91 rows=49915 width=60) (actual time=1564.887..1566.349 rows=5161 loops=1)
           Group Key: d_year, i_brand_id, i_class_id, i_category_id, i_manufact_id
           ->  HashAggregate  (cost=240544.77..245536.29 rows=499152 width=56) (actual time=1332.407..1433.937 rows=484968 loops=1)
                 Group Key: d_year, i_brand_id, i_class_id, i_category_id, i_manufact_id, ((cs_quantity - COALESCE(cr_return_quantity, 0))), ((cs_ext_sales_price - COALESCE(cr_return_amount, 0.0)))
                 ->  Append  (cost=8086.98..231809.61 rows=499152 width=56) (actual time=53.784..1007.229 rows=486567 loops=1)
                       ->  Remote Subquery Scan on all (dn0)  (cost=8086.98..71954.30 rows=142725 width=56) (actual time=53.784..313.255 rows=141880 loops=1)
                       ->  Remote Subquery Scan on all (dn0)  (cost=13587.15..118162.87 rows=285208 width=56) (actual time=80.209..511.722 rows=273040 loops=1)
                       ->  Remote Subquery Scan on all (dn0)  (cost=4729.38..36700.92 rows=71219 width=56) (actual time=37.690..161.079 rows=71647 loops=1)
   ->  Sort  (cost=2284.97..2284.97 rows=1 width=80) (actual time=1568.461..1568.464 rows=100 loops=1)
         Sort Key: ((curr_yr.sales_cnt - prev_yr.sales_cnt)), ((curr_yr.sales_amt - prev_yr.sales_amt))
         Sort Method: quicksort  Memory: 44kB
         ->  Hash Join  (cost=1128.09..2284.95 rows=1 width=80) (actual time=1567.743..1568.425 rows=141 loops=1)
               Hash Cond: ((curr_yr.i_brand_id = prev_yr.i_brand_id) AND (curr_yr.i_class_id = prev_yr.i_class_id) AND (curr_yr.i_category_id = prev_yr.i_category_id) AND (curr_yr.i_manufact_id = prev_yr.i_manufact_id))
               Join Filter: (((curr_yr.sales_cnt)::numeric(17,2) / (prev_yr.sales_cnt)::numeric(17,2)) < 0.9)
               Rows Removed by Join Filter: 454
               ->  CTE Scan on all_sales curr_yr  (cost=0.00..1123.09 rows=250 width=60) (actual time=1564.895..1565.183 rows=885 loops=1)
                     Filter: (d_year = 2002)
                     Rows Removed by Filter: 4276
               ->  Hash  (cost=1123.09..1123.09 rows=250 width=60) (actual time=2.825..2.825 rows=872 loops=1)
                     Buckets: 1024  Batches: 1  Memory Usage: 73kB
                     ->  CTE Scan on all_sales prev_yr  (cost=0.00..1123.09 rows=250 width=60) (actual time=0.001..2.656 rows=873 loops=1)
                           Filter: (d_year = 2001)
                           Rows Removed by Filter: 4288
 Planning time: 1.667 ms
 Execution time: 1575.389 ms
(27 rows)

