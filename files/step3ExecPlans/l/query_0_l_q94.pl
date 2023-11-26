                                                                      QUERY PLAN                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=88262.03..88262.04 rows=1 width=72) (actual time=594.764..594.765 rows=1 loops=1)
   ->  Sort  (cost=88262.03..88262.04 rows=1 width=72) (actual time=594.763..594.763 rows=1 loops=1)
         Sort Key: (count(DISTINCT ws1.ws_order_number))
         Sort Method: quicksort  Memory: 25kB
         ->  Aggregate  (cost=88262.01..88262.02 rows=1 width=72) (actual time=594.758..594.758 rows=1 loops=1)
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=2704.51..88262.00 rows=1 width=16) (actual time=536.074..594.723 rows=10 loops=1)
 Planning time: 1.091 ms
 Execution time: 601.253 ms
(8 rows)

SET
