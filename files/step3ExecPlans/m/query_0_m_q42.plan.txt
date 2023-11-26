                                                                      QUERY PLAN                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=136030.62..136030.71 rows=39 width=91) (actual time=257.214..257.215 rows=10 loops=1)
   ->  Sort  (cost=136030.62..136030.71 rows=39 width=91) (actual time=257.213..257.214 rows=10 loops=1)
         Sort Key: (sum(store_sales.ss_ext_sales_price)) DESC, item.i_category_id, item.i_category
         Sort Method: quicksort  Memory: 26kB
         ->  Finalize GroupAggregate  (cost=136024.44..136029.58 rows=39 width=91) (actual time=257.166..257.188 rows=10 loops=1)
               Group Key: dt.d_year, item.i_category_id, item.i_category
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=136024.44..136028.70 rows=32 width=91) (actual time=257.155..257.167 rows=20 loops=1)
 Planning time: 0.374 ms
 Execution time: 259.824 ms
(9 rows)

