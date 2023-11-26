                                                                                QUERY PLAN                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=325378.59..325382.42 rows=100 width=160) (actual time=2867.131..2867.240 rows=100 loops=1)
   CTE ssr
     ->  Finalize GroupAggregate  (cost=75115.36..75160.16 rows=125 width=145) (actual time=592.221..592.234 rows=6 loops=1)
           Group Key: s_store_id
           ->  Remote Subquery Scan on all (dn0)  (cost=75115.36..75152.03 rows=250 width=145) (actual time=592.203..592.205 rows=6 loops=1)
   CTE csr
     ->  GroupAggregate  (cost=145562.38..145573.79 rows=326 width=145) (actual time=1411.500..1416.771 rows=581 loops=1)
           Group Key: cp_catalog_page_id
           ->  Sort  (cost=145562.38..145563.19 rows=326 width=57) (actual time=1411.469..1412.194 rows=15841 loops=1)
                 Sort Key: cp_catalog_page_id
                 Sort Method: quicksort  Memory: 1622kB
                 ->  Hash Join  (cost=1101.20..145548.77 rows=326 width=57) (actual time=586.694..1392.256 rows=15841 loops=1)
                       Hash Cond: (cs_catalog_page_sk = cp_catalog_page_sk)
                       ->  Hash Join  (cost=933.31..145380.03 rows=326 width=44) (actual time=570.939..1373.766 rows=15882 loops=1)
                             Hash Cond: (cs_sold_date_sk = d_date_sk)
                             ->  Append  (cost=100.00..140383.43 rows=1585737 width=48) (actual time=6.414..464.443 rows=1585615 loops=1)
                                   ->  Remote Subquery Scan on all (dn0)  (cost=100.00..128330.21 rows=1441670 width=48) (actual time=6.414..359.872 rows=1441548 loops=1)
                                   ->  Remote Subquery Scan on all (dn0)  (cost=100.00..12053.22 rows=144067 width=48) (actual time=6.715..40.619 rows=144067 loops=1)
                             ->  Hash  (cost=933.29..933.29 rows=5 width=4) (actual time=12.005..12.005 rows=15 loops=1)
                                   Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                   ->  Remote Subquery Scan on all (dn0)  (cost=100.00..933.29 rows=5 width=4) (actual time=11.992..11.995 rows=15 loops=1)
                       ->  Hash  (cost=320.62..320.62 rows=3906 width=21) (actual time=15.741..15.741 rows=11718 loops=1)
                             Buckets: 16384 (originally 4096)  Batches: 1 (originally 1)  Memory Usage: 769kB
                             ->  Remote Subquery Scan on all (dn0)  (cost=100.00..320.62 rows=3906 width=21) (actual time=7.852..12.682 rows=11718 loops=1)
   CTE wsr
     ->  GroupAggregate  (cost=104599.48..104604.01 rows=105 width=145) (actual time=853.539..855.755 rows=15 loops=1)
           Group Key: web_site_id
           ->  Sort  (cost=104599.48..104599.88 rows=162 width=57) (actual time=853.377..853.702 rows=8395 loops=1)
                 Sort Key: web_site_id
                 Sort Method: quicksort  Memory: 1040kB
                 ->  Hash Join  (cost=948.04..104593.53 rows=162 width=57) (actual time=25.346..848.689 rows=8395 loops=1)
                       Hash Cond: (ws_web_site_sk = web_site_sk)
                       ->  Hash Join  (cost=933.31..104578.37 rows=162 width=44) (actual time=18.823..840.710 rows=8398 loops=1)
                             Hash Cond: (ws_sold_date_sk = d_date_sk)
                             ->  Append  (cost=100.00..101667.94 rows=791147 width=48) (actual time=6.347..381.503 rows=791147 loops=1)
                                   ->  Remote Subquery Scan on all (dn0)  (cost=100.00..64188.19 rows=719384 width=48) (actual time=6.346..180.870 rows=719384 loops=1)
                                   ->  Remote Subquery Scan on all (dn0)  (cost=3221.07..37479.75 rows=71763 width=48) (actual time=27.549..166.789 rows=71763 loops=1)
                             ->  Hash  (cost=933.29..933.29 rows=5 width=4) (actual time=12.007..12.007 rows=15 loops=1)
                                   Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                   ->  Remote Subquery Scan on all (dn0)  (cost=100.00..933.29 rows=5 width=4) (actual time=11.997..11.999 rows=15 loops=1)
                       ->  Hash  (cost=117.56..117.56 rows=210 width=21) (actual time=6.517..6.517 rows=30 loops=1)
                             Buckets: 1024  Batches: 1  Memory Usage: 10kB
                             ->  Remote Subquery Scan on all (dn0)  (cost=100.00..117.56 rows=210 width=21) (actual time=6.497..6.501 rows=30 loops=1)
   ->  GroupAggregate  (cost=40.64..56.00 rows=401 width=160) (actual time=2867.130..2867.233 rows=100 loops=1)
         Group Key: ('store channel'::text), (('store'::text || (ssr.s_store_id)::text))
         Group Key: ('store channel'::text)
         Group Key: ()
         ->  Sort  (cost=40.64..42.03 rows=556 width=160) (actual time=2867.123..2867.127 rows=101 loops=1)
               Sort Key: ('store channel'::text), (('store'::text || (ssr.s_store_id)::text))
               Sort Method: quicksort  Memory: 109kB
               ->  Append  (cost=0.00..15.29 rows=556 width=160) (actual time=592.225..2865.189 rows=602 loops=1)
                     ->  CTE Scan on ssr  (cost=0.00..3.44 rows=125 width=160) (actual time=592.225..592.242 rows=6 loops=1)
                     ->  CTE Scan on csr  (cost=0.00..8.96 rows=326 width=160) (actual time=1411.505..1417.145 rows=581 loops=1)
                     ->  CTE Scan on wsr  (cost=0.00..2.89 rows=105 width=160) (actual time=853.543..855.772 rows=15 loops=1)
 Planning time: 3.390 ms
 Execution time: 2875.432 ms
(56 rows)

