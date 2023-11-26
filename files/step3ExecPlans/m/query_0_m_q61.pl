                                                                      QUERY PLAN                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=10000291031.84..10000291031.85 rows=1 width=96) (actual time=2.338..2.338 rows=1 loops=1)
   ->  Sort  (cost=10000291031.84..10000291031.85 rows=1 width=96) (actual time=2.337..2.337 rows=1 loops=1)
         Sort Key: (sum(store_sales.ss_ext_sales_price)), (sum(store_sales_1.ss_ext_sales_price))
         Sort Method: quicksort  Memory: 25kB
         ->  Nested Loop  (cost=10000291031.77..10000291031.83 rows=1 width=96) (actual time=2.328..2.328 rows=1 loops=1)
               ->  Aggregate  (cost=145524.23..145524.24 rows=1 width=32) (actual time=1.565..1.565 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn1,dn2)  (cost=11824.31..145524.23 rows=2 width=6) (actual time=1.562..1.562 rows=0 loops=1)
               ->  Finalize Aggregate  (cost=145507.54..145507.55 rows=1 width=32) (actual time=0.759..0.760 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn1,dn2)  (cost=145507.31..145507.53 rows=2 width=32) (actual time=0.601..0.754 rows=2 loops=1)
 Planning time: 2.143 ms
 Execution time: 10.143 ms
(11 rows)

