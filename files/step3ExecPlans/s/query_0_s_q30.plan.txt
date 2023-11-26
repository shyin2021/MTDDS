                                                                                                             QUERY PLAN                                                                                                             
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=8581.61..8581.62 rows=3 width=246) (actual time=11690.400..11690.405 rows=63 loops=1)
   CTE customer_total_return
     ->  GroupAggregate  (cost=3761.12..3770.93 rows=357 width=39) (actual time=25.129..37.135 rows=13143 loops=1)
           Group Key: wr_returning_customer_sk, ca_state
           ->  Remote Subquery Scan on all (dn0)  (cost=3761.12..3763.79 rows=357 width=13) (actual time=25.117..28.567 rows=13297 loops=1)
   ->  Sort  (cost=4810.68..4810.68 rows=3 width=246) (actual time=11690.399..11690.401 rows=63 loops=1)
         Sort Key: c_customer_id, c_salutation, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_day, c_birth_month, c_birth_year, c_birth_country, c_login, c_email_address, c_last_review_date_sk, ctr1.ctr_total_return
         Sort Method: quicksort  Memory: 41kB
         ->  Hash Join  (cost=1927.40..4810.65 rows=3 width=246) (actual time=123.185..11690.242 rows=63 loops=1)
               Hash Cond: (ctr1.ctr_customer_sk = c_customer_sk)
               ->  CTE Scan on customer_total_return ctr1  (cost=0.00..2882.77 rows=119 width=36) (actual time=41.540..11668.952 rows=3204 loops=1)
                     Filter: (ctr_total_return > (SubPlan 2))
                     Rows Removed by Filter: 9939
                     SubPlan 2
                       ->  Aggregate  (cost=8.04..8.05 rows=1 width=32) (actual time=0.885..0.885 rows=1 loops=13143)
                             ->  CTE Scan on customer_total_return ctr2  (cost=0.00..8.03 rows=2 width=32) (actual time=0.024..0.847 rows=381 loops=13143)
                                   Filter: (ctr1.ctr_state = ctr_state)
                                   Rows Removed by Filter: 12762
               ->  Hash  (cost=2186.96..2186.96 rows=758 width=218) (actual time=19.762..19.763 rows=2320 loops=1)
                     Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 488kB
                     ->  Remote Subquery Scan on all (dn0)  (cost=675.07..2186.96 rows=758 width=218) (actual time=6.141..17.444 rows=2320 loops=1)
 Planning time: 0.417 ms
 Execution time: 11691.482 ms
(23 rows)

