                                                                                      QUERY PLAN                                                                                      
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=200922.86..200922.87 rows=4 width=152) (actual time=8255.223..8255.232 rows=316 loops=1)
   Sort Key: inv1.w_warehouse_sk, inv1.i_item_sk, inv1.mean, inv1.cov, inv2.mean, inv2.cov
   Sort Method: quicksort  Memory: 69kB
   CTE inv
     ->  Subquery Scan on foo  (cost=193875.84..197054.91 rows=84775 width=126) (actual time=3756.007..8234.270 rows=48525 loops=1)
           ->  Finalize HashAggregate  (cost=193875.84..195783.28 rows=84775 width=94) (actual time=3756.005..8211.893 rows=48525 loops=1)
                 Group Key: w_warehouse_sk, i_item_sk, d_moy
                 Filter: (CASE avg(inv_quantity_on_hand) WHEN '0'::numeric THEN '0'::numeric ELSE (stddev_samp(inv_quantity_on_hand) / avg(inv_quantity_on_hand)) END > '1'::numeric)
                 Rows Removed by Filter: 731535
                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=184250.33..192109.69 rows=70646 width=94) (actual time=1571.798..2020.785 rows=1430110 loops=1)
   ->  Hash Join  (cost=1913.80..3867.91 rows=4 width=152) (actual time=8251.399..8255.118 rows=316 loops=1)
         Hash Cond: ((inv1.i_item_sk = inv2.i_item_sk) AND (inv1.w_warehouse_sk = inv2.w_warehouse_sk))
         ->  CTE Scan on inv inv1  (cost=0.00..1907.44 rows=424 width=76) (actual time=3759.196..3762.434 rows=4565 loops=1)
               Filter: (d_moy = 2)
               Rows Removed by Filter: 43960
         ->  Hash  (cost=1907.44..1907.44 rows=424 width=76) (actual time=4492.182..4492.182 rows=4518 loops=1)
               Buckets: 8192 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 348kB
               ->  CTE Scan on inv inv2  (cost=0.00..1907.44 rows=424 width=76) (actual time=0.001..4490.487 rows=4518 loops=1)
                     Filter: (d_moy = 3)
                     Rows Removed by Filter: 44007
 Planning time: 0.533 ms
 Execution time: 8278.263 ms
(22 rows)

 w_warehouse_sk | i_item_sk | d_moy |         mean         |        cov         | w_warehouse_sk | i_item_sk | d_moy |         mean         |          cov           
----------------+-----------+-------+----------------------+--------------------+----------------+-----------+-------+----------------------+------------------------
              2 |       279 |     2 | 232.0000000000000000 | 1.7990582763568578 |              2 |       279 |     3 | 285.7500000000000000 |     1.3430339779457358
              2 |      5688 |     2 | 240.5000000000000000 | 1.5395381223123035 |              2 |      5688 |     3 | 109.2500000000000000 |     1.2766472601779680
              3 |      4281 |     2 | 261.5000000000000000 | 1.6314207782524704 |              3 |      4281 |     3 | 116.2500000000000000 |     1.1949947644206280
              3 |      4551 |     2 | 235.2500000000000000 | 1.5411562465962635 |              3 |      4551 |     3 | 256.7500000000000000 |     1.4035312640159688
              3 |     14235 |     2 | 204.6666666666666667 | 1.6106915473692313 |              3 |     14235 |     3 | 181.0000000000000000 | 1.00316441217071270718
              3 |     21309 |     2 | 320.3333333333333333 | 1.6171931134629053 |              3 |     21309 |     3 | 239.6666666666666667 |     1.5018911169831989
              4 |     18555 |     2 | 288.0000000000000000 | 1.6268055911285660 |              4 |     18555 |     3 | 321.2500000000000000 |     1.2242934522186459
              4 |     24973 |     2 | 247.5000000000000000 | 1.8184197375198747 |              4 |     24973 |     3 | 375.7500000000000000 |     1.1126017387476700
              5 |     14358 |     2 | 152.3333333333333333 | 1.6979911565714705 |              5 |     14358 |     3 | 211.0000000000000000 |     1.5318202244105355
              5 |     18090 |     2 | 291.5000000000000000 | 1.5447846025696364 |              5 |     18090 |     3 | 329.0000000000000000 |     1.0803835819467173
(10 rows)

