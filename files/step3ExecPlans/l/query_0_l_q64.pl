                                                                                                         QUERY PLAN                                                                                                          
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=514049.72..514049.73 rows=1 width=1310) (actual time=3707.170..3707.170 rows=9 loops=1)
   Sort Key: cs1.product_name, cs1.store_name, cs2.cnt, cs1.s1, cs2.s1
   Sort Method: quicksort  Memory: 27kB
   CTE cs_ui
     ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=159048.65..159075.55 rows=183 width=68) (actual time=559.191..761.109 rows=35192 loops=1)
   CTE cross_sales
     ->  GroupAggregate  (cost=354974.01..354974.07 rows=1 width=267) (actual time=3706.650..3706.899 rows=255 loops=1)
           Group Key: i_item_sk, s_store_name, s_zip, ca_street_number, ca_street_name, ca_city, ca_zip, ca_street_number, ca_street_name, ca_city, ca_zip, d_year, d_year, d_year
           ->  Sort  (cost=354974.01..354974.01 rows=1 width=178) (actual time=3706.638..3706.649 rows=255 loops=1)
                 Sort Key: i_item_sk, s_store_name, s_zip, ca_street_number, ca_street_name, ca_city, ca_zip, ca_street_number, ca_street_name, ca_city, ca_zip, d_year, d_year, d_year
                 Sort Method: quicksort  Memory: 92kB
                 ->  Hash Join  (cost=325498.39..354974.00 rows=1 width=178) (actual time=3410.334..3706.235 rows=255 loops=1)
                       Hash Cond: ((sr_item_sk = ss_item_sk) AND (sr_ticket_number = ss_ticket_number))
                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=100.00..34321.18 rows=862834 width=8) (actual time=19.622..142.221 rows=862834 loops=1)
                       ->  Hash  (cost=325497.52..325497.52 rows=58 width=190) (actual time=3387.997..3387.997 rows=2463 loops=1)
                             Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 593kB
                             ->  Hash Join  (cost=277257.00..325497.52 rows=58 width=190) (actual time=1648.435..3385.627 rows=2463 loops=1)
                                   Hash Cond: (ss_sold_date_sk = d_date_sk)
                                   ->  Hash Join  (cost=274208.40..322448.77 rows=58 width=190) (actual time=1569.594..3305.265 rows=2464 loops=1)
                                         Hash Cond: (hd_income_band_sk = ib_income_band_sk)
                                         ->  Hash Join  (cost=274206.95..322447.13 rows=58 width=194) (actual time=1551.720..3286.323 rows=2464 loops=1)
                                               Hash Cond: (ss_hdemo_sk = hd_demo_sk)
                                               ->  Hash Join  (cost=273991.95..322231.98 rows=58 width=194) (actual time=1531.333..3264.424 rows=2467 loops=1)
                                                     Hash Cond: (c_current_addr_sk = ca_address_sk)
                                                     ->  Hash Join  (cost=269832.95..318072.83 rows=58 width=158) (actual time=1368.123..3099.259 rows=2467 loops=1)
                                                           Hash Cond: (cd_demo_sk = c_current_cdemo_sk)
                                                           Join Filter: (cd_marital_status <> cd_marital_status)
                                                           Rows Removed by Join Filter: 592
                                                           ->  Remote Subquery Scan on all (dn3)  (cost=100.00..62264.80 rows=1920800 width=6) (actual time=14.156..1335.797 rows=1920800 loops=1)
                                                           ->  Hash  (cost=269832.04..269832.04 rows=73 width=164) (actual time=1352.210..1352.210 rows=3059 loops=1)
                                                                 Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 646kB
                                                                 ->  Hash Join  (cost=221456.98..269832.04 rows=73 width=164) (actual time=1175.905..1351.007 rows=3074 loops=1)
                                                                       Hash Cond: (c_first_sales_date_sk = d_date_sk)
                                                                       ->  Hash Join  (cost=218408.37..266783.25 rows=73 width=164) (actual time=1111.931..1285.678 rows=3105 loops=1)
                                                                             Hash Cond: (ss_item_sk = cs_ui.cs_item_sk)
                                                                             ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=218502.43..267611.87 rows=4560 width=160) (actual time=340.886..508.478 rows=3105 loops=1)
                                                                             ->  Hash  (cost=3.66..3.66 rows=183 width=4) (actual time=770.987..770.987 rows=35192 loops=1)
                                                                                   Buckets: 65536 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1750kB
                                                                                   ->  CTE Scan on cs_ui  (cost=0.00..3.66 rows=183 width=4) (actual time=559.198..766.214 rows=35192 loops=1)
                                                                       ->  Hash  (cost=3185.13..3185.13 rows=73049 width=8) (actual time=63.831..63.831 rows=73049 loops=1)
                                                                             Buckets: 131072  Batches: 1  Memory Usage: 3878kB
                                                                             ->  Remote Subquery Scan on all (dn1)  (cost=100.00..3185.13 rows=73049 width=8) (actual time=15.147..46.432 rows=73049 loops=1)
                                                     ->  Hash  (cost=7690.00..7690.00 rows=94000 width=44) (actual time=163.114..163.114 rows=94000 loops=1)
                                                           Buckets: 131072  Batches: 1  Memory Usage: 8175kB
                                                           ->  Remote Subquery Scan on all (dn3)  (cost=100.00..7690.00 rows=94000 width=44) (actual time=29.781..102.729 rows=94000 loops=1)
                                               ->  Hash  (cost=318.60..318.60 rows=7200 width=8) (actual time=20.376..20.376 rows=7200 loops=1)
                                                     Buckets: 8192  Batches: 1  Memory Usage: 346kB
                                                     ->  Remote Subquery Scan on all (dn2)  (cost=100.00..318.60 rows=7200 width=8) (actual time=15.473..18.935 rows=7200 loops=1)
                                         ->  Hash  (cost=101.38..101.38 rows=20 width=4) (actual time=17.864..17.864 rows=20 loops=1)
                                               Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                               ->  Remote Subquery Scan on all (dn2)  (cost=100.00..101.38 rows=20 width=4) (actual time=17.852..17.854 rows=20 loops=1)
                                   ->  Hash  (cost=3185.13..3185.13 rows=73049 width=8) (actual time=78.524..78.524 rows=73049 loops=1)
                                         Buckets: 131072  Batches: 1  Memory Usage: 3878kB
                                         ->  Remote Subquery Scan on all (dn2)  (cost=100.00..3185.13 rows=73049 width=8) (actual time=19.919..58.993 rows=73049 loops=1)
   ->  Hash Join  (cost=0.04..0.09 rows=1 width=1310) (actual time=3707.112..3707.145 rows=9 loops=1)
         Hash Cond: ((cs1.item_sk = cs2.item_sk) AND ((cs1.store_name)::text = (cs2.store_name)::text) AND (cs1.store_zip = cs2.store_zip))
         Join Filter: (cs2.cnt <= cs1.cnt)
         ->  CTE Scan on cross_sales cs1  (cost=0.00..0.02 rows=1 width=1206) (actual time=3706.699..3706.724 rows=38 loops=1)
               Filter: (syear = 2000)
               Rows Removed by Filter: 217
         ->  Hash  (cost=0.02..0.02 rows=1 width=274) (actual time=0.399..0.399 rows=36 loops=1)
               Buckets: 1024  Batches: 1  Memory Usage: 11kB
               ->  CTE Scan on cross_sales cs2  (cost=0.00..0.02 rows=1 width=274) (actual time=0.002..0.389 rows=40 loops=1)
                     Filter: (syear = 2001)
                     Rows Removed by Filter: 215
 Planning time: 64.685 ms
 Execution time: 3741.624 ms
(67 rows)

