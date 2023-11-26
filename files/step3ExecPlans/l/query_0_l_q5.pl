                                                                                     QUERY PLAN                                                                                     
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=970926.35..970926.60 rows=100 width=160) (actual time=7728.747..7728.757 rows=100 loops=1)
   CTE ssr
     ->  Finalize GroupAggregate  (cost=222120.40..222127.75 rows=17 width=145) (actual time=635.704..635.837 rows=17 loops=1)
           Group Key: s_store_id
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=222120.40..222126.65 rows=34 width=145) (actual time=635.686..635.750 rows=51 loops=1)
   CTE csr
     ->  GroupAggregate  (cost=435415.96..435447.84 rows=911 width=145) (actual time=4611.171..4625.816 rows=777 loops=1)
           Group Key: cp_catalog_page_id
           ->  Sort  (cost=435415.96..435418.23 rows=911 width=57) (actual time=4611.100..4613.357 rows=48261 loops=1)
                 Sort Key: cp_catalog_page_id
                 Sort Method: quicksort  Memory: 5307kB
                 ->  Hash Join  (cost=2756.78..435371.18 rows=911 width=57) (actual time=2103.222..4547.990 rows=48261 loops=1)
                       Hash Cond: (cs_catalog_page_sk = cp_catalog_page_sk)
                       ->  Hash Join  (cost=2251.13..434863.13 rows=911 width=44) (actual time=2076.098..4512.228 rows=48438 loops=1)
                             Hash Cond: (cs_sold_date_sk = d_date_sk)
                             ->  Append  (cost=100.00..420238.83 rows=4751410 width=48) (actual time=7.738..1170.773 rows=4751367 loops=1)
                                   ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=100.00..384294.83 rows=4319410 width=48) (actual time=7.737..848.939 rows=4319367 loops=1)
                                   ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=100.00..35944.00 rows=432000 width=48) (actual time=8.015..85.362 rows=432000 loops=1)
                             ->  Hash  (cost=2251.08..2251.08 rows=14 width=4) (actual time=13.931..13.931 rows=15 loops=1)
                                   Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                   ->  Remote Subquery Scan on all (dn3)  (cost=200.00..2251.08 rows=14 width=4) (actual time=13.889..13.891 rows=15 loops=1)
                       ->  Hash  (cost=763.85..763.85 rows=11718 width=21) (actual time=27.108..27.108 rows=11718 loops=1)
                             Buckets: 16384  Batches: 1  Memory Usage: 769kB
                             ->  Remote Subquery Scan on all (dn3)  (cost=100.00..763.85 rows=11718 width=21) (actual time=10.485..21.131 rows=11718 loops=1)
   CTE wsr
     ->  GroupAggregate  (cost=313272.64..313274.07 rows=17 width=145) (actual time=2456.739..2463.864 rows=17 loops=1)
           Group Key: web_site_id
           ->  Sort  (cost=313272.64..313272.82 rows=73 width=57) (actual time=2456.272..2457.371 rows=25028 loops=1)
                 Sort Key: web_site_id
                 Sort Method: quicksort  Memory: 2724kB
                 ->  Hash Join  (cost=2253.85..313270.38 rows=73 width=57) (actual time=116.266..2439.617 rows=25028 loops=1)
                       Hash Cond: (ws_web_site_sk = web_site_sk)
                       ->  Hash Join  (cost=2251.13..313266.44 rows=455 width=44) (actual time=48.040..2366.260 rows=25034 loops=1)
                             Hash Cond: (ws_sold_date_sk = d_date_sk)
                             ->  Append  (cost=100.00..304878.89 rows=2375642 width=48) (actual time=28.754..832.287 rows=2375642 loops=1)
                                   ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=100.00..192541.39 rows=2160165 width=48) (actual time=28.753..414.417 rows=2160165 loops=1)
                                   ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=9468.92..112337.49 rows=215477 width=48) (actual time=29.301..289.241 rows=215477 loops=1)
                             ->  Hash  (cost=2251.08..2251.08 rows=14 width=4) (actual time=19.109..19.109 rows=15 loops=1)
                                   Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                   ->  Remote Subquery Scan on all (dn1)  (cost=200.00..2251.08 rows=14 width=4) (actual time=19.092..19.094 rows=15 loops=1)
                       ->  Hash  (cost=103.15..103.15 rows=32 width=21) (actual time=68.218..68.218 rows=32 loops=1)
                             Buckets: 1024  Batches: 1  Memory Usage: 10kB
                             ->  Remote Subquery Scan on all (dn3)  (cost=100.00..103.15 rows=32 width=21) (actual time=68.032..68.051 rows=32 loops=1)
   ->  Sort  (cost=76.68..77.68 rows=401 width=160) (actual time=7728.745..7728.749 rows=100 loops=1)
         Sort Key: ('store channel'::text), (('store'::text || (ssr.s_store_id)::text))
         Sort Method: top-N heapsort  Memory: 49kB
         ->  MixedAggregate  (cost=0.00..61.35 rows=401 width=160) (actual time=7726.733..7727.122 rows=815 loops=1)
               Hash Key: ('store channel'::text), (('store'::text || (ssr.s_store_id)::text))
               Hash Key: ('store channel'::text)
               Group Key: ()
               ->  Append  (cost=0.00..25.99 rows=945 width=160) (actual time=635.709..7726.054 rows=811 loops=1)
                     ->  CTE Scan on ssr  (cost=0.00..0.47 rows=17 width=160) (actual time=635.709..635.853 rows=17 loops=1)
                     ->  CTE Scan on csr  (cost=0.00..25.05 rows=911 width=160) (actual time=4611.176..4626.263 rows=777 loops=1)
                     ->  CTE Scan on wsr  (cost=0.00..0.47 rows=17 width=160) (actual time=2456.743..2463.886 rows=17 loops=1)
 Planning time: 1.185 ms
 Execution time: 7754.391 ms
(56 rows)

