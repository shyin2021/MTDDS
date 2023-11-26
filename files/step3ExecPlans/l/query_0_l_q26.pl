                                                                      QUERY PLAN                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=179513.06..179517.06 rows=100 width=145) (actual time=420.897..421.270 rows=100 loops=1)
   ->  GroupAggregate  (cost=179513.06..179525.22 rows=304 width=145) (actual time=420.896..421.261 rows=100 loops=1)
         Group Key: item.i_item_id
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=179513.06..179515.34 rows=304 width=36) (actual time=420.883..421.066 rows=136 loops=1)
 Planning time: 0.636 ms
 Execution time: 430.475 ms
(6 rows)

