                                                                      QUERY PLAN                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=247354.34..247358.34 rows=100 width=145) (actual time=623.933..625.707 rows=100 loops=1)
   ->  GroupAggregate  (cost=247354.34..247377.98 rows=591 width=145) (actual time=623.931..625.678 rows=100 loops=1)
         Group Key: item.i_item_id
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=247354.34..247358.77 rows=591 width=36) (actual time=623.897..624.832 rows=165 loops=1)
 Planning time: 0.492 ms
 Execution time: 650.226 ms
(6 rows)

