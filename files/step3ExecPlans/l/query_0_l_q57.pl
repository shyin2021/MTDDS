                                                                                                           QUERY PLAN                                                                                                           
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=150693.35..150693.36 rows=1 width=368) (actual time=2246.727..2246.735 rows=100 loops=1)
   CTE v1
     ->  WindowAgg  (cost=139585.68..144318.16 rows=25249 width=195) (actual time=1363.145..1966.473 rows=70560 loops=1)
           ->  WindowAgg  (cost=139585.68..143686.93 rows=25249 width=187) (actual time=1363.142..1918.473 rows=70560 loops=1)
                 ->  Finalize GroupAggregate  (cost=139585.68..143118.83 rows=25249 width=155) (actual time=1363.122..1860.862 rows=70560 loops=1)
                       Group Key: i_category, i_brand, cc_name, d_year, d_moy
                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=139585.68..142435.02 rows=21040 width=155) (actual time=1363.097..1748.769 rows=163725 loops=1)
   CTE v2
     ->  Hash Join  (cost=5459.86..6375.14 rows=1 width=336) (actual time=2130.942..2174.439 rows=58562 loops=1)
           Hash Cond: ((v1_lead.i_category = v1.i_category) AND (v1_lead.i_brand = v1.i_brand) AND ((v1_lead.cc_name)::text = (v1.cc_name)::text) AND ((v1_lead.rn - 1) = v1.rn))
           ->  CTE Scan on v1 v1_lead  (cost=0.00..504.98 rows=25249 width=566) (actual time=1363.147..1368.511 rows=70560 loops=1)
           ->  Hash  (cost=5459.84..5459.84 rows=1 width=1168) (actual time=767.774..767.774 rows=63692 loops=1)
                 Buckets: 65536 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 20094kB
                 ->  Merge Join  (cost=4702.36..5459.84 rows=1 width=1168) (actual time=693.654..737.751 rows=63692 loops=1)
                       Merge Cond: ((v1.i_category = v1_lag.i_category) AND (v1.i_brand = v1_lag.i_brand) AND ((v1.cc_name)::text = (v1_lag.cc_name)::text) AND (v1.rn = ((v1_lag.rn + 1))))
                       ->  Sort  (cost=2351.18..2414.30 rows=25249 width=602) (actual time=659.184..661.911 rows=69538 loops=1)
                             Sort Key: v1.i_category, v1.i_brand, v1.cc_name, v1.rn
                             Sort Method: quicksort  Memory: 21617kB
                             ->  CTE Scan on v1  (cost=0.00..504.98 rows=25249 width=602) (actual time=0.001..630.851 rows=70560 loops=1)
                       ->  Sort  (cost=2351.18..2414.30 rows=25249 width=566) (actual time=34.464..37.036 rows=69486 loops=1)
                             Sort Key: v1_lag.i_category, v1_lag.i_brand, v1_lag.cc_name, ((v1_lag.rn + 1))
                             Sort Method: quicksort  Memory: 21617kB
                             ->  CTE Scan on v1 v1_lag  (cost=0.00..504.98 rows=25249 width=566) (actual time=0.001..8.960 rows=70560 loops=1)
   ->  Sort  (cost=0.05..0.06 rows=1 width=368) (actual time=2246.725..2246.729 rows=100 loops=1)
         Sort Key: ((v2.sum_sales - v2.avg_monthly_sales)), v2.avg_monthly_sales
         Sort Method: top-N heapsort  Memory: 48kB
         ->  CTE Scan on v2  (cost=0.00..0.04 rows=1 width=368) (actual time=2130.949..2234.571 rows=53450 loops=1)
               Filter: ((avg_monthly_sales > '0'::numeric) AND (d_year = 1999) AND (CASE WHEN (avg_monthly_sales > '0'::numeric) THEN (abs((sum_sales - avg_monthly_sales)) / avg_monthly_sales) ELSE NULL::numeric END > 0.1))
               Rows Removed by Filter: 5112
 Planning time: 0.692 ms
 Execution time: 2267.321 ms
(31 rows)

