                                                                      QUERY PLAN                                                                       
-------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=137695.85..137696.10 rows=100 width=91) (actual time=247.735..247.738 rows=31 loops=1)
   ->  Sort  (cost=137695.85..137696.86 rows=407 width=91) (actual time=247.734..247.735 rows=31 loops=1)
         Sort Key: dt.d_year, (sum(store_sales.ss_sales_price)) DESC, item.i_brand_id
         Sort Method: quicksort  Memory: 29kB
         ->  Finalize GroupAggregate  (cost=137625.76..137680.29 rows=407 width=91) (actual time=247.682..247.719 rows=31 loops=1)
               Group Key: dt.d_year, item.i_brand, item.i_brand_id
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=137625.76..137670.95 rows=340 width=91) (actual time=247.674..247.696 rows=31 loops=1)
 Planning time: 0.487 ms
 Execution time: 250.305 ms
(9 rows)

