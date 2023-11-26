                                                                      QUERY PLAN                                                                       
-------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=552272.73..552274.50 rows=71 width=125) (actual time=1673.248..1673.286 rows=34 loops=1)
   ->  Finalize GroupAggregate  (cost=552272.73..552274.50 rows=71 width=125) (actual time=1673.247..1673.283 rows=34 loops=1)
         Group Key: item.i_item_id, item.i_item_desc, item.i_current_price
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=552272.73..552273.26 rows=71 width=125) (actual time=1673.241..1673.270 rows=34 loops=1)
 Planning time: 0.699 ms
 Execution time: 1683.731 ms
(6 rows)

