                                                                                                                                     QUERY PLAN                                                                                                                                     
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=2604321.39..2604321.40 rows=5 width=332) (actual time=18297.819..18297.828 rows=100 loops=1)
   CTE year_total
     ->  Append  (cost=544205.32..1848302.74 rows=7200107 width=255) (actual time=9941.779..17770.954 rows=461362 loops=1)
           ->  Finalize GroupAggregate  (cost=544205.32..1410373.61 rows=5760860 width=255) (actual time=9941.778..14114.193 rows=350725 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_country, c_login, c_email_address, d_year
                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=544205.32..1218344.96 rows=4800716 width=223) (actual time=9941.745..13575.909 rows=700609 loops=1)
           ->  Finalize GroupAggregate  (cost=149531.58..365928.06 rows=1439247 width=255) (actual time=2743.285..3629.255 rows=110637 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_country, c_login, c_email_address, d_year
                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=149531.58..317953.17 rows=1199372 width=223) (actual time=2743.270..3454.776 rows=221109 loops=1)
   ->  Sort  (cost=756018.65..756018.66 rows=5 width=332) (actual time=18297.817..18297.820 rows=100 loops=1)
         Sort Key: t_s_secyear.customer_id, t_s_secyear.customer_first_name, t_s_secyear.customer_last_name, t_s_secyear.customer_login
         Sort Method: top-N heapsort  Memory: 38kB
         ->  Hash Join  (cost=558013.54..756018.59 rows=5 width=332) (actual time=18205.957..18297.443 rows=415 loops=1)
               Hash Cond: (t_s_secyear.customer_id = t_w_secyear.customer_id)
               Join Filter: (CASE WHEN (t_w_firstyear.year_total > '0'::numeric) THEN (t_w_secyear.year_total / t_w_firstyear.year_total) ELSE 0.0 END > CASE WHEN (t_s_firstyear.year_total > '0'::numeric) THEN (t_s_secyear.year_total / t_s_firstyear.year_total) ELSE 0.0 END)
               Rows Removed by Join Filter: 411
               ->  Hash Join  (cost=378008.62..576012.95 rows=16 width=564) (actual time=144.093..233.559 rows=5224 loops=1)
                     Hash Cond: (t_s_firstyear.customer_id = t_s_secyear.customer_id)
                     ->  Hash Join  (cost=198003.69..396007.42 rows=18 width=200) (actual time=76.484..162.843 rows=10767 loops=1)
                           Hash Cond: (t_s_firstyear.customer_id = t_w_firstyear.customer_id)
                           ->  CTE Scan on year_total t_s_firstyear  (cost=0.00..198002.94 rows=60 width=100) (actual time=0.002..77.168 rows=70298 loops=1)
                                 Filter: ((year_total > '0'::numeric) AND (sale_type = 's'::text) AND (dyear = 2000))
                                 Rows Removed by Filter: 391064
                           ->  Hash  (cost=198002.94..198002.94 rows=60 width=100) (actual time=76.448..76.448 rows=22096 loops=1)
                                 Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1507kB
                                 ->  CTE Scan on year_total t_w_firstyear  (cost=0.00..198002.94 rows=60 width=100) (actual time=53.837..72.979 rows=22096 loops=1)
                                       Filter: ((year_total > '0'::numeric) AND (sale_type = 'w'::text) AND (dyear = 2000))
                                       Rows Removed by Filter: 439266
                     ->  Hash  (cost=180002.68..180002.68 rows=180 width=364) (actual time=67.589..67.589 rows=69732 loops=1)
                           Buckets: 131072 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 8392kB
                           ->  CTE Scan on year_total t_s_secyear  (cost=0.00..180002.68 rows=180 width=364) (actual time=0.001..53.738 rows=69732 loops=1)
                                 Filter: ((sale_type = 's'::text) AND (dyear = 2001))
                                 Rows Removed by Filter: 391630
               ->  Hash  (cost=180002.68..180002.68 rows=180 width=100) (actual time=18061.746..18061.746 rows=22299 loops=1)
                     Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1518kB
                     ->  CTE Scan on year_total t_w_secyear  (cost=0.00..180002.68 rows=180 width=100) (actual time=17090.107..18055.556 rows=22299 loops=1)
                           Filter: ((sale_type = 'w'::text) AND (dyear = 2001))
                           Rows Removed by Filter: 439063
 Planning time: 0.866 ms
 Execution time: 18374.575 ms
(40 rows)

