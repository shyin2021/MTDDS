                                                                             QUERY PLAN                                                                              
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=206560.84..206561.09 rows=100 width=17) (actual time=707501.093..707501.102 rows=100 loops=1)
   CTE customer_total_return
     ->  Finalize GroupAggregate  (cost=12895.97..13271.35 rows=2874 width=40) (actual time=48.036..250.734 rows=104251 loops=1)
           Group Key: sr_customer_sk, sr_store_sk
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=12895.97..13211.46 rows=2396 width=40) (actual time=48.027..169.324 rows=106866 loops=1)
   ->  Sort  (cost=193289.50..193289.76 rows=105 width=17) (actual time=707501.092..707501.095 rows=100 loops=1)
         Sort Key: c_customer_id
         Sort Method: top-N heapsort  Memory: 37kB
         ->  Hash Join  (cost=7227.55..193285.97 rows=105 width=17) (actual time=413.265..707431.673 rows=39761 loops=1)
               Hash Cond: (ctr1.ctr_customer_sk = c_customer_sk)
               ->  Hash Join  (cost=1.55..186059.70 rows=105 width=4) (actual time=288.414..707269.871 rows=39773 loops=1)
                     Hash Cond: (ctr1.ctr_store_sk = s_store_sk)
                     ->  CTE Scan on customer_total_return ctr1  (cost=0.00..186055.57 rows=958 width=8) (actual time=287.241..707238.806 rows=39773 loops=1)
                           Filter: (ctr_total_return > (SubPlan 2))
                           Rows Removed by Filter: 64478
                           SubPlan 2
                             ->  Aggregate  (cost=64.70..64.71 rows=1 width=32) (actual time=6.782..6.782 rows=1 loops=104251)
                                   ->  CTE Scan on customer_total_return ctr2  (cost=0.00..64.66 rows=14 width=32) (actual time=0.051..5.959 rows=8522 loops=104251)
                                         Filter: (ctr1.ctr_store_sk = ctr_store_sk)
                                         Rows Removed by Filter: 95729
                     ->  Hash  (cost=101.47..101.47 rows=22 width=4) (actual time=1.163..1.163 rows=22 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 9kB
                           ->  Remote Subquery Scan on all (dn1)  (cost=100.00..101.47 rows=22 width=4) (actual time=1.149..1.152 rows=22 loops=1)
               ->  Hash  (cost=9270.00..9270.00 rows=144000 width=21) (actual time=124.390..124.390 rows=144000 loops=1)
                     Buckets: 262144  Batches: 1  Memory Usage: 9923kB
                     ->  Remote Subquery Scan on all (dn2)  (cost=100.00..9270.00 rows=144000 width=21) (actual time=0.672..64.669 rows=144000 loops=1)
 Planning time: 0.565 ms
 Execution time: 707507.674 ms
(28 rows)

