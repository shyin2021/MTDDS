                                                                                                         QUERY PLAN                                                                                                          
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=530484.42..530484.42 rows=1 width=80) (actual time=2356.782..2356.792 rows=100 loops=1)
   CTE all_sales
     ->  HashAggregate  (cost=524684.59..525932.98 rows=99871 width=60) (actual time=2350.105..2352.253 rows=7171 loops=1)
           Group Key: d_year, i_brand_id, i_class_id, i_category_id, i_manufact_id
           ->  HashAggregate  (cost=487233.08..497220.15 rows=998707 width=56) (actual time=1858.177..2071.617 rows=958594 loops=1)
                 Group Key: d_year, i_brand_id, i_class_id, i_category_id, i_manufact_id, ((cs_quantity - COALESCE(cr_return_quantity, 0))), ((cs_ext_sales_price - COALESCE(cr_return_amount, 0.0)))
                 ->  Append  (cost=18257.08..469755.71 rows=998707 width=56) (actual time=73.211..1055.594 rows=963118 loops=1)
                       ->  Remote Subquery Scan on all (dn1,dn2)  (cost=18257.08..145864.71 rows=285343 width=56) (actual time=73.210..295.459 rows=281670 loops=1)
                       ->  Remote Subquery Scan on all (dn1,dn2)  (cost=29250.93..238409.53 rows=570768 width=56) (actual time=116.190..521.999 rows=540080 loops=1)
                       ->  Remote Subquery Scan on all (dn1,dn2)  (cost=11527.53..75494.40 rows=142596 width=56) (actual time=56.500..187.264 rows=141368 loops=1)
   ->  Sort  (cost=4551.43..4551.44 rows=1 width=80) (actual time=2356.781..2356.785 rows=100 loops=1)
         Sort Key: ((curr_yr.sales_cnt - prev_yr.sales_cnt)), ((curr_yr.sales_amt - prev_yr.sales_amt))
         Sort Method: top-N heapsort  Memory: 48kB
         ->  Merge Join  (cost=4538.92..4551.42 rows=1 width=80) (actual time=2355.818..2356.643 rows=341 loops=1)
               Merge Cond: ((curr_yr.i_brand_id = prev_yr.i_brand_id) AND (curr_yr.i_class_id = prev_yr.i_class_id) AND (curr_yr.i_category_id = prev_yr.i_category_id) AND (curr_yr.i_manufact_id = prev_yr.i_manufact_id))
               Join Filter: (((curr_yr.sales_cnt)::numeric(17,2) / (prev_yr.sales_cnt)::numeric(17,2)) < 0.9)
               Rows Removed by Join Filter: 603
               ->  Sort  (cost=2269.46..2270.71 rows=499 width=60) (actual time=2354.140..2354.188 rows=1205 loops=1)
                     Sort Key: curr_yr.i_brand_id, curr_yr.i_class_id, curr_yr.i_category_id, curr_yr.i_manufact_id
                     Sort Method: quicksort  Memory: 155kB
                     ->  CTE Scan on all_sales curr_yr  (cost=0.00..2247.10 rows=499 width=60) (actual time=2350.114..2353.721 rows=1363 loops=1)
                           Filter: (d_year = 2000)
                           Rows Removed by Filter: 5808
               ->  Sort  (cost=2269.46..2270.71 rows=499 width=60) (actual time=1.663..1.703 rows=1109 loops=1)
                     Sort Key: prev_yr.i_brand_id, prev_yr.i_class_id, prev_yr.i_category_id, prev_yr.i_manufact_id
                     Sort Method: quicksort  Memory: 135kB
                     ->  CTE Scan on all_sales prev_yr  (cost=0.00..2247.10 rows=499 width=60) (actual time=0.002..0.446 rows=1110 loops=1)
                           Filter: (d_year = 1999)
                           Rows Removed by Filter: 6061
 Planning time: 1.839 ms
 Execution time: 2392.420 ms
(31 rows)

