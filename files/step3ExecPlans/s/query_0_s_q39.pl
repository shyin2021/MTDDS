                                                                                      QUERY PLAN                                                                                      
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=139613.35..139613.36 rows=2 width=152) (actual time=6155.148..6155.155 rows=230 loops=1)
   Sort Key: inv1.w_warehouse_sk, inv1.i_item_sk, inv1.mean, inv1.cov, inv2.mean, inv2.cov
   Sort Method: quicksort  Memory: 57kB
   CTE inv
     ->  Subquery Scan on foo  (cost=134771.28..136959.93 rows=58364 width=126) (actual time=2869.691..6138.679 rows=34172 loops=1)
           ->  Finalize HashAggregate  (cost=134771.28..136084.47 rows=58364 width=94) (actual time=2869.689..6123.891 rows=34172 loops=1)
                 Group Key: w_warehouse_sk, i_item_sk, d_moy
                 Filter: (CASE avg(inv_quantity_on_hand) WHEN '0'::numeric THEN '0'::numeric ELSE (stddev_samp(inv_quantity_on_hand) / avg(inv_quantity_on_hand)) END > '1'::numeric)
                 Rows Removed by Filter: 505828
                 ->  Remote Subquery Scan on all (dn0)  (cost=128144.63..133555.38 rows=48636 width=94) (actual time=2024.610..2185.423 rows=540000 loops=1)
   ->  Hash Join  (cost=1317.57..2653.41 rows=2 width=152) (actual time=6152.253..6155.069 rows=230 loops=1)
         Hash Cond: ((inv1.i_item_sk = inv2.i_item_sk) AND (inv1.w_warehouse_sk = inv2.w_warehouse_sk))
         ->  CTE Scan on inv inv1  (cost=0.00..1313.19 rows=292 width=76) (actual time=2869.926..2872.384 rows=3135 loops=1)
               Filter: (d_moy = 1)
               Rows Removed by Filter: 31037
         ->  Hash  (cost=1313.19..1313.19 rows=292 width=76) (actual time=3282.304..3282.304 rows=3220 loops=1)
               Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 235kB
               ->  CTE Scan on inv inv2  (cost=0.00..1313.19 rows=292 width=76) (actual time=0.001..3280.901 rows=3220 loops=1)
                     Filter: (d_moy = 2)
                     Rows Removed by Filter: 30952
 Planning time: 0.499 ms
 Execution time: 6175.025 ms
(22 rows)

 w_warehouse_sk | i_item_sk | d_moy |         mean         |        cov         | w_warehouse_sk | i_item_sk | d_moy |         mean         |        cov         
----------------+-----------+-------+----------------------+--------------------+----------------+-----------+-------+----------------------+--------------------
              1 |     14411 |     1 | 186.2500000000000000 | 1.6853723203686013 |              1 |     14411 |     2 | 429.6666666666666667 | 1.1260057194031071
              2 |      3638 |     1 | 152.6666666666666667 | 1.6131943546920131 |              2 |      3638 |     2 | 366.3333333333333333 | 1.0911246097178872
              2 |     17267 |     1 | 172.7500000000000000 | 1.7575796617243184 |              2 |     17267 |     2 | 465.0000000000000000 | 1.0430055795607591
              3 |      5617 |     1 | 263.0000000000000000 | 1.5303934532624829 |              3 |      5617 |     2 | 349.0000000000000000 | 1.4258030522792407
              4 |      4658 |     1 | 155.0000000000000000 | 1.5277931552006774 |              4 |      4658 |     2 | 468.7500000000000000 | 1.0543579601578155
              5 |      2501 |     1 | 202.3333333333333333 | 1.5223715684198995 |              5 |      2501 |     2 | 221.0000000000000000 | 1.1126315611842941
(6 rows)

