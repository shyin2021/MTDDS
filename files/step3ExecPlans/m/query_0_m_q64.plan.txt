                                                                                                                                      QUERY PLAN                                                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=376452.04..376452.05 rows=1 width=1310) (actual time=4739.990..4739.990 rows=19 loops=1)
   Sort Key: cs1.product_name, cs1.store_name, cs2.cnt, cs1.s1, cs2.s1
   Sort Method: quicksort  Memory: 30kB
   CTE cs_ui
     ->  Remote Subquery Scan on all (dn1,dn2)  (cost=106109.32..106132.32 rows=156 width=68) (actual time=460.286..574.802 rows=25341 loops=1)
   CTE cross_sales
     ->  GroupAggregate  (cost=270319.56..270319.63 rows=1 width=267) (actual time=4739.334..4739.576 rows=245 loops=1)
           Group Key: i_item_sk, s_store_name, s_zip, ca_street_number, ca_street_name, ca_city, ca_zip, ca_street_number, ca_street_name, ca_city, ca_zip, d_year, d_year, d_year
           ->  Sort  (cost=270319.56..270319.57 rows=1 width=178) (actual time=4739.317..4739.329 rows=245 loops=1)
                 Sort Key: i_item_sk, s_store_name, s_zip, ca_street_number, ca_street_name, ca_city, ca_zip, ca_street_number, ca_street_name, ca_city, ca_zip, d_year, d_year, d_year
                 Sort Method: quicksort  Memory: 90kB
                 ->  Hash Join  (cost=250665.04..270319.55 rows=1 width=178) (actual time=4465.821..4738.769 rows=245 loops=1)
                       Hash Cond: (ss_addr_sk = ca_address_sk)
                       ->  Hash Join  (cost=247479.04..267133.55 rows=1 width=142) (actual time=4343.042..4615.820 rows=245 loops=1)
                             Hash Cond: (hd_income_band_sk = ib_income_band_sk)
                             ->  Hash Join  (cost=247477.59..267132.09 rows=1 width=146) (actual time=4315.832..4588.516 rows=245 loops=1)
                                   Hash Cond: (hd_income_band_sk = ib_income_band_sk)
                                   ->  Hash Join  (cost=247476.14..267130.64 rows=1 width=150) (actual time=4288.429..4560.982 rows=245 loops=1)
                                         Hash Cond: (ss_promo_sk = p_promo_sk)
                                         ->  Hash Join  (cost=247459.90..267114.39 rows=1 width=154) (actual time=4261.906..4534.296 rows=246 loops=1)
                                               Hash Cond: ((sr_item_sk = ss_item_sk) AND (sr_ticket_number = ss_ticket_number))
                                               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=100.00..22918.56 rows=575285 width=8) (actual time=27.756..136.334 rows=575285 loops=1)
                                               ->  Hash  (cost=247459.36..247459.36 rows=36 width=166) (actual time=4233.949..4233.949 rows=2351 loops=1)
                                                     Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 508kB
                                                     ->  Hash Join  (cost=199219.73..247459.36 rows=36 width=166) (actual time=2834.642..4230.701 rows=2351 loops=1)
                                                           Hash Cond: (c_first_sales_date_sk = d_date_sk)
                                                           ->  Hash Join  (cost=196171.12..244410.66 rows=36 width=166) (actual time=2746.787..4140.910 rows=2359 loops=1)
                                                                 Hash Cond: (cd_demo_sk = ss_cdemo_sk)
                                                                 Join Filter: (cd_marital_status <> cd_marital_status)
                                                                 Rows Removed by Join Filter: 636
                                                                 ->  Remote Subquery Scan on all (dn1)  (cost=100.00..62264.80 rows=1920800 width=6) (actual time=28.236..888.314 rows=1920800 loops=1)
                                                                 ->  Hash  (cost=196170.56..196170.56 rows=45 width=172) (actual time=2718.469..2718.469 rows=2995 loops=1)
                                                                       Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 662kB
                                                                       ->  Hash Join  (cost=147931.01..196170.56 rows=45 width=172) (actual time=1396.937..2714.269 rows=3001 loops=1)
                                                                             Hash Cond: (c_current_hdemo_sk = hd_demo_sk)
                                                                             ->  Hash Join  (cost=147716.01..195955.44 rows=45 width=172) (actual time=1364.534..2678.934 rows=3021 loops=1)
                                                                                   Hash Cond: (cd_demo_sk = c_current_cdemo_sk)
                                                                                   ->  Remote Subquery Scan on all (dn1)  (cost=100.00..62264.80 rows=1920800 width=6) (actual time=28.116..803.741 rows=1920800 loops=1)
                                                                                   ->  Hash  (cost=147715.45..147715.45 rows=45 width=174) (actual time=1336.160..1336.160 rows=3021 loops=1)
                                                                                         Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 667kB
                                                                                         ->  Merge Join  (cost=147573.43..147715.45 rows=45 width=174) (actual time=1331.158..1334.823 rows=3074 loops=1)
                                                                                               Merge Cond: (d_date_sk = c_first_shipto_date_sk)
                                                                                               ->  Remote Subquery Scan on all (dn2)  (cost=100.17..3772.84 rows=73049 width=8) (actual time=26.836..45.378 rows=37658 loops=1)
                                                                                               ->  Sort  (cost=146221.48..146221.60 rows=45 width=174) (actual time=1279.522..1279.821 rows=3075 loops=1)
                                                                                                     Sort Key: c_first_shipto_date_sk
                                                                                                     Sort Method: quicksort  Memory: 939kB
                                                                                                     ->  Hash Join  (cost=140253.70..146220.25 rows=45 width=174) (actual time=1114.704..1275.268 rows=3170 loops=1)
                                                                                                           Hash Cond: (c_current_addr_sk = ca_address_sk)
                                                                                                           ->  Hash Join  (cost=137067.70..143034.13 rows=45 width=138) (actual time=997.363..1154.735 rows=3170 loops=1)
                                                                                                                 Hash Cond: (c_customer_sk = ss_customer_sk)
                                                                                                                 ->  Remote Subquery Scan on all (dn2)  (cost=100.00..9702.00 rows=144000 width=24) (actual time=28.479..96.167 rows=144000 loops=1)
                                                                                                                 ->  Hash  (cost=137067.14..137067.14 rows=45 width=122) (actual time=968.774..968.774 rows=3170 loops=1)
                                                                                                                       Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 533kB
                                                                                                                       ->  Hash Join  (cost=134657.28..137067.14 rows=45 width=122) (actual time=939.807..967.868 rows=3189 loops=1)
                                                                                                                             Hash Cond: (d_date_sk = ss_sold_date_sk)
                                                                                                                             ->  Remote Subquery Scan on all (dn1)  (cost=100.00..3185.13 rows=73049 width=8) (actual time=28.816..61.470 rows=73049 loops=1)
                                                                                                                             ->  Hash  (cost=134656.72..134656.72 rows=45 width=122) (actual time=884.604..884.604 rows=3189 loops=1)
                                                                                                                                   Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 532kB
                                                                                                                                   ->  Hash Join  (cost=586.91..134656.72 rows=45 width=122) (actual time=645.827..883.202 rows=3230 loops=1)
                                                                                                                                         Hash Cond: (ss_store_sk = s_store_sk)
                                                                                                                                         ->  Hash Join  (cost=585.42..134655.09 rows=45 width=110) (actual time=618.619..855.162 rows=3305 loops=1)
                                                                                                                                               Hash Cond: (ss_item_sk = cs_ui.cs_item_sk)
                                                                                                                                               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=680.35..135129.77 rows=3545 width=106) (actual time=36.005..267.383 rows=3391 loops=1)
                                                                                                                                               ->  Hash  (cost=3.12..3.12 rows=156 width=4) (actual time=582.583..582.583 rows=25341 loops=1)
                                                                                                                                                     Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1147kB
                                                                                                                                                     ->  CTE Scan on cs_ui  (cost=0.00..3.12 rows=156 width=4) (actual time=460.289..578.582 rows=25341 loops=1)
                                                                                                                                         ->  Hash  (cost=101.77..101.77 rows=22 width=20) (actual time=27.199..27.199 rows=22 loops=1)
                                                                                                                                               Buckets: 1024  Batches: 1  Memory Usage: 10kB
                                                                                                                                               ->  Remote Subquery Scan on all (dn2)  (cost=100.00..101.77 rows=22 width=20) (actual time=27.129..27.132 rows=22 loops=1)
                                                                                                           ->  Hash  (cost=5914.00..5914.00 rows=72000 width=44) (actual time=116.947..116.947 rows=72000 loops=1)
                                                                                                                 Buckets: 131072  Batches: 1  Memory Usage: 6502kB
                                                                                                                 ->  Remote Subquery Scan on all (dn1)  (cost=100.00..5914.00 rows=72000 width=44) (actual time=28.148..62.239 rows=72000 loops=1)
                                                                             ->  Hash  (cost=318.60..318.60 rows=7200 width=8) (actual time=32.346..32.346 rows=7200 loops=1)
                                                                                   Buckets: 8192  Batches: 1  Memory Usage: 346kB
                                                                                   ->  Remote Subquery Scan on all (dn2)  (cost=100.00..318.60 rows=7200 width=8) (actual time=26.557..29.783 rows=7200 loops=1)
                                                           ->  Hash  (cost=3185.13..3185.13 rows=73049 width=8) (actual time=87.527..87.527 rows=73049 loops=1)
                                                                 Buckets: 131072  Batches: 1  Memory Usage: 3878kB
                                                                 ->  Remote Subquery Scan on all (dn1)  (cost=100.00..3185.13 rows=73049 width=8) (actual time=26.734..60.888 rows=73049 loops=1)
                                         ->  Hash  (cost=115.12..115.12 rows=322 width=4) (actual time=26.512..26.512 rows=322 loops=1)
                                               Buckets: 1024  Batches: 1  Memory Usage: 20kB
                                               ->  Remote Subquery Scan on all (dn1)  (cost=100.00..115.12 rows=322 width=4) (actual time=26.373..26.403 rows=322 loops=1)
                                   ->  Hash  (cost=101.38..101.38 rows=20 width=4) (actual time=27.392..27.392 rows=20 loops=1)
                                         Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                         ->  Remote Subquery Scan on all (dn2)  (cost=100.00..101.38 rows=20 width=4) (actual time=27.376..27.379 rows=20 loops=1)
                             ->  Hash  (cost=101.38..101.38 rows=20 width=4) (actual time=27.193..27.193 rows=20 loops=1)
                                   Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                   ->  Remote Subquery Scan on all (dn1)  (cost=100.00..101.38 rows=20 width=4) (actual time=27.175..27.177 rows=20 loops=1)
                       ->  Hash  (cost=5914.00..5914.00 rows=72000 width=44) (actual time=122.657..122.658 rows=72000 loops=1)
                             Buckets: 131072  Batches: 1  Memory Usage: 6502kB
                             ->  Remote Subquery Scan on all (dn1)  (cost=100.00..5914.00 rows=72000 width=44) (actual time=34.007..69.631 rows=72000 loops=1)
   ->  Hash Join  (cost=0.04..0.09 rows=1 width=1310) (actual time=4739.816..4739.851 rows=19 loops=1)
         Hash Cond: ((cs1.item_sk = cs2.item_sk) AND ((cs1.store_name)::text = (cs2.store_name)::text) AND (cs1.store_zip = cs2.store_zip))
         Join Filter: (cs2.cnt <= cs1.cnt)
         ->  CTE Scan on cross_sales cs1  (cost=0.00..0.02 rows=1 width=1206) (actual time=4739.371..4739.396 rows=48 loops=1)
               Filter: (syear = 1999)
               Rows Removed by Filter: 197
         ->  Hash  (cost=0.02..0.02 rows=1 width=274) (actual time=0.421..0.421 rows=39 loops=1)
               Buckets: 1024  Batches: 1  Memory Usage: 12kB
               ->  CTE Scan on cross_sales cs2  (cost=0.00..0.02 rows=1 width=274) (actual time=0.001..0.408 rows=39 loops=1)
                     Filter: (syear = 2000)
                     Rows Removed by Filter: 206
 Planning time: 66.328 ms
 Execution time: 4789.829 ms
(103 rows)

