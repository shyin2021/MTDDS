                                                                                    QUERY PLAN                                                                                     
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=60441.74..60441.74 rows=1 width=97) (actual time=303.949..303.951 rows=8 loops=1)
   Sort Key: (sum(catalog_returns.cr_net_loss)) DESC
   Sort Method: quicksort  Memory: 26kB
   ->  GroupAggregate  (cost=60441.69..60441.73 rows=1 width=97) (actual time=303.880..303.928 rows=8 loops=1)
         Group Key: call_center.cc_call_center_id, call_center.cc_name, call_center.cc_manager, customer_demographics.cd_marital_status, customer_demographics.cd_education_status
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=60441.69..60441.70 rows=1 width=71) (actual time=303.741..303.877 rows=11 loops=1)
 Planning time: 1.268 ms
 Execution time: 315.413 ms
(8 rows)

