                                                                 QUERY PLAN                                                                 
--------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=24158.05..24158.06 rows=1 width=32) (actual time=109.018..109.019 rows=1 loops=1)
   ->  Sort  (cost=24158.05..24158.06 rows=1 width=32) (actual time=109.017..109.017 rows=1 loops=1)
         Sort Key: (sum(web_sales.ws_ext_discount_amt))
         Sort Method: quicksort  Memory: 25kB
         ->  Aggregate  (cost=24158.03..24158.04 rows=1 width=32) (actual time=109.010..109.010 rows=1 loops=1)
               ->  Remote Subquery Scan on all (dn0)  (cost=1518.67..24158.03 rows=1 width=6) (actual time=109.007..109.007 rows=0 loops=1)
 Planning time: 1.851 ms
 Execution time: 110.127 ms
(8 rows)

