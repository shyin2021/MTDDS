                                                                       QUERY PLAN                                                                        
---------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=470200.30..470202.79 rows=100 width=160) (actual time=660.650..660.764 rows=100 loops=1)
   CTE ssr
     ->  Finalize GroupAggregate  (cost=234453.50..234454.22 rows=17 width=113) (actual time=329.880..330.027 rows=17 loops=1)
           Group Key: s_store_id
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=234453.50..234453.63 rows=17 width=113) (actual time=329.862..329.952 rows=51 loops=1)
   CTE csr
     ->  GroupAggregate  (cost=155904.96..155908.75 rows=101 width=113) (actual time=191.885..206.850 rows=389 loops=1)
           Group Key: cp_catalog_page_id
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=155904.96..155905.72 rows=101 width=41) (actual time=191.820..202.648 rows=5204 loops=1)
   CTE wsr
     ->  Finalize GroupAggregate  (cost=79828.45..79829.17 rows=17 width=113) (actual time=121.577..121.685 rows=17 loops=1)
           Group Key: web_site_id
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=79828.45..79828.58 rows=17 width=113) (actual time=121.523..121.580 rows=51 loops=1)
   ->  GroupAggregate  (cost=8.15..14.92 rows=271 width=160) (actual time=660.648..660.756 rows=100 loops=1)
         Group Key: ('store channel'::text), (('store'::text || (ssr.store_id)::text))
         Group Key: ('store channel'::text)
         Group Key: ()
         ->  Sort  (cost=8.15..8.49 rows=135 width=160) (actual time=660.640..660.644 rows=101 loops=1)
               Sort Key: ('store channel'::text), (('store'::text || (ssr.store_id)::text))
               Sort Method: quicksort  Memory: 84kB
               ->  Append  (cost=0.00..3.38 rows=135 width=160) (actual time=329.884..659.147 rows=423 loops=1)
                     ->  CTE Scan on ssr  (cost=0.00..0.43 rows=17 width=160) (actual time=329.884..330.040 rows=17 loops=1)
                     ->  CTE Scan on csr  (cost=0.00..2.52 rows=101 width=160) (actual time=191.892..207.358 rows=389 loops=1)
                     ->  CTE Scan on wsr  (cost=0.00..0.43 rows=17 width=160) (actual time=121.582..121.697 rows=17 loops=1)
 Planning time: 3.531 ms
 Execution time: 676.141 ms
(26 rows)

