                                                                                                 QUERY PLAN                                                                                                 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=1271411.11..1271411.36 rows=13 width=108) (actual time=8584.862..8584.949 rows=100 loops=1)
   CTE cross_items
     ->  Hash Join  (cost=434184.00..437285.50 rows=3 width=4) (actual time=5625.159..5653.764 rows=29814 loops=1)
           Hash Cond: ((i_brand_id = r2.brand_id) AND (i_class_id = r2.class_id) AND (i_category_id = r2.category_id))
           ->  Remote Subquery Scan on all (dn1)  (cost=100.00..3674.00 rows=36000 width=16) (actual time=7.966..23.381 rows=36000 loops=1)
           ->  Hash  (cost=434121.00..434121.00 rows=3600 width=12) (actual time=5617.175..5617.175 rows=3763 loops=1)
                 Buckets: 4096  Batches: 1  Memory Usage: 194kB
                 ->  Subquery Scan on r2  (cost=3510.29..434121.00 rows=3600 width=12) (actual time=5616.203..5616.692 rows=3833 loops=1)
                       ->  HashSetOp Intersect  (cost=3510.29..434085.00 rows=3600 width=16) (actual time=5616.201..5616.378 rows=3833 loops=1)
                             ->  Append  (cost=3510.29..433896.10 rows=25187 width=16) (actual time=4758.303..5423.505 rows=1293892 loops=1)
                                   ->  Result  (cost=3510.29..359906.14 rows=3600 width=16) (actual time=4758.303..4759.603 rows=3833 loops=1)
                                         ->  HashSetOp Intersect  (cost=3510.29..359870.14 rows=3600 width=16) (actual time=4758.301..4758.881 rows=3833 loops=1)
                                               ->  Append  (cost=3510.29..358898.87 rows=129503 width=16) (actual time=17.957..3664.358 rows=7511572 loops=1)
                                                     ->  Subquery Scan on "*SELECT* 1"  (cost=3510.29..215065.24 rows=86338 width=16) (actual time=17.957..2183.128 rows=4940815 loops=1)
                                                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=3510.29..214201.86 rows=86338 width=12) (actual time=17.946..1097.653 rows=4940815 loops=1)
                                                     ->  Subquery Scan on "*SELECT* 2"  (cost=3510.29..143833.63 rows=43165 width=16) (actual time=16.986..1143.109 rows=2570757 loops=1)
                                                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=3510.29..143401.98 rows=43165 width=12) (actual time=16.975..593.168 rows=2570757 loops=1)
                                   ->  Subquery Scan on "*SELECT* 3"  (cost=3510.29..73989.96 rows=21587 width=16) (actual time=33.411..598.161 rows=1290059 loops=1)
                                         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=3510.29..73774.09 rows=21587 width=12) (actual time=33.399..321.766 rows=1290059 loops=1)
   CTE avg_sales
     ->  Finalize Aggregate  (cost=421284.23..421284.24 rows=1 width=32) (actual time=1452.433..1452.433 rows=1 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=421284.21..421284.22 rows=1 width=32) (actual time=1423.582..1452.359 rows=3 loops=1)
   ->  GroupAggregate  (cost=412841.37..412841.62 rows=13 width=108) (actual time=8584.861..8584.935 rows=100 loops=1)
         Group Key: ('store'::text), i_brand_id, i_class_id, i_category_id
         Group Key: ('store'::text), i_brand_id, i_class_id
         Group Key: ('store'::text), i_brand_id
         Group Key: ('store'::text)
         Group Key: ()
         ->  Sort  (cost=412841.37..412841.38 rows=3 width=84) (actual time=8584.846..8584.848 rows=71 loops=1)
               Sort Key: ('store'::text), i_brand_id, i_class_id, i_category_id
               Sort Method: quicksort  Memory: 1237kB
               ->  Append  (cost=203922.81..412841.35 rows=3 width=84) (actual time=7764.416..8578.664 rows=10912 loops=1)
                     ->  GroupAggregate  (cost=203922.81..203922.86 rows=1 width=84) (actual time=7764.415..7871.517 rows=3740 loops=1)
                           Group Key: i_brand_id, i_class_id, i_category_id
                           Filter: (sum(((ss_quantity)::numeric * ss_list_price)) > $8)
                           InitPlan 3 (returns $8)
                             ->  CTE Scan on avg_sales  (cost=0.00..0.02 rows=1 width=32) (actual time=1452.436..1452.436 rows=1 loops=1)
                           ->  Sort  (cost=203922.79..203922.80 rows=1 width=22) (actual time=6311.004..6339.642 rows=264594 loops=1)
                                 Sort Key: i_brand_id, i_class_id, i_category_id
                                 Sort Method: quicksort  Memory: 32764kB
                                 ->  Hash Join  (cost=3071.33..203922.78 rows=1 width=22) (actual time=5722.876..6219.198 rows=264594 loops=1)
                                       Hash Cond: (ss_item_sk = i_item_sk)
                                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=218.13..201121.88 rows=3430 width=14) (actual time=10.287..359.960 rows=265708 loops=1)
                                       ->  Hash  (cost=2953.17..2953.17 rows=3 width=20) (actual time=5712.488..5712.488 rows=29814 loops=1)
                                             Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1770kB
                                             ->  Hash Join  (cost=0.14..2953.17 rows=3 width=20) (actual time=5677.174..5708.187 rows=29814 loops=1)
                                                   Hash Cond: (i_item_sk = cross_items.ss_item_sk)
                                                   ->  Remote Subquery Scan on all (dn1)  (cost=100.00..3674.00 rows=36000 width=16) (actual time=5.898..22.747 rows=36000 loops=1)
                                                   ->  Hash  (cost=0.10..0.10 rows=3 width=4) (actual time=5671.228..5671.228 rows=29814 loops=1)
                                                         Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1305kB
                                                         ->  HashAggregate  (cost=0.07..0.10 rows=3 width=4) (actual time=5665.456..5668.607 rows=29814 loops=1)
                                                               Group Key: cross_items.ss_item_sk
                                                               ->  CTE Scan on cross_items  (cost=0.00..0.06 rows=3 width=4) (actual time=5625.161..5658.326 rows=29814 loops=1)
                     ->  GroupAggregate  (cost=138043.48..138043.52 rows=1 width=84) (actual time=377.918..429.928 rows=3716 loops=1)
                           Group Key: i_brand_id, i_class_id, i_category_id
                           Filter: (sum(((cs_quantity)::numeric * cs_list_price)) > $9)
                           Rows Removed by Filter: 24
                           InitPlan 4 (returns $9)
                             ->  CTE Scan on avg_sales avg_sales_1  (cost=0.00..0.02 rows=1 width=32) (actual time=0.001..0.001 rows=1 loops=1)
                           ->  Sort  (cost=138043.46..138043.46 rows=1 width=22) (actual time=377.450..387.597 rows=139226 loops=1)
                                 Sort Key: i_brand_id, i_class_id, i_category_id
                                 Sort Method: quicksort  Memory: 17010kB
                                 ->  Hash Join  (cost=3071.33..138043.45 rows=1 width=22) (actual time=126.127..336.096 rows=139226 loops=1)
                                       Hash Cond: (cs_item_sk = i_item_sk)
                                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=218.13..135216.39 rows=1715 width=14) (actual time=70.669..216.815 rows=139793 loops=1)
                                       ->  Hash  (cost=2953.17..2953.17 rows=3 width=20) (actual time=55.433..55.434 rows=29814 loops=1)
                                             Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1770kB
                                             ->  Hash Join  (cost=0.14..2953.17 rows=3 width=20) (actual time=19.079..51.742 rows=29814 loops=1)
                                                   Hash Cond: (i_item_sk = cross_items_1.ss_item_sk)
                                                   ->  Remote Subquery Scan on all (dn2)  (cost=100.00..3674.00 rows=36000 width=16) (actual time=5.922..23.883 rows=36000 loops=1)
                                                   ->  Hash  (cost=0.10..0.10 rows=3 width=4) (actual time=13.143..13.143 rows=29814 loops=1)
                                                         Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1305kB
                                                         ->  HashAggregate  (cost=0.07..0.10 rows=3 width=4) (actual time=7.408..10.726 rows=29814 loops=1)
                                                               Group Key: cross_items_1.ss_item_sk
                                                               ->  CTE Scan on cross_items cross_items_1  (cost=0.00..0.06 rows=3 width=4) (actual time=0.002..1.819 rows=29814 loops=1)
                     ->  GroupAggregate  (cost=70874.89..70874.94 rows=1 width=84) (actual time=250.989..276.696 rows=3456 loops=1)
                           Group Key: i_brand_id, i_class_id, i_category_id
                           Filter: (sum(((ws_quantity)::numeric * ws_list_price)) > $10)
                           Rows Removed by Filter: 246
                           InitPlan 5 (returns $10)
                             ->  CTE Scan on avg_sales avg_sales_2  (cost=0.00..0.02 rows=1 width=32) (actual time=0.001..0.001 rows=1 loops=1)
                           ->  Sort  (cost=70874.87..70874.88 rows=1 width=22) (actual time=250.754..254.380 rows=68554 loops=1)
                                 Sort Key: i_brand_id, i_class_id, i_category_id
                                 Sort Method: quicksort  Memory: 8428kB
                                 ->  Hash Join  (cost=3071.33..70874.86 rows=1 width=22) (actual time=81.964..230.493 rows=68554 loops=1)
                                       Hash Cond: (ws_item_sk = i_item_sk)
                                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=218.13..68034.73 rows=858 width=14) (actual time=6.810..121.103 rows=68846 loops=1)
                                       ->  Hash  (cost=2953.17..2953.17 rows=3 width=20) (actual time=75.110..75.110 rows=29814 loops=1)
                                             Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1770kB
                                             ->  Hash Join  (cost=0.14..2953.17 rows=3 width=20) (actual time=20.483..71.155 rows=29814 loops=1)
                                                   Hash Cond: (i_item_sk = cross_items_2.ss_item_sk)
                                                   ->  Remote Subquery Scan on all (dn1)  (cost=100.00..3674.00 rows=36000 width=16) (actual time=7.161..40.450 rows=36000 loops=1)
                                                   ->  Hash  (cost=0.10..0.10 rows=3 width=4) (actual time=13.281..13.281 rows=29814 loops=1)
                                                         Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1305kB
                                                         ->  HashAggregate  (cost=0.07..0.10 rows=3 width=4) (actual time=7.881..10.927 rows=29814 loops=1)
                                                               Group Key: cross_items_2.ss_item_sk
                                                               ->  CTE Scan on cross_items cross_items_2  (cost=0.00..0.06 rows=3 width=4) (actual time=0.001..1.934 rows=29814 loops=1)
 Planning time: 2.166 ms
 Execution time: 8620.484 ms
(99 rows)

 ty_channel | ty_brand | ty_class | ty_category |  ty_sales  | ty_number_sales | ly_channel | ly_brand | ly_class | ly_category |  ly_sales  | ly_number_sales 
------------+----------+----------+-------------+------------+-----------------+------------+----------+----------+-------------+------------+-----------------
 store      |  1001001 |        1 |           1 | 4380572.68 |            1144 | store      |  1001001 |        1 |           1 | 3909601.22 |            1054
 store      |  1001002 |        1 |           1 | 2122813.90 |             629 | store      |  1001002 |        1 |           1 | 2310060.17 |             602
 store      |  1002001 |        2 |           1 | 3895485.71 |            1076 | store      |  1002001 |        2 |           1 | 4091563.78 |            1094
 store      |  1002002 |        2 |           1 | 2075421.39 |             541 | store      |  1002002 |        2 |           1 | 1853536.48 |             509
 store      |  1003001 |        3 |           1 | 3428755.31 |             910 | store      |  1003001 |        3 |           1 | 3353015.33 |             898
 store      |  1003002 |        3 |           1 | 1758404.00 |             455 | store      |  1003002 |        3 |           1 | 1935208.96 |             498
 store      |  1004001 |        4 |           1 | 3539786.41 |             985 | store      |  1004001 |        4 |           1 | 3581781.71 |             981
 store      |  1004002 |        4 |           1 | 2185744.56 |             571 | store      |  1004002 |        4 |           1 | 2086047.47 |             566
 store      |  2001001 |        1 |           2 | 4102257.37 |            1073 | store      |  2001001 |        1 |           2 | 4237289.92 |            1123
 store      |  2001002 |        1 |           2 | 1742087.46 |             439 | store      |  2001002 |        1 |           2 | 1689115.38 |             482
 store      |  2002001 |        2 |           2 | 3927250.47 |            1081 | store      |  2002001 |        2 |           2 | 4201325.21 |            1117
 store      |  2002002 |        2 |           2 | 2044525.89 |             539 | store      |  2002002 |        2 |           2 | 1926536.26 |             543
 store      |  2003001 |        3 |           2 | 3616040.47 |            1041 | store      |  2003001 |        3 |           2 | 3767962.00 |            1036
 store      |  2003002 |        3 |           2 | 1635515.39 |             459 | store      |  2003002 |        3 |           2 | 1847720.09 |             481
 store      |  2004001 |        4 |           2 | 4114891.44 |            1147 | store      |  2004001 |        4 |           2 | 4033550.24 |            1146
 store      |  2004002 |        4 |           2 | 1893498.04 |             529 | store      |  2004002 |        4 |           2 | 2137402.69 |             547
 store      |  3001001 |        1 |           3 | 3861966.79 |             975 | store      |  3001001 |        1 |           3 | 3968698.83 |            1041
 store      |  3001002 |        1 |           3 | 1736226.91 |             490 | store      |  3001002 |        1 |           3 | 1922520.17 |             512
 store      |  3002001 |        2 |           3 | 4146771.61 |            1073 | store      |  3002001 |        2 |           3 | 3740585.75 |            1034
 store      |  3002002 |        2 |           3 | 1969484.90 |             505 | store      |  3002002 |        2 |           3 | 2177309.16 |             574
 store      |  3003001 |        3 |           3 | 3786432.92 |             999 | store      |  3003001 |        3 |           3 | 4114823.03 |            1096
 store      |  3003002 |        3 |           3 | 1890455.44 |             493 | store      |  3003002 |        3 |           3 | 1866132.34 |             484
 store      |  3004001 |        4 |           3 | 3588439.42 |             970 | store      |  3004001 |        4 |           3 | 3704018.39 |             982
 store      |  3004002 |        4 |           3 | 2176965.88 |             591 | store      |  3004002 |        4 |           3 | 2077783.16 |             556
 store      |  4001001 |        1 |           4 | 3966995.89 |            1064 | store      |  4001001 |        1 |           4 | 3727967.66 |            1021
 store      |  4001002 |        1 |           4 | 1829207.22 |             477 | store      |  4001002 |        1 |           4 | 1707581.31 |             479
 store      |  4002001 |        2 |           4 | 3954435.28 |            1092 | store      |  4002001 |        2 |           4 | 4012309.46 |            1105
 store      |  4002002 |        2 |           4 | 2006847.32 |             550 | store      |  4002002 |        2 |           4 | 2127336.39 |             573
 store      |  4003001 |        3 |           4 | 4240616.54 |            1126 | store      |  4003001 |        3 |           4 | 4479368.03 |            1175
 store      |  4003002 |        3 |           4 | 1977383.49 |             574 | store      |  4003002 |        3 |           4 | 1761862.37 |             503
 store      |  4004001 |        4 |           4 | 3662741.14 |            1029 | store      |  4004001 |        4 |           4 | 3501603.40 |             904
 store      |  4004002 |        4 |           4 | 1902508.12 |             511 | store      |  4004002 |        4 |           4 | 1821349.65 |             504
 store      |  5001001 |        1 |           5 | 3661158.74 |             955 | store      |  5001001 |        1 |           5 | 3547050.73 |             976
 store      |  5001002 |        1 |           5 | 1834335.91 |             546 | store      |  5001002 |        1 |           5 | 2147810.04 |             553
 store      |  5002001 |        2 |           5 | 3811284.05 |            1014 | store      |  5002001 |        2 |           5 | 3946463.01 |            1027
 store      |  5002002 |        2 |           5 | 1908489.83 |             520 | store      |  5002002 |        2 |           5 | 2035132.79 |             533
 store      |  5003001 |        3 |           5 | 4028786.05 |            1125 | store      |  5003001 |        3 |           5 | 3933717.44 |            1099
 store      |  5003002 |        3 |           5 | 2268484.45 |             588 | store      |  5003002 |        3 |           5 | 2228705.94 |             638
 store      |  5004001 |        4 |           5 | 4486361.22 |            1204 | store      |  5004001 |        4 |           5 | 4279053.60 |            1188
 store      |  5004002 |        4 |           5 | 2307211.09 |             612 | store      |  5004002 |        4 |           5 | 2217089.29 |             607
 store      |  6001001 |        1 |           6 |  318180.67 |              89 | store      |  6001001 |        1 |           6 |  402979.41 |             103
 store      |  6001002 |        1 |           6 |  128510.86 |              39 | store      |  6001002 |        1 |           6 |  224241.44 |              58
 store      |  6001003 |        1 |           6 |  172322.34 |              45 | store      |  6001003 |        1 |           6 |  176773.09 |              45
 store      |  6001004 |        1 |           6 |  125140.27 |              24 | store      |  6001004 |        1 |           6 |   87297.50 |              23
 store      |  6001005 |        1 |           6 |  224816.50 |              64 | store      |  6001005 |        1 |           6 |  183560.08 |              63
 store      |  6001006 |        1 |           6 |  138748.32 |              37 | store      |  6001006 |        1 |           6 |   97241.59 |              30
 store      |  6001007 |        1 |           6 |  134271.62 |              32 | store      |  6001007 |        1 |           6 |  169203.71 |              37
 store      |  6001008 |        1 |           6 |  142962.94 |              37 | store      |  6001008 |        1 |           6 |  119604.18 |              32
 store      |  6002001 |        2 |           6 |  217136.22 |              56 | store      |  6002001 |        2 |           6 |  265200.59 |              78
 store      |  6002002 |        2 |           6 |   93448.89 |              25 | store      |  6002002 |        2 |           6 |   85380.19 |              25
 store      |  6002003 |        2 |           6 |  219434.82 |              63 | store      |  6002003 |        2 |           6 |  212306.84 |              50
 store      |  6002004 |        2 |           6 |  118690.05 |              30 | store      |  6002004 |        2 |           6 |  114942.86 |              30
 store      |  6002005 |        2 |           6 |  343869.82 |              85 | store      |  6002005 |        2 |           6 |  222476.39 |              69
 store      |  6002006 |        2 |           6 |  109466.41 |              29 | store      |  6002006 |        2 |           6 |  159240.54 |              42
 store      |  6002007 |        2 |           6 |  146497.26 |              44 | store      |  6002007 |        2 |           6 |  164460.05 |              45
 store      |  6002008 |        2 |           6 |   78411.95 |              23 | store      |  6002008 |        2 |           6 |   81362.76 |              23
 store      |  6003001 |        3 |           6 |  172616.41 |              62 | store      |  6003001 |        3 |           6 |  206945.22 |              53
 store      |  6003002 |        3 |           6 |  225305.92 |              49 | store      |  6003002 |        3 |           6 |  171574.65 |              53
 store      |  6003003 |        3 |           6 |  284144.87 |              78 | store      |  6003003 |        3 |           6 |  345421.82 |             106
 store      |  6003004 |        3 |           6 |  165387.16 |              46 | store      |  6003004 |        3 |           6 |  124131.04 |              31
 store      |  6003005 |        3 |           6 |  358218.67 |             101 | store      |  6003005 |        3 |           6 |  397583.87 |              94
 store      |  6003006 |        3 |           6 |   94578.86 |              31 | store      |  6003006 |        3 |           6 |  113062.80 |              29
 store      |  6003007 |        3 |           6 |  359497.66 |              85 | store      |  6003007 |        3 |           6 |  313083.10 |              82
 store      |  6003008 |        3 |           6 |  213123.23 |              59 | store      |  6003008 |        3 |           6 |  277033.89 |              69
 store      |  6004001 |        4 |           6 |  128987.24 |              41 | store      |  6004001 |        4 |           6 |  142545.64 |              43
 store      |  6004002 |        4 |           6 |   64786.67 |              18 | store      |  6004002 |        4 |           6 |   98998.38 |              38
 store      |  6004003 |        4 |           6 |  163462.62 |              49 | store      |  6004003 |        4 |           6 |  183637.38 |              44
 store      |  6004004 |        4 |           6 |   64009.21 |              13 | store      |  6004004 |        4 |           6 |   60753.77 |              20
 store      |  6004005 |        4 |           6 |  179270.32 |              48 | store      |  6004005 |        4 |           6 |  210578.81 |              46
 store      |  6004006 |        4 |           6 |   62321.17 |              20 | store      |  6004006 |        4 |           6 |   86605.07 |              22
 store      |  6004007 |        4 |           6 |  178751.82 |              41 | store      |  6004007 |        4 |           6 |  167488.91 |              50
 store      |  6004008 |        4 |           6 |   58123.96 |              10 | store      |  6004008 |        4 |           6 |   50239.73 |              18
 store      |  6005001 |        5 |           6 |  298643.21 |              86 | store      |  6005001 |        5 |           6 |  401907.85 |             100
 store      |  6005002 |        5 |           6 |  148949.05 |              42 | store      |  6005002 |        5 |           6 |  131346.68 |              38
 store      |  6005003 |        5 |           6 |  170369.54 |              42 | store      |  6005003 |        5 |           6 |  210562.43 |              50
 store      |  6005004 |        5 |           6 |   27862.90 |               8 | store      |  6005004 |        5 |           6 |   33624.80 |               6
 store      |  6005005 |        5 |           6 |  120416.70 |              51 | store      |  6005005 |        5 |           6 |  140415.79 |              48
 store      |  6005006 |        5 |           6 |  111832.27 |              35 | store      |  6005006 |        5 |           6 |  119978.14 |              34
 store      |  6005007 |        5 |           6 |  137947.71 |              36 | store      |  6005007 |        5 |           6 |  110449.24 |              41
 store      |  6005008 |        5 |           6 |  159262.97 |              42 | store      |  6005008 |        5 |           6 |  100665.40 |              27
 store      |  6006001 |        6 |           6 |  227477.77 |              54 | store      |  6006001 |        6 |           6 |  245451.51 |              58
 store      |  6006002 |        6 |           6 |   67579.85 |              21 | store      |  6006002 |        6 |           6 |  117237.11 |              35
 store      |  6006003 |        6 |           6 |  334471.11 |              80 | store      |  6006003 |        6 |           6 |  252031.35 |              69
 store      |  6006004 |        6 |           6 |  130664.59 |              39 | store      |  6006004 |        6 |           6 |  149020.19 |              40
 store      |  6006005 |        6 |           6 |  183774.19 |              55 | store      |  6006005 |        6 |           6 |  149282.60 |              40
 store      |  6006006 |        6 |           6 |   80394.24 |              22 | store      |  6006006 |        6 |           6 |  105286.86 |              26
 store      |  6006007 |        6 |           6 |  326553.05 |              97 | store      |  6006007 |        6 |           6 |  272450.18 |              77
 store      |  6006008 |        6 |           6 |  154879.78 |              37 | store      |  6006008 |        6 |           6 |  147682.82 |              51
 store      |  6007001 |        7 |           6 |  203053.07 |              61 | store      |  6007001 |        7 |           6 |  211140.43 |              53
 store      |  6007002 |        7 |           6 |   78619.60 |              28 | store      |  6007002 |        7 |           6 |   91291.47 |              27
 store      |  6007003 |        7 |           6 |  388969.68 |             102 | store      |  6007003 |        7 |           6 |  374609.55 |             110
 store      |  6007004 |        7 |           6 |  146923.33 |              39 | store      |  6007004 |        7 |           6 |  118070.45 |              25
 store      |  6007005 |        7 |           6 |  244902.30 |              66 | store      |  6007005 |        7 |           6 |  176569.93 |              58
 store      |  6007006 |        7 |           6 |  212884.36 |              43 | store      |  6007006 |        7 |           6 |  147249.86 |              48
 store      |  6007007 |        7 |           6 |  374104.71 |              96 | store      |  6007007 |        7 |           6 |  243149.37 |              73
 store      |  6007008 |        7 |           6 |   92245.18 |              19 | store      |  6007008 |        7 |           6 |  125795.22 |              30
 store      |  6008001 |        8 |           6 |  217629.02 |              66 | store      |  6008001 |        8 |           6 |  227908.00 |              66
 store      |  6008002 |        8 |           6 |  220703.02 |              55 | store      |  6008002 |        8 |           6 |  146984.50 |              40
 store      |  6008003 |        8 |           6 |  352280.90 |              84 | store      |  6008003 |        8 |           6 |  276203.48 |              78
 store      |  6008004 |        8 |           6 |   52791.59 |              18 | store      |  6008004 |        8 |           6 |   57889.07 |              14
(100 rows)

