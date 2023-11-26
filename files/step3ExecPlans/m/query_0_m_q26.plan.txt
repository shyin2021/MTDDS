                                                                    QUERY PLAN                                                                    
--------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=132927.83..132931.83 rows=100 width=145) (actual time=383.873..384.329 rows=100 loops=1)
   ->  GroupAggregate  (cost=132927.83..132935.91 rows=202 width=145) (actual time=383.872..384.320 rows=100 loops=1)
         Group Key: item.i_item_id
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=132927.83..132929.34 rows=202 width=36) (actual time=383.857..384.051 rows=139 loops=1)
 Planning time: 0.750 ms
 Execution time: 387.885 ms
(6 rows)

