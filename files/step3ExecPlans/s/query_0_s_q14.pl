                                                                                         QUERY PLAN                                                                                         
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=432924.66..432924.91 rows=13 width=108) (actual time=4398.788..4398.868 rows=100 loops=1)
   CTE cross_items
     ->  Hash Join  (cost=3055.28..147401.28 rows=1 width=4) (actual time=2256.337..2259.014 rows=16193 loops=1)
           Hash Cond: ((r2.brand_id = i_brand_id) AND (r2.class_id = i_class_id) AND (r2.category_id = i_category_id))
           ->  Subquery Scan on r2  (cost=2480.28..146406.78 rows=948 width=12) (actual time=2235.308..2235.772 rows=3837 loops=1)
                 ->  HashSetOp Intersect  (cost=2480.28..146397.30 rows=948 width=16) (actual time=2235.307..2235.486 rows=3837 loops=1)
                       ->  Append  (cost=2480.28..146354.29 rows=5734 width=16) (actual time=1897.877..2175.770 rows=435895 loops=1)
                             ->  Result  (cost=2480.28..120709.57 rows=948 width=16) (actual time=1897.877..1898.359 rows=3837 loops=1)
                                   ->  HashSetOp Intersect  (cost=2480.28..120700.09 rows=948 width=16) (actual time=1897.876..1898.085 rows=3837 loops=1)
                                         ->  Append  (cost=2480.28..120484.41 rows=28757 width=16) (actual time=15.784..1564.229 rows=2504247 loops=1)
                                               ->  Subquery Scan on "*SELECT* 1"  (cost=2480.28..71786.53 rows=19166 width=16) (actual time=15.783..938.780 rows=1644312 loops=1)
                                                     ->  Remote Subquery Scan on all (dn0)  (cost=2480.28..71594.87 rows=19166 width=12) (actual time=15.778..616.735 rows=1644312 loops=1)
                                               ->  Subquery Scan on "*SELECT* 2"  (cost=2480.28..48697.88 rows=9591 width=16) (actual time=39.919..525.522 rows=859935 loops=1)
                                                     ->  Remote Subquery Scan on all (dn0)  (cost=2480.28..48601.97 rows=9591 width=12) (actual time=39.911..357.369 rows=859935 loops=1)
                             ->  Subquery Scan on "*SELECT* 3"  (cost=2480.28..25644.72 rows=4786 width=16) (actual time=15.963..260.109 rows=432058 loops=1)
                                   ->  Remote Subquery Scan on all (dn0)  (cost=2480.28..25596.86 rows=4786 width=12) (actual time=15.955..176.282 rows=432058 loops=1)
           ->  Hash  (cost=696.00..696.00 rows=6000 width=16) (actual time=21.010..21.010 rows=17931 loops=1)
                 Buckets: 32768 (originally 8192)  Batches: 1 (originally 1)  Memory Usage: 1097kB
                 ->  Remote Subquery Scan on all (dn0)  (cost=100.00..696.00 rows=6000 width=16) (actual time=11.067..15.617 rows=18000 loops=1)
   CTE avg_sales
     ->  Finalize Aggregate  (cost=143938.81..143938.82 rows=1 width=32) (actual time=1431.416..1431.416 rows=1 loops=1)
           ->  Remote Subquery Scan on all (dn0)  (cost=143938.79..143938.81 rows=1 width=32) (actual time=1431.402..1431.403 rows=1 loops=1)
   ->  GroupAggregate  (cost=141584.56..141584.81 rows=13 width=108) (actual time=4398.786..4398.855 rows=100 loops=1)
         Group Key: ('store'::text), i_brand_id, i_class_id, i_category_id
         Group Key: ('store'::text), i_brand_id, i_class_id
         Group Key: ('store'::text), i_brand_id
         Group Key: ('store'::text)
         Group Key: ()
         ->  Sort  (cost=141584.56..141584.57 rows=3 width=84) (actual time=4398.775..4398.778 rows=71 loops=1)
               Sort Key: ('store'::text), i_brand_id, i_class_id, i_category_id
               Sort Method: quicksort  Memory: 1155kB
               ->  Append  (cost=69299.92..141584.54 rows=3 width=84) (actual time=4011.791..4393.296 rows=9856 loops=1)
                     ->  GroupAggregate  (cost=69299.92..69299.97 rows=1 width=84) (actual time=4011.791..4045.545 rows=3509 loops=1)
                           Group Key: i_brand_id, i_class_id, i_category_id
                           Filter: (sum(((ss_quantity)::numeric * ss_list_price)) > $8)
                           Rows Removed by Filter: 20
                           InitPlan 3 (returns $8)
                             ->  CTE Scan on avg_sales  (cost=0.00..0.02 rows=1 width=32) (actual time=1431.418..1431.418 rows=1 loops=1)
                           ->  Sort  (cost=69299.90..69299.91 rows=1 width=22) (actual time=2580.345..2587.541 rows=86582 loops=1)
                                 Sort Key: i_brand_id, i_class_id, i_category_id
                                 Sort Method: quicksort  Memory: 9773kB
                                 ->  Hash Join  (cost=2325.94..69299.89 rows=1 width=22) (actual time=2296.299..2553.691 rows=86582 loops=1)
                                       Hash Cond: (ss_item_sk = i_item_sk)
                                       ->  Remote Subquery Scan on all (dn0)  (cost=1933.38..68925.36 rows=1183 width=14) (actual time=11.677..231.197 rows=86893 loops=1)
                                       ->  Hash  (cost=492.56..492.56 rows=1 width=20) (actual time=2284.612..2284.612 rows=16193 loops=1)
                                             Buckets: 16384 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 951kB
                                             ->  Hash Join  (cost=0.04..492.56 rows=1 width=20) (actual time=2272.395..2282.617 rows=16193 loops=1)
                                                   Hash Cond: (i_item_sk = cross_items.ss_item_sk)
                                                   ->  Remote Subquery Scan on all (dn0)  (cost=100.00..696.00 rows=6000 width=16) (actual time=5.103..9.379 rows=18000 loops=1)
                                                   ->  Hash  (cost=0.03..0.03 rows=1 width=4) (actual time=2267.281..2267.281 rows=16193 loops=1)
                                                         Buckets: 16384 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 698kB
                                                         ->  HashAggregate  (cost=0.02..0.03 rows=1 width=4) (actual time=2264.487..2265.927 rows=16193 loops=1)
                                                               Group Key: cross_items.ss_item_sk
                                                               ->  CTE Scan on cross_items  (cost=0.00..0.02 rows=1 width=4) (actual time=2256.339..2261.209 rows=16193 loops=1)
                     ->  GroupAggregate  (cost=47376.47..47376.51 rows=1 width=84) (actual time=205.919..222.913 rows=3408 loops=1)
                           Group Key: i_brand_id, i_class_id, i_category_id
                           Filter: (sum(((cs_quantity)::numeric * cs_list_price)) > $9)
                           Rows Removed by Filter: 109
                           InitPlan 4 (returns $9)
                             ->  CTE Scan on avg_sales avg_sales_1  (cost=0.00..0.02 rows=1 width=32) (actual time=0.001..0.001 rows=1 loops=1)
                           ->  Sort  (cost=47376.45..47376.45 rows=1 width=22) (actual time=205.901..208.096 rows=46537 loops=1)
                                 Sort Key: i_brand_id, i_class_id, i_category_id
                                 Sort Method: quicksort  Memory: 5169kB
                                 ->  Hash Join  (cost=2325.94..47376.44 rows=1 width=22) (actual time=130.402..192.546 rows=46537 loops=1)
                                       Hash Cond: (cs_item_sk = i_item_sk)
                                       ->  Remote Subquery Scan on all (dn0)  (cost=1933.38..46992.89 rows=592 width=14) (actual time=105.082..148.158 rows=46691 loops=1)
                                       ->  Hash  (cost=492.56..492.56 rows=1 width=20) (actual time=25.293..25.293 rows=16193 loops=1)
                                             Buckets: 16384 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 951kB
                                             ->  Hash Join  (cost=0.04..492.56 rows=1 width=20) (actual time=11.574..23.368 rows=16193 loops=1)
                                                   Hash Cond: (i_item_sk = cross_items_1.ss_item_sk)
                                                   ->  Remote Subquery Scan on all (dn0)  (cost=100.00..696.00 rows=6000 width=16) (actual time=4.990..10.653 rows=18000 loops=1)
                                                   ->  Hash  (cost=0.03..0.03 rows=1 width=4) (actual time=6.575..6.575 rows=16193 loops=1)
                                                         Buckets: 16384 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 698kB
                                                         ->  HashAggregate  (cost=0.02..0.03 rows=1 width=4) (actual time=3.658..5.244 rows=16193 loops=1)
                                                               Group Key: cross_items_1.ss_item_sk
                                                               ->  CTE Scan on cross_items cross_items_1  (cost=0.00..0.02 rows=1 width=4) (actual time=0.001..0.881 rows=16193 loops=1)
                     ->  GroupAggregate  (cost=24907.98..24908.03 rows=1 width=84) (actual time=115.355..124.389 rows=2939 loops=1)
                           Group Key: i_brand_id, i_class_id, i_category_id
                           Filter: (sum(((ws_quantity)::numeric * ws_list_price)) > $10)
                           Rows Removed by Filter: 423
                           InitPlan 5 (returns $10)
                             ->  CTE Scan on avg_sales avg_sales_2  (cost=0.00..0.02 rows=1 width=32) (actual time=0.001..0.001 rows=1 loops=1)
                           ->  Sort  (cost=24907.96..24907.97 rows=1 width=22) (actual time=115.339..116.327 rows=23443 loops=1)
                                 Sort Key: i_brand_id, i_class_id, i_category_id
                                 Sort Method: quicksort  Memory: 2600kB
                                 ->  Hash Join  (cost=2325.94..24907.95 rows=1 width=22) (actual time=36.678..108.525 rows=23443 loops=1)
                                       Hash Cond: (ws_item_sk = i_item_sk)
                                       ->  Remote Subquery Scan on all (dn0)  (cost=1933.38..24519.87 rows=295 width=14) (actual time=11.519..73.284 rows=23529 loops=1)
                                       ->  Hash  (cost=492.56..492.56 rows=1 width=20) (actual time=25.142..25.142 rows=16193 loops=1)
                                             Buckets: 16384 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 951kB
                                             ->  Hash Join  (cost=0.04..492.56 rows=1 width=20) (actual time=11.823..23.038 rows=16193 loops=1)
                                                   Hash Cond: (i_item_sk = cross_items_2.ss_item_sk)
                                                   ->  Remote Subquery Scan on all (dn0)  (cost=100.00..696.00 rows=6000 width=16) (actual time=5.019..10.146 rows=18000 loops=1)
                                                   ->  Hash  (cost=0.03..0.03 rows=1 width=4) (actual time=6.794..6.794 rows=16193 loops=1)
                                                         Buckets: 16384 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 698kB
                                                         ->  HashAggregate  (cost=0.02..0.03 rows=1 width=4) (actual time=3.907..5.461 rows=16193 loops=1)
                                                               Group Key: cross_items_2.ss_item_sk
                                                               ->  CTE Scan on cross_items cross_items_2  (cost=0.00..0.02 rows=1 width=4) (actual time=0.001..0.873 rows=16193 loops=1)
 Planning time: 2.264 ms
 Execution time: 4413.003 ms
(100 rows)

 ty_channel | ty_brand | ty_class | ty_category |  ty_sales  | ty_number_sales | ly_channel | ly_brand | ly_class | ly_category |  ly_sales  | ly_number_sales 
------------+----------+----------+-------------+------------+-----------------+------------+----------+----------+-------------+------------+-----------------
 store      |  1001001 |        1 |           1 |  564516.98 |             186 | store      |  1001001 |        1 |           1 | 1355972.52 |             370
 store      |  1001002 |        1 |           1 |  770168.13 |             221 | store      |  1001002 |        1 |           1 |  652087.60 |             188
 store      |  1002001 |        2 |           1 |  611324.48 |             167 | store      |  1002001 |        2 |           1 | 1349129.53 |             374
 store      |  1002002 |        2 |           1 |  801052.87 |             228 | store      |  1002002 |        2 |           1 |  551498.07 |             176
 store      |  1003001 |        3 |           1 |  634837.96 |             182 | store      |  1003001 |        3 |           1 | 1106103.98 |             301
 store      |  1003002 |        3 |           1 |  675915.71 |             199 | store      |  1003002 |        3 |           1 |  592368.94 |             135
 store      |  1004001 |        4 |           1 |  685507.24 |             198 | store      |  1004001 |        4 |           1 | 1319864.51 |             343
 store      |  1004002 |        4 |           1 |  904198.17 |             240 | store      |  1004002 |        4 |           1 |  826324.95 |             211
 store      |  2001001 |        1 |           2 |  659298.61 |             196 | store      |  2001001 |        1 |           2 | 1305030.04 |             333
 store      |  2001002 |        1 |           2 |  783789.02 |             195 | store      |  2001002 |        1 |           2 |  526044.13 |             137
 store      |  2002001 |        2 |           2 |  847805.43 |             232 | store      |  2002001 |        2 |           2 | 1468054.35 |             379
 store      |  2002002 |        2 |           2 |  834594.64 |             224 | store      |  2002002 |        2 |           2 |  563818.44 |             168
 store      |  2003001 |        3 |           2 |  531808.28 |             140 | store      |  2003001 |        3 |           2 | 1044238.01 |             279
 store      |  2003002 |        3 |           2 |  794085.07 |             207 | store      |  2003002 |        3 |           2 |  564564.59 |             145
 store      |  2004001 |        4 |           2 |  758678.44 |             216 | store      |  2004001 |        4 |           2 | 1512675.85 |             392
 store      |  2004002 |        4 |           2 |  731165.67 |             199 | store      |  2004002 |        4 |           2 |  582283.77 |             152
 store      |  3001001 |        1 |           3 |  508528.85 |             146 | store      |  3001001 |        1 |           3 | 1052713.14 |             315
 store      |  3001002 |        1 |           3 |  711128.33 |             193 | store      |  3001002 |        1 |           3 |  552310.03 |             163
 store      |  3002001 |        2 |           3 |  636985.09 |             183 | store      |  3002001 |        2 |           3 | 1204626.94 |             353
 store      |  3002002 |        2 |           3 |  833124.01 |             211 | store      |  3002002 |        2 |           3 |  626137.45 |             193
 store      |  3003001 |        3 |           3 |  784606.56 |             223 | store      |  3003001 |        3 |           3 | 1382462.19 |             359
 store      |  3003002 |        3 |           3 |  644822.62 |             191 | store      |  3003002 |        3 |           3 |  616313.62 |             158
 store      |  3004001 |        4 |           3 |  675325.69 |             165 | store      |  3004001 |        4 |           3 | 1082005.38 |             286
 store      |  3004002 |        4 |           3 |  832669.62 |             250 | store      |  3004002 |        4 |           3 |  685359.41 |             207
 store      |  4001001 |        1 |           4 |  636973.81 |             174 | store      |  4001001 |        1 |           4 | 1279028.65 |             365
 store      |  4001002 |        1 |           4 |  767432.69 |             213 | store      |  4001002 |        1 |           4 |  591154.07 |             161
 store      |  4002001 |        2 |           4 |  693037.57 |             183 | store      |  4002001 |        2 |           4 | 1294923.33 |             348
 store      |  4002002 |        2 |           4 | 1018050.11 |             284 | store      |  4002002 |        2 |           4 |  721357.55 |             218
 store      |  4003001 |        3 |           4 |  820265.62 |             213 | store      |  4003001 |        3 |           4 | 1485299.10 |             412
 store      |  4003002 |        3 |           4 |  856594.00 |             227 | store      |  4003002 |        3 |           4 |  596051.39 |             166
 store      |  4004001 |        4 |           4 |  732159.21 |             199 | store      |  4004001 |        4 |           4 | 1537850.70 |             394
 store      |  4004002 |        4 |           4 |  881854.80 |             235 | store      |  4004002 |        4 |           4 |  585924.31 |             154
 store      |  5001001 |        1 |           5 |  508520.30 |             156 | store      |  5001001 |        1 |           5 | 1287462.52 |             327
 store      |  5001002 |        1 |           5 |  655764.17 |             188 | store      |  5001002 |        1 |           5 |  631858.84 |             162
 store      |  5002001 |        2 |           5 |  668686.07 |             168 | store      |  5002001 |        2 |           5 | 1186313.49 |             297
 store      |  5002002 |        2 |           5 |  681735.46 |             194 | store      |  5002002 |        2 |           5 |  606296.62 |             171
 store      |  5003001 |        3 |           5 |  738687.24 |             194 | store      |  5003001 |        3 |           5 | 1442391.77 |             398
 store      |  5003002 |        3 |           5 |  900093.08 |             215 | store      |  5003002 |        3 |           5 |  678338.94 |             208
 store      |  5004001 |        4 |           5 |  835035.91 |             213 | store      |  5004001 |        4 |           5 | 1475793.16 |             400
 store      |  5004002 |        4 |           5 |  860967.19 |             234 | store      |  5004002 |        4 |           5 |  497430.41 |             164
 store      |  6001001 |        1 |           6 |   28900.95 |               5 | store      |  6001001 |        1 |           6 |   72248.80 |              15
 store      |  6001002 |        1 |           6 |   82312.93 |              22 | store      |  6001002 |        1 |           6 |   76749.88 |              18
 store      |  6001003 |        1 |           6 |   35065.27 |               7 | store      |  6001003 |        1 |           6 |   54109.17 |              15
 store      |  6001004 |        1 |           6 |   39352.79 |               8 | store      |  6001004 |        1 |           6 |    8646.15 |               4
 store      |  6001005 |        1 |           6 |   50966.39 |              11 | store      |  6001005 |        1 |           6 |   95101.74 |              21
 store      |  6001006 |        1 |           6 |   32952.24 |              13 | store      |  6001006 |        1 |           6 |   28611.85 |               6
 store      |  6001007 |        1 |           6 |   27484.71 |              10 | store      |  6001007 |        1 |           6 |   79755.51 |              22
 store      |  6001008 |        1 |           6 |   89058.34 |              27 | store      |  6001008 |        1 |           6 |  112536.54 |              26
 store      |  6002001 |        2 |           6 |  113229.18 |              25 | store      |  6002001 |        2 |           6 |   50021.20 |              18
 store      |  6002002 |        2 |           6 |  102376.15 |              21 | store      |  6002002 |        2 |           6 |   37979.23 |              10
 store      |  6002003 |        2 |           6 |   10111.45 |               3 | store      |  6002003 |        2 |           6 |   97399.56 |              25
 store      |  6002004 |        2 |           6 |   71805.65 |               9 | store      |  6002004 |        2 |           6 |   20793.84 |               8
 store      |  6002005 |        2 |           6 |   69741.20 |              13 | store      |  6002005 |        2 |           6 |   67920.13 |              28
 store      |  6002006 |        2 |           6 |   33122.15 |               9 | store      |  6002006 |        2 |           6 |    5382.70 |               5
 store      |  6002007 |        2 |           6 |   18676.25 |               6 | store      |  6002007 |        2 |           6 |   75406.18 |              21
 store      |  6002008 |        2 |           6 |   35394.12 |               9 | store      |  6002008 |        2 |           6 |   39536.95 |               8
 store      |  6003001 |        3 |           6 |    4910.65 |               4 | store      |  6003001 |        3 |           6 |   90527.47 |              23
 store      |  6003002 |        3 |           6 |   38640.03 |              19 | store      |  6003002 |        3 |           6 |   56168.11 |              18
 store      |  6003003 |        3 |           6 |    4422.28 |               2 | store      |  6003003 |        3 |           6 |  109108.91 |              30
 store      |  6003004 |        3 |           6 |   72536.85 |              14 | store      |  6003004 |        3 |           6 |   49678.35 |              15
 store      |  6003005 |        3 |           6 |  118700.85 |              23 | store      |  6003005 |        3 |           6 |  127627.61 |              35
 store      |  6003006 |        3 |           6 |   47335.64 |              12 | store      |  6003006 |        3 |           6 |   46966.05 |              12
 store      |  6003007 |        3 |           6 |   50419.40 |              20 | store      |  6003007 |        3 |           6 |  117851.84 |              37
 store      |  6003008 |        3 |           6 |   73266.42 |              21 | store      |  6003008 |        3 |           6 |   52146.22 |              14
 store      |  6004001 |        4 |           6 |   18273.56 |               3 | store      |  6004001 |        4 |           6 |   56777.80 |              12
 store      |  6004002 |        4 |           6 |   37980.68 |              10 | store      |  6004002 |        4 |           6 |   11310.40 |               2
 store      |  6004003 |        4 |           6 |   25788.85 |               7 | store      |  6004003 |        4 |           6 |   47697.09 |              15
 store      |  6004004 |        4 |           6 |   42891.64 |              10 | store      |  6004004 |        4 |           6 |   17587.84 |               7
 store      |  6004005 |        4 |           6 |   27480.99 |               4 | store      |  6004005 |        4 |           6 |   44956.13 |              14
 store      |  6004006 |        4 |           6 |   83500.22 |              19 | store      |  6004006 |        4 |           6 |   35562.32 |               9
 store      |  6004007 |        4 |           6 |   53663.49 |              11 | store      |  6004007 |        4 |           6 |   28640.46 |              10
 store      |  6004008 |        4 |           6 |   81512.06 |              19 | store      |  6004008 |        4 |           6 |   28227.49 |               6
 store      |  6005001 |        5 |           6 |   93358.36 |              15 | store      |  6005001 |        5 |           6 |  144629.80 |              32
 store      |  6005002 |        5 |           6 |   52502.23 |              16 | store      |  6005002 |        5 |           6 |   15664.49 |               9
 store      |  6005003 |        5 |           6 |   36341.60 |               5 | store      |  6005003 |        5 |           6 |   33206.06 |               9
 store      |  6005005 |        5 |           6 |   19448.74 |               6 | store      |  6005005 |        5 |           6 |   59494.32 |              19
 store      |  6005006 |        5 |           6 |   51675.15 |              14 | store      |  6005006 |        5 |           6 |   66944.49 |              19
 store      |  6005008 |        5 |           6 |    8001.96 |               6 | store      |  6005008 |        5 |           6 |   26237.09 |               8
 store      |  6006001 |        6 |           6 |   74497.83 |              23 | store      |  6006001 |        6 |           6 |   76678.00 |              22
 store      |  6006002 |        6 |           6 |   83873.50 |              27 | store      |  6006002 |        6 |           6 |   65248.15 |              17
 store      |  6006003 |        6 |           6 |   71928.38 |              22 | store      |  6006003 |        6 |           6 |   84749.18 |              20
 store      |  6006004 |        6 |           6 |   29476.77 |               7 | store      |  6006004 |        6 |           6 |   22026.68 |               8
 store      |  6006005 |        6 |           6 |   10999.25 |               5 | store      |  6006005 |        6 |           6 |   85993.50 |              19
 store      |  6006006 |        6 |           6 |   33231.82 |              11 | store      |  6006006 |        6 |           6 |   35807.84 |               9
 store      |  6006007 |        6 |           6 |   23798.91 |               7 | store      |  6006007 |        6 |           6 |  152416.03 |              43
 store      |  6006008 |        6 |           6 |   47565.84 |              14 | store      |  6006008 |        6 |           6 |   45526.54 |              13
 store      |  6007002 |        7 |           6 |   23377.16 |               8 | store      |  6007002 |        7 |           6 |   12788.41 |               8
 store      |  6007003 |        7 |           6 |   45043.28 |              12 | store      |  6007003 |        7 |           6 |  125925.10 |              32
 store      |  6007004 |        7 |           6 |   52147.91 |              19 | store      |  6007004 |        7 |           6 |   69155.09 |              18
 store      |  6007005 |        7 |           6 |   21437.05 |               5 | store      |  6007005 |        7 |           6 |   28881.69 |              11
 store      |  6007006 |        7 |           6 |   89509.05 |              24 | store      |  6007006 |        7 |           6 |   69320.79 |              15
 store      |  6007007 |        7 |           6 |   33249.45 |              11 | store      |  6007007 |        7 |           6 |  115683.50 |              29
 store      |  6007008 |        7 |           6 |   41989.20 |              11 | store      |  6007008 |        7 |           6 |   26153.25 |              10
 store      |  6008001 |        8 |           6 |   65067.36 |              19 | store      |  6008001 |        8 |           6 |   61774.86 |              23
 store      |  6008002 |        8 |           6 |   34087.46 |              10 | store      |  6008002 |        8 |           6 |   18492.19 |               7
 store      |  6008003 |        8 |           6 |   60937.88 |              14 | store      |  6008003 |        8 |           6 |   45466.22 |              11
 store      |  6008004 |        8 |           6 |   65624.64 |              17 | store      |  6008004 |        8 |           6 |   72780.14 |              16
 store      |  6008005 |        8 |           6 |   65997.05 |              20 | store      |  6008005 |        8 |           6 |   94014.82 |              33
 store      |  6008006 |        8 |           6 |   10019.19 |               2 | store      |  6008006 |        8 |           6 |    6978.60 |               3
 store      |  6008007 |        8 |           6 |   20868.46 |               4 | store      |  6008007 |        8 |           6 |   55347.79 |              17
(100 rows)

