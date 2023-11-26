                                                                      QUERY PLAN                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=155587.85..155592.10 rows=100 width=84) (actual time=217.139..221.365 rows=100 loops=1)
   ->  GroupAggregate  (cost=155587.85..155597.58 rows=229 width=84) (actual time=217.138..221.327 rows=100 loops=1)
         Group Key: warehouse.w_state, item.i_item_id
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=155587.85..155589.57 rows=229 width=36) (actual time=217.077..220.218 rows=468 loops=1)
 Planning time: 1.157 ms
 Execution time: 228.910 ms
(6 rows)

