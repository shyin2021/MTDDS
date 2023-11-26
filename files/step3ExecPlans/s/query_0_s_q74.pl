                                                                                                                                               QUERY PLAN                                                                                                                                               
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=105119.58..105119.59 rows=1 width=276) (actual time=1885.561..1885.570 rows=100 loops=1)
   CTE year_total
     ->  Append  (cost=73501.89..101362.48 rows=35781 width=137) (actual time=989.893..1796.283 rows=98369 loops=1)
           ->  Finalize HashAggregate  (cost=73501.89..73788.20 rows=28631 width=137) (actual time=989.892..1009.350 rows=75960 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, d_year
                 ->  Remote Subquery Scan on all (dn0)  (cost=70579.04..73203.64 rows=23860 width=105) (actual time=906.915..927.577 rows=75960 loops=1)
           ->  Finalize GroupAggregate  (cost=26278.53..27216.47 rows=7150 width=137) (actual time=705.547..782.737 rows=22409 loops=1)
                 Group Key: c_customer_id, c_first_name, c_last_name, d_year
                 ->  Remote Subquery Scan on all (dn0)  (cost=26278.53..27070.49 rows=5958 width=105) (actual time=705.529..764.864 rows=22409 loops=1)
   ->  Sort  (cost=3757.11..3757.11 rows=1 width=276) (actual time=1885.560..1885.563 rows=100 loops=1)
         Sort Key: t_s_secyear.customer_id, t_s_secyear.customer_last_name, t_s_secyear.customer_first_name
         Sort Method: quicksort  Memory: 39kB
         ->  Hash Join  (cost=2773.07..3757.10 rows=1 width=276) (actual time=1863.202..1885.416 rows=105 loops=1)
               Hash Cond: (t_s_secyear.customer_id = t_w_secyear.customer_id)
               Join Filter: (CASE WHEN (t_w_firstyear.year_total > '0'::numeric) THEN (t_w_secyear.year_total / t_w_firstyear.year_total) ELSE NULL::numeric END > CASE WHEN (t_s_firstyear.year_total > '0'::numeric) THEN (t_s_secyear.year_total / t_s_firstyear.year_total) ELSE NULL::numeric END)
               Rows Removed by Join Filter: 82
               ->  Hash Join  (cost=1878.53..2862.53 rows=1 width=508) (actual time=32.200..54.650 rows=1585 loops=1)
                     Hash Cond: (t_s_secyear.customer_id = t_w_firstyear.customer_id)
                     ->  Hash Join  (cost=894.54..1878.53 rows=1 width=408) (actual time=17.453..38.352 rows=14505 loops=1)
                           Hash Cond: (t_s_firstyear.customer_id = t_s_secyear.customer_id)
                           ->  CTE Scan on year_total t_s_firstyear  (cost=0.00..983.98 rows=1 width=100) (actual time=0.005..14.698 rows=37708 loops=1)
                                 Filter: ((year_total > '0'::numeric) AND (sale_type = 's'::text) AND (year = 1999))
                                 Rows Removed by Filter: 60661
                           ->  Hash  (cost=894.53..894.53 rows=1 width=308) (actual time=17.438..17.438 rows=38252 loops=1)
                                 Buckets: 65536 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 4485kB
                                 ->  CTE Scan on year_total t_s_secyear  (cost=0.00..894.53 rows=1 width=308) (actual time=0.001..10.757 rows=38252 loops=1)
                                       Filter: ((sale_type = 's'::text) AND (year = 2000))
                                       Rows Removed by Filter: 60117
                     ->  Hash  (cost=983.98..983.98 rows=1 width=100) (actual time=14.732..14.732 rows=11256 loops=1)
                           Buckets: 16384 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 750kB
                           ->  CTE Scan on year_total t_w_firstyear  (cost=0.00..983.98 rows=1 width=100) (actual time=9.498..13.142 rows=11256 loops=1)
                                 Filter: ((year_total > '0'::numeric) AND (sale_type = 'w'::text) AND (year = 1999))
                                 Rows Removed by Filter: 87113
               ->  Hash  (cost=894.53..894.53 rows=1 width=100) (actual time=1830.312..1830.312 rows=11153 loops=1)
                     Buckets: 16384 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 745kB
                     ->  CTE Scan on year_total t_w_secyear  (cost=0.00..894.53 rows=1 width=100) (actual time=1743.006..1828.734 rows=11153 loops=1)
                           Filter: ((sale_type = 'w'::text) AND (year = 2000))
                           Rows Removed by Filter: 87216
 Planning time: 0.591 ms
 Execution time: 1888.764 ms
(40 rows)

