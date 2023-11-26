                                                                                                                                               QUERY PLAN                                                                                                                                               
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=211115.44..211115.45 rows=1 width=276) (actual time=2746.767..2746.776 rows=100 loops=1)
   CTE year_total
     ->  Append  (cost=147404.48..203560.25 rows=71953 width=137) (actual time=1431.236..2561.005 rows=183653 loops=1)
           ->  Finalize HashAggregate  (cost=147404.48..147980.18 rows=57570 width=137) (actual time=1431.235..1467.196 rows=139748 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, d_year
                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=141527.42..146804.78 rows=47976 width=105) (actual time=978.151..1064.108 rows=279116 loops=1)
           ->  Finalize GroupAggregate  (cost=52973.65..54860.54 rows=14383 width=137) (actual time=890.637..1083.833 rows=43905 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, d_year
                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=52973.65..54566.89 rows=11986 width=105) (actual time=890.627..1044.823 rows=87738 loops=1)
   ->  Sort  (cost=7555.19..7555.20 rows=1 width=276) (actual time=2746.764..2746.767 rows=100 loops=1)
         Sort Key: t_s_secyear.customer_last_name, t_s_secyear.customer_first_name, t_s_secyear.customer_id
         Sort Method: top-N heapsort  Memory: 48kB
         ->  Hash Join  (cost=5576.42..7555.18 rows=1 width=276) (actual time=2697.468..2746.321 rows=401 loops=1)
               Hash Cond: (t_s_secyear.customer_id = t_w_secyear.customer_id)
               Join Filter: (CASE WHEN (t_w_firstyear.year_total > '0'::numeric) THEN (t_w_secyear.year_total / t_w_firstyear.year_total) ELSE NULL::numeric END > CASE WHEN (t_s_firstyear.year_total > '0'::numeric) THEN (t_s_secyear.year_total / t_s_firstyear.year_total) ELSE NULL::numeric END)
               Rows Removed by Join Filter: 459
               ->  Hash Join  (cost=3777.57..5756.31 rows=1 width=508) (actual time=62.400..109.438 rows=5232 loops=1)
                     Hash Cond: (t_s_secyear.customer_id = t_w_firstyear.customer_id)
                     ->  Hash Join  (cost=1798.85..3777.57 rows=1 width=408) (actual time=33.778..76.584 rows=33804 loops=1)
                           Hash Cond: (t_s_firstyear.customer_id = t_s_secyear.customer_id)
                           ->  CTE Scan on year_total t_s_firstyear  (cost=0.00..1978.71 rows=1 width=100) (actual time=0.002..28.621 rows=69986 loops=1)
                                 Filter: ((year_total > '0'::numeric) AND (sale_type = 's'::text) AND (year = 1998))
                                 Rows Removed by Filter: 113667
                           ->  Hash  (cost=1798.83..1798.83 rows=2 width=308) (actual time=33.759..33.759 rows=69762 loops=1)
                                 Buckets: 131072 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 8268kB
                                 ->  CTE Scan on year_total t_s_secyear  (cost=0.00..1798.83 rows=2 width=308) (actual time=0.002..21.033 rows=69762 loops=1)
                                       Filter: ((sale_type = 's'::text) AND (year = 1999))
                                       Rows Removed by Filter: 113891
                     ->  Hash  (cost=1978.71..1978.71 rows=1 width=100) (actual time=28.604..28.604 rows=21824 loops=1)
                           Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1462kB
                           ->  CTE Scan on year_total t_w_firstyear  (cost=0.00..1978.71 rows=1 width=100) (actual time=18.124..25.492 rows=21824 loops=1)
                                 Filter: ((year_total > '0'::numeric) AND (sale_type = 'w'::text) AND (year = 1998))
                                 Rows Removed by Filter: 161829
               ->  Hash  (cost=1798.83..1798.83 rows=2 width=100) (actual time=2635.012..2635.012 rows=22081 loops=1)
                     Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1476kB
                     ->  CTE Scan on year_total t_w_secyear  (cost=0.00..1798.83 rows=2 width=100) (actual time=2408.408..2629.420 rows=22081 loops=1)
                           Filter: ((sale_type = 'w'::text) AND (year = 1999))
                           Rows Removed by Filter: 161572
 Planning time: 2.558 ms
 Execution time: 2765.505 ms
(40 rows)

