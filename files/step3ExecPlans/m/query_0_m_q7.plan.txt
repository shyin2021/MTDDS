                                                                    QUERY PLAN                                                                    
--------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=178199.58..178203.58 rows=100 width=145) (actual time=551.861..552.391 rows=100 loops=1)
   ->  GroupAggregate  (cost=178199.58..178215.54 rows=399 width=145) (actual time=551.860..552.383 rows=100 loops=1)
         Group Key: item.i_item_id
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=178199.58..178202.57 rows=399 width=36) (actual time=551.848..552.109 rows=158 loops=1)
 Planning time: 0.592 ms
 Execution time: 555.013 ms
(6 rows)

