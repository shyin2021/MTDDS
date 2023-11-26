                                                                                    QUERY PLAN                                                                                     
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=127067.93..127067.98 rows=23 width=250) (actual time=1630.178..1630.188 rows=100 loops=1)
   CTE wss
     ->  Finalize HashAggregate  (cost=123609.42..124183.45 rows=20874 width=232) (actual time=1534.925..1536.674 rows=1834 loops=1)
           Group Key: d_week_seq, ss_store_sk
           ->  Remote Subquery Scan on all (dn0)  (cost=116981.92..121939.50 rows=41748 width=232) (actual time=1528.442..1529.461 rows=1834 loops=1)
   ->  Sort  (cost=2884.48..2884.53 rows=23 width=250) (actual time=1630.177..1630.179 rows=100 loops=1)
         Sort Key: s_store_name, s_store_id, wss.d_week_seq
         Sort Method: top-N heapsort  Memory: 78kB
         ->  Hash Join  (cost=2385.55..2883.96 rows=23 width=250) (actual time=1557.733..1626.851 rows=15288 loops=1)
               Hash Cond: ((wss_1.ss_store_sk = s_store_sk) AND (s_store_id = s_store_id))
               ->  Hash Join  (cost=2369.30..2866.65 rows=125 width=478) (actual time=1556.422..1590.167 rows=107016 loops=1)
                     Hash Cond: (wss.ss_store_sk = s_store_sk)
                     ->  Hash Join  (cost=2353.68..2850.69 rows=125 width=460) (actual time=1555.601..1573.003 rows=124852 loops=1)
                           Hash Cond: (wss.d_week_seq = d_week_seq)
                           ->  CTE Scan on wss  (cost=0.00..417.48 rows=20874 width=232) (actual time=1534.927..1535.113 rows=1834 loops=1)
                           ->  Hash  (cost=2353.41..2353.41 rows=21 width=236) (actual time=20.665..20.665 rows=17836 loops=1)
                                 Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 2003kB
                                 ->  Hash Join  (cost=1501.64..2353.41 rows=21 width=236) (actual time=15.274..17.681 rows=17836 loops=1)
                                       Hash Cond: (d_week_seq = (wss_1.d_week_seq - 52))
                                       ->  Remote Subquery Scan on all (dn0)  (cost=100.00..934.25 rows=111 width=4) (actual time=6.081..6.112 rows=366 loops=1)
                                       ->  Hash  (cost=1493.46..1493.46 rows=654 width=232) (actual time=9.183..9.183 rows=2555 loops=1)
                                             Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 273kB
                                             ->  Hash Join  (cost=834.61..1493.46 rows=654 width=232) (actual time=6.141..8.732 rows=2555 loops=1)
                                                   Hash Cond: (wss_1.d_week_seq = d_week_seq)
                                                   ->  CTE Scan on wss wss_1  (cost=0.00..417.48 rows=20874 width=232) (actual time=0.001..2.234 rows=1834 loops=1)
                                                   ->  Hash  (cost=934.23..934.23 rows=109 width=4) (actual time=6.119..6.119 rows=365 loops=1)
                                                         Buckets: 1024  Batches: 1  Memory Usage: 21kB
                                                         ->  Remote Subquery Scan on all (dn0)  (cost=100.00..934.23 rows=109 width=4) (actual time=6.028..6.061 rows=365 loops=1)
                     ->  Hash  (cost=120.25..120.25 rows=250 width=26) (actual time=0.761..0.761 rows=12 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 9kB
                           ->  Remote Subquery Scan on all (dn0)  (cost=100.00..120.25 rows=250 width=26) (actual time=0.750..0.751 rows=12 loops=1)
               ->  Hash  (cost=119.00..119.00 rows=250 width=21) (actual time=1.298..1.298 rows=12 loops=1)
                     Buckets: 1024  Batches: 1  Memory Usage: 9kB
                     ->  Remote Subquery Scan on all (dn0)  (cost=100.00..119.00 rows=250 width=21) (actual time=1.288..1.290 rows=12 loops=1)
 Planning time: 0.777 ms
 Execution time: 1633.513 ms
(36 rows)

