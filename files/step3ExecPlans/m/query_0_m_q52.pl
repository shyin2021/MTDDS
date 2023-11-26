                                                                      QUERY PLAN                                                                       
-------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=136030.62..136030.71 rows=39 width=91) (actual time=250.152..250.172 rows=100 loops=1)
   ->  Sort  (cost=136030.62..136030.71 rows=39 width=91) (actual time=250.151..250.155 rows=100 loops=1)
         Sort Key: (sum(store_sales.ss_ext_sales_price)) DESC, item.i_brand_id
         Sort Method: quicksort  Memory: 46kB
         ->  Finalize GroupAggregate  (cost=136024.44..136029.58 rows=39 width=91) (actual time=249.679..250.018 rows=151 loops=1)
               Group Key: dt.d_year, item.i_brand, item.i_brand_id
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=136024.44..136028.70 rows=32 width=91) (actual time=249.664..249.875 rows=173 loops=1)
 Planning time: 0.334 ms
 Execution time: 253.195 ms
(9 rows)

