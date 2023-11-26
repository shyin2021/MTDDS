                                                                    QUERY PLAN                                                                    
--------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=10000308707.66..10000308710.16 rows=100 width=132) (actual time=608.506..608.592 rows=60 loops=1)
   CTE ss
     ->  Finalize GroupAggregate  (cost=136446.86..136474.28 rows=22 width=68) (actual time=277.440..277.507 rows=12 loops=1)
           Group Key: s_store_sk
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=136446.86..136473.40 rows=44 width=68) (actual time=277.428..277.444 rows=24 loops=1)
   CTE sr
     ->  Finalize GroupAggregate  (cost=15319.22..15327.94 rows=22 width=68) (actual time=36.045..36.075 rows=12 loops=1)
           Group Key: s_store_sk
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=15319.22..15327.06 rows=44 width=68) (actual time=36.035..36.048 rows=24 loops=1)
   CTE cs
     ->  Finalize GroupAggregate  (cost=92604.52..92611.65 rows=8 width=68) (actual time=162.770..162.786 rows=6 loops=1)
           Group Key: cs_call_center_sk
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=92604.52..92611.33 rows=16 width=68) (actual time=162.758..162.766 rows=12 loops=1)
   CTE cr
     ->  Finalize GroupAggregate  (cost=9983.07..9985.91 rows=8 width=68) (actual time=26.265..26.279 rows=6 loops=1)
           Group Key: cr_call_center_sk
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=9983.07..9985.59 rows=16 width=68) (actual time=26.254..26.261 rows=12 loops=1)
   CTE ws
     ->  Finalize GroupAggregate  (cost=47829.68..47857.30 rows=74 width=68) (actual time=85.958..86.069 rows=38 loops=1)
           Group Key: wp_web_page_sk
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=47829.68..47854.34 rows=148 width=68) (actual time=85.946..85.994 rows=76 loops=1)
   CTE wr
     ->  Finalize GroupAggregate  (cost=6428.68..6435.57 rows=57 width=68) (actual time=19.494..19.624 rows=38 loops=1)
           Group Key: wp_web_page_sk
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=6428.68..6434.29 rows=34 width=68) (actual time=19.484..19.549 rows=76 loops=1)
   ->  GroupAggregate  (cost=10000000015.02..10000000023.03 rows=321 width=132) (actual time=608.505..608.588 rows=60 loops=1)
         Group Key: ('store channel'::text), ss.s_store_sk
         Group Key: ('store channel'::text)
         Group Key: ()
         ->  Sort  (cost=10000000015.02..10000000015.42 rows=160 width=132) (actual time=608.496..608.499 rows=86 loops=1)
               Sort Key: ('store channel'::text), ss.s_store_sk
               Sort Method: quicksort  Memory: 31kB
               ->  Append  (cost=0.72..10000000009.16 rows=160 width=132) (actual time=313.538..608.456 rows=86 loops=1)
                     ->  Hash Left Join  (cost=0.72..1.51 rows=22 width=132) (actual time=313.538..313.613 rows=12 loops=1)
                           Hash Cond: (ss.s_store_sk = sr.s_store_sk)
                           ->  CTE Scan on ss  (cost=0.00..0.44 rows=22 width=68) (actual time=277.442..277.512 rows=12 loops=1)
                           ->  Hash  (cost=0.44..0.44 rows=22 width=68) (actual time=36.086..36.086 rows=12 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                 ->  CTE Scan on sr  (cost=0.00..0.44 rows=22 width=68) (actual time=36.047..36.081 rows=12 loops=1)
                     ->  Nested Loop  (cost=10000000000.00..10000000001.68 rows=64 width=132) (actual time=189.042..189.088 rows=36 loops=1)
                           ->  CTE Scan on cs  (cost=0.00..0.16 rows=8 width=68) (actual time=162.771..162.789 rows=6 loops=1)
                           ->  CTE Scan on cr  (cost=0.00..0.16 rows=8 width=64) (actual time=4.378..4.381 rows=6 loops=6)
                     ->  Hash Left Join  (cost=1.85..4.36 rows=74 width=132) (actual time=105.614..105.747 rows=38 loops=1)
                           Hash Cond: (ws.wp_web_page_sk = wr.wp_web_page_sk)
                           ->  CTE Scan on ws  (cost=0.00..1.48 rows=74 width=68) (actual time=85.959..86.078 rows=38 loops=1)
                           ->  Hash  (cost=1.14..1.14 rows=57 width=68) (actual time=19.645..19.645 rows=38 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                 ->  CTE Scan on wr  (cost=0.00..1.14 rows=57 width=68) (actual time=19.496..19.635 rows=38 loops=1)
 Planning time: 1.189 ms
 Execution time: 620.376 ms
(50 rows)

