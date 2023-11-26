                                                                      QUERY PLAN                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=10000454442.61..10000454445.19 rows=100 width=132) (actual time=691.549..691.659 rows=73 loops=1)
   CTE ss
     ->  Finalize GroupAggregate  (cost=203280.65..203323.66 rows=32 width=68) (actual time=309.547..309.655 rows=17 loops=1)
           Group Key: s_store_sk
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=203280.65..203322.38 rows=64 width=68) (actual time=309.534..309.603 rows=51 loops=1)
   CTE sr
     ->  Finalize GroupAggregate  (cost=21624.70..21637.67 rows=32 width=68) (actual time=39.708..39.794 rows=17 loops=1)
           Group Key: s_store_sk
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=21624.70..21636.39 rows=64 width=68) (actual time=39.671..39.703 rows=51 loops=1)
   CTE cs
     ->  Finalize GroupAggregate  (cost=137531.91..137542.50 rows=10 width=68) (actual time=171.031..171.056 rows=7 loops=1)
           Group Key: cs_call_center_sk
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=137531.91..137542.10 rows=20 width=68) (actual time=170.971..170.989 rows=21 loops=1)
   CTE cr
     ->  Finalize GroupAggregate  (cost=13604.04..13607.76 rows=10 width=68) (actual time=31.112..31.136 rows=7 loops=1)
           Group Key: cr_call_center_sk
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=13604.04..13607.36 rows=20 width=68) (actual time=31.102..31.113 rows=21 loops=1)
   CTE ws
     ->  Finalize GroupAggregate  (cost=70437.85..70473.52 rows=90 width=68) (actual time=112.206..112.405 rows=45 loops=1)
           Group Key: wp_web_page_sk
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=70437.85..70469.92 rows=180 width=68) (actual time=112.190..112.279 rows=135 loops=1)
   CTE wr
     ->  GroupAggregate  (cost=7832.97..7835.68 rows=90 width=68) (actual time=26.129..27.277 rows=45 loops=1)
           Group Key: wp_web_page_sk
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=7832.97..7833.65 rows=91 width=16) (actual time=26.099..26.959 rows=1541 loops=1)
   ->  GroupAggregate  (cost=10000000021.81..10000000032.16 rows=401 width=132) (actual time=691.531..691.638 rows=73 loops=1)
         Group Key: ('store channel'::text), ss.s_store_sk
         Group Key: ('store channel'::text)
         Group Key: ()
         ->  Sort  (cost=10000000021.81..10000000022.36 rows=222 width=132) (actual time=691.521..691.524 rows=111 loops=1)
               Sort Key: ('store channel'::text), ss.s_store_sk
               Sort Method: quicksort  Memory: 33kB
               ->  Append  (cost=1.04..10000000013.16 rows=222 width=132) (actual time=349.367..691.467 rows=111 loops=1)
                     ->  Hash Left Join  (cost=1.04..2.20 rows=32 width=132) (actual time=349.366..349.485 rows=17 loops=1)
                           Hash Cond: (ss.s_store_sk = sr.s_store_sk)
                           ->  CTE Scan on ss  (cost=0.00..0.64 rows=32 width=68) (actual time=309.549..309.661 rows=17 loops=1)
                           ->  Hash  (cost=0.64..0.64 rows=32 width=68) (actual time=39.807..39.807 rows=17 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                 ->  CTE Scan on sr  (cost=0.00..0.64 rows=32 width=68) (actual time=39.710..39.801 rows=17 loops=1)
                     ->  Nested Loop  (cost=10000000000.00..10000000002.55 rows=100 width=132) (actual time=202.153..202.223 rows=49 loops=1)
                           ->  CTE Scan on cs  (cost=0.00..0.20 rows=10 width=68) (actual time=171.033..171.060 rows=7 loops=1)
                           ->  CTE Scan on cr  (cost=0.00..0.20 rows=10 width=64) (actual time=4.445..4.449 rows=7 loops=7)
                     ->  Hash Left Join  (cost=2.92..6.19 rows=90 width=132) (actual time=139.524..139.750 rows=45 loops=1)
                           Hash Cond: (ws.wp_web_page_sk = wr.wp_web_page_sk)
                           ->  CTE Scan on ws  (cost=0.00..1.80 rows=90 width=68) (actual time=112.208..112.415 rows=45 loops=1)
                           ->  Hash  (cost=1.80..1.80 rows=90 width=68) (actual time=27.305..27.305 rows=45 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                 ->  CTE Scan on wr  (cost=0.00..1.80 rows=90 width=68) (actual time=26.132..27.293 rows=45 loops=1)
 Planning time: 1.040 ms
 Execution time: 709.324 ms
(50 rows)

