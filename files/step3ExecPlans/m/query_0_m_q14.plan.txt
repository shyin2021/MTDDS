                                                                                              QUERY PLAN                                                                                               
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=849440.07..849440.31 rows=13 width=108) (actual time=6932.222..6932.308 rows=100 loops=1)
   CTE cross_items
     ->  Hash Join  (cost=290279.02..292519.77 rows=2 width=4) (actual time=4440.130..4463.585 rows=23467 loops=1)
           Hash Cond: ((i_brand_id = r2.brand_id) AND (i_class_id = r2.class_id) AND (i_category_id = r2.category_id))
           ->  Remote Subquery Scan on all (dn2)  (cost=100.00..2682.00 rows=26000 width=16) (actual time=9.756..20.523 rows=26000 loops=1)
           ->  Hash  (cost=290233.52..290233.52 rows=2600 width=12) (actual time=4430.351..4430.351 rows=4817 loops=1)
                 Buckets: 8192 (originally 4096)  Batches: 1 (originally 1)  Memory Usage: 271kB
                 ->  Subquery Scan on r2  (cost=2603.29..290233.52 rows=2600 width=12) (actual time=4429.088..4429.764 rows=4881 loops=1)
                       ->  HashSetOp Intersect  (cost=2603.29..290207.52 rows=2600 width=16) (actual time=4429.087..4429.327 rows=4881 loops=1)
                             ->  Append  (cost=2603.29..290080.14 rows=16983 width=16) (actual time=3792.939..4253.782 rows=869880 loops=1)
                                   ->  Result  (cost=2603.29..240520.35 rows=2600 width=16) (actual time=3792.938..3793.596 rows=4881 loops=1)
                                         ->  HashSetOp Intersect  (cost=2603.29..240494.35 rows=2600 width=16) (actual time=3792.937..3793.238 rows=4881 loops=1)
                                               ->  Append  (cost=2603.29..239846.72 rows=86351 width=16) (actual time=15.263..2766.450 rows=5007252 loops=1)
                                                     ->  Subquery Scan on "*SELECT* 1"  (cost=2603.29..143674.53 rows=57570 width=16) (actual time=15.263..1590.108 rows=3294874 loops=1)
                                                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=2603.29..143098.83 rows=57570 width=12) (actual time=15.254..670.721 rows=3294874 loops=1)
                                                     ->  Subquery Scan on "*SELECT* 2"  (cost=2603.29..96172.19 rows=28781 width=16) (actual time=39.538..893.265 rows=1712378 loops=1)
                                                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=2603.29..95884.38 rows=28781 width=12) (actual time=39.527..407.089 rows=1712378 loops=1)
                                   ->  Subquery Scan on "*SELECT* 3"  (cost=2603.29..49559.79 rows=14383 width=16) (actual time=14.435..410.985 rows=864999 loops=1)
                                         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=2603.29..49415.96 rows=14383 width=12) (actual time=14.427..169.016 rows=864999 loops=1)
   CTE avg_sales
     ->  Finalize Aggregate  (cost=281056.37..281056.38 rows=1 width=32) (actual time=1442.998..1442.998 rows=1 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=281056.35..281056.37 rows=1 width=32) (actual time=1417.096..1442.976 rows=2 loops=1)
   ->  GroupAggregate  (cost=275863.92..275864.17 rows=13 width=108) (actual time=6932.221..6932.293 rows=100 loops=1)
         Group Key: ('store'::text), i_brand_id, i_class_id, i_category_id
         Group Key: ('store'::text), i_brand_id, i_class_id
         Group Key: ('store'::text), i_brand_id
         Group Key: ('store'::text)
         Group Key: ()
         ->  Sort  (cost=275863.92..275863.93 rows=3 width=84) (actual time=6932.213..6932.215 rows=70 loops=1)
               Sort Key: ('store'::text), i_brand_id, i_class_id, i_category_id
               Sort Method: quicksort  Memory: 1418kB
               ->  Append  (cost=136185.94..275863.89 rows=3 width=84) (actual time=6334.510..6924.670 rows=13226 loops=1)
                     ->  GroupAggregate  (cost=136185.94..136185.99 rows=1 width=84) (actual time=6334.509..6405.291 rows=4585 loops=1)
                           Group Key: i_brand_id, i_class_id, i_category_id
                           Filter: (sum(((ss_quantity)::numeric * ss_list_price)) > $8)
                           Rows Removed by Filter: 1
                           InitPlan 3 (returns $8)
                             ->  CTE Scan on avg_sales  (cost=0.00..0.02 rows=1 width=32) (actual time=1443.000..1443.001 rows=1 loops=1)
                           ->  Sort  (cost=136185.92..136185.93 rows=1 width=22) (actual time=4891.463..4908.700 rows=175073 loops=1)
                                 Sort Key: i_brand_id, i_class_id, i_category_id
                                 Sort Method: quicksort  Memory: 19690kB
                                 ->  Hash Join  (cost=2251.76..136185.91 rows=1 width=22) (actual time=4523.165..4833.662 rows=175073 loops=1)
                                       Hash Cond: (ss_item_sk = i_item_sk)
                                       ->  Remote Subquery Scan on all (dn1,dn2)  (cost=218.13..134187.15 rows=2287 width=14) (actual time=9.939..223.486 rows=175878 loops=1)
                                       ->  Hash  (cost=2133.61..2133.61 rows=2 width=20) (actual time=4513.209..4513.209 rows=23467 loops=1)
                                             Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1448kB
                                             ->  Hash Join  (cost=0.08..2133.61 rows=2 width=20) (actual time=4481.355..4509.163 rows=23467 loops=1)
                                                   Hash Cond: (i_item_sk = cross_items.ss_item_sk)
                                                   ->  Remote Subquery Scan on all (dn1)  (cost=100.00..2682.00 rows=26000 width=16) (actual time=5.646..18.016 rows=26000 loops=1)
                                                   ->  Hash  (cost=0.06..0.06 rows=2 width=4) (actual time=4475.698..4475.698 rows=23467 loops=1)
                                                         Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1082kB
                                                         ->  Unique  (cost=0.05..0.06 rows=2 width=4) (actual time=4471.078..4473.910 rows=23467 loops=1)
                                                               ->  Sort  (cost=0.05..0.06 rows=2 width=4) (actual time=4471.077..4471.854 rows=23467 loops=1)
                                                                     Sort Key: cross_items.ss_item_sk
                                                                     Sort Method: quicksort  Memory: 1869kB
                                                                     ->  CTE Scan on cross_items  (cost=0.00..0.04 rows=2 width=4) (actual time=4440.131..4467.838 rows=23467 loops=1)
                     ->  GroupAggregate  (cost=92252.62..92252.66 rows=1 width=84) (actual time=307.796..345.344 rows=4551 loops=1)
                           Group Key: i_brand_id, i_class_id, i_category_id
                           Filter: (sum(((cs_quantity)::numeric * cs_list_price)) > $9)
                           Rows Removed by Filter: 32
                           InitPlan 4 (returns $9)
                             ->  CTE Scan on avg_sales avg_sales_1  (cost=0.00..0.02 rows=1 width=32) (actual time=0.001..0.001 rows=1 loops=1)
                           ->  Sort  (cost=92252.60..92252.60 rows=1 width=22) (actual time=307.768..315.243 rows=92050 loops=1)
                                 Sort Key: i_brand_id, i_class_id, i_category_id
                                 Sort Method: quicksort  Memory: 10257kB
                                 ->  Hash Join  (cost=2251.76..92252.59 rows=1 width=22) (actual time=147.028..276.325 rows=92050 loops=1)
                                       Hash Cond: (cs_item_sk = i_item_sk)
                                       ->  Remote Subquery Scan on all (dn1,dn2)  (cost=218.13..90236.38 rows=1143 width=14) (actual time=102.434..180.866 rows=92493 loops=1)
                                       ->  Hash  (cost=2133.61..2133.61 rows=2 width=20) (actual time=44.484..44.484 rows=23467 loops=1)
                                             Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1448kB
                                             ->  Hash Join  (cost=0.08..2133.61 rows=2 width=20) (actual time=14.570..40.057 rows=23467 loops=1)
                                                   Hash Cond: (i_item_sk = cross_items_1.ss_item_sk)
                                                   ->  Remote Subquery Scan on all (dn2)  (cost=100.00..2682.00 rows=26000 width=16) (actual time=5.802..17.520 rows=26000 loops=1)
                                                   ->  Hash  (cost=0.06..0.06 rows=2 width=4) (actual time=8.580..8.580 rows=23467 loops=1)
                                                         Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1082kB
                                                         ->  Unique  (cost=0.05..0.06 rows=2 width=4) (actual time=4.111..6.869 rows=23467 loops=1)
                                                               ->  Sort  (cost=0.05..0.06 rows=2 width=4) (actual time=4.110..4.832 rows=23467 loops=1)
                                                                     Sort Key: cross_items_1.ss_item_sk
                                                                     Sort Method: quicksort  Memory: 1869kB
                                                                     ->  CTE Scan on cross_items cross_items_1  (cost=0.00..0.04 rows=2 width=4) (actual time=0.002..1.451 rows=23467 loops=1)
                     ->  GroupAggregate  (cost=47425.17..47425.21 rows=1 width=84) (actual time=155.688..173.444 rows=4090 loops=1)
                           Group Key: i_brand_id, i_class_id, i_category_id
                           Filter: (sum(((ws_quantity)::numeric * ws_list_price)) > $10)
                           Rows Removed by Filter: 390
                           InitPlan 5 (returns $10)
                             ->  CTE Scan on avg_sales avg_sales_2  (cost=0.00..0.02 rows=1 width=32) (actual time=0.001..0.001 rows=1 loops=1)
                           ->  Sort  (cost=47425.15..47425.15 rows=1 width=22) (actual time=155.668..157.825 rows=45465 loops=1)
                                 Sort Key: i_brand_id, i_class_id, i_category_id
                                 Sort Method: quicksort  Memory: 5088kB
                                 ->  Hash Join  (cost=2251.76..47425.14 rows=1 width=22) (actual time=51.467..140.589 rows=45465 loops=1)
                                       Hash Cond: (ws_item_sk = i_item_sk)
                                       ->  Remote Subquery Scan on all (dn1,dn2)  (cost=218.13..45400.21 rows=571 width=14) (actual time=6.715..70.034 rows=45706 loops=1)
                                       ->  Hash  (cost=2133.61..2133.61 rows=2 width=20) (actual time=44.732..44.732 rows=23467 loops=1)
                                             Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1448kB
                                             ->  Hash Join  (cost=0.08..2133.61 rows=2 width=20) (actual time=15.215..40.249 rows=23467 loops=1)
                                                   Hash Cond: (i_item_sk = cross_items_2.ss_item_sk)
                                                   ->  Remote Subquery Scan on all (dn2)  (cost=100.00..2682.00 rows=26000 width=16) (actual time=5.897..17.779 rows=26000 loops=1)
                                                   ->  Hash  (cost=0.06..0.06 rows=2 width=4) (actual time=9.210..9.210 rows=23467 loops=1)
                                                         Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1082kB
                                                         ->  Unique  (cost=0.05..0.06 rows=2 width=4) (actual time=4.516..7.409 rows=23467 loops=1)
                                                               ->  Sort  (cost=0.05..0.06 rows=2 width=4) (actual time=4.516..5.289 rows=23467 loops=1)
                                                                     Sort Key: cross_items_2.ss_item_sk
                                                                     Sort Method: quicksort  Memory: 1869kB
                                                                     ->  CTE Scan on cross_items cross_items_2  (cost=0.00..0.04 rows=2 width=4) (actual time=0.001..1.572 rows=23467 loops=1)
 Planning time: 2.335 ms
 Execution time: 6959.454 ms
(106 rows)

 ty_channel | ty_brand | ty_class | ty_category |  ty_sales  | ty_number_sales | ly_channel | ly_brand | ly_class | ly_category |  ly_sales  | ly_number_sales 
------------+----------+----------+-------------+------------+-----------------+------------+----------+----------+-------------+------------+-----------------
 store      |  1001001 |        1 |           1 | 1252999.48 |             352 | store      |  1001001 |        1 |           1 | 2543087.89 |             696
 store      |  1001002 |        1 |           1 | 1703168.36 |             456 | store      |  1001002 |        1 |           1 | 1442354.67 |             413
 store      |  1002001 |        2 |           1 | 1266766.13 |             371 | store      |  1002001 |        2 |           1 | 2879423.29 |             750
 store      |  1002002 |        2 |           1 | 1562915.33 |             440 | store      |  1002002 |        2 |           1 | 1470390.89 |             377
 store      |  1003001 |        3 |           1 | 1086125.17 |             288 | store      |  1003001 |        3 |           1 | 2305887.24 |             646
 store      |  1003002 |        3 |           1 | 1456492.97 |             399 | store      |  1003002 |        3 |           1 | 1243102.91 |             323
 store      |  1004001 |        4 |           1 | 1349849.72 |             345 | store      |  1004001 |        4 |           1 | 2533155.08 |             673
 store      |  1004002 |        4 |           1 | 1723448.32 |             481 | store      |  1004002 |        4 |           1 | 1409545.42 |             394
 store      |  2001001 |        1 |           2 | 1421744.08 |             396 | store      |  2001001 |        1 |           2 | 2649956.32 |             719
 store      |  2001002 |        1 |           2 | 1412824.33 |             392 | store      |  2001002 |        1 |           2 | 1213601.54 |             339
 store      |  2002001 |        2 |           2 | 1623685.95 |             432 | store      |  2002001 |        2 |           2 | 3019227.38 |             804
 store      |  2002002 |        2 |           2 | 1309797.53 |             387 | store      |  2002002 |        2 |           2 | 1125686.86 |             331
 store      |  2003001 |        3 |           2 | 1213442.58 |             287 | store      |  2003001 |        3 |           2 | 2416562.78 |             677
 store      |  2003002 |        3 |           2 | 1432891.95 |             405 | store      |  2003002 |        3 |           2 | 1332531.00 |             320
 store      |  2004001 |        4 |           2 | 1549615.31 |             438 | store      |  2004001 |        4 |           2 | 2916423.97 |             792
 store      |  2004002 |        4 |           2 | 1508431.91 |             419 | store      |  2004002 |        4 |           2 | 1307851.84 |             349
 store      |  3001001 |        1 |           3 | 1114232.30 |             305 | store      |  3001001 |        1 |           3 | 2549736.35 |             656
 store      |  3001002 |        1 |           3 | 1525946.78 |             410 | store      |  3001002 |        1 |           3 | 1147059.90 |             285
 store      |  3002001 |        2 |           3 | 1534094.07 |             415 | store      |  3002001 |        2 |           3 | 2986013.96 |             752
 store      |  3002002 |        2 |           3 | 1654398.47 |             437 | store      |  3002002 |        2 |           3 | 1278035.38 |             367
 store      |  3003001 |        3 |           3 | 1398092.22 |             394 | store      |  3003001 |        3 |           3 | 2730796.60 |             733
 store      |  3003002 |        3 |           3 | 1461515.06 |             400 | store      |  3003002 |        3 |           3 | 1122790.10 |             315
 store      |  3004001 |        4 |           3 | 1278212.40 |             382 | store      |  3004001 |        4 |           3 | 2313776.78 |             617
 store      |  3004002 |        4 |           3 | 1629257.43 |             452 | store      |  3004002 |        4 |           3 | 1331894.68 |             358
 store      |  4001001 |        1 |           4 | 1359760.60 |             383 | store      |  4001001 |        1 |           4 | 2812872.91 |             749
 store      |  4001002 |        1 |           4 | 1459972.49 |             401 | store      |  4001002 |        1 |           4 | 1190229.56 |             315
 store      |  4002001 |        2 |           4 | 1074698.65 |             319 | store      |  4002001 |        2 |           4 | 2640783.90 |             724
 store      |  4002002 |        2 |           4 | 1671034.66 |             485 | store      |  4002002 |        2 |           4 | 1702640.92 |             430
 store      |  4003001 |        3 |           4 | 1579631.49 |             418 | store      |  4003001 |        3 |           4 | 2623740.42 |             745
 store      |  4003002 |        3 |           4 | 1648951.56 |             443 | store      |  4003002 |        3 |           4 | 1187145.25 |             327
 store      |  4004001 |        4 |           4 | 1267352.66 |             355 | store      |  4004001 |        4 |           4 | 2634156.03 |             699
 store      |  4004002 |        4 |           4 | 1506706.83 |             404 | store      |  4004002 |        4 |           4 | 1380032.92 |             356
 store      |  5001001 |        1 |           5 | 1341125.51 |             365 | store      |  5001001 |        1 |           5 | 2475414.31 |             672
 store      |  5001002 |        1 |           5 | 1554271.17 |             400 | store      |  5001002 |        1 |           5 | 1407364.24 |             370
 store      |  5002001 |        2 |           5 | 1304061.48 |             357 | store      |  5002001 |        2 |           5 | 2581122.46 |             685
 store      |  5002002 |        2 |           5 | 1789778.47 |             440 | store      |  5002002 |        2 |           5 | 1293446.75 |             349
 store      |  5003001 |        3 |           5 | 1316121.39 |             359 | store      |  5003001 |        3 |           5 | 2844338.66 |             749
 store      |  5003002 |        3 |           5 | 1772325.44 |             473 | store      |  5003002 |        3 |           5 | 1476888.58 |             398
 store      |  5004001 |        4 |           5 | 1486881.39 |             392 | store      |  5004001 |        4 |           5 | 3057956.15 |             857
 store      |  5004002 |        4 |           5 | 1632548.69 |             468 | store      |  5004002 |        4 |           5 | 1366880.41 |             405
 store      |  6001001 |        1 |           6 |  104427.15 |              24 | store      |  6001001 |        1 |           6 |  172621.56 |              44
 store      |  6001002 |        1 |           6 |  108034.05 |              30 | store      |  6001002 |        1 |           6 |  110720.04 |              26
 store      |  6001003 |        1 |           6 |   55158.57 |              14 | store      |  6001003 |        1 |           6 |  123489.68 |              29
 store      |  6001004 |        1 |           6 |  100285.23 |              22 | store      |  6001004 |        1 |           6 |   28429.13 |               7
 store      |  6001005 |        1 |           6 |   95291.03 |              25 | store      |  6001005 |        1 |           6 |  208071.24 |              55
 store      |  6001006 |        1 |           6 |   75632.53 |              25 | store      |  6001006 |        1 |           6 |   87222.30 |              29
 store      |  6001007 |        1 |           6 |  101882.72 |              26 | store      |  6001007 |        1 |           6 |  115047.86 |              32
 store      |  6001008 |        1 |           6 |  131861.01 |              44 | store      |  6001008 |        1 |           6 |  108541.75 |              27
 store      |  6002001 |        2 |           6 |   77294.77 |              24 | store      |  6002001 |        2 |           6 |  145476.58 |              46
 store      |  6002002 |        2 |           6 |  122179.91 |              26 | store      |  6002002 |        2 |           6 |   65933.27 |              23
 store      |  6002003 |        2 |           6 |   36782.18 |              12 | store      |  6002003 |        2 |           6 |  146550.29 |              35
 store      |  6002004 |        2 |           6 |  152707.66 |              42 | store      |  6002004 |        2 |           6 |   99048.80 |              25
 store      |  6002005 |        2 |           6 |  150330.58 |              28 | store      |  6002005 |        2 |           6 |  202374.04 |              60
 store      |  6002006 |        2 |           6 |   72102.52 |              15 | store      |  6002006 |        2 |           6 |   27505.41 |              10
 store      |  6002007 |        2 |           6 |   63072.31 |              16 | store      |  6002007 |        2 |           6 |  112189.44 |              33
 store      |  6002008 |        2 |           6 |  163892.44 |              39 | store      |  6002008 |        2 |           6 |  117276.36 |              28
 store      |  6003001 |        3 |           6 |   67092.48 |              19 | store      |  6003001 |        3 |           6 |  117428.36 |              31
 store      |  6003002 |        3 |           6 |  135957.41 |              39 | store      |  6003002 |        3 |           6 |  180672.67 |              44
 store      |  6003003 |        3 |           6 |   63826.70 |              19 | store      |  6003003 |        3 |           6 |  181510.09 |              51
 store      |  6003004 |        3 |           6 |  107439.25 |              33 | store      |  6003004 |        3 |           6 |   90471.55 |              27
 store      |  6003005 |        3 |           6 |   71598.60 |              24 | store      |  6003005 |        3 |           6 |  253544.40 |              57
 store      |  6003006 |        3 |           6 |   51247.91 |              15 | store      |  6003006 |        3 |           6 |   37511.81 |              17
 store      |  6003007 |        3 |           6 |  110830.50 |              27 | store      |  6003007 |        3 |           6 |  180573.81 |              59
 store      |  6003008 |        3 |           6 |  161948.96 |              42 | store      |  6003008 |        3 |           6 |  180414.56 |              40
 store      |  6004001 |        4 |           6 |   23619.17 |               4 | store      |  6004001 |        4 |           6 |   77326.98 |              25
 store      |  6004002 |        4 |           6 |   56866.15 |              18 | store      |  6004002 |        4 |           6 |   72407.22 |              16
 store      |  6004003 |        4 |           6 |   60581.47 |              19 | store      |  6004003 |        4 |           6 |   69698.51 |              24
 store      |  6004004 |        4 |           6 |   58567.83 |              20 | store      |  6004004 |        4 |           6 |   29109.07 |               8
 store      |  6004005 |        4 |           6 |   78420.80 |              18 | store      |  6004005 |        4 |           6 |  106594.90 |              32
 store      |  6004006 |        4 |           6 |  102595.73 |              25 | store      |  6004006 |        4 |           6 |   30228.16 |               9
 store      |  6004007 |        4 |           6 |   37877.62 |              16 | store      |  6004007 |        4 |           6 |  103377.17 |              33
 store      |  6004008 |        4 |           6 |   78657.70 |              22 | store      |  6004008 |        4 |           6 |   64333.35 |              15
 store      |  6005001 |        5 |           6 |  164900.55 |              45 | store      |  6005001 |        5 |           6 |  238567.68 |              58
 store      |  6005002 |        5 |           6 |  100756.80 |              28 | store      |  6005002 |        5 |           6 |   53010.55 |              18
 store      |  6005003 |        5 |           6 |   54327.16 |              17 | store      |  6005003 |        5 |           6 |  123264.11 |              33
 store      |  6005004 |        5 |           6 |   12062.03 |              10 | store      |  6005004 |        5 |           6 |   29649.99 |               6
 store      |  6005005 |        5 |           6 |   54734.32 |              14 | store      |  6005005 |        5 |           6 |   65662.32 |              25
 store      |  6005006 |        5 |           6 |   93379.14 |              32 | store      |  6005006 |        5 |           6 |  122518.86 |              31
 store      |  6005007 |        5 |           6 |   30337.70 |               8 | store      |  6005007 |        5 |           6 |   72291.67 |              21
 store      |  6005008 |        5 |           6 |  114108.82 |              37 | store      |  6005008 |        5 |           6 |  112135.49 |              37
 store      |  6006001 |        6 |           6 |  144814.28 |              34 | store      |  6006001 |        6 |           6 |  223736.09 |              55
 store      |  6006002 |        6 |           6 |  139237.02 |              39 | store      |  6006002 |        6 |           6 |  101456.62 |              29
 store      |  6006003 |        6 |           6 |   53417.80 |              24 | store      |  6006003 |        6 |           6 |  144750.38 |              42
 store      |  6006004 |        6 |           6 |   42112.33 |              19 | store      |  6006004 |        6 |           6 |   60829.13 |              18
 store      |  6006005 |        6 |           6 |   15613.92 |               7 | store      |  6006005 |        6 |           6 |  113234.07 |              28
 store      |  6006006 |        6 |           6 |   88124.85 |              28 | store      |  6006006 |        6 |           6 |   89666.55 |              24
 store      |  6006007 |        6 |           6 |   94202.44 |              18 | store      |  6006007 |        6 |           6 |  301568.09 |              75
 store      |  6006008 |        6 |           6 |   78972.66 |              20 | store      |  6006008 |        6 |           6 |  116479.18 |              40
 store      |  6007001 |        7 |           6 |   44088.00 |               9 | store      |  6007001 |        7 |           6 |  107970.06 |              29
 store      |  6007002 |        7 |           6 |  169139.69 |              35 | store      |  6007002 |        7 |           6 |   38887.04 |               9
 store      |  6007003 |        7 |           6 |  100672.16 |              29 | store      |  6007003 |        7 |           6 |  301643.01 |              75
 store      |  6007004 |        7 |           6 |  124328.19 |              33 | store      |  6007004 |        7 |           6 |  163966.76 |              37
 store      |  6007005 |        7 |           6 |  103043.46 |              22 | store      |  6007005 |        7 |           6 |  119233.06 |              33
 store      |  6007006 |        7 |           6 |  120586.18 |              36 | store      |  6007006 |        7 |           6 |  191407.47 |              44
 store      |  6007007 |        7 |           6 |   98921.22 |              26 | store      |  6007007 |        7 |           6 |  190268.95 |              53
 store      |  6007008 |        7 |           6 |   61430.24 |              23 | store      |  6007008 |        7 |           6 |   44779.74 |              12
 store      |  6008001 |        8 |           6 |  105478.14 |              27 | store      |  6008001 |        8 |           6 |  173830.52 |              42
 store      |  6008002 |        8 |           6 |   77733.03 |              21 | store      |  6008002 |        8 |           6 |   61873.21 |              17
 store      |  6008003 |        8 |           6 |  139097.59 |              33 | store      |  6008003 |        8 |           6 |  193940.27 |              41
 store      |  6008004 |        8 |           6 |   95310.63 |              30 | store      |  6008004 |        8 |           6 |   67801.58 |              18
(100 rows)

