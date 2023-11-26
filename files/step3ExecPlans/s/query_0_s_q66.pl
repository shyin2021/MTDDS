                                                                                                  QUERY PLAN                                                                                                   
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=73413.84..73417.11 rows=12 width=1254) (actual time=350.644..350.706 rows=5 loops=1)
   ->  GroupAggregate  (cost=73413.84..73417.11 rows=12 width=1254) (actual time=350.643..350.705 rows=5 loops=1)
         Group Key: warehouse.w_warehouse_name, warehouse.w_warehouse_sq_ft, warehouse.w_city, warehouse.w_county, warehouse.w_state, warehouse.w_country, ('ORIENTAL,BOXBUNDLES'::text), date_dim.d_year
         ->  Sort  (cost=73413.84..73413.87 rows=12 width=870) (actual time=350.614..350.614 rows=10 loops=1)
               Sort Key: warehouse.w_warehouse_name, warehouse.w_warehouse_sq_ft, warehouse.w_city, warehouse.w_county, warehouse.w_state, warehouse.w_country, ('ORIENTAL,BOXBUNDLES'::text), date_dim.d_year
               Sort Method: quicksort  Memory: 30kB
               ->  Append  (cost=25483.92..73413.63 rows=12 width=870) (actual time=122.467..350.584 rows=10 loops=1)
                     ->  GroupAggregate  (cost=25483.92..25485.26 rows=4 width=870) (actual time=122.467..134.598 rows=5 loops=1)
                           Group Key: warehouse.w_warehouse_name, warehouse.w_warehouse_sq_ft, warehouse.w_city, warehouse.w_county, warehouse.w_state, warehouse.w_country, date_dim.d_year
                           ->  Remote Subquery Scan on all (dn0)  (cost=25483.92..25483.95 rows=4 width=91) (actual time=119.340..121.342 rows=6606 loops=1)
                     ->  Finalize GroupAggregate  (cost=47926.82..47928.25 rows=8 width=870) (actual time=215.938..215.984 rows=5 loops=1)
                           Group Key: warehouse_1.w_warehouse_name, warehouse_1.w_warehouse_sq_ft, warehouse_1.w_city, warehouse_1.w_county, warehouse_1.w_state, warehouse_1.w_country, date_dim_1.d_year
                           ->  Remote Subquery Scan on all (dn0)  (cost=47926.82..47926.86 rows=6 width=838) (actual time=215.891..215.894 rows=5 loops=1)
 Planning time: 9.504 ms
 Execution time: 354.876 ms
(15 rows)

