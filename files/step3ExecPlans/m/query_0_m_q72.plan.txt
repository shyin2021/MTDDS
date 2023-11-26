                                                                         QUERY PLAN                                                                         
------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=369745.59..369745.60 rows=4 width=148) (actual time=11609.265..11609.273 rows=100 loops=1)
   ->  Sort  (cost=369745.59..369745.60 rows=4 width=148) (actual time=11609.264..11609.267 rows=100 loops=1)
         Sort Key: (count(*)) DESC, item.i_item_desc, warehouse.w_warehouse_name, d1.d_week_seq
         Sort Method: top-N heapsort  Memory: 47kB
         ->  GroupAggregate  (cost=369745.42..369745.55 rows=4 width=148) (actual time=11601.564..11608.005 rows=4428 loops=1)
               Group Key: item.i_item_desc, warehouse.w_warehouse_name, d1.d_week_seq
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=369745.42..369745.45 rows=4 width=128) (actual time=11601.558..11606.383 rows=4489 loops=1)
 Planning time: 11.445 ms
 Execution time: 11612.916 ms
(9 rows)

