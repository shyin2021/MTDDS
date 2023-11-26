                                                                                                                                               QUERY PLAN                                                                                                                                               
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=314245.70..314245.70 rows=1 width=276) (actual time=3986.384..3986.394 rows=100 loops=1)
   CTE year_total
     ->  Append  (cost=219797.85..302913.44 rows=107925 width=137) (actual time=2059.792..3733.329 rows=265707 loops=1)
           ->  Finalize HashAggregate  (cost=219797.85..220877.08 rows=86338 width=137) (actual time=2059.792..2191.414 rows=200686 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, d_year
                 ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=210714.42..218718.63 rows=71948 width=105) (actual time=1079.196..1252.468 rows=594938 loops=1)
           ->  Finalize GroupAggregate  (cost=78003.62..80957.11 rows=21587 width=137) (actual time=1057.102..1529.708 rows=65021 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, d_year
                 ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=78003.62..80417.42 rows=17990 width=105) (actual time=1057.084..1388.895 rows=192649 loops=1)
   ->  Sort  (cost=11332.26..11332.26 rows=1 width=276) (actual time=3986.383..3986.386 rows=100 loops=1)
         Sort Key: t_s_secyear.customer_last_name, t_s_secyear.customer_first_name, t_s_secyear.customer_id
         Sort Method: top-N heapsort  Memory: 47kB
         ->  Hash Join  (cost=8364.27..11332.25 rows=1 width=276) (actual time=3928.614..3985.750 rows=854 loops=1)
               Hash Cond: (t_s_secyear.customer_id = t_w_firstyear.customer_id)
               Join Filter: (CASE WHEN (t_w_firstyear.year_total > '0'::numeric) THEN (t_w_secyear.year_total / t_w_firstyear.year_total) ELSE NULL::numeric END > CASE WHEN (t_s_firstyear.year_total > '0'::numeric) THEN (t_s_secyear.year_total / t_s_firstyear.year_total) ELSE NULL::numeric END)
               Rows Removed by Join Filter: 836
               ->  Hash Join  (cost=5396.32..8364.27 rows=1 width=508) (actual time=73.767..126.990 rows=9328 loops=1)
                     Hash Cond: (t_s_firstyear.customer_id = t_s_secyear.customer_id)
                     ->  CTE Scan on year_total t_s_firstyear  (cost=0.00..2967.94 rows=1 width=100) (actual time=0.002..41.181 rows=100143 loops=1)
                           Filter: ((year_total > '0'::numeric) AND (sale_type = 's'::text) AND (year = 1998))
                           Rows Removed by Filter: 165564
                     ->  Hash  (cost=5396.31..5396.31 rows=1 width=408) (actual time=73.748..73.748 rows=17418 loops=1)
                           Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 2601kB
                           ->  Hash Join  (cost=2698.16..5396.31 rows=1 width=408) (actual time=28.607..70.023 rows=17418 loops=1)
                                 Hash Cond: (t_s_secyear.customer_id = t_w_secyear.customer_id)
                                 ->  CTE Scan on year_total t_s_secyear  (cost=0.00..2698.12 rows=3 width=308) (actual time=0.001..28.484 rows=100543 loops=1)
                                       Filter: ((sale_type = 's'::text) AND (year = 1999))
                                       Rows Removed by Filter: 165164
                                 ->  Hash  (cost=2698.12..2698.12 rows=3 width=100) (actual time=28.600..28.600 rows=32709 loops=1)
                                       Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 2162kB
                                       ->  CTE Scan on year_total t_w_secyear  (cost=0.00..2698.12 rows=3 width=100) (actual time=16.876..24.382 rows=32709 loops=1)
                                             Filter: ((sale_type = 'w'::text) AND (year = 1999))
                                             Rows Removed by Filter: 232998
               ->  Hash  (cost=2967.94..2967.94 rows=1 width=100) (actual time=3854.792..3854.792 rows=32312 loops=1)
                     Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 2138kB
                     ->  CTE Scan on year_total t_w_firstyear  (cost=0.00..2967.94 rows=1 width=100) (actual time=3334.179..3848.571 rows=32312 loops=1)
                           Filter: ((year_total > '0'::numeric) AND (sale_type = 'w'::text) AND (year = 1998))
                           Rows Removed by Filter: 233395
 Planning time: 0.680 ms
 Execution time: 4013.027 ms
(40 rows)

