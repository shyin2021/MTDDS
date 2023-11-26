                                                                                                                                                  QUERY PLAN                                                                                                                                                  
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=1862502.85..1862502.85 rows=1 width=334) (actual time=23964.887..23964.888 rows=4 loops=1)
   CTE year_total
     ->  Append  (cost=194998.04..1068390.58 rows=5041944 width=255) (actual time=11568.501..23438.125 rows=384208 loops=1)
           ->  Finalize GroupAggregate  (cost=194998.04..637154.24 rows=2880890 width=255) (actual time=11568.500..14402.692 rows=190581 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_country, c_login, c_email_address, d_year
                 ->  Remote Subquery Scan on all (dn0)  (cost=194998.04..541124.56 rows=2400742 width=223) (actual time=11568.439..14117.526 rows=190581 loops=1)
           ->  GroupAggregate  (cost=209657.12..285344.80 rows=1441670 width=255) (actual time=4890.860..7673.032 rows=136978 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_country, c_login, c_email_address, d_year
                 ->  Remote Subquery Scan on all (dn0)  (cost=209657.12..220469.65 rows=1441670 width=216) (actual time=4890.790..5311.740 rows=1430939 loops=1)
           ->  Finalize HashAggregate  (cost=86479.81..95472.11 rows=719384 width=255) (actual time=1318.275..1344.123 rows=56649 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_country, c_login, c_email_address, d_year
                 ->  Remote Subquery Scan on all (dn0)  (cost=55905.99..68495.21 rows=719384 width=223) (actual time=1199.473..1222.477 rows=56649 loops=1)
   ->  Sort  (cost=794112.26..794112.27 rows=1 width=334) (actual time=23964.886..23964.887 rows=4 loops=1)
         Sort Key: t_s_secyear.customer_id, t_s_secyear.customer_first_name, t_s_secyear.customer_last_name, t_s_secyear.customer_birth_country
         Sort Method: quicksort  Memory: 25kB
         ->  Hash Join  (cost=655458.49..794112.25 rows=1 width=334) (actual time=23954.058..23964.870 rows=4 loops=1)
               Hash Cond: (t_s_secyear.customer_id = t_w_secyear.customer_id)
               Join Filter: (CASE WHEN (t_c_firstyear.year_total > '0'::numeric) THEN (t_c_secyear.year_total / t_c_firstyear.year_total) ELSE NULL::numeric END > CASE WHEN (t_w_firstyear.year_total > '0'::numeric) THEN (t_w_secyear.year_total / t_w_firstyear.year_total) ELSE NULL::numeric END)
               Rows Removed by Join Filter: 3
               ->  Hash Join  (cost=529408.31..668062.04 rows=1 width=702) (actual time=297.946..308.736 rows=51 loops=1)
                     Hash Cond: (t_s_secyear.customer_id = t_c_secyear.customer_id)
                     Join Filter: (CASE WHEN (t_c_firstyear.year_total > '0'::numeric) THEN (t_c_secyear.year_total / t_c_firstyear.year_total) ELSE NULL::numeric END > CASE WHEN (t_s_firstyear.year_total > '0'::numeric) THEN (t_s_secyear.year_total / t_s_firstyear.year_total) ELSE NULL::numeric END)
                     Rows Removed by Join Filter: 68
                     ->  Hash Join  (cost=403358.14..542011.82 rows=1 width=666) (actual time=241.514..252.758 rows=404 loops=1)
                           Hash Cond: (t_s_firstyear.customer_id = t_s_secyear.customer_id)
                           ->  Hash Join  (cost=277307.96..415961.60 rows=2 width=300) (actual time=187.182..198.083 rows=1087 loops=1)
                                 Hash Cond: (t_w_firstyear.customer_id = t_s_firstyear.customer_id)
                                 ->  CTE Scan on year_total t_w_firstyear  (cost=0.00..138653.46 rows=42 width=100) (actual time=51.599..61.215 rows=11077 loops=1)
                                       Filter: ((year_total > '0'::numeric) AND (sale_type = 'w'::text) AND (dyear = 1999))
                                       Rows Removed by Filter: 373131
                                 ->  Hash  (cost=277307.85..277307.85 rows=9 width=200) (actual time=135.560..135.560 rows=9835 loops=1)
                                       Buckets: 16384 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 924kB
                                       ->  Hash Join  (cost=138653.99..277307.85 rows=9 width=200) (actual time=65.579..133.488 rows=9835 loops=1)
                                             Hash Cond: (t_s_firstyear.customer_id = t_c_firstyear.customer_id)
                                             ->  CTE Scan on year_total t_s_firstyear  (cost=0.00..138653.46 rows=42 width=100) (actual time=0.002..62.714 rows=37708 loops=1)
                                                   Filter: ((year_total > '0'::numeric) AND (sale_type = 's'::text) AND (dyear = 1999))
                                                   Rows Removed by Filter: 346500
                                             ->  Hash  (cost=138653.46..138653.46 rows=42 width=100) (actual time=65.563..65.563 rows=26331 loops=1)
                                                   Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1726kB
                                                   ->  CTE Scan on year_total t_c_firstyear  (cost=0.00..138653.46 rows=42 width=100) (actual time=29.402..61.521 rows=26331 loops=1)
                                                         Filter: ((year_total > '0'::numeric) AND (sale_type = 'c'::text) AND (dyear = 1999))
                                                         Rows Removed by Filter: 357877
                           ->  Hash  (cost=126048.60..126048.60 rows=126 width=366) (actual time=54.319..54.319 rows=38252 loops=1)
                                 Buckets: 65536 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 4895kB
                                 ->  CTE Scan on year_total t_s_secyear  (cost=0.00..126048.60 rows=126 width=366) (actual time=0.004..44.299 rows=38252 loops=1)
                                       Filter: ((sale_type = 's'::text) AND (dyear = 2000))
                                       Rows Removed by Filter: 345956
                     ->  Hash  (cost=126048.60..126048.60 rows=126 width=100) (actual time=55.703..55.703 rows=27449 loops=1)
                           Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 1787kB
                           ->  CTE Scan on year_total t_c_secyear  (cost=0.00..126048.60 rows=126 width=100) (actual time=18.833..40.911 rows=27449 loops=1)
                                 Filter: ((sale_type = 'c'::text) AND (dyear = 2000))
                                 Rows Removed by Filter: 356759
               ->  Hash  (cost=126048.60..126048.60 rows=126 width=100) (actual time=23656.101..23656.101 rows=11153 loops=1)
                     Buckets: 16384 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 753kB
                     ->  CTE Scan on year_total t_w_secyear  (cost=0.00..126048.60 rows=126 width=100) (actual time=23598.678..23654.467 rows=11153 loops=1)
                           Filter: ((sale_type = 'w'::text) AND (dyear = 2000))
                           Rows Removed by Filter: 373055
 Planning time: 1.726 ms
 Execution time: 24030.426 ms
(59 rows)

