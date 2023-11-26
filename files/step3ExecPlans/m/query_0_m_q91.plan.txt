                                                                                    QUERY PLAN                                                                                     
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=54700.53..54700.53 rows=1 width=98) (actual time=288.586..288.587 rows=8 loops=1)
   Sort Key: (sum(catalog_returns.cr_net_loss)) DESC
   Sort Method: quicksort  Memory: 26kB
   ->  GroupAggregate  (cost=54700.48..54700.52 rows=1 width=98) (actual time=288.490..288.504 rows=8 loops=1)
         Group Key: call_center.cc_call_center_id, call_center.cc_name, call_center.cc_manager, customer_demographics.cd_marital_status, customer_demographics.cd_education_status
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=54700.48..54700.49 rows=1 width=72) (actual time=288.477..288.489 rows=16 loops=1)
 Planning time: 2.976 ms
 Execution time: 291.380 ms
(8 rows)

