                                                                          QUERY PLAN                                                                           
---------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=70396.57..70397.06 rows=193 width=77) (actual time=305.762..305.762 rows=3 loops=1)
   Sort Key: dj.cnt DESC, c_last_name
   Sort Method: quicksort  Memory: 25kB
   ->  Hash Join  (cost=69006.99..70389.25 rows=193 width=77) (actual time=248.911..305.750 rows=3 loops=1)
         Hash Cond: (c_customer_sk = dj.ss_customer_sk)
         ->  Remote Subquery Scan on all (dn0)  (cost=100.00..3821.97 rows=33333 width=69) (actual time=0.275..24.924 rows=100000 loops=1)
         ->  Hash  (cost=69004.58..69004.58 rows=193 width=16) (actual time=240.907..240.907 rows=3 loops=1)
               Buckets: 1024  Batches: 1  Memory Usage: 9kB
               ->  Subquery Scan on dj  (cost=68977.85..69004.58 rows=193 width=16) (actual time=239.861..240.901 rows=66 loops=1)
                     ->  Finalize GroupAggregate  (cost=68977.85..69002.65 rows=193 width=16) (actual time=239.860..240.895 rows=66 loops=1)
                           Group Key: ss_ticket_number, ss_customer_sk
                           Filter: ((count(*) >= 1) AND (count(*) <= 5))
                           Rows Removed by Filter: 1003
                           ->  Remote Subquery Scan on all (dn0)  (cost=68977.85..68998.72 rows=160 width=16) (actual time=239.847..240.525 rows=1069 loops=1)
 Planning time: 0.383 ms
 Execution time: 306.656 ms
(16 rows)

