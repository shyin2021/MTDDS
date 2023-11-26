                                                                     QUERY PLAN                                                                     
----------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=316678.05..316680.54 rows=100 width=160) (actual time=808.595..808.711 rows=100 loops=1)
   CTE ssr
     ->  Finalize GroupAggregate  (cost=157335.91..157336.42 rows=12 width=113) (actual time=479.447..479.500 rows=12 loops=1)
           Group Key: s_store_id
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=157335.91..157336.00 rows=12 width=113) (actual time=479.424..479.450 rows=24 loops=1)
   CTE csr
     ->  GroupAggregate  (cost=105144.76..105147.16 rows=64 width=113) (actual time=216.026..221.271 rows=385 loops=1)
           Group Key: cp_catalog_page_id
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=105144.76..105145.24 rows=64 width=41) (actual time=215.972..219.638 rows=3536 loops=1)
   CTE wsr
     ->  Finalize GroupAggregate  (cost=54188.60..54189.24 rows=15 width=113) (actual time=106.024..106.090 rows=15 loops=1)
           Group Key: web_site_id
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=54188.60..54188.72 rows=15 width=113) (actual time=105.999..106.031 rows=30 loops=1)
   ->  GroupAggregate  (cost=5.24..9.80 rows=183 width=160) (actual time=808.594..808.703 rows=100 loops=1)
         Group Key: ('store channel'::text), (('store'::text || (ssr.store_id)::text))
         Group Key: ('store channel'::text)
         Group Key: ()
         ->  Sort  (cost=5.24..5.46 rows=91 width=160) (actual time=808.581..808.584 rows=101 loops=1)
               Sort Key: ('store channel'::text), (('store'::text || (ssr.store_id)::text))
               Sort Method: quicksort  Memory: 82kB
               ->  Append  (cost=0.00..2.28 rows=91 width=160) (actual time=479.453..807.112 rows=412 loops=1)
                     ->  CTE Scan on ssr  (cost=0.00..0.30 rows=12 width=160) (actual time=479.453..479.512 rows=12 loops=1)
                     ->  CTE Scan on csr  (cost=0.00..1.60 rows=64 width=160) (actual time=216.031..221.466 rows=385 loops=1)
                     ->  CTE Scan on wsr  (cost=0.00..0.38 rows=15 width=160) (actual time=106.028..106.102 rows=15 loops=1)
 Planning time: 4.965 ms
 Execution time: 817.483 ms
(26 rows)

