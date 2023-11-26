                                                                                                                              QUERY PLAN                                                                                                                               
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=229721.73..229721.74 rows=1 width=404) (actual time=4487.094..4487.102 rows=100 loops=1)
   CTE v1
     ->  WindowAgg  (cost=206147.32..216023.45 rows=50502 width=195) (actual time=2935.828..4109.440 rows=89998 loops=1)
           ->  WindowAgg  (cost=206147.32..214634.64 rows=50502 width=187) (actual time=2935.819..4038.807 rows=89998 loops=1)
                 ->  Finalize GroupAggregate  (cost=206147.32..213372.09 rows=50502 width=155) (actual time=2935.676..3953.872 rows=89998 loops=1)
                       Group Key: i_category, i_brand, s_store_name, s_company_name, d_year, d_moy
                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=206147.32..211899.14 rows=42084 width=155) (actual time=2935.620..3789.308 rows=218298 loops=1)
   CTE v2
     ->  Hash Join  (cost=11678.14..13698.23 rows=1 width=372) (actual time=4335.510..4394.658 rows=69745 loops=1)
           Hash Cond: ((v1_lead.i_category = v1.i_category) AND (v1_lead.i_brand = v1.i_brand) AND ((v1_lead.s_store_name)::text = (v1.s_store_name)::text) AND ((v1_lead.s_company_name)::text = (v1.s_company_name)::text) AND ((v1_lead.rn - 1) = v1.rn))
           ->  CTE Scan on v1 v1_lead  (cost=0.00..1010.04 rows=50502 width=684) (actual time=2935.832..2942.581 rows=89998 loops=1)
           ->  Hash  (cost=11678.12..11678.12 rows=1 width=1408) (actual time=1399.633..1399.633 rows=78168 loops=1)
                 Buckets: 131072 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 25624kB
                 ->  Merge Join  (cost=9910.54..11678.12 rows=1 width=1408) (actual time=1297.067..1359.888 rows=78168 loops=1)
                       Merge Cond: ((v1.i_category = v1_lag.i_category) AND (v1.i_brand = v1_lag.i_brand) AND ((v1.s_store_name)::text = (v1_lag.s_store_name)::text) AND ((v1.s_company_name)::text = (v1_lag.s_company_name)::text) AND (v1.rn = ((v1_lag.rn + 1))))
                       ->  Sort  (cost=4955.27..5081.52 rows=50502 width=724) (actual time=1252.803..1255.995 rows=88276 loops=1)
                             Sort Key: v1.i_category, v1.i_brand, v1.s_store_name, v1.s_company_name, v1.rn
                             Sort Method: quicksort  Memory: 26649kB
                             ->  CTE Scan on v1  (cost=0.00..1010.04 rows=50502 width=724) (actual time=0.002..1214.156 rows=89998 loops=1)
                       ->  Sort  (cost=4955.27..5081.52 rows=50502 width=684) (actual time=44.251..47.842 rows=88178 loops=1)
                             Sort Key: v1_lag.i_category, v1_lag.i_brand, v1_lag.s_store_name, v1_lag.s_company_name, ((v1_lag.rn + 1))
                             Sort Method: quicksort  Memory: 26640kB
                             ->  CTE Scan on v1 v1_lag  (cost=0.00..1010.04 rows=50502 width=684) (actual time=0.002..11.599 rows=89998 loops=1)
   ->  Sort  (cost=0.05..0.06 rows=1 width=404) (actual time=4487.092..4487.095 rows=100 loops=1)
         Sort Key: ((v2.sum_sales - v2.avg_monthly_sales)), v2.psum
         Sort Method: top-N heapsort  Memory: 48kB
         ->  CTE Scan on v2  (cost=0.00..0.04 rows=1 width=404) (actual time=4335.516..4470.142 rows=63606 loops=1)
               Filter: ((avg_monthly_sales > '0'::numeric) AND (d_year = 2001) AND (CASE WHEN (avg_monthly_sales > '0'::numeric) THEN (abs((sum_sales - avg_monthly_sales)) / avg_monthly_sales) ELSE NULL::numeric END > 0.1))
               Rows Removed by Filter: 6139
 Planning time: 0.662 ms
 Execution time: 4522.482 ms
(31 rows)

