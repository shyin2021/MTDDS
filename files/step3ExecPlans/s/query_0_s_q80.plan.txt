                                                                  QUERY PLAN                                                                  
----------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=157094.55..157097.05 rows=100 width=160) (actual time=972.145..972.257 rows=100 loops=1)
   CTE ssr
     ->  GroupAggregate  (cost=78264.86..78267.41 rows=68 width=113) (actual time=350.438..352.916 rows=6 loops=1)
           Group Key: s_store_id
           ->  Remote Subquery Scan on all (dn0)  (cost=78264.86..78265.37 rows=68 width=41) (actual time=350.005..350.852 rows=3309 loops=1)
   CTE csr
     ->  GroupAggregate  (cost=52111.31..52112.59 rows=34 width=113) (actual time=210.469..212.238 rows=397 loops=1)
           Group Key: cp_catalog_page_id
           ->  Remote Subquery Scan on all (dn0)  (cost=52111.31..52111.57 rows=34 width=41) (actual time=210.444..210.802 rows=1843 loops=1)
   CTE wsr
     ->  GroupAggregate  (cost=26706.85..26707.48 rows=17 width=113) (actual time=404.862..405.510 rows=15 loops=1)
           Group Key: web_site_id
           ->  Remote Subquery Scan on all (dn0)  (cost=26706.85..26706.97 rows=17 width=41) (actual time=404.804..404.931 rows=870 loops=1)
   ->  GroupAggregate  (cost=7.08..13.04 rows=239 width=160) (actual time=972.144..972.250 rows=100 loops=1)
         Group Key: ('store channel'::text), (('store'::text || (ssr.store_id)::text))
         Group Key: ('store channel'::text)
         Group Key: ()
         ->  Sort  (cost=7.08..7.37 rows=119 width=160) (actual time=972.138..972.142 rows=101 loops=1)
               Sort Key: ('store channel'::text), (('store'::text || (ssr.store_id)::text))
               Sort Method: quicksort  Memory: 83kB
               ->  Append  (cost=0.00..2.98 rows=119 width=160) (actual time=350.442..970.880 rows=418 loops=1)
                     ->  CTE Scan on ssr  (cost=0.00..1.70 rows=68 width=160) (actual time=350.442..352.929 rows=6 loops=1)
                     ->  CTE Scan on csr  (cost=0.00..0.85 rows=34 width=160) (actual time=210.472..212.409 rows=397 loops=1)
                     ->  CTE Scan on wsr  (cost=0.00..0.43 rows=17 width=160) (actual time=404.865..405.521 rows=15 loops=1)
 Planning time: 13.648 ms
 Execution time: 977.324 ms
(26 rows)

