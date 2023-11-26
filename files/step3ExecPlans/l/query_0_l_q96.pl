                                                                      QUERY PLAN                                                                       
-------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=203787.41..203787.41 rows=1 width=8) (actual time=302.258..302.259 rows=1 loops=1)
   ->  Sort  (cost=203787.41..203787.41 rows=1 width=8) (actual time=302.241..302.241 rows=1 loops=1)
         Sort Key: (count(*))
         Sort Method: quicksort  Memory: 25kB
         ->  Finalize Aggregate  (cost=203787.39..203787.40 rows=1 width=8) (actual time=302.235..302.235 rows=1 loops=1)
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=203787.16..203787.38 rows=2 width=8) (actual time=260.107..302.219 rows=3 loops=1)
 Planning time: 0.298 ms
 Execution time: 308.094 ms
(8 rows)

