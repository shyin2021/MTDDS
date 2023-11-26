                                                                                                             QUERY PLAN                                                                                                             
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=26463.45..26463.46 rows=5 width=246) (actual time=48061.879..48061.888 rows=100 loops=1)
   CTE customer_total_return
     ->  GroupAggregate  (cost=7138.32..7158.06 rows=718 width=39) (actual time=27.680..60.895 rows=26432 loops=1)
           Group Key: wr_returning_customer_sk, ca_state
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=7138.32..7143.70 rows=718 width=13) (actual time=27.672..49.431 rows=26815 loops=1)
   ->  Sort  (cost=19305.39..19305.40 rows=5 width=246) (actual time=48061.878..48061.882 rows=100 loops=1)
         Sort Key: c_customer_id, c_salutation, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_day, c_birth_month, c_birth_year, c_birth_country, c_login, c_email_address, c_last_review_date_sk, ctr1.ctr_total_return
         Sort Method: quicksort  Memory: 56kB
         ->  Hash Join  (cost=7670.99..19305.33 rows=5 width=246) (actual time=1662.161..48061.563 rows=119 loops=1)
               Hash Cond: (ctr1.ctr_customer_sk = c_customer_sk)
               ->  CTE Scan on customer_total_return ctr1  (cost=0.00..11633.40 rows=239 width=36) (actual time=70.491..48022.410 rows=6447 loops=1)
                     Filter: (ctr_total_return > (SubPlan 2))
                     Rows Removed by Filter: 19985
                     SubPlan 2
                       ->  Aggregate  (cost=16.17..16.18 rows=1 width=32) (actual time=1.815..1.815 rows=1 loops=26432)
                             ->  CTE Scan on customer_total_return ctr2  (cost=0.00..16.16 rows=4 width=32) (actual time=0.047..1.738 rows=770 loops=26432)
                                   Filter: (ctr1.ctr_state = ctr_state)
                                   Rows Removed by Filter: 25662
               ->  Hash  (cost=8411.75..8411.75 rows=3044 width=218) (actual time=36.396..36.396 rows=2947 loops=1)
                     Buckets: 4096  Batches: 1  Memory Usage: 612kB
                     ->  Remote Subquery Scan on all (dn1)  (cost=2685.03..8411.75 rows=3044 width=218) (actual time=9.011..32.703 rows=2947 loops=1)
 Planning time: 0.443 ms
 Execution time: 48065.904 ms
(23 rows)

