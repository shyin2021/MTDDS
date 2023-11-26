                                                                                                                                     QUERY PLAN                                                                                                                                     
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=3913452.24..3913452.30 rows=25 width=334) (actual time=23097.988..23098.026 rows=100 loops=1)
   CTE year_total
     ->  Append  (cost=823636.75..2779458.08 rows=10799795 width=255) (actual time=11570.101..22155.682 rows=668243 loops=1)
           ->  Finalize GroupAggregate  (cost=823636.75..2122639.82 rows=8639630 width=255) (actual time=11570.100..17335.132 rows=504505 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_country, c_login, c_email_address, d_year
                 ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=823636.75..1834652.15 rows=7199692 width=223) (actual time=11570.082..16153.502 rows=1495568 loops=1)
           ->  Finalize GroupAggregate  (cost=224030.76..548820.31 rows=2160165 width=255) (actual time=3168.364..4779.360 rows=163738 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_country, c_login, c_email_address, d_year
                 ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=224030.76..476814.80 rows=1800138 width=223) (actual time=3168.345..4397.186 rows=485319 loops=1)
   ->  Sort  (cost=1133994.16..1133994.22 rows=25 width=334) (actual time=23097.987..23097.990 rows=100 loops=1)
         Sort Key: t_s_secyear.customer_id, t_s_secyear.customer_first_name, t_s_secyear.customer_last_name, t_s_secyear.customer_birth_country
         Sort Method: top-N heapsort  Memory: 38kB
         ->  Hash Join  (cost=836991.99..1133993.58 rows=25 width=334) (actual time=22944.109..23097.424 rows=793 loops=1)
               Hash Cond: (t_s_firstyear.customer_id = t_s_secyear.customer_id)
               Join Filter: (CASE WHEN (t_w_firstyear.year_total > '0'::numeric) THEN (t_w_secyear.year_total / t_w_firstyear.year_total) ELSE 0.0 END > CASE WHEN (t_s_firstyear.year_total > '0'::numeric) THEN (t_s_secyear.year_total / t_s_firstyear.year_total) ELSE 0.0 END)
               Rows Removed by Join Filter: 845
               ->  Hash Join  (cost=566993.74..863991.73 rows=54 width=300) (actual time=240.492..390.851 rows=3069 loops=1)
                     Hash Cond: (t_s_firstyear.customer_id = t_w_secyear.customer_id)
                     ->  Hash Join  (cost=296995.49..593991.49 rows=40 width=200) (actual time=137.891..283.852 rows=17452 loops=1)
                           Hash Cond: (t_s_firstyear.customer_id = t_w_firstyear.customer_id)
                           ->  CTE Scan on year_total t_s_firstyear  (cost=0.00..296994.36 rows=90 width=100) (actual time=0.008..131.663 rows=100416 loops=1)
                                 Filter: ((year_total > '0'::numeric) AND (sale_type = 's'::text) AND (dyear = 2001))
                                 Rows Removed by Filter: 567827
                           ->  Hash  (cost=296994.36..296994.36 rows=90 width=100) (actual time=137.866..137.866 rows=32845 loops=1)
                                 Buckets: 65536 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 2371kB
                                 ->  CTE Scan on year_total t_w_firstyear  (cost=0.00..296994.36 rows=90 width=100) (actual time=96.052..132.052 rows=32845 loops=1)
                                       Filter: ((year_total > '0'::numeric) AND (sale_type = 'w'::text) AND (dyear = 2001))
                                       Rows Removed by Filter: 635398
                     ->  Hash  (cost=269994.88..269994.88 rows=270 width=100) (actual time=102.588..102.588 rows=32756 loops=1)
                           Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 2110kB
                           ->  CTE Scan on year_total t_w_secyear  (cost=0.00..269994.88 rows=270 width=100) (actual time=73.159..97.536 rows=32756 loops=1)
                                 Filter: ((sale_type = 'w'::text) AND (dyear = 2002))
                                 Rows Removed by Filter: 635487
               ->  Hash  (cost=269994.88..269994.88 rows=270 width=366) (actual time=22703.607..22703.607 rows=100888 loops=1)
                     Buckets: 131072 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 12603kB
                     ->  CTE Scan on year_total t_s_secyear  (cost=0.00..269994.88 rows=270 width=366) (actual time=11570.157..22663.362 rows=100888 loops=1)
                           Filter: ((sale_type = 's'::text) AND (dyear = 2002))
                           Rows Removed by Filter: 567355
 Planning time: 0.647 ms
 Execution time: 23203.091 ms
(40 rows)

