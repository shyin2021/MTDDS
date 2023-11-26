                                                                                                QUERY PLAN                                                                                                
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=302604.91..302604.92 rows=1 width=8) (actual time=4902.705..4902.705 rows=1 loops=1)
   ->  Aggregate  (cost=302604.91..302604.92 rows=1 width=8) (actual time=4902.704..4902.704 rows=1 loops=1)
         ->  Subquery Scan on hot_cust  (cost=53853.09..302585.46 rows=7782 width=0) (actual time=4902.060..4902.690 rows=204 loops=1)
               ->  HashSetOp Intersect  (cost=53853.09..302507.64 rows=7782 width=216) (actual time=4902.059..4902.673 rows=204 loops=1)
                     ->  Append  (cost=53853.09..302332.48 rows=23355 width=216) (actual time=379.271..4893.721 rows=24472 loops=1)
                           ->  Subquery Scan on "*SELECT* 3"  (cost=53853.09..54047.64 rows=7782 width=60) (actual time=379.271..731.440 rows=23871 loops=1)
                                 ->  Unique  (cost=53853.09..53969.82 rows=7782 width=56) (actual time=379.269..728.881 rows=23871 loops=1)
                                       ->  Remote Subquery Scan on all (dn1,dn2)  (cost=53853.09..53911.46 rows=7782 width=56) (actual time=379.268..686.523 rows=288494 loops=1)
                           ->  Result  (cost=99990.28..248284.83 rows=15573 width=216) (actual time=4158.575..4160.647 rows=601 loops=1)
                                 ->  HashSetOp Intersect  (cost=99990.28..248129.10 rows=15573 width=216) (actual time=4158.574..4160.590 rows=601 loops=1)
                                       ->  Append  (cost=99990.28..247778.67 rows=46724 width=216) (actual time=750.446..4111.971 rows=157275 loops=1)
                                             ->  Subquery Scan on "*SELECT* 2"  (cost=99990.28..100379.60 rows=15573 width=60) (actual time=750.446..1422.157 rows=62984 loops=1)
                                                   ->  Unique  (cost=99990.28..100223.87 rows=15573 width=56) (actual time=750.444..1415.609 rows=62984 loops=1)
                                                         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=99990.28..100107.07 rows=15573 width=56) (actual time=750.444..1331.845 rows=570864 loops=1)
                                             ->  Subquery Scan on "*SELECT* 1"  (cost=146620.30..147399.07 rows=31151 width=60) (actual time=1394.979..2678.970 rows=94291 loops=1)
                                                   ->  Unique  (cost=146620.30..147087.56 rows=31151 width=56) (actual time=1394.977..2669.077 rows=94291 loops=1)
                                                         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=146620.30..146853.93 rows=31151 width=56) (actual time=1394.977..2512.612 rows=1071566 loops=1)
 Planning time: 0.651 ms
 Execution time: 4914.639 ms
(19 rows)

