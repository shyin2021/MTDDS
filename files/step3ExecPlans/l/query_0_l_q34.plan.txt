                                                                                QUERY PLAN                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=210653.12..210657.88 rows=1904 width=77) (actual time=614.617..614.652 rows=994 loops=1)
   Sort Key: c_last_name, c_first_name, c_salutation, c_preferred_cust_flag DESC, dn.ss_ticket_number
   Sort Method: quicksort  Memory: 161kB
   ->  Merge Join  (cost=201457.91..210549.41 rows=1904 width=77) (actual time=361.927..612.364 rows=994 loops=1)
         Merge Cond: (c_customer_sk = dn.ss_customer_sk)
         ->  Remote Subquery Scan on all (dn2)  (cost=100.17..22605.10 rows=188000 width=69) (actual time=0.313..101.630 rows=187916 loops=1)
         ->  Sort  (cost=201457.74..201462.50 rows=1904 width=16) (actual time=361.582..361.940 rows=994 loops=1)
               Sort Key: dn.ss_customer_sk
               Sort Method: quicksort  Memory: 102kB
               ->  Subquery Scan on dn  (cost=201089.27..201354.03 rows=1904 width=16) (actual time=314.639..361.315 rows=994 loops=1)
                     ->  Finalize GroupAggregate  (cost=201089.27..201334.99 rows=1904 width=16) (actual time=314.638..361.233 rows=994 loops=1)
                           Group Key: ss_ticket_number, ss_customer_sk
                           Filter: ((count(*) >= 15) AND (count(*) <= 20))
                           Rows Removed by Filter: 9945
                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=201089.27..201296.12 rows=1586 width=16) (actual time=314.588..356.458 rows=30944 loops=1)
 Planning time: 0.459 ms
 Execution time: 621.021 ms
(17 rows)

SET
