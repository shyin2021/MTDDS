                                                                                  QUERY PLAN                                                                                   
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=649908.71..649912.67 rows=100 width=160) (actual time=4899.593..4899.706 rows=100 loops=1)
   CTE ssr
     ->  Finalize GroupAggregate  (cost=149015.32..149020.01 rows=12 width=145) (actual time=585.979..586.047 rows=12 loops=1)
           Group Key: s_store_id
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=149015.32..149019.23 rows=24 width=145) (actual time=585.958..585.989 rows=24 loops=1)
   CTE csr
     ->  GroupAggregate  (cost=291312.28..291332.02 rows=564 width=145) (actual time=2794.923..2804.698 rows=696 loops=1)
           Group Key: cp_catalog_page_id
           ->  Sort  (cost=291312.28..291313.69 rows=564 width=57) (actual time=2794.875..2796.326 rows=32535 loops=1)
                 Sort Key: cp_catalog_page_id
                 Sort Method: quicksort  Memory: 3310kB
                 ->  Hash Join  (cost=2756.67..291286.50 rows=564 width=57) (actual time=1203.607..2753.812 rows=32535 loops=1)
                       Hash Cond: (cs_catalog_page_sk = cp_catalog_page_sk)
                       ->  Hash Join  (cost=2251.01..290779.37 rows=564 width=44) (actual time=1186.144..2730.599 rows=32624 loops=1)
                             Hash Cond: (cs_sold_date_sk = d_date_sk)
                             ->  Append  (cost=100.00..280310.56 rows=3168501 width=48) (actual time=6.945..691.549 rows=3168549 loops=1)
                                   ->  Remote Subquery Scan on all (dn1,dn2)  (cost=100.00..256272.63 rows=2880010 width=48) (actual time=6.945..493.408 rows=2880058 loops=1)
                                   ->  Remote Subquery Scan on all (dn1,dn2)  (cost=100.00..24037.93 rows=288491 width=48) (actual time=11.000..56.385 rows=288491 loops=1)
                             ->  Hash  (cost=2250.97..2250.97 rows=13 width=4) (actual time=13.152..13.152 rows=15 loops=1)
                                   Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                   ->  Remote Subquery Scan on all (dn1)  (cost=200.00..2250.97 rows=13 width=4) (actual time=13.138..13.139 rows=15 loops=1)
                       ->  Hash  (cost=763.85..763.85 rows=11718 width=21) (actual time=17.420..17.420 rows=11718 loops=1)
                             Buckets: 16384  Batches: 1  Memory Usage: 769kB
                             ->  Remote Subquery Scan on all (dn1)  (cost=100.00..763.85 rows=11718 width=21) (actual time=6.923..12.047 rows=11718 loops=1)
   CTE wsr
     ->  GroupAggregate  (cost=209512.30..209513.23 rows=15 width=145) (actual time=1500.843..1505.397 rows=15 loops=1)
           Group Key: web_site_id
           ->  Sort  (cost=209512.30..209512.40 rows=42 width=57) (actual time=1500.522..1501.217 rows=16678 loops=1)
                 Sort Key: web_site_id
                 Sort Method: quicksort  Memory: 2071kB
                 ->  Hash Join  (cost=2253.69..209511.16 rows=42 width=57) (actual time=30.495..1490.503 rows=16678 loops=1)
                       Hash Cond: (ws_web_site_sk = web_site_sk)
                       ->  Hash Join  (cost=2251.01..209507.74 rows=282 width=44) (actual time=22.535..1479.441 rows=16683 loops=1)
                             Hash Cond: (ws_sold_date_sk = d_date_sk)
                             ->  Append  (cost=100.00..203201.43 rows=1582876 width=48) (actual time=7.687..505.458 rows=1582876 loops=1)
                                   ->  Remote Subquery Scan on all (dn1,dn2)  (cost=100.00..128315.56 rows=1439247 width=48) (actual time=7.686..239.259 rows=1439247 loops=1)
                                   ->  Remote Subquery Scan on all (dn1,dn2)  (cost=6345.73..74885.87 rows=143629 width=48) (actual time=27.862..198.541 rows=143629 loops=1)
                             ->  Hash  (cost=2250.97..2250.97 rows=13 width=4) (actual time=14.624..14.624 rows=15 loops=1)
                                   Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                   ->  Remote Subquery Scan on all (dn1)  (cost=200.00..2250.97 rows=13 width=4) (actual time=14.610..14.612 rows=15 loops=1)
                       ->  Hash  (cost=103.08..103.08 rows=30 width=21) (actual time=7.954..7.954 rows=30 loops=1)
                             Buckets: 1024  Batches: 1  Memory Usage: 10kB
                             ->  Remote Subquery Scan on all (dn1)  (cost=100.00..103.08 rows=30 width=21) (actual time=7.932..7.936 rows=30 loops=1)
   ->  GroupAggregate  (cost=43.46..59.34 rows=401 width=160) (actual time=4899.592..4899.699 rows=100 loops=1)
         Group Key: ('store channel'::text), (('store'::text || (ssr.s_store_id)::text))
         Group Key: ('store channel'::text)
         Group Key: ()
         ->  Sort  (cost=43.46..44.94 rows=591 width=160) (actual time=4899.584..4899.587 rows=101 loops=1)
               Sort Key: ('store channel'::text), (('store'::text || (ssr.s_store_id)::text))
               Sort Method: quicksort  Memory: 126kB
               ->  Append  (cost=0.00..16.25 rows=591 width=160) (actual time=585.986..4896.673 rows=723 loops=1)
                     ->  CTE Scan on ssr  (cost=0.00..0.33 rows=12 width=160) (actual time=585.985..586.062 rows=12 loops=1)
                     ->  CTE Scan on csr  (cost=0.00..15.51 rows=564 width=160) (actual time=2794.928..2805.160 rows=696 loops=1)
                     ->  CTE Scan on wsr  (cost=0.00..0.41 rows=15 width=160) (actual time=1500.848..1505.414 rows=15 loops=1)
 Planning time: 1.473 ms
 Execution time: 4914.256 ms
(56 rows)

