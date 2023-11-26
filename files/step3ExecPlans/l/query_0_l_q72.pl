                                                                           QUERY PLAN                                                                           
----------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=574552.22..574552.24 rows=7 width=149) (actual time=26332.008..26332.017 rows=100 loops=1)
   ->  Sort  (cost=574552.22..574552.24 rows=7 width=149) (actual time=26332.007..26332.011 rows=100 loops=1)
         Sort Key: (count(*)) DESC, item.i_item_desc, warehouse.w_warehouse_name, d1.d_week_seq
         Sort Method: top-N heapsort  Memory: 50kB
         ->  Finalize GroupAggregate  (cost=574551.92..574552.12 rows=7 width=149) (actual time=26313.212..26328.937 rows=7675 loops=1)
               Group Key: item.i_item_desc, warehouse.w_warehouse_name, d1.d_week_seq
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=574551.92..574551.96 rows=6 width=149) (actual time=26313.206..26325.637 rows=7675 loops=1)
 Planning time: 11.764 ms
 Execution time: 26340.034 ms
(9 rows)

