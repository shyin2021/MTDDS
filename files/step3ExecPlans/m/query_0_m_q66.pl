                                                                                                QUERY PLAN                                                                                                 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=138829.47..138901.83 rows=100 width=1254) (actual time=332.703..332.767 rows=5 loops=1)
   ->  GroupAggregate  (cost=138829.47..138974.19 rows=200 width=1254) (actual time=332.702..332.766 rows=5 loops=1)
         Group Key: warehouse.w_warehouse_name, warehouse.w_warehouse_sq_ft, warehouse.w_city, warehouse.w_county, warehouse.w_state, warehouse.w_country, ('DHL,BARIAN'::text), date_dim.d_year
         ->  Sort  (cost=138829.47..138831.28 rows=723 width=870) (actual time=332.671..332.672 rows=10 loops=1)
               Sort Key: warehouse.w_warehouse_name, warehouse.w_warehouse_sq_ft, warehouse.w_city, warehouse.w_county, warehouse.w_state, warehouse.w_country, ('DHL,BARIAN'::text), date_dim.d_year
               Sort Method: quicksort  Memory: 30kB
               ->  Append  (cost=46849.72..138795.14 rows=723 width=870) (actual time=118.178..332.649 rows=10 loops=1)
                     ->  Finalize GroupAggregate  (cost=46849.72..46951.17 rows=241 width=870) (actual time=118.178..119.347 rows=5 loops=1)
                           Group Key: warehouse.w_warehouse_name, warehouse.w_warehouse_sq_ft, warehouse.w_city, warehouse.w_county, warehouse.w_state, warehouse.w_country, date_dim.d_year
                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=46849.72..46906.80 rows=200 width=838) (actual time=117.989..119.091 rows=10 loops=1)
                     ->  Finalize GroupAggregate  (cost=91632.98..91836.74 rows=482 width=870) (actual time=210.567..213.299 rows=5 loops=1)
                           Group Key: warehouse_1.w_warehouse_name, warehouse_1.w_warehouse_sq_ft, warehouse_1.w_city, warehouse_1.w_county, warehouse_1.w_state, warehouse_1.w_country, date_dim_1.d_year
                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=91632.98..91747.72 rows=402 width=838) (actual time=210.496..213.136 rows=10 loops=1)
 Planning time: 2.044 ms
 Execution time: 337.544 ms
(15 rows)

