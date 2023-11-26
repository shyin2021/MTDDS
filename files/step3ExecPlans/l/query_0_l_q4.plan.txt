                                                                                                                                                  QUERY PLAN                                                                                                                                                  
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=6356947.26..6356947.35 rows=37 width=334) (actual time=37701.667..37701.673 rows=86 loops=1)
   CTE year_total
     ->  Append  (cost=830844.55..3975631.43 rows=15119205 width=255) (actual time=13018.176..35926.782 rows=1044974 loops=1)
           ->  Finalize GroupAggregate  (cost=830844.55..2156846.47 rows=8639630 width=255) (actual time=13018.175..20647.998 rows=504505 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_country, c_login, c_email_address, d_year
                 ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=830844.55..1868858.79 rows=7199692 width=223) (actual time=13018.137..19469.743 rows=1495568 loops=1)
           ->  Finalize GroupAggregate  (cost=447281.42..1110220.14 rows=4319410 width=255) (actual time=6313.304..10373.517 rows=376731 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_country, c_login, c_email_address, d_year
                 ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=447281.42..966239.81 rows=3599508 width=223) (actual time=6313.278..9524.043 rows=1082578 loops=1)
           ->  Finalize GroupAggregate  (cost=225832.71..557372.78 rows=2160165 width=255) (actual time=3203.709..4835.926 rows=163738 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_country, c_login, c_email_address, d_year
                 ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=225832.71..485367.27 rows=1800138 width=223) (actual time=3203.688..4456.039 rows=485319 loops=1)
   ->  Sort  (cost=2381315.82..2381315.92 rows=37 width=334) (actual time=37701.665..37701.668 rows=86 loops=1)
         Sort Key: t_s_secyear.customer_id, t_s_secyear.customer_first_name, t_s_secyear.customer_last_name, t_s_secyear.customer_birth_country
         Sort Method: quicksort  Memory: 37kB
         ->  Hash Join  (cost=1965513.98..2381314.86 rows=37 width=334) (actual time=37468.343..37701.577 rows=86 loops=1)
               Hash Cond: (t_s_secyear.customer_id = t_w_secyear.customer_id)
               Join Filter: (CASE WHEN (t_c_firstyear.year_total > '0'::numeric) THEN (t_c_secyear.year_total / t_c_firstyear.year_total) ELSE NULL::numeric END > CASE WHEN (t_w_firstyear.year_total > '0'::numeric) THEN (t_w_secyear.year_total / t_w_firstyear.year_total) ELSE NULL::numeric END)
               Rows Removed by Join Filter: 37
               ->  Hash Join  (cost=1587529.13..2003324.54 rows=59 width=702) (actual time=755.555..988.399 rows=697 loops=1)
                     Hash Cond: (t_s_secyear.customer_id = t_c_secyear.customer_id)
                     Join Filter: (CASE WHEN (t_c_firstyear.year_total > '0'::numeric) THEN (t_c_secyear.year_total / t_c_firstyear.year_total) ELSE NULL::numeric END > CASE WHEN (t_s_firstyear.year_total > '0'::numeric) THEN (t_s_secyear.year_total / t_s_firstyear.year_total) ELSE NULL::numeric END)
                     Rows Removed by Join Filter: 766
                     ->  Hash Join  (cost=1209544.28..1625330.99 rows=94 width=666) (actual time=600.885..831.075 rows=3629 loops=1)
                           Hash Cond: (t_s_firstyear.customer_id = t_s_secyear.customer_id)
                           ->  Hash Join  (cost=831559.43..1247342.70 rows=50 width=300) (actual time=427.346..654.965 rows=6647 loops=1)
                                 Hash Cond: (t_s_firstyear.customer_id = t_w_firstyear.customer_id)
                                 ->  Hash Join  (cost=415779.71..831561.00 rows=79 width=200) (actual time=210.694..430.431 rows=38639 loops=1)
                                       Hash Cond: (t_s_firstyear.customer_id = t_c_firstyear.customer_id)
                                       ->  CTE Scan on year_total t_s_firstyear  (cost=0.00..415778.14 rows=126 width=100) (actual time=0.005..200.988 rows=100543 loops=1)
                                             Filter: ((year_total > '0'::numeric) AND (sale_type = 's'::text) AND (dyear = 1999))
                                             Rows Removed by Filter: 944431
                                       ->  Hash  (cost=415778.14..415778.14 rows=126 width=100) (actual time=210.674..210.674 rows=72292 loops=1)
                                             Buckets: 131072 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 5063kB
                                             ->  CTE Scan on year_total t_c_firstyear  (cost=0.00..415778.14 rows=126 width=100) (actual time=93.038..199.447 rows=72292 loops=1)
                                                   Filter: ((year_total > '0'::numeric) AND (sale_type = 'c'::text) AND (dyear = 1999))
                                                   Rows Removed by Filter: 972682
                                 ->  Hash  (cost=415778.14..415778.14 rows=126 width=100) (actual time=216.629..216.629 rows=32166 loops=1)
                                       Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 2061kB
                                       ->  CTE Scan on year_total t_w_firstyear  (cost=0.00..415778.14 rows=126 width=100) (actual time=178.557..211.564 rows=32166 loops=1)
                                             Filter: ((year_total > '0'::numeric) AND (sale_type = 'w'::text) AND (dyear = 1999))
                                             Rows Removed by Filter: 1012808
                           ->  Hash  (cost=377980.12..377980.12 rows=378 width=366) (actual time=173.503..173.503 rows=100894 loops=1)
                                 Buckets: 131072 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 12585kB
                                 ->  CTE Scan on year_total t_s_secyear  (cost=0.00..377980.12 rows=378 width=366) (actual time=0.006..150.901 rows=100894 loops=1)
                                       Filter: ((sale_type = 's'::text) AND (dyear = 2000))
                                       Rows Removed by Filter: 944080
                     ->  Hash  (cost=377980.12..377980.12 rows=378 width=100) (actual time=154.654..154.654 rows=75252 loops=1)
                           Buckets: 131072 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 5225kB
                           ->  CTE Scan on year_total t_c_secyear  (cost=0.00..377980.12 rows=378 width=100) (actual time=65.391..143.414 rows=75252 loops=1)
                                 Filter: ((sale_type = 'c'::text) AND (dyear = 2000))
                                 Rows Removed by Filter: 969722
               ->  Hash  (cost=377980.12..377980.12 rows=378 width=100) (actual time=36712.778..36712.778 rows=32727 loops=1)
                     Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 2091kB
                     ->  CTE Scan on year_total t_w_secyear  (cost=0.00..377980.12 rows=378 width=100) (actual time=34939.924..36704.566 rows=32727 loops=1)
                           Filter: ((sale_type = 'w'::text) AND (dyear = 2000))
                           Rows Removed by Filter: 1012247
 Planning time: 1.760 ms
 Execution time: 37847.662 ms
(59 rows)

