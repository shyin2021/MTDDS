                                                                                                QUERY PLAN                                                                                                 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=206545.13..206648.71 rows=100 width=1255) (actual time=361.900..361.982 rows=6 loops=1)
   ->  GroupAggregate  (cost=206545.13..206752.29 rows=200 width=1255) (actual time=361.899..361.981 rows=6 loops=1)
         Group Key: warehouse.w_warehouse_name, warehouse.w_warehouse_sq_ft, warehouse.w_city, warehouse.w_county, warehouse.w_state, warehouse.w_country, ('MSC,UPS'::text), date_dim.d_year
         ->  Sort  (cost=206545.13..206547.84 rows=1085 width=871) (actual time=361.868..361.868 rows=12 loops=1)
               Sort Key: warehouse.w_warehouse_name, warehouse.w_warehouse_sq_ft, warehouse.w_city, warehouse.w_county, warehouse.w_state, warehouse.w_country, ('MSC,UPS'::text), date_dim.d_year
               Sort Method: quicksort  Memory: 31kB
               ->  Append  (cost=69459.29..206490.43 rows=1085 width=871) (actual time=124.353..361.837 rows=12 loops=1)
                     ->  Finalize GroupAggregate  (cost=69459.29..69612.36 rows=362 width=871) (actual time=124.353..126.619 rows=6 loops=1)
                           Group Key: warehouse.w_warehouse_name, warehouse.w_warehouse_sq_ft, warehouse.w_city, warehouse.w_county, warehouse.w_state, warehouse.w_country, date_dim.d_year
                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=69459.29..69545.49 rows=302 width=839) (actual time=124.294..126.404 rows=18 loops=1)
                     ->  Finalize GroupAggregate  (cost=136562.01..136867.22 rows=723 width=871) (actual time=230.738..235.215 rows=6 loops=1)
                           Group Key: warehouse_1.w_warehouse_name, warehouse_1.w_warehouse_sq_ft, warehouse_1.w_city, warehouse_1.w_county, warehouse_1.w_state, warehouse_1.w_country, date_dim_1.d_year
                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=136562.01..136733.84 rows=602 width=839) (actual time=230.682..235.037 rows=18 loops=1)
 Planning time: 3.229 ms
 Execution time: 373.663 ms
(15 rows)

