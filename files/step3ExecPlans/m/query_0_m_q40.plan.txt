                                                                    QUERY PLAN                                                                    
--------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=104757.43..104761.68 rows=100 width=84) (actual time=175.942..176.713 rows=100 loops=1)
   ->  GroupAggregate  (cost=104757.43..104763.43 rows=141 width=84) (actual time=175.941..176.691 rows=100 loops=1)
         Group Key: warehouse.w_state, item.i_item_id
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=104757.43..104758.49 rows=141 width=36) (actual time=175.927..176.449 rows=439 loops=1)
 Planning time: 1.079 ms
 Execution time: 180.446 ms
(6 rows)

