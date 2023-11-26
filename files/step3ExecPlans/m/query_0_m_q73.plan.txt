                                                                             QUERY PLAN                                                                              
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=141239.61..141240.58 rows=386 width=77) (actual time=413.154..413.154 rows=7 loops=1)
   Sort Key: dj.cnt DESC, c_last_name
   Sort Method: quicksort  Memory: 25kB
   ->  Merge Join  (cost=134275.47..141223.03 rows=386 width=77) (actual time=272.415..413.138 rows=7 loops=1)
         Merge Cond: (c_customer_sk = dj.ss_customer_sk)
         ->  Remote Subquery Scan on all (dn2)  (cost=100.17..17337.94 rows=144000 width=69) (actual time=0.495..70.987 rows=129694 loops=1)
         ->  Sort  (cost=134275.30..134276.27 rows=386 width=16) (actual time=249.709..249.712 rows=8 loops=1)
               Sort Key: dj.ss_customer_sk
               Sort Method: quicksort  Memory: 31kB
               ->  Subquery Scan on dj  (cost=134204.98..134258.72 rows=386 width=16) (actual time=244.331..249.689 rows=131 loops=1)
                     ->  Finalize GroupAggregate  (cost=134204.98..134254.86 rows=386 width=16) (actual time=244.330..249.676 rows=131 loops=1)
                           Group Key: ss_ticket_number, ss_customer_sk
                           Filter: ((count(*) >= 1) AND (count(*) <= 5))
                           Rows Removed by Filter: 2056
                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=134204.98..134246.97 rows=322 width=16) (actual time=244.323..248.750 rows=4239 loops=1)
 Planning time: 0.460 ms
 Execution time: 501.453 ms
(17 rows)

