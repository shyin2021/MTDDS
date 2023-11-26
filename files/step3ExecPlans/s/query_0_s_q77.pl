                                                                  QUERY PLAN                                                                  
----------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=10000157568.34..10000157568.59 rows=100 width=132) (actual time=568.629..568.633 rows=44 loops=1)
   CTE ss
     ->  Finalize GroupAggregate  (cost=68829.11..68914.97 rows=250 width=68) (actual time=263.041..263.051 rows=6 loops=1)
           Group Key: s_store_sk
           ->  Remote Subquery Scan on all (dn0)  (cost=68829.11..68904.97 rows=500 width=68) (actual time=263.012..263.014 rows=6 loops=1)
   CTE sr
     ->  GroupAggregate  (cost=8268.67..8272.21 rows=118 width=68) (actual time=32.935..34.620 rows=6 loops=1)
           Group Key: s_store_sk
           ->  Remote Subquery Scan on all (dn0)  (cost=8268.67..8269.56 rows=118 width=16) (actual time=32.659..33.385 rows=3052 loops=1)
   CTE cs
     ->  Finalize GroupAggregate  (cost=46932.28..46936.52 rows=6 width=68) (actual time=142.060..142.066 rows=4 loops=1)
           Group Key: cs_call_center_sk
           ->  Remote Subquery Scan on all (dn0)  (cost=46932.28..46936.28 rows=12 width=68) (actual time=142.032..142.033 rows=4 loops=1)
   CTE cr
     ->  Finalize GroupAggregate  (cost=5629.90..5630.11 rows=6 width=68) (actual time=22.580..22.587 rows=5 loops=1)
           Group Key: cr_call_center_sk
           ->  Remote Subquery Scan on all (dn0)  (cost=5629.90..5629.94 rows=6 width=68) (actual time=22.562..22.563 rows=5 loops=1)
   CTE ws
     ->  GroupAggregate  (cost=24548.85..24557.70 rows=295 width=68) (actual time=78.153..88.626 rows=30 loops=1)
           Group Key: wp_web_page_sk
           ->  Remote Subquery Scan on all (dn0)  (cost=24548.85..24551.07 rows=295 width=16) (actual time=77.872..81.965 rows=15955 loops=1)
   CTE wr
     ->  GroupAggregate  (cost=3167.27..3189.25 rows=29 width=68) (actual time=16.688..17.341 rows=40 loops=1)
           Group Key: wp_web_page_sk
           ->  Remote Subquery Scan on all (dn0)  (cost=3167.27..3188.60 rows=29 width=16) (actual time=16.636..16.866 rows=1061 loops=1)
   ->  Sort  (cost=10000000067.57..10000000068.57 rows=401 width=132) (actual time=568.628..568.630 rows=44 loops=1)
         Sort Key: ('store channel'::text), ss.s_store_sk
         Sort Method: quicksort  Memory: 28kB
         ->  MixedAggregate  (cost=3.83..10000000052.24 rows=401 width=132) (actual time=568.574..568.595 rows=44 loops=1)
               Hash Key: ('store channel'::text), ss.s_store_sk
               Hash Key: ('store channel'::text)
               Group Key: ()
               ->  Append  (cost=3.83..10000000027.79 rows=581 width=132) (actual time=297.694..568.467 rows=56 loops=1)
                     ->  Hash Left Join  (cost=3.83..11.88 rows=250 width=132) (actual time=297.694..297.707 rows=6 loops=1)
                           Hash Cond: (ss.s_store_sk = sr.s_store_sk)
                           ->  CTE Scan on ss  (cost=0.00..5.00 rows=250 width=68) (actual time=263.044..263.055 rows=6 loops=1)
                           ->  Hash  (cost=2.36..2.36 rows=118 width=68) (actual time=34.636..34.636 rows=6 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                 ->  CTE Scan on sr  (cost=0.00..2.36 rows=118 width=68) (actual time=32.937..34.627 rows=6 loops=1)
                     ->  Nested Loop  (cost=10000000000.00..10000000000.99 rows=36 width=132) (actual time=164.648..164.669 rows=20 loops=1)
                           ->  CTE Scan on cs  (cost=0.00..0.12 rows=6 width=68) (actual time=142.062..142.068 rows=4 loops=1)
                           ->  CTE Scan on cr  (cost=0.00..0.12 rows=6 width=64) (actual time=5.645..5.648 rows=5 loops=4)
                     ->  Hash Left Join  (cost=0.94..9.12 rows=295 width=132) (actual time=95.537..106.084 rows=30 loops=1)
                           Hash Cond: (ws.wp_web_page_sk = wr.wp_web_page_sk)
                           ->  CTE Scan on ws  (cost=0.00..5.90 rows=295 width=68) (actual time=78.155..88.663 rows=30 loops=1)
                           ->  Hash  (cost=0.58..0.58 rows=29 width=68) (actual time=17.363..17.363 rows=40 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 11kB
                                 ->  CTE Scan on wr  (cost=0.00..0.58 rows=29 width=68) (actual time=16.690..17.353 rows=40 loops=1)
 Planning time: 1.894 ms
 Execution time: 575.682 ms
(50 rows)

