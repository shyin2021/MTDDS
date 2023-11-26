                                                                   QUERY PLAN                                                                   
------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=140911.00..140911.01 rows=1 width=32) (actual time=924.863..924.863 rows=1 loops=1)
   ->  Aggregate  (cost=140911.00..140911.01 rows=1 width=32) (actual time=924.862..924.862 rows=1 loops=1)
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=5528.14..140910.99 rows=2 width=6) (actual time=924.827..924.836 rows=33 loops=1)
 Planning time: 0.521 ms
 Execution time: 935.033 ms
(5 rows)

