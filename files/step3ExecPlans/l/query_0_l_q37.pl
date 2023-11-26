                                                                      QUERY PLAN                                                                       
-------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=481266.41..481266.51 rows=4 width=125) (actual time=12546.418..12546.418 rows=1 loops=1)
   ->  Finalize GroupAggregate  (cost=481266.41..481266.51 rows=4 width=125) (actual time=12546.417..12546.417 rows=1 loops=1)
         Group Key: item.i_item_id, item.i_item_desc, item.i_current_price
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=481266.41..481266.44 rows=4 width=125) (actual time=12546.413..12546.413 rows=1 loops=1)
 Planning time: 1.977 ms
 Execution time: 12570.079 ms
(6 rows)

