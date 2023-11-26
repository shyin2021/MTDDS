                                                                        QUERY PLAN                                                                        
----------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=10000432079.76..10000432079.76 rows=1 width=96) (actual time=2.266..2.266 rows=1 loops=1)
   ->  Sort  (cost=10000432079.76..10000432079.76 rows=1 width=96) (actual time=2.265..2.265 rows=1 loops=1)
         Sort Key: (sum(store_sales.ss_ext_sales_price)), (sum(store_sales_1.ss_ext_sales_price))
         Sort Method: quicksort  Memory: 25kB
         ->  Nested Loop  (cost=10000432079.69..10000432079.75 rows=1 width=96) (actual time=2.256..2.256 rows=1 loops=1)
               ->  Finalize Aggregate  (cost=216048.45..216048.46 rows=1 width=32) (actual time=1.676..1.676 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=216048.22..216048.44 rows=2 width=32) (actual time=0.620..1.665 rows=3 loops=1)
               ->  Finalize Aggregate  (cost=216031.24..216031.25 rows=1 width=32) (actual time=0.578..0.578 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=216031.01..216031.23 rows=2 width=32) (actual time=0.499..0.572 rows=3 loops=1)
 Planning time: 2.066 ms
 Execution time: 11.040 ms
(11 rows)

