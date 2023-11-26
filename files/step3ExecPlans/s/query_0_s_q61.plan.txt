                                                                   QUERY PLAN                                                                   
------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=10000142551.43..10000142551.43 rows=1 width=96) (actual time=30.208..30.208 rows=1 loops=1)
   ->  Sort  (cost=10000142551.43..10000142551.43 rows=1 width=96) (actual time=30.207..30.207 rows=1 loops=1)
         Sort Key: (sum(store_sales.ss_ext_sales_price)), (sum(store_sales_1.ss_ext_sales_price))
         Sort Method: quicksort  Memory: 25kB
         ->  Nested Loop  (cost=10000142551.36..10000142551.42 rows=1 width=96) (actual time=30.202..30.202 rows=1 loops=1)
               ->  Aggregate  (cost=71277.89..71277.90 rows=1 width=32) (actual time=4.547..4.547 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn0)  (cost=4425.23..71277.88 rows=1 width=6) (actual time=4.546..4.546 rows=0 loops=1)
               ->  Aggregate  (cost=71273.47..71273.48 rows=1 width=32) (actual time=25.653..25.653 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn0)  (cost=4420.81..71273.47 rows=1 width=6) (actual time=25.652..25.652 rows=0 loops=1)
 Planning time: 5.282 ms
 Execution time: 31.363 ms
(11 rows)

