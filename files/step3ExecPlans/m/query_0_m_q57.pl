                                                                                                           QUERY PLAN                                                                                                           
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=100799.10..100799.10 rows=1 width=368) (actual time=1707.605..1707.613 rows=100 loops=1)
   CTE v1
     ->  WindowAgg  (cost=93491.16..96646.79 rows=16835 width=195) (actual time=1226.982..1541.608 rows=43627 loops=1)
           ->  WindowAgg  (cost=93491.16..96225.92 rows=16835 width=187) (actual time=1226.979..1512.186 rows=43627 loops=1)
                 ->  Finalize GroupAggregate  (cost=93491.16..95847.13 rows=16835 width=155) (actual time=1226.952..1476.010 rows=43627 loops=1)
                       Group Key: i_category, i_brand, cc_name, d_year, d_moy
                       ->  Remote Subquery Scan on all (dn1,dn2)  (cost=93491.16..95391.17 rows=14030 width=155) (actual time=1226.905..1424.331 rows=75990 loops=1)
   CTE v2
     ->  Hash Join  (cost=3541.98..4152.25 rows=1 width=336) (actual time=1640.997..1664.953 rows=33839 loops=1)
           Hash Cond: ((v1_lead.i_category = v1.i_category) AND (v1_lead.i_brand = v1.i_brand) AND ((v1_lead.cc_name)::text = (v1.cc_name)::text) AND ((v1_lead.rn - 1) = v1.rn))
           ->  CTE Scan on v1 v1_lead  (cost=0.00..336.70 rows=16835 width=566) (actual time=1226.983..1230.082 rows=43627 loops=1)
           ->  Hash  (cost=3541.96..3541.96 rows=1 width=1168) (actual time=413.979..413.979 rows=37961 loops=1)
                 Buckets: 65536 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 12165kB
                 ->  Merge Join  (cost=3036.90..3541.96 rows=1 width=1168) (actual time=368.959..395.879 rows=37961 loops=1)
                       Merge Cond: ((v1.i_category = v1_lag.i_category) AND (v1.i_brand = v1_lag.i_brand) AND ((v1.cc_name)::text = (v1_lag.cc_name)::text) AND (v1.rn = ((v1_lag.rn + 1))))
                       ->  Sort  (cost=1518.45..1560.54 rows=16835 width=602) (actual time=347.608..349.212 rows=43001 loops=1)
                             Sort Key: v1.i_category, v1.i_brand, v1.cc_name, v1.rn
                             Sort Method: quicksort  Memory: 12987kB
                             ->  CTE Scan on v1  (cost=0.00..336.70 rows=16835 width=602) (actual time=0.001..331.922 rows=43627 loops=1)
                       ->  Sort  (cost=1518.45..1560.54 rows=16835 width=566) (actual time=21.342..23.276 rows=42969 loops=1)
                             Sort Key: v1_lag.i_category, v1_lag.i_brand, v1_lag.cc_name, ((v1_lag.rn + 1))
                             Sort Method: quicksort  Memory: 12987kB
                             ->  CTE Scan on v1 v1_lag  (cost=0.00..336.70 rows=16835 width=566) (actual time=0.001..5.641 rows=43627 loops=1)
   ->  Sort  (cost=0.05..0.06 rows=1 width=368) (actual time=1707.604..1707.607 rows=100 loops=1)
         Sort Key: ((v2.sum_sales - v2.avg_monthly_sales)), v2.nsum
         Sort Method: top-N heapsort  Memory: 48kB
         ->  CTE Scan on v2  (cost=0.00..0.04 rows=1 width=368) (actual time=1641.004..1699.708 rows=30938 loops=1)
               Filter: ((avg_monthly_sales > '0'::numeric) AND (d_year = 2001) AND (CASE WHEN (avg_monthly_sales > '0'::numeric) THEN (abs((sum_sales - avg_monthly_sales)) / avg_monthly_sales) ELSE NULL::numeric END > 0.1))
               Rows Removed by Filter: 2901
 Planning time: 0.698 ms
 Execution time: 1720.188 ms
(31 rows)

