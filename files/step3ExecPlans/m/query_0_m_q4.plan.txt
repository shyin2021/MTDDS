                                                                                                                                                  QUERY PLAN                                                                                                                                                  
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=4232009.81..4232009.82 rows=3 width=334) (actual time=29508.810..29508.813 rows=32 loops=1)
   CTE year_total
     ->  Append  (cost=549010.52..2644375.51 rows=10080117 width=255) (actual time=10340.744..28238.299 rows=720242 loops=1)
           ->  Finalize GroupAggregate  (cost=549010.52..1433181.50 rows=5760860 width=255) (actual time=10340.743..15599.316 rows=350725 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_country, c_login, c_email_address, d_year
                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=549010.52..1241152.85 rows=4800716 width=223) (actual time=10340.722..15038.261 rows=700609 loops=1)
           ->  Finalize GroupAggregate  (cost=296746.86..738767.88 rows=2880010 width=255) (actual time=5657.421..8568.059 rows=258880 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_country, c_login, c_email_address, d_year
                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=296746.86..642767.56 rows=2400008 width=223) (actual time=5657.375..8151.991 rows=513117 loops=1)
           ->  Finalize GroupAggregate  (cost=150730.83..371624.95 rows=1439247 width=255) (actual time=2950.543..4017.329 rows=110637 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_country, c_login, c_email_address, d_year
                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=150730.83..323650.07 rows=1199372 width=223) (actual time=2950.529..3729.918 rows=221109 loops=1)
   ->  Sort  (cost=1587634.31..1587634.31 rows=3 width=334) (actual time=29508.809..29508.810 rows=32 loops=1)
         Sort Key: t_s_secyear.customer_id, t_s_secyear.customer_first_name, t_s_secyear.customer_last_name, t_s_secyear.customer_birth_country
         Sort Method: quicksort  Memory: 29kB
         ->  Hash Join  (cost=1310426.76..1587634.28 rows=3 width=334) (actual time=29351.824..29508.770 rows=32 loops=1)
               Hash Cond: (t_s_secyear.customer_id = t_w_secyear.customer_id)
               Join Filter: (CASE WHEN (t_c_firstyear.year_total > '0'::numeric) THEN (t_c_secyear.year_total / t_c_firstyear.year_total) ELSE NULL::numeric END > CASE WHEN (t_w_firstyear.year_total > '0'::numeric) THEN (t_w_secyear.year_total / t_w_firstyear.year_total) ELSE NULL::numeric END)
               Rows Removed by Join Filter: 16
               ->  Hash Join  (cost=1058420.69..1335627.71 rows=8 width=702) (actual time=511.018..669.201 rows=292 loops=1)
                     Hash Cond: (t_s_firstyear.customer_id = t_s_secyear.customer_id)
                     Join Filter: (CASE WHEN (t_c_firstyear.year_total > '0'::numeric) THEN (t_c_secyear.year_total / t_c_firstyear.year_total) ELSE NULL::numeric END > CASE WHEN (t_s_firstyear.year_total > '0'::numeric) THEN (t_s_secyear.year_total / t_s_firstyear.year_total) ELSE NULL::numeric END)
                     Rows Removed by Join Filter: 334
                     ->  Hash Join  (cost=806414.61..1083620.51 rows=18 width=400) (actual time=391.571..548.608 rows=1319 loops=1)
                           Hash Cond: (t_s_firstyear.customer_id = t_c_secyear.customer_id)
                           ->  Hash Join  (cost=554408.54..831613.74 rows=15 width=300) (actual time=281.739..437.543 rows=3689 loops=1)
                                 Hash Cond: (t_s_firstyear.customer_id = t_w_firstyear.customer_id)
                                 ->  Hash Join  (cost=277204.27..554408.89 rows=35 width=200) (actual time=144.675..295.881 rows=23984 loops=1)
                                       Hash Cond: (t_s_firstyear.customer_id = t_c_firstyear.customer_id)
                                       ->  CTE Scan on year_total t_s_firstyear  (cost=0.00..277203.22 rows=84 width=100) (actual time=0.005..137.658 rows=69762 loops=1)
                                             Filter: ((year_total > '0'::numeric) AND (sale_type = 's'::text) AND (dyear = 1999))
                                             Rows Removed by Filter: 650480
                                       ->  Hash  (cost=277203.22..277203.22 rows=84 width=100) (actual time=144.651..144.651 rows=49491 loops=1)
                                             Buckets: 65536 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 3276kB
                                             ->  CTE Scan on year_total t_c_firstyear  (cost=0.00..277203.22 rows=84 width=100) (actual time=64.255..137.051 rows=49491 loops=1)
                                                   Filter: ((year_total > '0'::numeric) AND (sale_type = 'c'::text) AND (dyear = 1999))
                                                   Rows Removed by Filter: 670751
                                 ->  Hash  (cost=277203.22..277203.22 rows=84 width=100) (actual time=137.036..137.036 rows=21696 loops=1)
                                       Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1473kB
                                       ->  CTE Scan on year_total t_w_firstyear  (cost=0.00..277203.22 rows=84 width=100) (actual time=111.290..133.676 rows=21696 loops=1)
                                             Filter: ((year_total > '0'::numeric) AND (sale_type = 'w'::text) AND (dyear = 1999))
                                             Rows Removed by Filter: 698546
                           ->  Hash  (cost=252002.93..252002.93 rows=252 width=100) (actual time=109.802..109.802 rows=51608 loops=1)
                                 Buckets: 65536 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 3392kB
                                 ->  CTE Scan on year_total t_c_secyear  (cost=0.00..252002.93 rows=252 width=100) (actual time=47.330..102.074 rows=51608 loops=1)
                                       Filter: ((sale_type = 'c'::text) AND (dyear = 2000))
                                       Rows Removed by Filter: 668634
                     ->  Hash  (cost=252002.93..252002.93 rows=252 width=366) (actual time=119.431..119.431 rows=70298 loops=1)
                           Buckets: 131072 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 9082kB
                           ->  CTE Scan on year_total t_s_secyear  (cost=0.00..252002.93 rows=252 width=366) (actual time=0.012..103.633 rows=70298 loops=1)
                                 Filter: ((sale_type = 's'::text) AND (dyear = 2000))
                                 Rows Removed by Filter: 649944
               ->  Hash  (cost=252002.93..252002.93 rows=252 width=100) (actual time=28839.404..28839.404 rows=22096 loops=1)
                     Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1495kB
                     ->  CTE Scan on year_total t_w_secyear  (cost=0.00..252002.93 rows=252 width=100) (actual time=27619.419..28829.213 rows=22096 loops=1)
                           Filter: ((sale_type = 'w'::text) AND (dyear = 2000))
                           Rows Removed by Filter: 698146
 Planning time: 1.863 ms
 Execution time: 29613.917 ms
(59 rows)

