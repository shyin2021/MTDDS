                                                                        QUERY PLAN                                                                         
-----------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=205342.86..205343.11 rows=100 width=91) (actual time=291.848..291.851 rows=31 loops=1)
   ->  Sort  (cost=205342.86..205344.36 rows=601 width=91) (actual time=291.847..291.848 rows=31 loops=1)
         Sort Key: dt.d_year, (sum(store_sales.ss_sales_price)) DESC, item.i_brand_id
         Sort Method: quicksort  Memory: 29kB
         ->  Finalize GroupAggregate  (cost=205239.67..205319.89 rows=601 width=91) (actual time=291.788..291.831 rows=31 loops=1)
               Group Key: dt.d_year, item.i_brand, item.i_brand_id
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=205239.67..205306.13 rows=500 width=91) (actual time=291.776..291.802 rows=31 loops=1)
 Planning time: 0.420 ms
 Execution time: 298.636 ms
(9 rows)

