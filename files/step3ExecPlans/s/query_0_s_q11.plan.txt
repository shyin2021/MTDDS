                                                                                                                                     QUERY PLAN                                                                                                                                     
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=1132262.68..1132262.69 rows=1 width=480) (actual time=13901.423..13901.430 rows=95 loops=1)
   CTE year_total
     ->  Append  (cost=194998.04..754230.92 rows=3600274 width=255) (actual time=10854.678..13645.086 rows=247230 loops=1)
           ->  Finalize GroupAggregate  (cost=194998.04..628151.46 rows=2880890 width=255) (actual time=10854.677..12705.405 rows=190581 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_country, c_login, c_email_address, d_year
                 ->  Remote Subquery Scan on all (dn0)  (cost=194998.04..532121.78 rows=2400742 width=223) (actual time=10854.655..12428.139 rows=190581 loops=1)
           ->  Finalize HashAggregate  (cost=81084.43..90076.73 rows=719384 width=255) (actual time=898.899..926.644 rows=56649 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_country, c_login, c_email_address, d_year
                 ->  Remote Subquery Scan on all (dn0)  (cost=50510.61..63099.83 rows=719384 width=223) (actual time=792.910..811.074 rows=56649 loops=1)
   ->  Sort  (cost=378031.76..378031.76 rows=1 width=480) (actual time=13901.422..13901.425 rows=95 loops=1)
         Sort Key: t_s_secyear.customer_id, t_s_secyear.customer_first_name, t_s_secyear.customer_last_name, t_s_secyear.customer_email_address
         Sort Method: quicksort  Memory: 49kB
         ->  Hash Join  (cost=279023.86..378031.75 rows=1 width=480) (actual time=13854.450..13901.357 rows=95 loops=1)
               Hash Cond: (t_s_secyear.customer_id = t_w_secyear.customer_id)
               Join Filter: (CASE WHEN (t_w_firstyear.year_total > '0'::numeric) THEN (t_w_secyear.year_total / t_w_firstyear.year_total) ELSE 0.0 END > CASE WHEN (t_s_firstyear.year_total > '0'::numeric) THEN (t_s_secyear.year_total / t_s_firstyear.year_total) ELSE 0.0 END)
               Rows Removed by Join Filter: 108
               ->  Hash Join  (cost=189015.89..288023.72 rows=2 width=712) (actual time=78.212..124.518 rows=1680 loops=1)
                     Hash Cond: (t_s_firstyear.customer_id = t_s_secyear.customer_id)
                     ->  Hash Join  (cost=99007.91..198015.67 rows=4 width=200) (actual time=41.048..86.228 rows=4332 loops=1)
                           Hash Cond: (t_s_firstyear.customer_id = t_w_firstyear.customer_id)
                           ->  CTE Scan on year_total t_s_firstyear  (cost=0.00..99007.54 rows=30 width=100) (actual time=0.007..41.062 rows=37991 loops=1)
                                 Filter: ((year_total > '0'::numeric) AND (sale_type = 's'::text) AND (dyear = 1998))
                                 Rows Removed by Filter: 209239
                           ->  Hash  (cost=99007.54..99007.54 rows=30 width=100) (actual time=41.019..41.019 rows=11309 loops=1)
                                 Buckets: 16384 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 768kB
                                 ->  CTE Scan on year_total t_w_firstyear  (cost=0.00..99007.54 rows=30 width=100) (actual time=29.479..39.267 rows=11309 loops=1)
                                       Filter: ((year_total > '0'::numeric) AND (sale_type = 'w'::text) AND (dyear = 1998))
                                       Rows Removed by Filter: 235921
                     ->  Hash  (cost=90006.85..90006.85 rows=90 width=512) (actual time=37.152..37.152 rows=37708 loops=1)
                           Buckets: 65536 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 6306kB
                           ->  CTE Scan on year_total t_s_secyear  (cost=0.00..90006.85 rows=90 width=512) (actual time=0.002..28.265 rows=37708 loops=1)
                                 Filter: ((sale_type = 's'::text) AND (dyear = 1999))
                                 Rows Removed by Filter: 209522
               ->  Hash  (cost=90006.85..90006.85 rows=90 width=100) (actual time=13776.225..13776.225 rows=11256 loops=1)
                     Buckets: 16384 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 765kB
                     ->  CTE Scan on year_total t_w_secyear  (cost=0.00..90006.85 rows=90 width=100) (actual time=13716.849..13774.501 rows=11256 loops=1)
                           Filter: ((sale_type = 'w'::text) AND (dyear = 1999))
                           Rows Removed by Filter: 235974
 Planning time: 0.599 ms
 Execution time: 13962.047 ms
(40 rows)

